if [ ! -f service.tmp ]; then
	. ./get_url.sh
fi

export GCP_URL=`cat service.tmp`

curl -I $GCP_URL -w "\nTime to First Byte: %{time_starttransfer}\n"
