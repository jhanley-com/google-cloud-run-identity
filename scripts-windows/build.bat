@if not exist env.tmp call env.bat

cd ..

call gcloud builds submit ^
--tag gcr.io/%GCP_PROJECT_ID%/%GCP_IMAGE_NAME%
@if errorlevel 1 goto err_out

@echo on

@REM The script in setup_bucket.bat and setup_sa.bat must be run before deploy.
@REM The bucket and service account must be created first.
@REM The script setup.bat takes care of everything

call gcloud alpha run deploy %GCP_SERVICE_NAME% ^
--region %GCP_REGION% ^
--image gcr.io/%GCP_PROJECT_ID%/%GCP_IMAGE_NAME% ^
--allow-unauthenticated ^
--set-env-vars BUCKET_NAME=%GCS_BUCKET_NAME% ^
--set-env-vars KMS_KEY_ID=%GCP_KMS_KEY_ID% ^
--service-account=%GCP_SA%

@if errorlevel 1 goto err_out

@goto end

:err_out
@echo ***************************************************************
@echo Build Failed     Build Failed     Build Failed     Build Failed
@echo ***************************************************************

:end
cd scripts-windows
