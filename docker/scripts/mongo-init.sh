mongosh --eval "rs.initiate()"

# Wait for primary replica to be ready before performing create commands. Restoring from backup will fail otherwise.
echo "Waiting for Mongo to start"
until mongosh --eval "rs.status()" | grep "stateStr: 'PRIMARY'"; do
    echo "Still waiting for Mongo to start"
    sleep 5
done
echo "Mongo started"

# import event provider db (takes around 10-15 mins)
mongorestore --uri="mongodb://localhost:27017" --gzip --archive=eventProviderV2 --nsInclude=eventProviderV2.* -v
# import exchange db (takes around 10-15 mins)
mongorestore --uri="mongodb://localhost:27017" --gzip --archive=exchangeV2 --nsInclude=exchangeV2.* -v
