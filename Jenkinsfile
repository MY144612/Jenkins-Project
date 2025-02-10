pipeline {
    agent any

    environment {
        AWS_REGION = 'eu-west-1'  // Change this if needed
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/MY144612/Jenkins-Project.git'
            }
        }

        stage('Setup AWS Credentials') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_ACCESS_KEY_ID']]) {
                    echo 'AWS Credentials Configured'
                }
            }
        }

        stage('Install Terraform') {
            steps {
                sh '''
                if ! command -v terraform &> /dev/null; then
                  echo "Terraform not found, installing..."
                  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
                  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
                  sudo apt update && sudo apt install -y terraform
                else
                  echo "Terraform is already installed."
                fi
                terraform --version
                '''
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }

    post {
        success {
            echo 'Terraform Deployment Successful!'
        }
        failure {
            echo 'Terraform Deployment Failed!'
        }
    }
}
