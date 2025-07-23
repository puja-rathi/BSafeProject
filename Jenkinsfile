pipeline {
  agent any

  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds') //comment
    SLACK_CHANNEL = '#slackforbsafe'                // Slack channel name
    SLACK_CREDENTIAL_ID = 'slack_notification'          // Jenkins Slack credential ID

  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/puja-rathi/BSafeProject.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          sh 'docker build -t my-flask-app .'
        }
      }
    }


    //automated tests on created build

    stage('Run Automated Tests') {
      steps {
        sh '''
          pip install --upgrade pip --break-system-packages
          pip install -r requirements.txt --break-system-packages
          ~/.local/bin/pytest tests/ --junitxml=report.xml
        '''
    }
  }

    stage('Publish Test Report') {
      steps {
        junit 'report.xml'
      }
    }

    stage('Push to Docker Hub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
          sh """
            echo "$PASSWORD" | docker login -u "$USERNAME" --password-stdin
            docker tag my-flask-app $USERNAME/my-flask-app:latest
            docker push $USERNAME/my-flask-app:latest
          """
        }
      }
    }

    stage('Deploy Container') {
      steps {
        script {
          // Optional: remove old container if it exists
          sh 'docker rm -f flask-container || true'

          // Run the new container
          withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
            sh """
              docker pull $USERNAME/my-flask-app:latest
              docker run -d -p 5000:5000 --name flask-container $USERNAME/my-flask-app:latest
            """
          }
        }
      }
    }
 



    stage('Test') {
      steps {
        script {
          sh 'sleep 5' // 🔄 give app time to start
          sh 'curl -f http://localhost:5000 || exit 1'
        }
      }
    }

    // Optional cleanup stage
    // stage('Clean Up') {
    //   steps {
    //     sh 'docker stop flask-container && docker rm flask-container'
    //   }
    // }
  }

// for slack & email notification
post {
  success {
    slackSend(
      color: '#00FF00',
      message: "✅ SUCCESS: Job '${env.JOB_NAME} [#${env.BUILD_NUMBER}]' succeeded. <${env.BUILD_URL}|View Build>"
    )
    mail(
      to: 'your@email.com',
      subject: "✅ SUCCESS: ${env.JOB_NAME} [#${env.BUILD_NUMBER}]",
      body: "The job succeeded!\n\nCheck it here: ${env.BUILD_URL}"
    )
  }

  failure {
    slackSend(
      color: '#FF0000',
      message: "❌ FAILURE: Job '${env.JOB_NAME} [#${env.BUILD_NUMBER}]' failed. <${env.BUILD_URL}|View Build>"
    )
    mail(
      to: 'your@email.com',
      subject: "❌ FAILURE: ${env.JOB_NAME} [#${env.BUILD_NUMBER}]",
      body: "The job failed.\n\nCheck here: ${env.BUILD_URL}"
    )
  }
}





}
