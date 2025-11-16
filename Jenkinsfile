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
    }
}
