pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out the code..."
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo "Skipping Docker build. Only code checkout is done."
            }
        }
    }

    post {
        always {
            echo "Pipeline finished successfully!"
        }
    }
}
