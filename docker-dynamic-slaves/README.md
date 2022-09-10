# Jenkins-docker-slave

Jenkins has powerful feature of master slave architecture which enables distributed builds. In This repository we will learn how to setup slave nodes using Docker and integrate with Jenkins Master.

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

 **Step 1** - Configure Docker Host with Remote API
Login to Docker host machine. Open docker service file. Search for ExecStart and replace that line with the following.
```
sudo vi /lib/systemd/system/docker.service
```


**You can replace with below line:**
```
ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock
```

**Restart Docker service**
```
sudo systemctl daemon-reload

sudo service docker restart
```


Validate API by executing below curl command
```
curl http://localhost:4243/version
```

![image](https://user-images.githubusercontent.com/92631457/185804619-0f353c6e-3a40-4216-a590-c95cf530e3f2.png)


**Step 2** - Build Jenkins slave Docker image
Download Dockerfile from below repo.

```
git clone https://github.com/tarunk0/dynamic-jenkins-slaves.git;  cd dynamic-jenkins-slaves
```
**Build Docker image**

```
sudo docker build -t my-jenkins-slave .
```

![image](https://user-images.githubusercontent.com/92631457/185804635-7b312a91-9ce1-4867-a7b0-48824c4e7cdc.png)



**Perform below command to see the list of docker images:**
```
sudo docker images
```
![image](https://user-images.githubusercontent.com/92631457/185804650-509a6e17-32bf-4a58-844c-72449f8eebbe.png)

**Step 3** - Configure Jenkins Server with Docker plug-in
Now login to Jenkins Master. Make sure you install Docker plug-in in Jenkins.

![image](https://user-images.githubusercontent.com/92631457/185804667-021006b8-d5e3-4634-b081-dbdabb900fc8.png)


**Now go to Manage Jenkins -> Configure Nodes Cloud**

![image](https://user-images.githubusercontent.com/92631457/185804676-3ea7e7ee-b3a1-4e8d-a3a5-80f54f8191b2.png)


**Click on Docker Cloud Details**

![image](https://user-images.githubusercontent.com/92631457/185804692-05c61f8c-232b-43cf-94b4-678079599f43.png)


Enter docker host dns name or ip address
tcp://docker_host_dns:4243
Make sure Enabled is selected
Now click on Test Connection to make sure connecting with docker host is working. 

![image](https://user-images.githubusercontent.com/92631457/185804706-93596c8b-d885-4c6b-8de9-b11cc855d518.png)



**Step 4** - Configure Docker Agent Templates
Now click on Docker Agent templates:

Enter label as "docker-slave" and give some name

Click on Enabled

Now enter the name of the docker image you have built previously in docker host.

enter /home/jenkins as Remote file system root
 
![image](https://user-images.githubusercontent.com/92631457/185804714-ba9ae0fe-2251-4622-9438-7d03574ac96a.png)


Choose Connect with SSH as connection method:

Enter SSH credentials per your Dockerfile - jenkins/password

![image](https://user-images.githubusercontent.com/92631457/185804728-57fbc970-728f-4b11-9e8f-2f9d6ef4e9ac.png)


choose Never Pull as pull strategy as we have already image stored in DockerHost.

![image](https://user-images.githubusercontent.com/92631457/185804735-cdaca900-0ec1-42f4-b263-4eb91067c58a.png)

Click on Save.

**Step 5** - Create build job in Jenkins

Now Create a pipeline job in Jenkins with below pipeline code:

``` pipeline {
    agent { 
        label "docker-slave"
     }
    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
    }
}

```
**Click Apply and Save. **


Now build the job. Now you will see output like below:

![image](https://user-images.githubusercontent.com/92631457/185804752-084dbad8-fd34-4122-94e7-1c2ba3952c52.png)



**Create a free style job**


Choose Restrict where this project can be run and enter docker-slave as label.

![image](https://user-images.githubusercontent.com/92631457/185804765-c6de5321-f0b1-47be-8b51-9d8c1e6ad987.png)
