if [ ! -f env.tmp ]; then
	source ./env.sh
fi

cd ..

gcloud builds submit \
--tag gcr.io/$GCP_PROJECT_ID/$GCP_IMAGE_NAME

# The script in setup_bucket.sh and setup_sa.sh must be run before deploy.
# The bucket and service account must be created first.
# The script setup.sh takes care of everything

gcloud alpha run deploy $GCP_SERVICE_NAME \
--region $GCP_REGION \
--image gcr.io/$GCP_PROJECT_ID/$GCP_IMAGE_NAME \
--allow-unauthenticated \
--set-env-vars BUCKET_NAME=$GCS_BUCKET_NAME \
--set-env-vars KMS_KEY_ID=$GCP_KMS_KEY_ID \
--service-account=$GCP_SA

cd scripts-linux
