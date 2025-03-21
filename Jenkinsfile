pipeline {
    agent any
    environment {
        PORT = "${env.BRANCH_NAME == 'main' ? '3000' : '3001'}"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: env.BRANCH_NAME, url: 'https://github.com/tu-usuario/tu-repo.git'
            }
        }
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
        stage('Test') {
            steps {
                sh 'npm test'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh "docker build -t my-app:${env.BRANCH_NAME} ."
            }
        }
        stage('Deploy') {
            steps {
                sh "docker run -d -p ${PORT}:${PORT} my-app:${env.BRANCH_NAME}"
            }
        }
    }
}
