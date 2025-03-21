pipeline {
    agent any

    stages {
        stage('Set Environment Variables') {
            steps {
                script {
                    env.PORT = (env.BRANCH_NAME == 'main') ? '3000' : '3001'
                }
            }
        }

        stage('Checkout') {
            steps {
                git branch: env.BRANCH_NAME, 
                    credentialsId: 'github-token-api',  
                    url: 'https://github.com/srodriguev/Lab3-IntegrationDelivery.git'
            }
        }

        stage('Build') {
            steps {
                sh 'npm install'
                script {
                    echo "Branch is: ${env.BRANCH_NAME}"
                }
            }
        }

        stage('Test') {
            steps {
                sh 'npm test'
            }
        }

        stage('Change Logo') {
            steps {
                sh "cp ${env.BRANCH_NAME}/src/logo.svg src/logo2.svg"
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t myapp:${env.BRANCH_NAME} ."
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh "docker run -d -p ${env.PORT}:80 myapp:${env.BRANCH_NAME}"
                }
            }
        }
    }
}