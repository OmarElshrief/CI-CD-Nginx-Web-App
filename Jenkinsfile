pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'omarelshrief/simple-web-app'
        //DOCKERFILE_PATH = '-f /var/jenkins_home/workspace/CICD_pipeline/Dockerfile /var/jenkins_home/workspace/CICD_pipeline'
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

	    stage('Deploy to Minikube') {
            steps {
                script {
                    // Deploy the Docker image to Minikube
                    sh "kubectl apply -f deployment.yaml"
                }
            }
        }

        stage('Integration Test') {
            steps {
                script{
                    POD_NAME = sh(script: "kubectl get pods -l app=my-nginx -o jsonpath='{.items[0].metadata.name}'", returnStdout: true).trim()
                    sh "kubectl port-forward ${POD_NAME} 8091:80 &"
                    sh 'curl -s http://localhost:8091' // Example test for content verification
                }
            }
        }
    }

   /* post {
        always {
            // Integration test for nginx server deployment..
            script {
                try {

                    POD_NAME = sh(script: "kubectl get pods -l app=my-nginx -o jsonpath='{.items[0].metadata.name}'", returnStdout: true).trim()
                    sh "kubectl port-forward ${POD_NAME} 8098:80 &"
                    sh 'curl -s http://localhost:8098' 

                    echo 'Deployment Built successfully!'
                } catch (Exception e) {

                    currentBuild.result = 'FAILURE'
                    echo 'Deployment failed, Try again!!'
    
                }
            }
        }
    }*/
}
