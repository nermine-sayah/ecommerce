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
                echo "Building project..."
                // Exemple : npm build pour React si nécessaire
                // sh 'npm install && npm run build'

                // Création d'un fichier de log pour montrer les artefacts
                bat 'mkdir -p logs && echo "Build log" > logs/build.log'
            }
        }

        stage('Archive Artifacts') {
            steps {
                echo "Archiving build and logs..."
                archiveArtifacts artifacts: 'build/**'
                archiveArtifacts artifacts: 'logs/**'
            }
        }
    }

    post {
        always {
            echo "Pipeline finished successfully!"
        }
    }
}
