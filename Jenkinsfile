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
    stage ("Docker") {
        steps {
            sh '''
            docker --version
            docker build -t ews-backend-service:v1 /root/workspace/Docker-project/ews-service-registry
            docker images
            '''
        }
    }
    stage ("Push docker image to dockerhub") {
        steps {
            script {
                withCredentials([string(credentialsId: 'docker-hub-password', variable: 'docker-hub-password')]) {
                sh '''
                docker login -u omprakashbhanarkar -p ${docker-hub-password}
                '''    
}
              sh "docker push ews-backend-service"
            }


        }
    }
}
}