pipeline {
   environment {
    registry = "sowmyabv123/hearti-health-app"
    registryCredential = 'docker_hub'
    dockerImage = ''
  }
   agent any
   stages {
	   stage('npm install package'){
                steps{
                    sh label: '', script: '''
                         npm install  --save-dev  --unsafe-perm node-sass
                         npm start 
                         npm stop
                     '''
                     echo 'Installing packages completed...'
                    }
            }
                stage('Build'){
                    steps{
                        sh 'npm run ng -- build --prod' 
                        echo 'Build Completed...'
                        
                    }
                }
               stage ('Archive') {
                steps{
                  echo "Archiving Project"
                  archiveArtifacts artifacts: 'dist/*.zip', followSymlinks: false
                }
              }
               stage ('Build Docker Image') {
          steps{
            echo "Building Docker Image"
             script {
              dockerImage = docker.build registry + ":$BUILD_NUMBER"
            }
          }
        }
        stage ('Push Docker Image') {
          steps{
            echo "Pushing Docker Image"
             script {
              docker.withRegistry( '', registryCredential ) {
                  dockerImage.push()
                  dockerImage.push('latest')
              }
            }
          }
        }
        stage ('Deploy to Dev') {
          steps{
            echo "Deploying to Dev Environment"
            sh "docker rm -f hearti-health-app || true"
            sh "docker run -d --name=hearti-health-app -p 8081:8080 sowmyabv123/hearti-health-app"
          }
        }
  }
}
	  
}
}
