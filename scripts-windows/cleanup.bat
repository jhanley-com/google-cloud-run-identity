@if not exist env.tmp call env.bat

call gcloud beta run services delete %GCP_SERVICE_NAME% -q ^
--region %GCP_REGION% ^

@echo on

call gsutil rm -r gs://%GCS_BUCKET_NAME%

@echo on

call gcloud kms keys remove-iam-policy-binding %GCP_KMS_KEYNAME% ^
--location global ^
--keyring %GCP_KMS_KEYRING% ^
--member serviceAccount:%GCP_SA% ^
--role %GCP_KMS_ROLE%

call gcloud iam service-accounts delete %GCP_SA% -q

del config.enc
del config.out
del *.tmp
