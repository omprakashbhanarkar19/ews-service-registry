pipeline {
    agent {
        label "docker"
    }
    tools {
        maven 'maven'
    }
  stages {
    stage ('install git') {
        steps {
        sh "yum install git -y"
      }
    }  
    stage ('Cloning') {
        steps {
            cleanWs()
            sh '''
            git clone -b main https://github.com/omprakashbhanarkar19/ews-service-registry.git
            git --version
            mvn --version
            '''
            
        } 
    }
    stage ("Build") {
        steps {
            sh '''
            cd "/root/workspace/Docker-project/ews-service-registry"
            mvn clean install
            ls target
            '''

        }
    }
    stage ("loggin dockerhub account") {
        steps {
            script {
                withCredentials([string(credentialsId: 'docker-hub-password', variable: 'dockerhubpassword')]) {
                
                sh 'docker login -u omprakashbhanarkar -p ${dockerhubpassword}'   
            }
        }
    }
    }
    stage ("Docker build and push ") {
        steps {
            script {
                sh '''
                #!/bin/bash
                
                # File to store the current version
                VERSION_FILE="/root/workspace/Docker-project/ews-service-registry/version.txt"
                
                # Check if the version file exists
if [ ! -f "$VERSION_FILE" ]; then
    echo "1.0.0" > "$VERSION_FILE"  # Initialize if version file doesn't exist
fi
            # Read the current version
VERSION=$(cat "$VERSION_FILE")

                export VERSION="1.0.0"
                IFS='.' read -r major minor patch <<< "$VERSION"
                patch=$((patch + 1))
                NEW_VERSION="$major.$minor.$patch"
                export VERSION=$NEW_VERSION
                docker build -t omprakashbhanarkar/ews-backend-service:${VERSION} /root/workspace/Docker-project/ews-service-registry
                docker push omprakashbhanarkar/ews-backend-service:${VERSION}
                '''

            }
            
        }
    }
    
}
}