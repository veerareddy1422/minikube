pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "apache-app"
    }
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }

        stage('Deploy to Minikube') {
            steps {
                script {
                    // Ensure Minikube is started
                    echo "Starting Minikube if not already running"
                    sh 'minikube start'  // Start Minikube if it's not running

                    // Set kubectl context to Minikube
                    echo "Setting kubectl context to minikube"
                    sh 'kubectl config use-context minikube'

                    // Apply the deployment and service YAML files
                    echo "Deploying to Minikube"
                    sh 'kubectl apply -f k8s/apache-deployment.yaml'
                    sh 'kubectl apply -f k8s/apache-service.yaml'
                    sh 'kubectl get pods'
                }
            }
        }

        stage('Expose Service') {
            steps {
                script {
                    // Expose the Apache service and print the URL
                    echo "Exposing Apache service and getting the URL"
                    sh 'minikube service apache-service --url'
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution completed.'
        }
    }
}
