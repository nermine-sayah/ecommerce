pipeline {
    agent any

    triggers {
        githubPush()
    }

    environment {
        NODE_ENV = "development"
    }

    stages {

        stage('Fix Git Settings') {
            steps {
                bat """
                    git config --global http.version HTTP/1.1
                    git config --global http.postBuffer 524288000
                    git config --global http.maxRequestBuffer 1000M
                    git config --global core.compression 0
                """
            }
        }

        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM',
                    branches: [[name: "*/feature/jenkins"]],
                    userRemoteConfigs: [[url: 'https://github.com/nermine-sayah/ecommerce-final-project.git']],
                    extensions: [[$class: 'CloneOption', shallow: true, depth: 1]]
                ])
            }
        }

        stage('Install Dependencies') {
            steps {
                bat 'npm install'
            }
        }

        stage('Build React App') {
            steps {
                bat 'npm run build'
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

                bat '''
                    docker run -d -p 3000:80 ^
                    --env-file .env ^
                    --name ecommerce_container ecommerce_app
                '''
            }
        }
    }

    post {
        always {
            bat 'echo "Pipeline Finished"'
        }
    }
}
