"""
Example program to demonstrate Cloud Run parameters and secrets
"""

import os
import json
import logging
import base64
from google.cloud import storage
from googleapiclient import discovery

from flask import Flask

enable_logging = True

# Change the format of messages logged to Stackdriver
logging.basicConfig(format='%(message)s', level=logging.INFO)

# HTML page to return when Cloud Run is invoked
html = """
<html>
 <head>
  <title>
   Google Cloud Run - Identity
  </title>
 </head>
 <body>
  <p>Hello Google Cloud Run World!</p>
  <p>DB_HOST: {}</p>
  <p>DB_PORT: {}</p>
  <p>DB_USER: {}</p>
  <p>DB_PASS: {}</p>
  <a href="https://cloud.google.com/run/" target="_blank">Google Cloud Run Website</a>
 </body>
</html>
"""

app = Flask(__name__)

def decrypt(client, ciphertext):
	""" Use Google KMS to decrypt the ciphertext """

	if 'KMS_KEY_ID' not in os.environ:
		logging.error('Error: Missing environment variable: KMS_KEY_ID')
		return None

	key_id = os.environ['KMS_KEY_ID']

	keys = client.projects().locations().keyRings().cryptoKeys() 

	response = keys.decrypt(name=key_id, body={"ciphertext":ciphertext}).execute()

	return base64.b64decode(response['plaintext']).decode('utf-8').strip()

def get_config(filename):
	""" Read the configuration from Cloud Storage """

	try:
		if 'BUCKET_NAME' not in os.environ:
			logging.error('Error: Missing environment variable: BUCKET_NAME')
			return None

		bucket_name = os.getenv('BUCKET_NAME')

		if enable_logging is True:
			logging.info('Reading bucket: %s', bucket_name)

		blob = storage.Client() \
			    .get_bucket(bucket_name) \
			    .get_blob(filename) \
			    .download_as_string()

		return base64.b64encode(blob).decode()

	except Exception as e:
		logging.error(str(e))
		return None

@app.route('/')
def home():
	""" Home URL """

	db_host = 'not_defined'
	db_port = 'not_defined'
	db_user = 'not_defined'
	db_pass = 'not_defined'

	data = get_config('config.enc')

	try:
		kms_client = discovery.build('cloudkms', 'v1', cache_discovery=False)

		s = decrypt(kms_client, data)

		config = json.loads(s)
	except Exception as e:
		logging.error(str(e))
		config = None

	if config is not None:
		try:
			db_host = config['DB_HOST']
			db_port = config['DB_PORT']
			db_user = config['DB_USER']
			db_pass = config['DB_PASS']
		except Exception as e:
			logging.error(str(e))

	if enable_logging is True:
		logging.info('DB_HOST: %s', db_host)
		logging.info('DB_PORT: %s', db_port)
		logging.info('DB_USER: %s', db_user)
		logging.info('DB_PASS: %s', db_pass)

	return html.format(db_host, db_port, db_user, db_pass)

if __name__ == '__main__':
	app.run(debug=True, host='0.0.0.0', port=int(os.environ.get('PORT', 8080)))
