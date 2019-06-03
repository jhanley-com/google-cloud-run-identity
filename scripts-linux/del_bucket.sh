if [ ! -f env.tmp ]; then
	source ./env.sh
fi

gsutil rm -r gs://$GCS_BUCKET_NAME
