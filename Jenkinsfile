pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Docker Build') {
            steps {
                // بناء الصورة
                bat 'docker build -t ecommerce_app .'
            }
        }

        stage('Run Container') {
            steps {
                // إيقاف وإزالة أي container سابق
                bat 'docker stop ecommerce_container || echo no container'
                bat 'docker rm ecommerce_container || echo no container'
                // تشغيل الصورة الجديدة
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
