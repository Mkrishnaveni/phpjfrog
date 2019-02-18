pipeline {
  environment {
    registry = "krishnaveni07/veni"
    registryCredential = 'dockerhub'
  }
  agent any
  stages {
    stage('Building image') {
      steps{
        script {
          docker.build registry + ":$BUILD_NUMBER"
        }
      }
      stage('Git') {
'		git 'https://https://github.com/Mkrishnaveni/dockerpoc.git'
	}
	stage('Build') {
		sh 'npm install'
	}
	stage('Test') {
		sh 'npm test'
    }
	stage('Building image') {
        docker.withRegistry( 'https://github.com/Mkrishnaveni/dockerpoc.git/Dockerfile' + registry, dockerhub ) {
		    def buildName = registry + ":$BUILD_NUMBER"
			newApp = docker.build buildName
			newApp.push()
        }
	}
	stage('Registring image') {
        docker.withRegistry( 'https://github.com/Mkrishnaveni/dockerpoc.git/Dockerfile' + registry, registryCredential ) {
    		newApp.push 'latest2'
        }
	}
    }
  }
}
