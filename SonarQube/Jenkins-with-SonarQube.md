```bash
pipeline {
    agent any

    stages {

        stage('clone repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Rohit-1920/EasyCRUD.git'
            }
        }

        stage('build') {
            steps {
                sh '''
                cd backend
                mvn clean package -DskipTests
                '''
            }
        }

        stage('sonar analysis') {
            steps {
                withSonarQubeEnv('Sonar-env') {
                    sh '''
                    cd backend
                    mvn sonar:sonar \
                    -Dsonar.projectKey=studentapp \
                    -Dsonar.projectName=studentapp \
                    -DskipTests
                    '''
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('deploy') {
            steps {
                echo 'deployment stage'
            }
        }
    }
}
```
