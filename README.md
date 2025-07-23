# B-Safe Project Implementation

A company wanted move their legacy development process to a DevOps process to gain true business value through faster feature releases, better service quality, and cost optimization, they wanted to adopt agility in their build and release process.
The objective is to implement iterative deployments, continuous innovation, and automated testing through the assistance of the strategy.


# 📁 **Project Structure**
app.py: Main Flask application file.

requirements.txt: Python dependencies.

tests/test_app.py: Pytest-based automated test suite.

Jenkinsfile: Jenkins pipeline configuration.

Dockerfile: Container setup for the Flask app.

# 🚀 **Features**

- Flask-based Python web application.
- Automated testing using pytest.
- Continuous deployment using Docker.
- Slack notification integration for pipeline status.
- Email notification setup for Jenkins build results.


# 🛠️ **Technologies Used**

- Python3
- Flask
- Jenkins
- Docker
- GitHub
- AWS EC2 (Ubuntu)
- Slack
- Email (Gmail SMTP)
- Pytest

# 📦 **Installation & Setup**

## 1. Clone Repository & Create Branch ##
```
git clone https://github.com/puja-rathi/BSafeProject.git
cd BSafeProject
git checkout -b dev
```
## 2. Push Code to GitHub ##
```
git add .
git commit -m "Initial commit with flask app and Jenkinsfile"
git push -u origin dev

```
## ☁️ AWS EC2 Setup ##
1. Launch Ubuntu EC2 instance named BSafeServer.
2. Open security group ports:
   - 5000 for Flask App
   - 8080 for Jenkins
3. Install required tools like jdk-17, docker, python3:
   ```
   sudo apt update && sudo apt upgrade -y
   sudo apt install git docker.io openjdk-17-jdk python3-pip curl -y
   ```
4. Setup Docker and Jenkins:
   ```
   sudo systemctl enable docker && sudo systemctl start docker
   sudo usermod -aG docker $USER && newgrp docker

   ```
5. Jenkins Installation:
   ```
   wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
   sudo sh -c 'echo deb https://pkg.jenkins.io/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
   sudo apt update
   sudo apt install jenkins -y
   sudo systemctl enable jenkins && sudo systemctl start jenkins

   ```
6. Grant Jenkins permission to use Docker:
   ```
   sudo usermod -aG docker jenkins
   sudo systemctl restart jenkins

   ```
7. Access Jenkins:
   ```
   http://<EC2-PUBLIC-IP>:8080
   ```

# 🧪 **Testing**

Tests are written using pytest and located in the tests/ directory.
To run tests manually:
  ```
  pip install pytest
  pytest tests/test_app.py
  ```
> Test results are also integrated into Jenkins using the JUnit attachments plugin.

# 🧩 **Jenkins Configuration**

  ### Installed Plugins
  - Docker Pipeline
 - Pipeline Stage View
 - GitHub Integration
 - Pipeline Utility Steps
 - Slack Notification
 - SonarQube Scanner
 - JUnit Attachments

### Credentials Setup:
 - GitHub: github-creds (Username + PAT with repo & workflow scope)
 - DockerHub: dockerhub-creds (Dockerhub username & PAT)

### Webhook:
  - Set up GitHub webhook to immediate trigger builds on push.
 - payload URL: http://<EC2public ip>:8080/github-webhook/
 - content type: application/json
  - SSL: disable
  - Events: on push
    
### Jenkins Job:
  - Trigger: GitHub hook trigger for GitScm polling
  - Pipeline: From SCM
  - Repo: https://github.com/puja-rathi/BSafeProject.git
  - Branch: */main
  - Script Path: Jenkinsfile

# 💬 **Slack Notifications**
  - Create a Slack channel (e.g., #slackforbsafe)
  - Integrate Jenkins CI App into Slack
  - Note subdomain and secret token
  - Configure Jenkins > System > Slack Settings > create & add credentials

# 📧 **Email Notifications**
  - Configure Jenkins > System > Email Settings > Set SMTP server & port
  - Configure Jenkins system settings using Gmail App password.
  - Notifications sent for pipeline status and test results.

# 🐳 **Docker Usage**
  - The Flask app can be containerized using Docker.
  - Docker ensures consistency across environments.
  - Jenkins can build and deploy the app as a container.

# 📍 **Why Docker?**
  Without Docker:

  - Needs to manually install packages & dependencies
  - Dependency issues may arise across environments

  With Docker:

  - Containerizes the app and its dependencies
  - Enables easy deployment, rollback, and scaling
  - Standard approach in modern DevOps pipelines

# 📎**Notes**
- The app runs on port 5000
- Jenkins is accessible on port 8080
- All secrets and tokens are stored securely in Jenkins credentials

# 👩‍💻 **Author**
Puja Rathi

DevOps Engineer
    
