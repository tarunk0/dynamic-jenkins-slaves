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

![image](https://user-images.githubusercontent.com/92631457/189523584-b5a88d24-6a2d-4e16-95f9-ae62dd88f609.png)

![image](https://user-images.githubusercontent.com/92631457/189523668-3db9edea-04bd-4e17-891c-2691e4c8859a.png)

![image](https://user-images.githubusercontent.com/92631457/189523740-23fe4577-e4db-48f4-bea9-b7e1fd7db842.png)

![image](https://user-images.githubusercontent.com/92631457/189523810-ef6cbdcf-d451-4782-a0d5-e18d50e16859.png)

 - Now there is no need of doing any other configuration like adding the jnlp pod template and all. As jnlp pod would be automatically launched and rest we define in the groovy pipeline whatever container we need. The containers will be created in the same pod. This way we can even restrict which stage to run and which not.(This is very helpful in development phase when we try and test the pipeline and debug it) and which stage should use which container. 

 ## Create Secrets and Service Account to connect to cluster
 
  - if you want to connect to any CSPs k8s cluster like GKE or EKS or AKS then create a service account and secret and connect to your cluster, i have experimented that is the only feasible way especially for GKE, else you cant connect with the cluster using the kube config file. 
  - Just run this manifest in your cluster and you are good to go. 
  - Run commands like ```kubectl get secrets``` then just describe the secret using ```kubectl describe <secret name> ```

```sh
apiVersion: v1
kind: ServiceAccount
metadata:
  name: jenkins-sa
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: jenkins
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["create","delete","get","list","patch","update","watch"]
- apiGroups: [""]
  resources: ["pods/exec"]
  verbs: ["create","delete","get","list","patch","update","watch"]
- apiGroups: [""]
  resources: ["pods/log"]
  verbs: ["get","list","watch"]
- apiGroups: [""]
  resources: ["secrets"]
  verbs: ["get"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: jenkins-role-binding
  namespace: default
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: jenkins
subjects:
- kind: ServiceAccount
  name: jenkins-sa
  namespace: default
 ```
https://raw.githubusercontent.com/kunchalavikram1427/jenkins-cloud-agents/master/jenkins-sa.yml
