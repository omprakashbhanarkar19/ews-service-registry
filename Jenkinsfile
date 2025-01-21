pipeline {
    agent {
	label "EWS-dev"
	}
    
    stages {
        stage('Cloning') {
            steps {
                echo 'Cloning..'
	        cleanWs()
               //git branch: 'development', credentialsId: 'f631f3f1-f6f3-4878-b16d-57f90ee2c104', url: 'https://github.com/prodwaresol/ews-service-registry.git'
               bat "git clone -b development https://github.com/prodwaresol/ews-service-registry.git"
	    }
        }
        stage('build'){
            steps{
                echo "building ..."
                bat """
                dir
                cd ews-service-registry
                mvn clean install
                dir
                """
            }
        }
        stage('composing and getting red for next build'){
            steps {
                    echo "composing.."
                    bat """
                    cd "ews-service-registry/target"
                    """
            }
        }
        
        stage('Archive Artifacts') {
            steps {
                echo "Creating artifacts......."
                // Archive the JAR file as an artifact
                archiveArtifacts artifacts: 'ews-service-registry/target/*.jar'
        
        
		}
		}
		stage ('Copy Artifacts') {
	        steps {
			    echo "Copy Artifacts to EWS server......"
				bat """
				dir 
				cd "D:/EWS-Services/Workspace/workspace/EWS Eureka server/ews-service-registry/target"
				xcopy *.jar "D:/EWS-Services/mastek_ews_api-backend-with-gateway/Service-Registry" /s /y
				
				"""

			}
	    }
        stage ("deployment jar to EWS Dev Env") {
          steps {
		   echo "Deployment and Compose....."
           
	       //bat 'pwsh C:/Scripts/demo.ps1'
	       //  bat "powershell.exe -file C:/Scripts/script.vbs"
	        
	        script {
	       
	        bat """ C://Windows//System32//WindowsPowerShell//v1.0//powershell.exe -Command "Start-Process cmd.exe -Verb RunAs -ArgumentList '/c D:/EWS-Services/mastek_ews_api-backend-with-gateway/Service-Registry/Eureka-service.vbs'" """                         
	        
	     }
	  }  
    }
}
post {
        success {
            // Post-build actions for successful builds
            emailext ( body: '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS: <pre> \n </pre> Changes since last successful build: <pre> ${CHANGES} \n </pre> <pre> ${BUILD_LOG} </pre> <pre> ${BUILD_STATUS} </pre>, ', subject: '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!', to: 'omprakash.bhanarkar@mastek.com, hpal@prodwaresol.com, sjaiswal@prodwaresol.com', attachLog: true, )
            
        }
     
        failure {
            // Post-build actions for failed builds
            emailext ( body: '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS: <pre> \n </pre> Changes since last successful build: <pre> ${CHANGES} <pre> ${BUILD_LOG} </pre> <pre> ${BUILD_STATUS} </pre>', subject: '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!', to: 'omprakash.bhanarkar@mastek.com, hpal@prodwaresol.com, sjaiswal@prodwaresol.com', attachLog: true, )
            
        }
    }
}


