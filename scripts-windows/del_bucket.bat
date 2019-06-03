@if not exist env.tmp call env.bat

call gsutil rm -r gs://%GCS_BUCKET_NAME%
@echo on
