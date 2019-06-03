@if not exist env.tmp call env.bat

call gsutil mb gs://%GCS_BUCKET_NAME%
@if errorlevel 1 goto err_out
@echo on

call gsutil defacl set private gs://%GCS_BUCKET_NAME%
@if errorlevel 1 goto err_out
@echo on

call gsutil versioning set on gs://%GCS_BUCKET_NAME%
@if errorlevel 1 goto err_out
@echo on

call gsutil -h "Content-Type: application/octet-stream" cp config.enc gs://%GCS_BUCKET_NAME%/config.enc
@if errorlevel 1 goto err_out
@echo on

@REM - this command will return an error on an empty bucket
call gsutil acl set private gs://%GCS_BUCKET_NAME%/config.enc
@if errorlevel 1 goto err_out
@echo on

call gsutil iam ch serviceAccount:%GCP_SA%:%GCS_BUCKET_ROLE% gs://%GCS_BUCKET_NAME%/
@if errorlevel 1 goto err_out
@echo on

call gsutil iam ch serviceAccount:%GCP_SA%:%GCS_OBJECT_ROLE% gs://%GCS_BUCKET_NAME%/config.enc
@if errorlevel 1 goto err_out
@echo on

@goto end

:err_out
@echo ********************************************************************
@echo Bucket Setup Failed     Bucket Setup Failed     Bucket Setup Failed
@echo ********************************************************************

:end
