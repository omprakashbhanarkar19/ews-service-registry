pipeline {
    agent any 

    stages {
        stage ("checkout") {
            steps {
                cleanWs()
                sh "git clone -b main https://github.com/omprakashbhanarkar19/ews-service-registry.git"
                sh "pwd"
            }
        }
        stage ("Build") {
            steps {
                sh '''
                cd /var/lib/jenkins/workspace/ews-project/ews-service-registry
                mvn clean install
                ''' 
            }
        }
        stage ("sonar-scanner") {
            environment {
                SONAR_URL = "http://3.91.15.120:9000/"
            }
            steps {
            //    withCredentials([string(credentialsId: 'sonarqube-token', variable: 'SONAR_AUTH_TOKEN')]) {
            //    sh ''' mvn clean verify sonar:sonar \ 
            //    -Dsonar.projectKey=/var/lib/jenkins/workspace/ews-project \ 
            //    -Dsonar.host.url=${SONAR_URL} \
            //    -Dsonar.login=$SONAR_AUTH_TOKEN \'''' 
            sh '''  
                    cd /var/lib/jenkins/workspace/ews-project/ews-service-registry
                     mvn clean verify sonar:sonar \
                    -Dsonar.projectKey=ews-service-registry \
                    -Dsonar.host.url=http://3.91.15.120:9000 \
                    -Dsonar.login=9e0af1c978d58dafd27f39fda197ef42a0b8477c '''  
    
                }
            }
        }
    }
