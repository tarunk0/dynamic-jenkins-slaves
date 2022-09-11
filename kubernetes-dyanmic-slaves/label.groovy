#slave having any label
pipeline {
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
