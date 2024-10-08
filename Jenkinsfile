pipeline {
    agent {
        kubernetes {
            yaml """
            apiVersion: v1
            kind: Pod
            spec:
              containers:
              - name: python
                image: python:3.13.0-alpine3.20
                command:
                - cat
                tty: true
            """
        }
    }

    environment {
        SONARQUBE_SCANNER_HOME = tool 'SonarQube Scanner' // 使用你配置的SonarQube Scanner工具
    }

    stages {
        stage('build') {
            steps {
                container('python') {
                    sh 'python --version'
                }
            }
        }

        stage('Check SonarQube Access') {
            steps {
                sh 'curl -I http://35.197.25.242:9000'
            }
        }

        stage('SonarQube analysis') {
            steps {
                withSonarQubeEnv('SonarQube-first-instance') {
                    sh """
                    ${SONARQUBE_SCANNER_HOME}/bin/sonar-scanner\
                      -Dsonar.projectKey=first-hello-world\
                      -Dsonar.sources=.\
                      -Dsonar.host.url=http://35.197.25.242:9000\ 
                      -Dsonar.login=sqp_7e365cbcaa5df920d6badd46554e2f21de5811fd
                    """
                }
            }
        }

        // stage('Quality Gate') {
        //     steps {
        //         timeout(time: 1, unit: 'HOURS') {
        //             waitForQualityGate abortPipeline: true // 如果质量门失败，则终止pipeline
        //         }
        //     }
        // }
    }

    post {
        always {
            cleanWs() // 清理工作区
        }
    }
}
