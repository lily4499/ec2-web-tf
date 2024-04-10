pipeline {
  agent any

   parameters {
        choice(name: 'TERRAFORM_ACTION', choices: ['apply', 'destroy'], description: 'Select Terraform action to perform')
    }

  environment {
    AWS_ACCESS_KEY_ID     = credentials('ec2-aws-access-key-id')
    AWS_SECRET_ACCESS_KEY = credentials('ec2-aws-secret-access-key')
  }

  stages {

    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/lily4499/ec2-web-tf.git'
      }
    }
    
    stage('Terraform Apply') {
      steps {
        script {
            sh '''
              terraform init
              terraform apply -auto-approve
            '''
          }
        }
      }
    }
  }

