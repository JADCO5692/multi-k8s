docker build -t himanshu5692/multi-client:latest -t himanshu5692/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t himanshu5692/multi-server:latest -t himanshu5692/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t himanshu5692/multi-worker:latest -t himanshu5692/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push himanshu5692/multi-client:latest
docker push himanshu5692/multi-server:latest
docker push himanshu5692/multi-worker:latest

docker push himanshu5692/multi-client:$SHA
docker push himanshu5692/multi-server:$SHA
docker push himanshu5692/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=himanshu5692/multi-server:$SHA
kubectl set image deployments/client-deployment client=himanshu5602/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=himanshu5692/multi-worker:$SHA
