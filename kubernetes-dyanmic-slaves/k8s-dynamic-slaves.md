# JENKINS DYANAMIC SLAVES IN KUBERNETES:

 - If you are using Jenkins in the same kubernetes cluster using helm then all the configuration is done by default just use the correct pipeline syntax and your Jenkins Slave pods will execute your jobs. 
 - Ex:1
 
```sh
pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        metadata:
          labels:
            app: test
        spec:
          containers:
          - name: maven
            image: maven:alpine
            command:
            - cat
            tty: true
          - name: node
            image: node:7-alpine
            command:
            - cat
            tty: true
        '''
    }
  }
  stages {
    stage('Test Maven & Node') {
      steps {
        container('maven') {
          sh 'mvn -version'
        }
        container('node') {
          sh 'node --version'
        }
      }
    }
  }
}
```

 - Ex:2
 
 ```sh
 pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        metadata:
          labels:
            app: test
        spec:
          containers:
          - name: maven
            image: maven:3.8.3-adoptopenjdk-11
            command:
            - cat
            tty: true
          - name: git
            image: bitnami/git:latest
            command:
            - cat
            tty: true
        '''
    }
  }
  stages {
    stage('Clone SCM') {
      steps{
        container('git') {
          sh 'git clone https://github.com/kunchalavikram1427/maven-employee-web-application.git .'
        }
      }
    }
    stage('Build Project') {
      steps {
        container('maven') {
          sh 'mvn clean package'
        }
      }
    }
  }
}
```

 - If your jenkins is running in any other instance outside your cluster then you have to create the credentials using kubeconfig or create secrets and service account in kubernetes. Then configure the kubernetes cloud in jenkins. 
