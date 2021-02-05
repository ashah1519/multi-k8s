docker build -t ashah1519/multi-client:latest -t ashah1519/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ashah1519/multi-server:latest -t ashah1519/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ashah1519/multi-worker:latest -t ashah1519/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ashah1519/multi-client:latest
docker push ashah1519/multi-server:latest
docker push ashah1519/multi-worker:latest

docker push ashah1519/multi-client:$SHA
docker push ashah1519/multi-server:$SHA
docker push ashah1519/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ashah1519/multi-server:$SHA
kubectl set image deployments/client-deployment client=ashah1519/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ashah1519/multi-worker:$SHA