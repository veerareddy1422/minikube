pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "apache-app"  // Name of the Docker image
    }
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build("${DOCKER_IMAGE},".")
                }
            }
        }

        stage('Deploy to Minikube') {
            steps {
                script {
                    // Set kubectl context to Minikube
                    sh 'kubectl config use-context minikube'

                    // Apply the deployment and service YAML files
                    sh 'kubectl apply -f k8s/apache-deployment.yaml'
                    sh 'kubectl apply -f k8s/apache-service.yaml'
                }
            }
        }

        stage('Expose Service') {
            steps {
                script {
                    // Expose the Apache service and print the URL
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
