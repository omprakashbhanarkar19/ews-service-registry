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
                sh ''' cd /var/lib/jenkins/workspace/ews-project/ews-service-registry && mvn sonar:sonar -Dsonar.projectKey=ews-service-registry -Dsonar.host.url=${SONAR_URL} -Dsonar.login=$SONAR_AUTH_TOKEN '''
                
                }
            }
        }
        stage ("docker build") {
            environment {
                DOCKER_IMAGE = "omprakashbhanarkar/docker-cicd:${BUILD_NUMBER}"
            }
            steps {
                sh '''
                cd /var/lib/jenkins/workspace/ews-project/ews-service-registry
                docker build -t ${DOCKER_IMAGE} .
                '''
            }
        }
        stage ("docker push to dockerhub") {
            environment {
                DOCKERHUB_USERNAME = "omprakashbhanarkar"
            }
            steps {
                withCredentials([usernameColonPassword(credentialsId: 'dockerhub-cred', variable: 'DOCKER_PASS')]) {
                sh '''
                docker login -u ${DOCKERHUB_USERNAME} -p $DOCKER_PASS
                docker push ${DOCKER_IMAGE}
                '''
              }
            }
        }
    }
}
