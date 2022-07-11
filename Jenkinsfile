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
        
        //stage('Parameter ') { 
        //    steps { 
        //        script{
        //            println params.Distribution
        //       }
        //   echo "Just testing"
        //    }
        //}
        
        stage('Build') { 
            steps { 
               sh '''
                #for file in `cat centos.txt`; do sudo docker build --target $file -t $file:$file .; done
                for file in `grep -v '#' Dockerfile | awk 'NF>1{print $NF}'`; do sudo docker build --target $file -t $file:$file .; done
               '''
            }
        }
        
        stage ('Artifactory configuration') {
            steps {
                rtServer (
                    id: "ARTIFACTORY_SERVER",
                    url: 'https://rajith.jfrog.io/artifactory',
                    credentialsId: '0bde53a0-d8b4-4b40-b51c-b6859aee8123'
                )

                xrayScan (
                    serverId: 'ARTIFACTORY_SERVER',
                    // If the build name and build number are not set here, the current job name and number will be used:
                    buildName: 'scan-docker-image-pipeline',
                    buildNumber: "${BUILD_NUMBER}",
                    // Optional - Only if this build is associated with a project in Artifactory, set the project key as follows.
                    //project: 'my-project-key',   
                    // If the build is found vulnerable, the job will fail by default. If you do not wish it to fail:
                    failBuild: true
                )
            }
        }
        
        stage('Test'){
            steps {
                 echo 'Empty'
            }
        }
        
        stage ('Push image to Artifactory') {
            steps {
                sh '''
                    for file in `grep -v '#' Dockerfile | awk 'NF>1{print $NF}'`; do sudo docker tag "$file:$file" "rajith.jfrog.io/artifactory-docker-dev-local/$file:secure-$file"; done
                    for file in `grep -v '#' Dockerfile | awk 'NF>1{print $NF}'`; do sudo docker push "rajith.jfrog.io/artifactory-docker-dev-local/$file:secure-$file"; done
                '''
            }
        }
        
        stage ('Publish build info') {
            steps {
                rtPublishBuildInfo (
                    serverId: "ARTIFACTORY_SERVER"
                )
            }
        }
        
        //stage('Scan'){
        //    steps {
        //        xrayScan (
        //            serverId: "ARTIFACTORY_SERVER",
                    // If the build name and build number are not set here, the current job name and number will be used:
        //            buildName: 'my-build-name',
        //            buildNumber: "${BUILD_NUMBER}",
                    // Optional - Only if this build is associated with a project in Artifactory, set the project key as follows.
                    //project: 'my-project-key',   
                    // If the build is found vulnerable, the job will fail by default. If you do not wish it to fail:
        //            failBuild: true
        //        )
        //    }
        //}
        //stage('Deploy') {
        //    steps {
        //            sh '''
        //               aws ecr get-login-password --region us-east-2 | sudo docker login --username AWS --password-stdin 466557447748.dkr.ecr.us-east-2.amazonaws.com
        //                # sudo docker tag "centos7:${BUILD_NUMBER}" "466557447748.dkr.ecr.us-east-2.amazonaws.com/centos:${BUILD_NUMBER}"
        //               for file in `cat centos.txt`; do sudo docker tag "$file:$file" "466557447748.dkr.ecr.us-east-2.amazonaws.com/centos:$file"; done
        //                #sudo docker push 466557447748.dkr.ecr.us-east-2.amazonaws.com/centos
        //                for file in `cat centos.txt`; do sudo docker push "466557447748.dkr.ecr.us-east-2.amazonaws.com/centos:$file"; done
        //            '''
        //        }
        //}
        //stage('Sleep') {
        //    steps {
        //      sleep time: 60000, unit: 'MILLISECONDS'
        //        }
        //}
        //stage('ReadScanFindings') {
        //    steps {
        //            sh '''
        //                sudo chmod +x ./ReadScanFindings.sh
        //                sudo ./ReadScanFindings.sh
        //           '''
        //        }
        //}        
    }
}
