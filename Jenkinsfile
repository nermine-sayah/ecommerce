pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // نسحب الكود من Git
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
                // حذف الحاوية القديمة لو موجودة
                bat 'docker stop ecommerce_container || echo no container'
                bat 'docker rm ecommerce_container || echo no container'

                // تشغيل الحاوية الجديدة
                bat 'docker run -d -p 3000:80 --name ecommerce_container ecommerce_app'
            }
        }
    }

    post {
        always {
            // رسالة نهاية البايبلاين
            bat 'echo Pipeline Finished'
        }
    }
}
