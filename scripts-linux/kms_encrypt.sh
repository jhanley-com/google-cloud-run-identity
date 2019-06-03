if [ ! -f env.tmp ]; then
	source ./env.sh
fi

gcloud kms encrypt \
--location=global \
--keyring $GCP_KMS_KEYRING \
--key=$GCP_KMS_KEYNAME \
--plaintext-file=config.json \
--ciphertext-file=config.enc
