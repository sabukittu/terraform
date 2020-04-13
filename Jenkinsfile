pipeline {
  agent any
  
  environment {
    AWS_ACCESS_KEY_ID = "${params.AWS_ACCESS_KEY_ID}"
    AWS_SECRET_ACCESS_KEY = "${params.AWS_SECRET_ACCESS_KEY}"
    JENKINS_USER_ID="${params.USER}"
    JENKINS_API_TOKEN="${params.TOKEN}"
    AGENT_NAME="${params.SLAVE_NAME}"
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
    stage('ModifyAgent IPAddress') {
      steps {
        sh "./script.sh"
      }
    }
    stage('Reload Jenkins Configuration') {
      steps {
        sh "wget ${env.JENKINS_URL}jnlpJars/jenkins-cli.jar"
        sh "java -jar jenkins-cli.jar -s ${env.JENKINS_URL} reload-configuration"
        sh "sleep 120"
      }
    }  
  }
  post {
    always {
        slackNotify(SlackChannel,currentBuild.currentResult)
        cleanWs()
    }
  }
}
