pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-northeast-2'
        ECR_REPO_NAME = '188870935142.dkr.ecr.ap-northeast-2.amazonaws.com/project'
        DOCKER_IMAGE_NAME = 'project'
        DOCKER_IMAGE_TAG = "${env.BUILD_NUMBER}"
        ECR_PATH = "188870935142.dkr.ecr.ap-northeast-2.amazonaws.com"
        AWS_CREDENTIAL_NAME = 'AWS'
    }

    stages {
        stage('Build and Push to ECR') {
            steps {
                script {
                    // Docker 이미지 빌드 및 ECR에 푸시
                    docker.withRegistry("https://${ECR_PATH}", "ecr:${AWS_REGION}:${AWS_CREDENTIAL_NAME}") {
                        def customImage = docker.build("${ECR_REPO_NAME}:${DOCKER_IMAGE_TAG}", "-t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} .")
                        customImage.push()
                    }
                }
            }
        }
    }
}
