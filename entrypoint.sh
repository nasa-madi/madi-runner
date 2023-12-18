#!/bin/bash
# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

URL=https://developer.nasa.gov
# /runner/config.sh --url https://developer.nasa.gov/javilla8/madi --token AAAARDYM7KHIFP22L633GVDFN56D2

#remove runner on stop signal
remove_runner() {
    /runner/config.sh remove --unattended --token "$(curl -sS --request POST --url "${URL}/repos/${REPO_OWNER}/${REPO_NAME}/actions/runners/remove-token" --header "authorization: Bearer ${GITHUB_TOKEN}"  --header "content-type: application/json" | jq -r .token)"
    exit 0
}

#Trap SIGTERM
trap 'remove_runner' SIGTERM
#Trap SIGINT
trap 'remove_runner' SIGINT


# shellcheck disable=SC2034
#ACTIONS_RUNNER_INPUT_NAME is read by config.sh
#set name for this runner as the hostname
ACTIONS_RUNNER_INPUT_NAME=$HOSTNAME
#get regsistration token for this runnner
# ACTIONS_RUNNER_INPUT_TOKEN="$(curl -sS --request POST --url "${URL}/repos/${REPO_OWNER}/${REPO_NAME}/actions/runners/registration-token" --header "authorization: Bearer ${GITHUB_TOKEN}"  --header 'content-type: application/json' | jq -r .token)"
#configure runner

ACTIONS_RUNNER_INPUT_URL=https://developer.nasa.gov/javilla8/madi
ACTIONS_RUNNER_INPUT_TOKEN=AAAARDYM7KHIFP22L633GVDFN56D2
# ./config.sh --url https://developer.nasa.gov/javilla8/madi --token AAAARDYM7KHIFP22L633GVDFN56D2

/runner/config.sh --unattended --replace --work "/tmp" --url "$ACTIONS_RUNNER_INPUT_URL" --token "$ACTIONS_RUNNER_INPUT_TOKEN"
#start runner
#https://github.com/actions/runner/issues/246#issuecomment-615293718
/runner/bin/runsvc.sh & wait $!
