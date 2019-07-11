docker build -t sivagurunathan/docker-fib-client:latest -t sivagurunathan/docker-fib-client:$SHA -f ./client/Dockerfile ./client
docker build -t sivagurunathan/docker-fib-server:latest -t sivagurunathan/docker-fib-server:$SHA -f ./server/Dockerfile ./server
docker build -t sivagurunathan/docker-fib-worker:latest -t sivagurunathan/docker-fib-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sivagurunathan/docker-fib-client:latest
docker push sivagurunathan/docker-fib-server:latest
docker push sivagurunathan/docker-fib-worker:latest

docker push sivagurunathan/docker-fib-client:$SHA
docker push sivagurunathan/docker-fib-server:$SHA
docker push sivagurunathan/docker-fib-worker:$SHA

kubectl apply -f k8s

kubectl set image deployment/server-deployment server=sivagurunathan/docker-fib-server:$SHA
kubectl set image deployment/client-deployment client=sivagurunathan/docker-fib-client:$SHA
kubectl set image deployment/worker-deployment worker=sivagurunathan/docker-fib-worker:$SHA
