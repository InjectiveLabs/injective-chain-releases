mongosh --eval "rs.initiate()"

# Wait for primary replica to be ready before performing create commands. Restoring from backup will fail otherwise.
echo "Waiting for Mongo to start"
until mongosh --eval "rs.status()" | grep "stateStr: 'PRIMARY'"; do
    echo "Still waiting for Mongo to start"
    sleep 5
done
echo "Mongo started"

cd /dumps

if [ ! -f eventProviderV2 ]; then
    echo "eventProviderV2 not found skipping..."
else
    echo "eventProviderV2 found, importing"
    mongorestore --uri="mongodb://localhost:27017" --gzip --archive=eventProviderV2 --nsInclude=eventProviderV2.* -v && rm eventProviderV2
fi

if [ ! -f eventProviderV2Pruned ]; then
    echo "eventProviderV2Pruned not found skipping..."
else
    echo "eventProviderV2Pruned found, importing"
    mongorestore --uri="mongodb://localhost:27017" --gzip --archive=eventProviderV2Pruned -nsFrom=eventProviderV2Pruned.* --nsTo=eventProviderV2.* -v && rm eventProviderV2Pruned
fi

if [ ! -f exchangeV2 ]; then
    echo "exchangeV2 not found skipping..."
else
    echo "exchangeV2 found, importing"
    mongorestore --uri="mongodb://localhost:27017" --gzip --archive=exchangeV2 --nsInclude=exchangeV2.* -v && rm exchangeV2
fi

if [ ! -f explorerV2 ]; then
    echo "explorerV2 not found skipping..."
else
    echo "explorerV2 found, importing"
    mongorestore --uri="mongodb://localhost:27017" --gzip --archive=explorerV2 --nsInclude=explorerV2.* -v && rm explorerV2
fi
