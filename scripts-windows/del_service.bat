@if not exist env.tmp call env.bat

call gcloud beta run services delete %GCP_SERVICE_NAME% -q ^
--region %GCP_REGION% ^
