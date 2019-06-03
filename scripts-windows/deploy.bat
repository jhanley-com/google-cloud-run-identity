call gcloud alpha run deploy %GCP_SERVICE_NAME% ^
--region %GCP_REGION% ^
--image gcr.io/%GCP_PROJECT_ID%/%GCP_IMAGE_NAME% ^
--allow-unauthenticated ^
--set-env-vars BUCKET_NAME=%GCS_BUCKET_NAME% ^
--set-env-vars KMS_KEY_ID=%GCP_KMS_KEY_ID% ^
--service-account=%GCP_SA%
