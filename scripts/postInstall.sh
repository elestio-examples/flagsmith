#set env vars
# set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 30s;

$target=$(docker-compose port flagsmith 8000)


curl http://$target/api/v1/users/config/init/ \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
  -H 'cache-control: max-age=0' \
  -H 'content-type: application/x-www-form-urlencoded' \
  -H 'upgrade-insecure-requests: 1' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36' \
  --data-raw 'csrfmiddlewaretoken='${ADMIN_PASSWORD}'&username=admin&email='${ADMIN_EMAIL}'&password='${ADMIN_PASSWORD}'&site_name=Flagsmith&site_domain='${DOMAIN}'' \
  --compressed



# curl http://$target/api/v1/auth/users/ \
#   -H 'accept: application/json' \
#   -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
#   -H 'content-type: application/json; charset=utf-8' \
#   -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36' \
#   --data-raw '{"email":"'${ADMIN_EMAIL}'","password":"'${ADMIN_PASSWORD}'","first_name":"Flagsmith","last_name":"root","marketing_consent_given":false,"sign_up_type":"NO_INVITE","referrer":""}' \
#   --compressed
