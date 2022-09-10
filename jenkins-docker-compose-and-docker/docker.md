# Jenkins Setup using Docker Imperative command for persistent sotrage even after the container is restarted!


 ## Prequisites:
  - Make sure the docker is up and running
  
  - Then run the follwoing command that's it, and check the logs and you are good to go.
  
```sh
   docker run --name jenkins -d -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts
```
