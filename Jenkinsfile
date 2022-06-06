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
                for file in `cat centos.txt`; do sudo docker build --target $file -t $file:$file .; done
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
                        # sudo docker tag "centos7:${BUILD_NUMBER}" "466557447748.dkr.ecr.us-east-2.amazonaws.com/centos:${BUILD_NUMBER}"
                        for file in `cat centos.txt`; do sudo docker tag "$file:$file" "466557447748.dkr.ecr.us-east-2.amazonaws.com/centos:$file"; done
                        #sudo docker push 466557447748.dkr.ecr.us-east-2.amazonaws.com/centos
                        for file in `cat centos.txt`; do sudo docker push "466557447748.dkr.ecr.us-east-2.amazonaws.com/centos:$file"; done
                    '''
                }
        }
        stage('Sleep') {
            steps {
              sleep time: 60000, unit: 'MILLISECONDS'
                }
        }
        stage('ReadScanFindings') {
            steps {
                    sh '''
                        sudo chmod +x ./ReadScanFindings.sh
                        sudo ./ReadScanFindings.sh
                    '''
                }
        }        
    }
}
