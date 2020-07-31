pipeline {
   agent any
   tools {
		maven 'Maven-3.6.3'
		jdk 'jdk1.8.0_231'
    }
   stages {
       stage('Git-Checkout') {
         steps {
            echo 'Checking out from Gitlab Repo'
            git 'https://github.com/bvss1994/HeartiHealthProject.git'
         }
      }
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
                
            stage('Build docker image and push to docker hub') {
         steps {
            sh label: '', script: '''
            cd /home/bitnami/HeartiHealthProject
            docker login -u sowmyabv123 -p nov091994
            docker build -t sowmyabv123/hearti-health-app .
            docker push sowmyabv123/hearti-health-app
            '''
         }
      }    
	  
}
}
