echo "Waiting injectived to launch on port 26657..."

while ! timeout 1 /bin/sh -c "echo > /dev/tcp/localhost/26657"; do   
  sleep 5
done

echo "Injectived launched, starting other components"
exec "$@"