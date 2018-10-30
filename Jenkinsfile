pipeline {
    agent any
    environment {
      VAULT_ADDR  = 'http://localhost:8200/'
      VAULT_TOKEN = 'vaultpassword'
    }
    stages {
        stage('Create Vault Container') {
            steps {
                sh 'sudo docker run -d --name vaultci -e "VAULT_DEV_ROOT_TOKEN_ID=vaultpassword" -p 8200:8200 vault:latest'
                sh 'sleep 15'
            }
        }
        stage('Download Vault Client'){
            steps {
                sh 'sudo curl -o vault.zip https://releases.hashicorp.com/vault/0.10.4/vault_0.10.4_linux_amd64.zip ; yes | sudo unzip vault.zip'
            }
        }
        stage('Download Terraform'){
            steps {
                sh 'sudo curl -o terraform.zip https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_linux_amd64.zip ; yes | sudo unzip terraform.zip'
            }
        }
         stage('Terraform Init') {
            steps {
                sh './terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                sh './terraform plan'
            }
        }
        stage('Terraform Apply') {
            steps {
                sh './terraform apply -auto-approve'
            }
        }
        stage('Provision Vault Instance'){
            steps {
                sh './vault policy write vault-admin-policy ./policies/vault-admin-policy.hcl'
            }
        }
        stage('Test Vault Instance'){
            steps {
                sh 'curl --header "X-Vault-Token:vaultpassword" http://127.0.0.1:8200/v1/sys/auth | python -m json.tool'
            }
        }
    }
    post { 
        always { 
            sh 'sudo docker stop vaultci && sudo docker rm vaultci'
        }
    }
}
