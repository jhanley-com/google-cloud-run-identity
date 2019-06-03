if [ ! -f env.tmp ]; then
	source ./env.sh
fi

gcloud beta run services describe $GCP_SERVICE_NAME --format json --region $GCP_REGION | jq -r ".status.address.hostname" > service.tmp
