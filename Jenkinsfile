pipeline {
    agent any
    stages {
         stage('Hello') { 
            steps { 
             // withAWS(roleAccount:'466557447748', role:'arn:aws:iam::466557447748:role/EC2-to-call-ECR') {
                sh '''
                    aws ecr list-images --repository-name centos
                '''
              //      }
                }
            }
        }
       stages {
         stage('Hello') { 
            steps { 
             // withAWS(roleAccount:'466557447748', role:'arn:aws:iam::466557447748:role/EC2-to-call-ECR') {
                sh '''
                    aws ecr list-images --repository-name centos
                '''
              //      }
                }
            }
        }
}        
