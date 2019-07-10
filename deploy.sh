docker build -t diceprime/multi-client:latest -t diceprime/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t diceprime/multi-server:latest -t diceprime/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t diceprime/multi-worker:latest -t diceprime/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push diceprime/multi-client:latest
docker push diceprime/multi-client:$SHA

docker push diceprime/multi-server:latest
docker push diceprime/multi-server:$SHA

docker push diceprime/multi-worker:latest
docker push diceprime/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=diceprime/multi-server:$SHA
kubectl set image deployments/client-deployment client=diceprime/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=diceprime/multi-worker:$SHA