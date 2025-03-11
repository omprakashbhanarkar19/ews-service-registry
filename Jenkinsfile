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
                IMAGE = "omprakashbhanarkar/docker-cicd"
                TAG = "${BUILD_NUMBER}"
            }
           
            steps {
                script {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', passwordVariable: 'DOCKERHUB_PASS', usernameVariable: 'DOCKERHUB_USER')]) {
                sh ''' docker login -u $DOCKERHUB_USER -p $DOCKERHUB_PASS '''
                }      

                sh "docker push ${IMAGE}:${BUILD_NUMBER}"

              }
            }
        }
    }
}

/*
stage('Update Deployment File') {
        environment {
            GIT_REPO_NAME = "Jenkins-Zero-To-Hero"
            GIT_USER_NAME = "iam-veeramalla"
        }
        steps {
            withCredentials([string(credentialsId: 'github', variable: 'GITHUB_TOKEN')]) {
                sh '''
                    git config user.email "abhishek.xyz@gmail.com"
                    git config user.name "Abhishek Veeramalla"
                    BUILD_NUMBER=${BUILD_NUMBER}
                    sed -i "s/replaceImageTag/${BUILD_NUMBER}/g" java-maven-sonar-argocd-helm-k8s/spring-boot-app-manifests/deployment.yml
                    git add java-maven-sonar-argocd-helm-k8s/spring-boot-app-manifests/deployment.yml
                    git commit -m "Update deployment image to version ${BUILD_NUMBER}"
                    git push https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:main
                '''
            }
        }
    } */