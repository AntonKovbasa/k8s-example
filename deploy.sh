docker build -t antonkovbasa/multi-client:latest -t antonkovbasa/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t antonkovbasa/multi-server:latest -t antonkovbasa/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t antonkovbasa/multi-worker:latest -t antonkovbasa/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push antonkovbasa/multi-client:latest
docker push antonkovbasa/multi-server:latest
docker push antonkovbasa/multi-worker:latest

docker push antonkovbasa/multi-client:$SHA
docker push antonkovbasa/multi-server:$SHA
docker push antonkovbasa/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=antonkovbasa/multi-server:$SHA
kubectl set image deployments/client-deployment client=antonkovbasa/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=antonkovbasa/multi-worker:$SHA