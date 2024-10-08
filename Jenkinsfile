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

        stage('SonarQube analysis') {
            steps {
                withSonarQubeEnv('SonarQube-first-instance') { // 替换为你在 Jenkins 中配置的 SonarQube 实例名
                    sh """
                    ${SONARQUBE_SCANNER_HOME}/bin/sonar-scanner \
                      -Dsonar.projectKey=first-hello-world \  // 替换为你的项目key
                      -Dsonar.sources=. \  // 扫描当前目录中的源文件
                      -Dsonar.host.url=http://35.197.25.242/:9000 \  // 替换为SonarQube的URL
                      -Dsonar.login=sqa_8625397ea241471b8a2b22ce6993df3a979d2aff  // 替换为SonarQube的访问token
                    """
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    waitForQualityGate abortPipeline: true // 如果质量门失败，则终止pipeline
                }
            }
        }
    }

    post {
        always {
            cleanWs() // 清理工作区
        }
    }
}
