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
                sh 'python3 --version || python --version'
                sh 'pip3 install Flask || pip install Flask'
                sh 'pip3 install unittest-xml-reporting || pip install unittest-xml-reporting'
                sh 'python3 testprogram.py || python testprogram.py'
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
    }
}
