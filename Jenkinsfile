pipeline {
  agent any

  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/YOUR_USERNAME/YOUR_REPO.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t my-flask-app .'
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
        sh 'docker run -d -p 5000:5000 --name flask-container my-flask-app'
      }
    }

    stage('Test') {
      steps {
        sh 'curl http://localhost:5000 || exit 1'
      }
    }

    // stage('Clean Up') {
    //   steps {
    //     sh 'docker stop flask-container && docker rm flask-container'
    //   }
    // }
  }
}
