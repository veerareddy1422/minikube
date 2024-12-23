pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "apache-app"  // Name of the Docker image
    }
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Check if Docker is running
                    sh 'docker --version'
                    // Build the Docker image using the current directory
                    echo "Building Docker image ${DOCKER_IMAGE}"
                    docker.build("${DOCKER_IMAGE}", ".")  // Adjust path if Dockerfile is elsewhere
                }
            }
        }

        stage('Deploy to Minikube') {
            steps {
                script {
                    // Ensure kubectl is pointing to the Minikube context
                    echo "Setting kubectl context to minikube"
                    sh 'kubectl config use-context minikube'

                    // Apply the deployment and service YAML files
                    echo "Deploying to Minikube"
                    sh 'kubectl apply -f k8s/apache-deployment.yaml'
                    sh 'kubectl apply -f k8s/apache-service.yaml'
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
