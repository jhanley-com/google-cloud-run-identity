if [ ! -f env.tmp ]; then
	source ./env.sh
fi

gcloud kms keyrings create $GCP_KMS_KEYRING \
--location global

gcloud kms keys create $GCP_KMS_KEYNAME \
--location global \
--keyring $GCP_KMS_KEYRING \
--purpose encryption
