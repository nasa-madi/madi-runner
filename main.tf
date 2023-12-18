/**
 * Copyright 2020 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

provider "google" {
  credentials = file("./google.credentials.json")
  project     = var.project_id
}

provider "google-beta" {
  credentials = file("./google.credentials.json")
  project     = var.project_id
}

module "runner-mig-dind" {
  source  = "terraform-google-modules/github-actions-runners/google//modules/gh-runner-mig-container-vm"
  version = "3.1.2"
  # create_network = true
  project_id     = var.project_id
  image          = var.image
  repo_name      = var.repo_name
  repo_url       = var.repo_url
  repo_owner     = var.repo_owner
  gh_token       = var.gh_token
  dind           = true
  subnet_name    = "hq-madi-vpc"
  subnetwork_project = "hq-madi-anchor-proj-654cb100"
  subnet_ip      = "10.24.80.0/24"
  target_size    = 1

}

# module "runner-mig-dind" {
#   source         = "../../modules/gh-runner-mig-container-vm"
# }
