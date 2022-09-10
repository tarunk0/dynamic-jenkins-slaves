# How to set up Jenkins using Docker-Compose?

Jenkins is an open source continuous integration/continuous delivery and deployment (CI/CD) automation software DevOps tool written in the Java programming language. It is used to implement CI/CD workflows, called pipelines.

  ## How to setup Jenkins using Docker Compose?

   - Jenkins is Continuous integration server. It is open source and Java based tool. Jenkins can be setup using Docker Compose with less manual steps.

  ## What is Docker Compose?

  - Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration. Since Docker Compose lets you configure related containers in a single YAML file, you get the same Infrastructure-as-Code abilities as Kubernetes. But they come in a simpler system that’s more suited to smaller applications that don’t need Kubernetes’ resiliency and scaling.

  - The purpose of docker-compose is to function as docker cli but to issue multiple commands much more quickly. To make use of docker-compose, you need to encode the commands you were running before into a docker-compose.yml file

  - Run docker-compose up and Compose starts and runs your entire app.

  ## Pre-requisites:

  - New Ubuntu EC2 up and running with at least t2.small
  - Port 8080 is opened in security firewall rule
  - Perform system update

 ```
    sudo apt-get update
 ```
   - Install Docker-Compose
   
 ```
   sudo apt-get install docker-compose -y
```
   - Create docker-compose.yml

   - This yml has all configuration for installing Jenkins.

```sh
  sudo vi docker-compose.yml
  #copy and paste the below code
  

  version: ‘3’
  services:
  jenkins:
  image: jenkins/jenkins:lts
  restart: always
  privileged: true
  user: root
  ports:
  - 8080:8080
  - 50000:50000
  container_name: jenkins
  volumes:
  - /home/ubuntu/jenkins_compose/jenkins_configuration:/var/jenkins_home
  - /var/run/docker.sock:/var/run/docker.sock
  #Save the file by entering :wq!
```

  - Execute Docker compose command:

```
  sudo docker-compose up -d
```

  - Make sure Jenkins is up and running by checking the logs

```
   sudo docker-compose logs — follow
```

  - Once you see the message, that’s it. Jenkins is been installed successfully. press control C and enter.

  - Now access Jenkins UI by going to browser and enter public dns name with port 8080

  - Now to go to browser → http://your_jenkins_publicdns_name:8080/

  - You can get the Admin password from above command as well.

  - Enter Admin Password


  - Enter the password and Click on continue.

  - Then click on install suggested plugins.
  - Also create username and password.
  - Enter everything as admin. At Least user name as admin password as admin
  - Click on Save and Finish. Click on start using Jenkins. Now you should see a screen like below:


  - That’s it. You have setup Jenkins successfully using Docker Compose.

  - To Clean Up Resources:
```
  sudo docker compose down
```
  - This would stop the Jenkins container that is running.

