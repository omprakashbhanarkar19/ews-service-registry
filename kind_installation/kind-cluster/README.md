# steps for installation KIND , Kubectl and argocd

# Install kind cluster

1. Create config.yml file

kind create cluster --config=config.yml

2. Run kind script

3. Run kubectl script

4. Install argocd 

# Commands

kubectl get pods

kubectl get namespace or ns

kubectl get svc

kubetctl get svc -n argocd


kubectl port-forward -n argocd service/argocd-server 31837:443 --address=0.0.0.0 & --> argocd


https://3.84.178.203:31837/ -- running port no argocd


kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo   ---> password for argocd



kubectl delete -f deployment.yaml

kubectl delete -f service.yaml

kubectl port-forward svc/ews-registry-app 8761:8761 --address=0.0.0.0 & --> ews application to access on chrome
 

