pipeline {
    agent any
    
    environment {
        ECR_REPO_URL = '188870935142.dkr.ecr.ap-northeast-2.amazonaws.com/project'
        IMAGE_NAME = 'project'
        IMAGE_TAG = '${env.BUILD_NUMBER}'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build and Push to ECR') {
            steps {
                script {
                    // Docker 빌드
                    sh "docker build -t $IMAGE_NAME:$IMAGE_TAG ."
                    
                    // 이미지를 ECR에 푸시
                    sh "docker tag $IMAGE_NAME:$IMAGE_TAG $ECR_REPO_URL/$IMAGE_NAME:$IMAGE_TAG"
                    
                    // AWS ECR에 로그인
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        credentialsId: 'AWS',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                    ]]) {
                        sh "aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin $ECR_REPO_URL"
                    }

                    sh "docker push $ECR_REPO_URL/$IMAGE_NAME:$IMAGE_TAG"
                }
            }
        }
    }
}
