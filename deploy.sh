docker build -t mstandley/multi-client:latest -t mstandley/multi-client:$SHA -f ./frontend/Dockerfile ./frontend
docker build -t mstandley/multi-server:latest -t mstandley/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mstandley/multi-worker:latest -t mstandley/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push mstandley/multi-client:latest
docker push mstandley/multi-server:latest
docker push mstandley/multi-worker:latest
docker push mstandley/multi-client:$SHA
docker push mstandley/multi-server:$SHA
docker push mstandley/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mstandley/multi-server:$SHA
kubectl set image deployments/client-deployment client=mstandley/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mstandley/multi-worker:$SHA

