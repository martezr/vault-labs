pipeline {
    agent any
    environment {
      VAULT_ADDR  = 'http://localhost:8200/'
      VAULT_TOKEN = 'vaultpassword
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
                sh 'curl -o vault.zip https://releases.hashicorp.com/vault/0.10.4/vault_0.10.4_linux_amd64.zip ; yes | unzip vault.zip'
            }
        }
        stage('Provision Vault Instance'){
            steps {
                sh 'sudo curl --header "X-Vault-Token:vaultpassword" --request POST -d \'{"type": "github","description": "Login with GitHub"}\' http://127.0.0.1:8200/v1/sys/auth/my-auth'
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
