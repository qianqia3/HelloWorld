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
    stages {
        stage('build') {
            steps {
                container('python') {
                    sh 'python --version'
                }
            }
        }
    }
}
