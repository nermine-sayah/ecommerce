pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code
                checkout scm
            }
        }

        stage('Docker Build') {
            steps {
                // Build Docker image
                bat 'docker build -t ecommerce_app .'
            }
        }

        stage('Run Container') {
            steps {
                // Stop and remove previous container
                bat 'docker stop ecommerce_container || echo "no container"'
                bat 'docker rm ecommerce_container || echo "no container"'

                // Run new container
                bat 'docker run -d -p 3000:80 --name ecommerce_container ecommerce_app'
            }
        }
    }

    post {
        always {
            // Pipeline finished message
            bat 'echo Pipeline Finished'
        }
    }
}
