# Jenkins-docker-slave

Jenkins has powerful feature of master slave architecture which enables distributed builds. This article we will learn how to setup slave nodes using Docker and integrate with Jenkins Master.

![image](https://user-images.githubusercontent.com/92631457/185803451-b7ba3db2-a2ea-46b2-8ef2-8afbd32e3e94.png)

Advantages of using Docker Containers as Jenkins Build Agents:
- Ephemeral
- Better resource utilization
- Customized agents as it can run different builds like Java 8, Java 11 
- Scalability
##  Let's see how we can set up dynamic jenkins slaves (nodes) with Jenkins Master:

Pre-requisites:
* Jenkins Master is already setup and running.
* port 8080 opened in Jenkins EC2's firewall rule.
* Setup Docker host. Creating another EC2 instance is recommended to serve as a Docker Host. 
* port 4243 opened in docker host machine.
* 32768 - 60999 opened in docker host machine.

![image](https://user-images.githubusercontent.com/92631457/185803427-53833d8e-d8a7-47e1-9411-bd3fecca6a06.png)

### Step 1 - Configure Docker Host with Remote API
Login to Docker host machine. Open docker service file. Search for ExecStart and replace that line with the following.
sudo vi /lib/systemd/system/docker.service


You can replace with below line:
ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock

Restart Docker service
'sudo systemctl daemon-reload
 sudo service docker restart'

Validate API by executing below curl command
curl http://localhost:4243/version
