pipeline {
    agent any

    triggers {
        githubPush()
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Docker Build') {
            steps {
                bat 'docker build -t ecommerce_app .'
            }
        }

        stage('Run Container') {
            steps {
                bat 'docker stop ecommerce_container || echo no container'
                bat 'docker rm ecommerce_container || echo no container'
                bat 'docker run -d -p 3000:80 --name ecommerce_container ecommerce_app'
            }
        }
    }

    post {
        always {
            bat 'echo "Pipeline Finished"'
        }
    }
}
