pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/qianqia3/HelloWorld.git'
            }
        }
        stage('Install Python') {
            steps {
                sh 'sudo apt-get update && sudo apt-get install -y python3' // 确保 Python 3 被安装
            }
        }
        stage('Build') {
            steps {
                sh 'python3 hello_world.py' // 假设你有一个简单的Python脚本
            }
        }
        stage('SonarQube analysis') {
            environment {
                SONARQUBE_SCANNER_HOME = tool 'SonarQube Scanner' // 设置SonarQube Scanner
            }
            steps {
                withSonarQubeEnv('SonarQube-first-instance') { // 使用在Jenkins中配置的SonarQube实例
                    sh "${SONARQUBE_SCANNER_HOME}/bin/sonar-scanner \
                        -Dsonar.projectKey=first-hello-world \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=http://35.197.25.242/:9000 \
                        -Dsonar.login=sqa_8625397ea241471b8a2b22ce6993df3a979d2aff"
                }
            }
        }
        stage("Quality Gate") {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    waitForQualityGate abortPipeline: true
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
