pipeline {
    agent any
    environment {
        SONARQUBE_URL = 'http://192.168.56.11:9000'
        SONARQUBE_CREDENTIALS = 'sonarqube-creds'
    }
    options {
        timestamps()
        skipDefaultCheckout(true)
    }
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out the repository...'
                git url: 'https://github.com/nikhilnsalgaonkar/todo-list-app.git', branch: 'main'
            }
        }
        stage('Build') {
            steps {
                echo 'Building the project using Gradle...'
                sh './gradlew clean build'
            }
        }
        stage('SonarQube Scan') {
            steps {
                echo 'Running SonarQube analysis...'
                withSonarQubeEnv('SonarQube') {  
                    sh './gradlew sonarqube -Dsonar.host.url=$SONARQUBE_URL -Dsonar.login=$SONARQUBE_CREDENTIALS'
                }
            }
        }
        stage('Upload Build Artifacts') {
            steps {
                echo 'Archiving build artifacts...'
                archiveArtifacts artifacts: '**/build/libs/*.jar', fingerprint: true
            }
        }
        stage('Cleanup') {
            steps {
                echo 'Cleaning up the workspace...'
                cleanWs()
            }
        }
    }
    post {
        always {
            echo 'Pipeline execution finished!'
        }
        success {
            echo 'Build succeeded!'
        }
        failure {
            echo 'Build failed. Please check the logs.'
        }
    }
}