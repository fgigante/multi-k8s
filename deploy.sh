docker build -t fgigante/multi-client:latest -t fgigante/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t fgigante/multi-server:latest -t fgigante/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t fgigante/multi-worker:latest -t fgigante/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aidfgdocker/multi-client:latest
docker push aidfgdocker/multi-server:latest
docker push aidfgdocker/multi-worker:latest

docker push aidfgdocker/multi-client:$SHA
docker push aidfgdocker/multi-server:$SHA
docker push aidfgdocker/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=fgigante/multi-server:$SHA
kubectl set image deployments/client-deployment client=fgigante/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=fgigante/multi-worker:$SHA
