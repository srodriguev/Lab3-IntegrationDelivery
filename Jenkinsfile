pipeline {
    agent any

    environment {
        BRANCH_NAME = env.BRANCH_NAME
        PORT = (env.BRANCH_NAME == 'main') ? '3000' : '3001'
        DOCKER_REGISTRY = "sarodriel"  // Set your Docker Hub username
        IMAGE_NAME = "myapp:${env.BRANCH_NAME}"
        FULL_IMAGE_NAME = "${DOCKER_REGISTRY}/${IMAGE_NAME}"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: env.BRANCH_NAME, url: 'https://github.com/srodriguev/Lab3-IntegrationDelivery.git'
            }
        }

        stage('Change Logo') {
            steps {
                script {
                    def logoPath = "src/logo.svg"
                    def newLogo = (env.BRANCH_NAME == 'main') ? 'public/main_logo.svg' : 'public/dev_logo.svg'
                    sh "cp ${newLogo} ${logoPath}"
                }
            }
        }

        stage('Build') {
            steps {
                sh 'bash scripts/build.sh'
            }
        }

        stage('Test') {
            steps {
                sh 'bash scripts/test.sh'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build --build-arg BRANCH_NAME=${env.BRANCH_NAME} -t ${FULL_IMAGE_NAME} ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh "docker push ${FULL_IMAGE_NAME}"
            }
        }

        stage('Deploy') {
            steps {
                // Stop any existing container running on the same port
                sh "docker ps -q --filter 'publish=${PORT}' | xargs -r docker stop"

                // Pull the latest pushed image
                sh "docker pull ${FULL_IMAGE_NAME}"

                // Run the new container
                sh "docker run -d -p ${PORT}:3000 ${FULL_IMAGE_NAME}"
            }
        }
    }
}
