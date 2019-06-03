# to get your current Project ID
# gcloud config list project
#
export GCP_PROJECT_ID=
export GCP_PROJECT_NUM=
export GCP_REGION=us-central1
export GCP_SERVICE_NAME=cloudrun-identity
export GCP_IMAGE_NAME=cloudrun-identity

# The follow scripts gets the Project ID and Project Number
# from your current configuration

# This code gets the Project ID from gcloud
export GCP_PROJECT_ID=`gcloud config get-value project`
echo Project ID: $GCP_PROJECT_ID

# This code gets the Project Number from gcloud
export GCP_PROJECT_NUM=`gcloud projects list --filter="$GCP_PROJECT_ID" --format="value(PROJECT_NUMBER)"`
echo Project Number: $GCP_PROJECT_NUM

# The name for the new service account
export GCP_SA_NAME=cloud-run-identity
export GCP_SA=${GCP_SA_NAME}@${GCP_PROJECT_ID}.iam.gserviceaccount.com

export GCS_BUCKET_NAME=${GCP_PROJECT_ID}-cloudrun-identity

# Cloud Storage role to grant
export GCS_BUCKET_ROLE=legacyBucketReader
export GCS_OBJECT_ROLE=legacyObjectReader

# Cloud KMS
export GCP_KMS_KEYRING=cloudrun-secrets
export GCP_KMS_KEYNAME=cloudrun-identity
export GCP_KMS_ROLE=roles/cloudkms.cryptoKeyDecrypter
export GCP_KMS_KEY_ID=projects/$GCP_PROJECT_ID/locations/global/keyRings/$GCP_KMS_KEYRING/cryptoKeys/$GCP_KMS_KEYNAME

# echo Done > env.tmp
