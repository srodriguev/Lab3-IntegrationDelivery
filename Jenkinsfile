pipeline {
    agent any

    stages {
        stage('Set Environment Variables') {
            steps {
                script {
                    def branch = env.BRANCH_NAME ?: 'main'
                    def imageVersion = 'v1.0' 
                    def imageName = ''
                    def port = ''
                    def containerName = ''

                    if (branch == 'main') {
                        imageName = "sarodriel/nodemain:${imageVersion}"
                        port = '3000'
                        containerName = 'my-app-main'
                    } else if (branch == 'dev') {
                        imageName = "sarodriel/nodedev:${imageVersion}"
                        port = '3001'
                        containerName = 'my-app-dev'
                    } else {
                        error "Branch no reconocido: ${branch}"
                    }

                    echo "Usando imagen: ${imageName} en puerto: ${port}"

                    currentBuild.description = "Branch: ${branch}, Image: ${imageName}, Port: ${port}"

                    env.IMAGE_NAME = imageName
                    env.PORT = port
                    env.CONTAINER_NAME = containerName
                }
            }
        }

        stage('Checkout') {
            steps {
                git branch: env.BRANCH_NAME, url: 'https://github.com/srodriguev/Lab3-IntegrationDelivery.git'
            }
        }

        stage('Select Logo') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'main') {
                        sh 'cp public/main_logo.svg src/logo.svg'
                    } else if (env.BRANCH_NAME == 'dev') {
                        sh 'cp public/dev_logo.svg src/logo.svg'
                    }
                }
            }
        }

        stage('Build') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }

        stage('Test') {
            steps {
                sh 'chmod +x scripts/test.sh && scripts/test.sh'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "echo 'Image name: ${env.IMAGE_NAME}'"
                sh "docker build -t ${env.IMAGE_NAME} ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh "docker push ${env.IMAGE_NAME}"
            }
        }

        stage('Deploy') {
            steps {
                sh "docker stop ${env.CONTAINER_NAME} || true && docker rm ${env.CONTAINER_NAME} || true"
                sh "docker run -d --name ${env.CONTAINER_NAME} -p ${env.PORT}:3000 ${env.IMAGE_NAME}"
            }
        }
    }
}

