pipeline {
    agent any

    triggers {
        // Lance automatiquement la pipeline lors d'un push GitHub
        githubPush()
    }

    environment {
        APP_NAME = "ecommerce_app"
        IMAGE_NAME = "ecommerce_image"
        CONTAINER_NAME = "ecommerce_container"
        PORT_LOCAL = "3000"
        PORT_DOCKER = "80"
        NODE_ENV = "development"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Load .env File') {
            steps {
                script {
                    if (fileExists('.env')) {
                        echo "Loading .env variables..."
                        def props = readProperties file: '.env'
                        props.each { key, value ->
                            env."${key}" = value
                        }
                    } else {
                        echo ".env NOT FOUND - skipping loading env vars"
                    }
                }
            }
        }

        stage('Docker Build') {
            steps {
                echo "Building Docker Image..."
                bat """
                    docker build -t %IMAGE_NAME% .
                """
            }
        }

        stage('Stop Previous Container') {
            steps {
                echo "Stopping existing container (if exists)..."
                bat """
                    docker stop %CONTAINER_NAME% || echo no container to stop
                    docker rm %CONTAINER_NAME% || echo no container to remove
                """
            }
        }

        stage('Run New Container') {
            steps {
                echo "Running new Docker Container..."

                bat """
                    docker run -d ^
                    --name %CONTAINER_NAME% ^
                    -p %PORT_LOCAL%:%PORT_DOCKER% ^
                    %IMAGE_NAME%
                """
            }
        }
    }

    post {
        always {
            echo "Pipeline Finished Successfully"
        }
    }
}
