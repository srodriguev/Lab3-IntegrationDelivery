pipeline {
    agent {
        docker {
            image 'node:18'  // Use Node.js 18 Docker image
        }
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }
        stage('Run Tests') {
            steps {
                sh 'npm test'
            }
        }
        stage('Build App') {
            steps {
                sh './scripts/build.sh'
            }
        }
        stage('Run App') {
            steps {
                sh 'npm start'
            }
        }
    }
}
