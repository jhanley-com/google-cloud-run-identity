@if not exist env.tmp call env.bat

call gcloud kms keyrings create %GCP_KMS_KEYRING% ^
--location global

@echo on

call gcloud kms keys create %GCP_KMS_KEYNAME% ^
--location global ^
--keyring %GCP_KMS_KEYRING% ^
--purpose encryption
