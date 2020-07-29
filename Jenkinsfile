pipeline {

 agent any

 environment {
      _IMAGE_NAME='prod-centos7-javaapp-v1-image'
      _PROJECT_ID='searce-playground'
      _IMAGE_FAMILY='centos-7'
      _REGION='asia-south1'
      _IMAGE_ZONE='asia-south1-b'
      _MACHINE_TYPE='n1-standard-2'
      _NETWORK='packer-vpc'
      _SUBNETWORK='packer-subnet'
    }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }


    stage('maven clean') {
      steps {
        sh 'mvn clean'
      }
    }

    stage('maven package') {
      steps {
        sh 'mvn package'
      }
    }

    stage('packer') {
      steps {
        sh 'packer build -var image_name=${_IMAGE_NAME}-$SHORT_SHA -var project_id=searce-playground -var image_family=centos-7 -var image_zone=asia-south1-b -var zone=asia-south1-b -var region=asia-south1 -var source_image_family=centos-7 -var network=packer-vpc -var subnetwork=packer-subnet -var machine_type=${_MACHINE_TYPE} packer.json'
      }
    }

    stage('instance template') {
      steps {
        sh 'gcloud beta compute --project=${_PROJECT_ID} instance-templates create java-packer-template-${BUILD_NUMBER} --image=prod-centos7-javaapp-v1-image-${BUILD_NUMBER} --machine-type=${_MACHINE_TYPE} --network=projects/searce-playground/global/networks/default --network-tier=PREMIUM --maintenance-policy=MIGRATE'
      }
    }

    stage('rolling update') {
      steps {
        sh 'gcloud compute instance-groups --project=${_PROJECT_ID} managed rolling-action start-update java-packer-mig --version template=java-packer-template-${BUILD_NUMBER} --type=proactive --force --max-surge=1 --max-unavailable=1 --replacement-method=substitute --zone=us-east1-d'
      }
    }

  }
}
