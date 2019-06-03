@if not exist env.tmp call env.bat

gcloud kms keys remove-iam-policy-binding %GCP_KMS_KEYNAME% ^
--location global ^
--keyring %GCP_KMS_KEYRING% ^
--member serviceAccount:%GCP_SA% ^
--role %GCP_KMS_ROLE%
@if errorlevel 1 goto err_out

@echo on

@goto end

:err_out
@echo *************************************************************
@echo Service Account Setup Failed     Service Account Setup Failed
@echo *************************************************************

:end
