pipeline {
    agent any

    stages {

        stage('Clone Repository') {
            steps {
                git branch: 'main',url: 'https://github.com/kavya-vajrangi/devops-demo-project.git'
            }
        }

        stage('Build Maven') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t demo-app:v1 .'
            }
        }

        stage('Trivy Scan') {
            steps {
                sh 'trivy image --timeout 30m --severity HIGH,CRITICAL --exit-code 1 --no-progress demo-app:v1'
            }
        }

        stage('Kube Score Check') {
            steps {
                sh 'kube-score score deployment.yaml'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
            }
        }
    }
}
