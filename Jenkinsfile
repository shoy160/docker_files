pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        sh 'dotnet restore'
        sh 'dotnet build'
      }
    }
    stage('publish') {
      steps {
        sh 'dotnet publish **/${ACB_PROJECT}.csproj -c Release -o ./bin/publish'
      }
    }
    stage('docker') {
      steps {
        sh '(docker rm -f ${ACB_IMAGE_NAME} && docker rmi ${ACB_IMAGE_NAME}:3.0) || echo \'image \'${ACB_IMAGE_NAME}\' not exist\''
        sh 'docker build -t ${ACB_IMAGE_NAME}:3.0 ./${ACB_PROJECT}/bin/publish/'
        sh 'docker run --name=${ACB_IMAGE_NAME} --restart=always --network=icb_net -e ACB_MODE=${ACB_MODE} -p ${ACB_DOCKER_PORT}:5000 -d ${ACB_IMAGE_NAME}:3.0'
      }
    }
    stage('push') {
      steps {
        sh 'docker tag ${ACB_IMAGE_NAME}:3.0 ${ACB_DOCKER_HOST}:5000/web/${ACB_IMAGE_NAME} && docker push ${ACB_DOCKER_HOST}:5000/web/${ACB_IMAGE_NAME} && docker rmi ${ACB_DOCKER_HOST}:5000/web/${ACB_IMAGE_NAME}'
        sh 'curl \'http://192.168.0.230:8081/update?service_name=\'${ACB_IMAGE_NAME}\'&image_name=web/\'${ACB_IMAGE_NAME}\'&version=latest\''
      }
    }
  }
  environment {
    ACB_PROJECT = 'Acb.Gateway.App'
    ACB_IMAGE_NAME = 'gateway-app'
    ACB_MODE = 'Test'
    ACB_DOCKER_HOST = '192.168.0.230'
    ACB_DOCKER_PORT = 6301
  }
}