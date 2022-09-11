# Jenkins Installation using Helm Charts in k8s-cluster:

 - Go to artifacthub.io and search for Jenkins Helm Chart
 - Read the instructions on how to install the charts.
 
![image](https://user-images.githubusercontent.com/92631457/189499277-d7349c0f-8669-4d4f-a43a-4be26dee0d6f.png)
 
 - Add the repo.
 
```sh
   helm repo add jenkins https://charts.jenkins.io
```
 - Update the repo

```sh
   helm repo update
```
![image](https://user-images.githubusercontent.com/92631457/189499711-9ef6d854-c9fe-4c26-a0df-d34a8ddff063.png)

 - Before installing the chart, Pull the chart using --untar command and check it's content and check if any changes are required!

![image](https://user-images.githubusercontent.com/92631457/189499798-5cea13b0-5109-4c8c-8229-41bc3dbe4802.png)

- Now after making the changes as required, like changing the servicetype to NodePort  or Load Balancer save the file and then install the chart by giving it some name. Check other configurations also then intall the chart using helm install <release name> <chart name>

![image](https://user-images.githubusercontent.com/92631457/189500145-744e21a1-a743-4786-868c-aa3c8df06374.png)

- Open Jenkins in your browser using Loadbalancer IP iff you are using cloud cluster or Use Nodeport service if you are using normal cluster. 
