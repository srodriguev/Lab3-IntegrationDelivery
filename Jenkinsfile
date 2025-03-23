pipeline {
    agent {
        docker {
            image 'node:18'  // Use a proper Node.js image
        }
    }
    stages {
        stage('Install Dependencies') {
            steps {
                sh '''
                npm config set cache /tmp/.npm
                npm install
                '''
            }
        }
        stage('Run Tests') {
            steps {
                sh 'npm test'
            }
        }
        stage('Build App') {
            steps {
                sh 'npm run build'
            }
        }
        stage('Run App') {
            steps {
                sh 'node src/index.js'
            }
        }
    }
}
