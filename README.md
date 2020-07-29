# Packer Cloudbuild

Before we begin with the packer cloudbuild steps, we have to push the docker image of packer to the gcp project that contains cloudbuild.
```bash
cd packer-image
gcloud builds submit .
```
We need to create a seperate vpc for packer for the images to be build.
```bash
gcloud compute networks create packer-vpc --project=searce-playground --subnet-mode=custom --bgp-routing-mode=regional
```
Next we create the subnet.
```bash
gcloud compute networks subnets create packer-subnet --project=searce-playground --range=10.1.0.0/16 --network=packer-vpc --region=asia-south1
```
We have to create a firewall rule to allow ssh from public.
```bash
gcloud compute --project=searce-playground firewall-rules create packer-firewall --direction=INGRESS --priority=1000 --network=packer-vpc --action=ALLOW --rules=tcp:22 --source-ranges=74.125.0.0/16,72.14.192.0/18,108.177.8.0/21,173.194.0.0/16
```

## Create tigger


1) #### Create the google source repository or link your git repository to csr

2) #### Create a trigger in cloudbuild
* Select the csr name just created.
* Select the branc that we want to be triggered from.
* Provide path for the cloudbuild.yaml

3) #### Just push the new code and cloudbuild will trigger
