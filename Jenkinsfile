pipeline {
  agent any
  
  environment {
    AWS_ACCESS_KEY_ID = "${params.AWS_ACCESS_KEY_ID}"
    AWS_SECRET_ACCESS_KEY = "${params.AWS_SECRET_ACCESS_KEY}"
    MASTER_IP = "${params.MASTER_IP}"
    JENKINS_USER_ID="${params.USER}"
    JENKINS_API_TOKEN="${params.TOKEN}"
  }
  stages {
    stage('Terraform Init') {
      steps {
        script { 
          slackNotify.init(SlackChannel)
        }
        sh "terraform init"
      }
    }
    stage('Terraform Plan') {
      steps {
        sh "terraform plan -out=ec2plan"
      }
    }
    stage('Terraform Apply') {
      steps {
        sh "terraform apply ec2plan"

      }
    }
    stage('Modify SlaveIP') {
      steps {
        sh "./script.sh"
      }
    }
    stage('Node updating') {
      steps {
        sh "wget http://${MASTER_IP}:8080/jnlpJars/jenkins-cli.jar"
        sh "java -jar jenkins-cli.jar -s http://${MASTER_IP}:8080/ reload-configuration"
        // sh "java -jar jenkins-cli.jar -s http://${MASTER_IP}:8080/ update-node Slave01"
        sh "java -jar jenkins-cli.jar -s http://${MASTER_IP}:8080/ wait-node-online Slave01"
      }
    }   
  }
  post {
    always {
        slackNotify(SlackChannel)
        cleanWs()
    }
  }
}