docker build -t lohmag/multi-client:latest -t lohmag/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lohmag/multi-server:latest -t lohmag/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lohmag/multi-worker:latest -t lohmag/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lohmag/multi-client:latest
docker push lohmag/multi-server:latest
docker push lohmag/multi-worker:latest

docker push lohmag/multi-client:$SHA
docker push lohmag/multi-server:$SHA
docker push lohmag/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=lohmag/multi-server:$SHA
kubectl set image deployments/client-deployment client=lohmag/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lohmag/multi-worker:$SHA
