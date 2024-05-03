pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'omarelshrief/simple-web-app'
        DOCKERFILE_PATH = 'Dockerfile'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build(env.DOCKER_IMAGE_NAME, '-f /var/jenkins_home/workspace/CICD_pipeline/Dockerfile /var/jenkins_home/workspace/CICD_pipeline')
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to a registry (if needed)
                    docker.withRegistry('https://index.docker.io/v1/', 'DockerhubCre') {
                        docker.image(env.DOCKER_IMAGE_NAME).push('latest')
                    }
                }
            }
        }
    }
}
