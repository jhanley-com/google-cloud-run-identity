@if not exist env.tmp call env.bat

call gcloud beta run services describe %GCP_SERVICE_NAME% --format json | jq -r ".status.address.hostname" > service.tmp
