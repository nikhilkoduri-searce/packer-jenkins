# Packer Cloudbuild

Before we begin with the packer cloudbuild steps, we have to install Packer on the Jenkins VM.
```bash
wget https://releases.hashicorp.com/packer/1.6.0/packer_1.6.0_linux_amd64.zip
apt-get install unzip
unzip packer_1.6.0_linux_amd64.zip
mv packer /usr/local/bin
```

## Create Jenkinsfile


1) #### Create the google source repository or link your git repository to csr

2) #### Create a trigger in cloudbuild
* Select the csr name just created.
* Select the branc that we want to be triggered from.
* Provide path for the cloudbuild.yaml

3) #### Just push the new code and cloudbuild will trigger
