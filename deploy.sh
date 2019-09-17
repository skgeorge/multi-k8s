docker build -t stephengrider/multi-client:latest -t stephengrider/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t stephengrider/multi-server:latest -t stephengrider/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t stephengrider/multi-worker:latest -t  stephengrider/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push stephengrider/multi-client:latest
docker push stephengrider/multi-server:latest
docker push stephengrider/multi-worker:latest

docker push stephengrider/multi-client:$SHA
docker push stephengrider/multi-server:$SHA
docker push stephengrider/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=skgeorge/multi-server:$SHA
kubectl set image deployments/client-deployment client=skgeorge/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=skgeorge/multi-worker:$SHA