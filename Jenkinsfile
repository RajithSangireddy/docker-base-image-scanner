pipeline {
    agent any
    options {
        skipStagesAfterUnstable()
    }
    stages {
         stage('Clone repository') { 
            steps { 
                script{
                git branch: 'main', url: 'https://github.com/RajithSangireddy/docker-base-image-scanner.git'
                }
            }
        }
        stage('Build') { 
            steps { 
               sh '''
                sudo docker build -t "centos7:${BUILD_NUMBER}" .
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
                        sudo docker tag "centos7:${BUILD_NUMBER}" "466557447748.dkr.ecr.us-east-2.amazonaws.com/centos7:${BUILD_NUMBER}"
                        sudo docker push "466557447748.dkr.ecr.us-east-2.amazonaws.com/centos7:${BUILD_NUMBER}"
                    '''
                }
        }
    }
}
