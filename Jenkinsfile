pipeline {
    agent any

    environment {
        APP_NAME = "ecommerce-app"
        IMAGE_NAME = "ecommerce:${env.BUILD_NUMBER}"
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Checkout du code"
            }
        }

        stage('Setup') {
            steps {
                echo "Setup environnement"
                sh 'mkdir -p logs reports || true'
            }
        }

        stage('Build') {
            when {
                anyOf {
                    branch 'dev'
                    branch 'master'
                    changeRequest()
                    tag "v*"
                }
            }
            steps {
                echo "Build application"
                sh 'echo "Build OK" > logs/build.log'
            }
        }

        stage('Docker Build') {
            when {
                anyOf {
                    branch 'dev'
                    branch 'master'
                    tag "v*"
                }
            }
            steps {
                echo "Docker build"
                sh 'echo "Docker image built" > logs/docker.log'
            }
        }

        stage('Run (Docker)') {
            when {
                branch 'dev'
            }
            steps {
                echo "Run container"
                sh 'echo "Container running" > logs/run.log'
            }
        }

        stage('Smoke Test') {
            when {
                anyOf {
                    branch 'dev'
                    changeRequest()
                }
            }
            steps {
                echo "Smoke test"
                sh 'echo "SMOKE TEST PASSED" > reports/smoke.txt'
            }
        }

        stage('Archive Artifacts') {
            steps {
                echo "Archive artifacts"
                archiveArtifacts artifacts: 'logs/**, reports/**', fingerprint: true
            }
        }

        stage('Cleanup') {
            steps {
                echo "Cleanup (always visible)"
            }
        }
    }

    post {
        always {
            echo "Pipeline terminé (Passed / Skipped visibles)"
        }
    }
}
