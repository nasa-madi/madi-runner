# First download credentials for an admin accout for the project
# name the credentials file google.credentials.json and put in the root of this folder
# Set the project ID below 
# Then run the commands in the following order.


PROJECT_ID='hq-madi-dev-4ebd7d92';
gcloud config set project $PROJECT_ID;
gcloud services enable containerregistry.googleapis.com cloudbuild.googleapis.com;
gcloud builds submit --config=cloudbuild.yaml;

terraform init;
terraform plan;
terraform apply;

#gcloud compute ssh --zone "us-east4-a" "gh-runner-6ca74295-rkd4" --tunnel-through-iap --project "hq-madi-dev-4ebd7d92"

