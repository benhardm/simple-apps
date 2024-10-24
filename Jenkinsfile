pipeline {
    agent { label 'rido-docker-label' }
    
    tools {nodejs "nodejs-simpleapps"}

    stages {
        stage('Checkout SCM') {
            steps {
                git branch: 'main', url: 'https://github.com/benhardm/simple-apps.git'
            }
        }
        stage('Build') {
            steps {
                sh '''cd apps
                npm install'''
            }
        }
        stage('Testing') {
            steps {
                sh '''cd apps
                npm test
                npm run test:coverage'''
            }
        }
        stage('Code Review') {
            steps {
                sh '''cd apps
                sonar-scanner \
                -Dsonar.projectKey=simple-apps \
                -Dsonar.sources=. \
                -Dsonar.host.url=http://172.23.14.1:9000 \
                -Dsonar.login=sqp_c0db8612306121861f9dda5685295b145ba849fb'''
            }
        }
        stage('Deploy compose') {
            steps {
                sh '''
                docker compose build
                docker compose up -d
                '''
            }
        }

        stage('Build Images') {
            steps {
                sh '''
                cd apps
                docker build -t simple-apps:latest .
                docker tag simple-apps:latest benhardm/simpleapps-pipeline:latest
                docker push benhardm/simpleapps-pipeline:latest
                '''
            }
        }
    }
}