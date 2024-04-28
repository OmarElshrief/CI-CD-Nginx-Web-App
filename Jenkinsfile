pipeline {
    agent any
    
    environment {
        // Define Docker registry credentials if needed
        DOCKER_REGISTRY_CREDENTIALS = 'DockerhubCre'
        
        // Define Minikube configuration
        //KUBECONFIG = "${HOME}/.kube/config"
    }
    
    stages {
        stage('Build Docker image') {
            steps {
                // Build Docker image
                script {
                    docker.build('simple-web-app:latest', '.')
                }
            }
        }
        
        stage('Push Docker image') {
            /*when {
                // Conditionally push Docker image only if DOCKER_REGISTRY_CREDENTIALS is defined
                expression { env.DOCKER_REGISTRY_CREDENTIALS != null }
            }*/
            steps {
                // Push Docker image to registry
                script {
                    docker.withRegistry('https://docker.io', env.DOCKER_REGISTRY_CREDENTIALS) {
                        docker.image('omarelshrief/simple-web-app:latest').push('latest')
                    }
                }
            }
        }
        
        stage('Deploy to Minikube') {
            steps {
                // Deploy to Minikube using Kubernetes plugin
                kubernetesDeploy(
                    configs: 'kubeconfig',
                    kubeconfigId: 'miniCred', //'minikube',
                    enableConfigSubstitution: true,
                    showRawYaml: false,
                    namespace: 'default',
                    yaml: 'deployment.yaml' // Path to your Kubernetes deployment YAML file
                )
            }
        }
    }
}
