pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-northeast-2'
        ECR_REPO_NAME = '188870935142.dkr.ecr.ap-northeast-2.amazonaws.com/project'
        DOCKER_IMAGE_NAME = 'project'
        DOCKER_IMAGE_TAG = "${env.BUILD_NUMBER.take(6)}"
        ECR_PATH = "188870935142.dkr.ecr.ap-northeast-2.amazonaws.com"
        AWS_CREDENTIAL_NAME = 'AWS'
        GIT_CREDENTIAL_NAME = 'Git_Jenkins_ci'
        HELM_CHART_REPO = 'https://github.com/Geonu97/Helm-chart-project-app.git'
        HELM_CHART_PATH = 'Geonu97/Helm-chart-project-app'
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

        stage('Configure Git') {
            steps {
                script {
                    // Git 사용자 정보 설정
                    sh "git config --global user.email 'player97@daum.net'"
                    sh "git config --global user.name Geonu97"
                }
            }
        }

        stage('Update Helm Chart Image Tag') {
            steps {
                script {
                    // Git 리포지토리 클론
                    withCredentials([usernamePassword(credentialsId: "${GIT_CREDENTIAL_NAME}", passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        git branch: 'main', credentialsId: "${GIT_CREDENTIAL_NAME}", url: "${HELM_CHART_REPO}"
                        
                        // 이미지 태그 업데이트
                        sh "sed -i 's|tag: \".*\"|tag: \"${DOCKER_IMAGE_TAG}\"|' values.yaml"
                        
                        // 변경 사항을 Git에 푸시
                        sh "git add values.yaml"
                        sh "git commit -m 'Update image tag in Helm Chart'"
                        sh "git remote set-url origin ${HELM_CHART_REPO}"
                        sh "git push --set-upstream origin main"
                    }
                }
            }
        }
    }
}
