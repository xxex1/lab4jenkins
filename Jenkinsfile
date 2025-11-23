pipeline {
    options { timestamps() }

    agent any
    
    stages {
        stage('Check scm') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo "Building ...${BUILD_NUMBER}"
                echo "Build completed"
            }
        }

        stage('Test') {
            steps {
                sh 'python3 --version'
                sh 'python3 -c "import flask" 2>/dev/null || pip3 install --break-system-packages Flask'
                sh 'python3 -c "import xmlrunner" 2>/dev/null || pip3 install --break-system-packages unittest-xml-reporting'
                sh 'python3 testprogram.py'
            }
            post {
                always {
                    junit 'test-reports/*.xml'
                }
                success {
                    echo "Application testing successfully completed"
                }
                failure {
                    echo "Oooppss!!! Tests failed!"
                }
            }
        }

        stage('Build and Push Docker Image') {
            when {
                branch 'main'
            }
            steps {
                script {
                    def imageName = "dmytroshcherban/jenkins-python:${BUILD_NUMBER}"
                    def imageLatest = "dmytroshcherban/jenkins-python:latest"

                    sh "docker build -t ${imageName} -t ${imageLatest} ."

                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                        sh "docker push ${imageName}"
                        sh "docker push ${imageLatest}"
                    }
                }
            }
        }
    }
}
