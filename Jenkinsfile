pipeline {
    agent any
    
    environment {
        AWS_REGION = 'ap-northeast-2'
        ECR_REPO_NAME = '188870935142.dkr.ecr.ap-northeast-2.amazonaws.com/project'
        DOCKER_IMAGE_NAME = 'project'
        DOCKER_IMAGE_TAG = "${env.BUILD_NUMBER}"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Docker 이미지 빌드
                    sh "docker build -t ${ECR_REPO_NAME}:${DOCKER_IMAGE_TAG} ."
                }
            }
        }

        stage('Push to ECR') {
            steps {
                script {
                    // AWS CLI를 사용하여 ECR에 Docker 이미지 푸시
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                        sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REPO_NAME}"
                        sh "docker push ${ECR_REPO_NAME}:${DOCKER_IMAGE_TAG}"
                    }
                }
            }
        }
    }
}