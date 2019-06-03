if [ ! -f env.tmp ]; then
	source ./env.sh
fi

gcloud iam service-accounts create $GCP_SA_NAME \
--display-name=$GCP_SA_NAME
