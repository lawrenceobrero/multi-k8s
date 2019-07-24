docker build -t lawrenceobrero/multi-client:latest -t lawrenceobrero/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lawrenceobrero/multi-server:latest -t lawrenceobrero/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lawrenceobrero/multi-worker:latest -t lawrenceobrero/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push lawrenceobrero/multi-client:latest
docker push lawrenceobrero/multi-server:latest
docker push lawrenceobrero/multi-worker:latest

docker push lawrenceobrero/multi-client:$SHA
docker push lawrenceobrero/multi-server:$SHA
docker push lawrenceobrero/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lawrenceobrero/multi-server:$SHA
kubectl set image deployments/client-deployment client=lawrenceobrero/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lawrenceobrero/multi-worker:$SHA