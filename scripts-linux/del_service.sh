if [ ! -f env.tmp ]; then
	source ./env.sh
fi

gcloud beta run services delete $GCP_SERVICE_NAME -q
