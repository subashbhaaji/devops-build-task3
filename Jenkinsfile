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
                    if (env.BRANCH_NAME == 'master') {
                        env.TARGET_REPO = "${DOCKERHUB_USERNAME}/prod"
                        env.IMAGE_TAG = "prod"
                    } else {
                        env.TARGET_REPO = "${DOCKERHUB_USERNAME}/dev"
                        env.IMAGE_TAG = "dev"
                    }
                    
                    app = docker.image("${env.TARGET_REPO}:${env.IMAGE_TAG}")
                    app.build()
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'DOCKERHUB_CREDENTIALS') {
                        app.push(env.IMAGE_TAG)
                    }
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
