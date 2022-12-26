pipeline {
    agent {
        label 'new123'
    }
    environment {
        registry = "706274417810.dkr.ecr.ap-south-1.amazonaws.com/springboot"
    }
    
	   
    stages{
          stage('git'){
           steps{
               checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: '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', url: 'https://github.com/sanataba/k8sdemo']]])
           }
        } 
          stage('Build') {
            steps {
                script {
                    sh 'mvn clean install'
                }
            }
        } 
        stage('docker build'){
            steps{
                script{
                    sh 'docker build -t kpdocker .'
                    sh 'docker tag kpdocker:latest 706274417810.dkr.ecr.ap-south-1.amazonaws.com/kpdocker:latest'
                }
            }
        }
            
        stage('aws login'){
            steps{
              sh 'aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 706274417810.dkr.ecr.ap-south-1.amazonaws.com'
          }
      } 
         stage('DockerPush to AWS ECR'){
            steps{
                sh 'docker push 706274417810.dkr.ecr.ap-south-1.amazonaws.com/springboot:latest'
            }
        } 

        stage('EKS Deployment'){
            steps{
                script{
                    withKubeConfig([credentialsId: 'K8s', serverUrl: '']) 
                    {
		        sh 'chmod +x changeTag.sh'
			sh './changeTag.sh $BUILD_NUMBER'
//			sh 'kubectl delete --all pods'
			sh 'kubectl apply -f  Deployment.yml'
                    }
                  }
                }    
              }  
    }
}
