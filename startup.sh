#!/bin/bash

if [ -z $TOKEN ]; then
    echo "No gitlab TOKEN variable"
    exit -1
fi
if [ -z $SERVER ]; then
    echo "No gitlab ADDRESS variable"
    exit
fi
cat << EOF > /root/.gitlab_config
{"gitlab_server":"$SERVER/api/v3","gitlab_token":"$TOKEN"}
EOF
HTTP_LESS=${SERVER#http://}
HTTPS_LESS=${HTTP_LESS#https://}
echo -e "machine $HTTPS_LESS\nlogin gitlab-ci-token\npassword $TOKEN" | tee /root/.netrc
echo "Using $(< /root/.gitlab_config ) and CMD Options: $OPTIONS"
if [ -z $LOOP ]; then 
    gitlab-clone "$OPTIONS"
else
    while /bin/true; do 
	gitlab-clone "$OPTIONS"
	echo Sleeping $LOOP s
	sleep $LOOP
    done
fi
