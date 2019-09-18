docker build -t skgeorge/multi-client:latest -t skgeorge/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t skgeorge/multi-server:latest -t skgeorge/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t skgeorge/multi-worker:latest -t skgeorge/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push skgeorge/multi-client:latest
docker push skgeorge/multi-server:latest
docker push skgeorge/multi-worker:latest

docker push skgeorge/multi-client:$SHA
docker push skgeorge/multi-server:$SHA
docker push skgeorge/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=skgeorge/multi-server:$SHA
kubectl set image deployments/client-deployment client=skgeorge/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=skgeorge/multi-worker:$SHA