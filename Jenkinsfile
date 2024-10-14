pipeline {
    agent any
    tools {
        jdk 'jdk17'
        nodejs 'node22'
    }
    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }
    stages {
        stage('Clear Jenkins Workspace - PRE') {
            steps {
                cleanWs()
            }
        }
        stage('Clone Project to Jenkins Workspace') {
            steps {
                git credentialsId: 'GITHUB-YasinDeger48', url: 'https://github.com/YasinDeger48/devops-004-pipeline-aws.git'
            }
        }
        stage('NPM Installation') {
            steps {
                sh 'npm install'
            }
        }
        stage('Run SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar-server') {
                    sh '''
                        ${SCANNER_HOME}/bin/sonar-scanner \
                        -Dsonar.projectKey=devops-004-pipeline-aws \
                        -Dsonar.sources=src
                    '''
                }
            }
        }
        stage('Quality Gate') {
            steps {
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar-admin', timeout: 30
                }
            }
        }
        stage('TRIVY File Scan') {
            steps {
                sh "trivy fs . > trivyfs.txt"
            }
        }
        stage('Clean up old Docker Images') {
            steps {
                sh 'docker image prune -a -f'
            }
        }
        stage("Docker Build & Push to Docker Hub"){
            steps{
withCredentials([usernameColonPassword(credentialsId: 'DockerHUB-YasinDeger48', variable: 'docker-hub')]) {
                    sh "docker build -t yasindeger48/$JOB_NAME:v$BUILD_ID ."
                    sh "docker build -t yasindeger48/$JOB_NAME:latest ."
                    sh 'docker push yasindeger48/$JOB_NAME:v$BUILD_ID'
                    sh 'docker push yasindeger48/$JOB_NAME:latest'
                }
            }
        }
        stage("TRIVY Image Scan"){
            steps{
                sh "trivy image yasindeger48/$JOB_NAME:latest > trivyimage.txt"
            }
        }
        stage('Clear Jenkins Workspace - POST') {
            steps {
                cleanWs()
            }
        }
    }
}
