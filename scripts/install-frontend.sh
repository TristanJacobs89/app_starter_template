#!/bin/bash

log_message() {
  echo -e "\033[1;32m$1\033[0m"
}

install_jq() {
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    log_message "Installing jq on Linux..."
    sudo apt-get update && sudo apt-get install -y jq
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    log_message "Installing jq on macOS..."
    brew install jq
  elif [[ "$OSTYPE" == "win"* ]]; then
    log_message "Installing jq on Windows..."
    choco install jq
  else
    log_message "Unsupported operating system: $OSTYPE"
    exit 1
  fi
}

create_docker_file() {
  log_message "🕙 Creating Dockerfile..."
  cp templates/Dockerfile.template frontend/Dockerfile
}

update_hosts() {
  log_message "🕙 Adding entries to /etc/hosts file..."
  log_message "Which name do you want to use for your project? (e.g. my-project becomes my-project.local)"
  read PROJECT_NAME
  log_message "127.0.0.1 $PROJECT_NAME.local" | sudo tee -a /etc/hosts
  log_message "✅ Entries added to /etc/hosts file."
}

install_jq

INSTALL_PROJECT=$1
USE_TYPESCRIPT=$2
USE_JEST=$3
USE_REACT_QUERY=$4
USE_STATE_MANAGER=$5
USE_GRAPHQL=$6
USE_STORYBOOK=$7

install_frontend() {
  log_message "❓ What is the name of your project?"
  read PROJECT_NAME
  log_message "❓ What is your name? (author)"
  read AUTHOR_NAME
  log_message "❓ Use TypeScript in your project? (y/n)"
  read USE_TYPESCRIPT
  log_message "❓ Use Jest in your project? (y/n)"
  read USE_JEST
  log_message "❓ Use React Query in your project? (y/n)"
  read USE_REACT_QUERY
  log_message "❓ Which state manager do you want to use? 
  Zustand = 1
  Redux Toolkit = 2
  None = 0"
  read USE_STATE_MANAGER
  log_message "❓ Use GraphQL in your project? (y/n)"
  read USE_GRAPHQL
  log_message "❓ Use Storybook in your project? (y/n)"
  read USE_STORYBOOK


  if [ "$USE_TYPESCRIPT" = "y" ]; then
    npx create-next-app@latest --ts frontend &&
    jq '.scripts.test = "jest && tsc --noEmit"' frontend/package.json > tmp.json && mv tmp.json frontend/package.json
  elif [ "$USE_TYPESCRIPT" = "n" ]; then
    npx create-next-app@latest frontend
    jq '.scripts.test = "jest"' frontend/package.json > tmp.json && mv tmp.json frontend/package.json
  fi

  if [ "$USE_JEST" = "y" ]; then
    dependencies=("jest" "@types/jest" "ts-jest")
    npm install --prefix frontend -D "${dependencies[@]}" &&
    sed -i 's/"devDependencies": {/"devDependencies": {\n    "jest": "latest",\n    "ts-jest": "latest",/' package.json &&
    sed -i 's/"test": "jest"/"test": "jest",/' package.json
  fi

  if [ "$USE_REACT_QUERY" = "y" ]; then
    dependencies=("react-query")
    npm install --prefix frontend -D "${dependencies[@]}" &&
    sed -i 's/"dependencies": {/"dependencies": {\n    "react-query": "latest",/' package.json
  fi

  if [ "$USE_STATE_MANAGER" = "1" ]; then
    dependencies=("zustand")
    npm install --prefix frontend -D "${dependencies[@]}" &&
    sed -i 's/"dependencies": {/"dependencies": {\n    "zustand": "latest",/' package.json
  elif [ "$USE_STATE_MANAGER" = "2" ]; then
    dependencies=("@reduxjs/toolkit" "react-redux")
    npm install --prefix frontend -D "${dependencies[@]}" &&
    sed -i 's/"dependencies": {/"dependencies": {\n    "@reduxjs\/toolkit": "latest",\n    "react-redux": "latest",/' package.json
  fi

  if [ "$USE_GRAPHQL" = "y" ]; then
    dependencies=("graphql-request")
    npm install --prefix frontend -D "${dependencies[@]}" &&
    sed -i 's/"dependencies": {/"dependencies": {\n    "graphql-request": "latest",/' package.json
  fi

  if [ "$USE_STORYBOOK" = "y" ]; then
    npx sb init --prefix frontend &&
    sed -i 's/"scripts": {/"scripts": {\n    "storybook": "start-storybook",\n    "build-storybook": "build-storybook",/' package.json
  fi

  if [ ${#dependencies[@]} -gt 0 ]; then
    npm install --prefix frontend -D "${dependencies[@]}"
  fi

  jq --arg PROJECT_NAME "$PROJECT_NAME" '.name = $PROJECT_NAME' frontend/package.json > tmp.json && mv tmp.json frontend/package.json &&
  jq --arg AUTHOR_NAME "$AUTHOR_NAME" '.author = $AUTHOR_NAME' frontend/package.json > tmp.json && mv tmp.json frontend/package.json

  create_docker_file
  update_hosts
}

# Ask to install frontend, if not, exit
log_message "❓ Would you like to install the frontend? (y/n)"
read INSTALL_PROJECT

if [ "$INSTALL_PROJECT" = "n" ]; then
  exit 0
elif [ "$INSTALL_PROJECT" = "y" ]; then
  install_frontend
fi


