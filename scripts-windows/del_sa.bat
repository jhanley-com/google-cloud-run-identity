@if not exist env.tmp call env.bat

gcloud iam service-accounts delete %GCP_SA% -q
