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
                    // Select repo and tag based on active branch
                    if (env.BRANCH_NAME == 'master') {
                        env.TARGET_REPO = "${subashbhaaji}/prod"
                        env.IMAGE_TAG = "prod"
                    } else {
                        env.TARGET_REPO = "${subashbhaaji}/dev"
                        env.IMAGE_TAG = "dev"
                    }

                    // Build image with proper tag pointing to the repo
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
                    // Triggers your deploy script locally on the server running Jenkins
                    sh './deploy.sh'
                }
            }
        }
    }
}
