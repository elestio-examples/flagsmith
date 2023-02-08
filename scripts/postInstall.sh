#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 90s;


    url=$(curl -i https://${DOMAIN}/api/v1/users/config/init/)
    echo $url > url.txt

    csrftoken=$(sed -e 's/.*csrftoken=\(.*\)\; expires.*/\1/' url.txt)
    csrfmiddlewaretoken=$(sed -n '/token/s/.*name="csrfmiddlewaretoken"\s\+value="\([^"]\+\).*/\1/p' url.txt)

    rm url.txt


    curl https://${DOMAIN}/api/v1/users/config/init/ \
  -H 'referer: https://'${DOMAIN}'/api/v1/users/config/init/' \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
  -H 'cache-control: max-age=0' \
  -H 'content-type: application/x-www-form-urlencoded' \
  -H 'cookie: csrftoken='${csrftoken}';' \
  -H 'upgrade-insecure-requests: 1' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36' \
  --data-raw 'csrfmiddlewaretoken='${csrfmiddlewaretoken}'&username=admin&email='${ADMIN_EMAIL}'&password='${ADMIN_PASSWORD}'&site_name=Flagsmith&site_domain='${DOMAIN}'' \
  --compressed
