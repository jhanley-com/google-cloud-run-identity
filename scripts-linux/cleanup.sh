if [ ! -f env.tmp ]; then
	source ./env.sh
fi

gcloud beta run services delete $GCP_SERVICE_NAME -q \
--region $GCP_REGION

gsutil rm -r gs://$GCS_BUCKET_NAME

gcloud kms keys remove-iam-policy-binding $GCP_KMS_KEYNAME \
--location global \
--keyring $GCP_KMS_KEYRING \
--member serviceAccount:$GCP_SA \
--role $GCP_KMS_ROLE

gcloud iam service-accounts delete $GCP_SA -q

rm config.enc
rm config.out
rm *.tmp
