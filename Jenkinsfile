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
            git clone -b main git@github.com:omprakashbhanarkar19/ews-service-registry.git
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
                sh 'chmod 777 /root/workspace/Docker-project/ews-service-registry/version.txt'  
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
                # Update the version file with the new version
                echo "${NEW_VERSION}" >> "${VERSION_FILE}"
                export VERSION=$NEW_VERSION
                docker build -t omprakashbhanarkar/ews-backend-service:${VERSION} /root/workspace/Docker-project/ews-service-registry
                docker push omprakashbhanarkar/ews-backend-service:${VERSION}
               
               # Commit the updated version file to GitHub
cd /root/workspace/Docker-project/ews-service-registry
git add "$VERSION_FILE"
git commit -m "Updated version to $NEW_VERSION"
git push ssh-origin main

echo "Docker image built and pushed with version: ${VERSION}"
echo "Version file updated and changes pushed to GitHub."

                '''

            }
            
        }
    }
    
}
}