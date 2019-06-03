if [ ! -f env.tmp ]; then
	source ./env.sh
fi

gcloud kms keys remove-iam-policy-binding $GCP_KMS_KEYNAME \
--location global \
--keyring $GCP_KMS_KEYRING \
--member serviceAccount:$GCP_SA \
--role $GCP_KMS_ROLE
