@REM to get your current Project ID
@REM gcloud config list project

@set GCP_PROJECT_ID=
@set GCP_PROJECT_NUM=
@set GCP_REGION=us-central1
@set GCP_SERVICE_NAME=cloudrun-identity
@set GCP_IMAGE_NAME=cloudrun-identity

@REM - The follow scripts gets the Project ID and Project Number
@REM - from your current configuration

@REM This code gets the Project ID from gcloud
call gcloud config get-value project > project.tmp
for /f "delims=" %%x in (project.tmp) do set GCP_PROJECT_ID=%%x
echo Project ID: %GCP_PROJECT_ID%

del project.tmp

@echo on

@REM This code gets the Project Number from gcloud
call gcloud projects list --filter="%GCP_PROJECT_ID%" --format="value(PROJECT_NUMBER)" > number.tmp
for /f "delims=" %%x in (number.tmp) do set GCP_PROJECT_NUM=%%x
echo Project Number: %GCP_PROJECT_NUM%

del number.tmp

@echo on

@REM - The name for the new service account
@REM - This must match the script setup_sa.bat
set GCP_SA_NAME=cloud-run-identity
set GCP_SA=%GCP_SA_NAME%@%PROJECT_ID%.iam.gserviceaccount.com

@set GCS_BUCKET_NAME=%GCP_PROJECT_ID%-cloudrun-identity

@REM - Cloud Storage role to grant
set GCS_BUCKET_ROLE=legacyBucketReader
set GCS_OBJECT_ROLE=legacyObjectReader 

@REM - Cloud KMS
set GCP_KMS_KEYRING=cloudrun-secrets
set GCP_KMS_KEYNAME=cloudrun-identity
set GCP_KMS_ROLE=roles/cloudkms.cryptoKeyDecrypter
set GCP_KMS_KEY_ID=projects/%GCP_PROJECT_ID%/locations/global/keyRings/%GCP_KMS_KEYRING%/cryptoKeys/%GCP_KMS_KEYNAME%

echo Done > env.tmp
