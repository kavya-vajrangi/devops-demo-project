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
       stage('artifact upload') {
            steps {
                nexusArtifactUploader artifacts: [[artifactId: 'demo-app', classifier: '', file: 'target/demo-app-1.0.jar', type: 'jar']], credentialsId: '3a8532e5-2f09-43b7-ae52-51b091b13843', groupId: 'com.example', nexusUrl: '192.168.1.4:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'devops', version: '1.0'
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
                sh(script: 'kube-score score deployment.yaml', returnStatus: true)
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
            }
        }
    }
}
