pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        DOCKERHUB_USERNAME = 'subashbhaaji'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build & Tag Docker Image') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'master' || env.BRANCH_NAME == 'main') {
                        env.TARGET_REPO = "${DOCKERHUB_USERNAME}/prod"
                        env.IMAGE_TAG = "prod"
                    } else {
                        env.TARGET_REPO = "${DOCKERHUB_USERNAME}/dev"
                        env.IMAGE_TAG = "dev"
                    }
                    
                    // Build using standard docker CLI command via shell
                    sh "docker build -t ${env.TARGET_REPO}:${env.IMAGE_TAG} ."
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    // Log in and push using standard Docker CLI commands
                    sh "echo \$DOCKERHUB_CREDENTIALS_PSW | docker login -u \$DOCKERHUB_CREDENTIALS_USR --password-stdin"
                    sh "docker push ${env.TARGET_REPO}:${env.IMAGE_TAG}"
                }
            }
        }
        stage('Deploy to AWS EC2') {
            steps {
                script {
                    sh './deploy.sh'
                }
            }
        }
    }
}
