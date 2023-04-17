pipeline { 
    agent any 
    environment { 
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID') 
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY_ID')
        SBT_OPTS = "${SBT_OPTS} -Dsbt.color=false"
    }
    stages { 
        stage('Terraform Initialization') { 
            steps { 
                sh 'terraform init' 
                sh 'pwd' 
                sh 'ls -al' 
                sh 'printenv' 
            } 
        } 
        stage('Terraform Format') { 
            steps { 
                sh 'terraform fmt -check || exit 0' 
            } 
        } 
        stage('Terraform Validate') { 
            steps { 
                sh 'terraform validate'
            } 
        }
        stage('Terraform Planning') { 
            steps { 
                sh 'terraform plan -no-color -out=terraform_plan'
                sh 'terraform show -json ./terraform_plan > terraform_plan.json'
            } 
        }
        stage('archive terrafrom plan output') {
            steps {
                archiveArtifacts artifacts: 'terraform_plan.json', excludes: 'output/*.md', onlyIfSuccessful: true
            }
        }
        stage('Terraform Apply') { 
            steps { 
                sh 'terraform apply -auto-approve'
            } 
        }
        stage('Terraform Destroy') {
            steps {
                sh 'sleep 30'
                sh 'terraform destroy -auto-approve'
            }
        }
    } 
}
