if [ ! -f env.tmp ]; then
	source ./env.sh
fi

gsutil -h "Content-Type: application/octet-stream" cp config.enc gs://$GCS_BUCKET_NAME/config.enc

# this command will return an error on an empty bucket
gsutil acl set private gs://$GCS_BUCKET_NAME/config.enc

gsutil iam ch serviceAccount:$GCP_SA:$GCS_BUCKET_ROLE gs://$GCS_BUCKET_NAME/

gsutil iam ch serviceAccount:$GCP_SA:$GCS_OBJECT_ROLE gs://$GCS_BUCKET_NAME/config.enc
