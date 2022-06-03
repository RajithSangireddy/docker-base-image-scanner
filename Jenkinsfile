pipeline {
    agent any
    options {
        skipStagesAfterUnstable()
    }
    stages {
         stage('Clone repository') { 
            steps { 
                script{
                checkout https://github.com/RajithSangireddy/docker-base-image-scanner.git
                }
            }
        }
        stage('Test'){
            steps {
                 echo 'Empty'
            }
        }

        stage('Build') { 
            steps { 
               sh '''
                docker build -t centos7:${env.BUILD_NUMBER} .
               '''
            }
        }
        stage('Test'){
            steps {
                 echo 'Empty'
            }
        }
        stage('Deploy') {
            steps {
                    sh '''
                        aws ecr get-login-password --region us-east-2 | sudo docker login --username AWS --password-stdin 466557447748.dkr.ecr.us-east-2.amazonaws.com
                        sudo docker tag centos7:${env.BUILD_NUMBER} 466557447748.dkr.ecr.us-east-2.amazonaws.com/centos7:${env.BUILD_NUMBER}
                        sudo docker push 466557447748.dkr.ecr.us-east-2.amazonaws.com/centos7:${env.BUILD_NUMBER}
                    '''
                }
        }
    }
}
