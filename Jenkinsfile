pipeline {
    agent any
    stages {
        stage('Create Vault Container') {
            steps {
                sh 'sudo docker run -d --name vaultci -e "VAULT_DEV_ROOT_TOKEN_ID=vaultpassword" -p 8200:8200 vault:latest'
                sh 'sleep 15'
            }
        }
        stage('Provision Vault Instance'){
            steps {
                sh 'sudo curl --header "X-Vault-Token:vaultpassword" --request POST -d \'{"type": "github","description": "Login with GitHub"}\' http://127.0.0.1:8200/v1/sys/auth/my-auth'
                sh 'sudo curl --header "X-Vault-Token:vaultpassword" --request PUT --data @./policies/vault-admin-policy.hcl http://127.0.0.1:8200/v1/sys/policy/vault-admin-policy'
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
