docker build -t marco1022/multi-client:latest -t marco1022/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t marco1022/multi-server:latest -t marco1022/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t marco1022/multi-worker:latest -t marco1022/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push marco1022/multi-client:latest
docker push marco1022/multi-server:latest
docker push marco1022/multi-worker:latest

docker push marco1022/multi-client:$SHA
docker push marco1022/multi-server:$SHA
docker push marco1022/multi-worker:$SHA

kubectl apply -f k8s
kubuctl set image deployments/server-deployment server=marco1022/multi-server:$SHA
kubuctl set image deployments/client-deployment client=marco1022/multi-client:$SHA
kubuctl set image deployments/worker-deployment worker=marco1022/multi-worker:$SHA