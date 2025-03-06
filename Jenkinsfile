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
                withCredentials([string(credentialsId: 'sonarqube-token', variable: 'SONAR_AUTH_TOKEN')]) {
                sh ''' mvn sonar:sonar -Dsonar.url=${SONAR_URL}/ -Dsonar.login=$SONAR_AUTH_TOKEN -Dsonar.projectName=/var/lib/jenkins/workspace/ews-project/ews-service-registry \
	                -Dsonar.java.binaries=. \
                    -Dsonar.projectKey=/var/lib/jenkins/workspace/ews-project/ews-service-registry '''
    
                }
            }
        }
    }
}