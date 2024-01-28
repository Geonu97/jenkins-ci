pipeline {
    agent any

    environment {
        ECR_REGISTRY = '188870935142.dkr.ecr.ap-northeast-2.amazonaws.com'
        AWS_REGION = 'ap-northeast-2'
        DOCKER_IMAGE_NAME = 'project'
        DOCKER_IMAGE_TAG = "${env.BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build and Push Docker Image to ECR') {
            steps {
                script {
                    // Use Jenkins global AWS credentials
                    withCredentials([awsAccessKey(credentialsId: 'AWS', accessKeyVariable: 'ACCESS_KEY_ID', secretKeyVariable: 'SECRET_ACCESS_KEY')]) {
                        // AWS ECR login
                        sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REGISTRY}"

                        // Docker build command
                        sh "docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} ."

                        // Docker tag and push to ECR
                        sh "docker tag ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} ${ECR_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                        sh "docker push ${ECR_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                    }
                }
            }
        }
    }
}