if [ ! -f env.tmp ]; then
	source ./env.sh
fi

gcloud iam service-accounts delete $GCP_SA -q
