# App Starter

## About this project

Working at a digital agency will often require developers to setup new codebases. This project aims to automate a large part of the initial setup of a full stack application.

## Requirements

Make sure to have the following installed on your system.

- Task (https://taskfile.dev/)
- Docker (https://docs.docker.com/get-docker/)

## How it works

The core concept of this project is the automation of a new project setup and begins with the `Taskfile.yml`. This file contains / should contain the commands to initialize the repository, setup Docker containers and install a Directus instance (including SQL database) and a frontend with NextJS.

### Commands

```shell
🔧 INITIALISING THE REPOSITORY:
    👉 Run 'task init' to init the repo and create a docker-compose file
    👉 Run 'task init-cms' to only init the backend folder.
    👉 Run 'task init-frontend' to only init the frontend folder.

🔧 INSTALLATION:
    👉 Run 'task install' to install both Directus CMS and NextJS.
    👉 Run 'task install-frontend' to only install NextJS.
    👉 Run 'task install-cms' to only install Directus CMS.

 📟 DOCKER:
    👉 Run 'task up' to start all Docker containers.
    👉 Run 'task stop' to stop all Docker containers.
    👉 Run 'task down' to stop and remove Docker containers.
    👉 Run 'task start-frontend' to only start NextJS container.
    👉 Run 'task stop-frontend' to only stop NextJS container.
    👉 Run 'task start-cms' to only start Directus CMS container.
    👉 Run 'task stop-cms' to only stop Directus CMS container.


 🛠️ FRONTEND TOOLS:
    👉 Run 'task lint' to lint frontend code.
    👉 Run 'task format' to format frontend code.
    👉 Run 'task test' to run frontend tests.

 🗑️ CLEANUP:
    👉 Run 'task clean' to start the repository cleanup script.

 ⁉️ HELP:
    👉 Run 'task help' to show this message in your terminal.
    🔎 Have a look at the Taskfile.yml to see all available commands!"
```

### Folders

`/scripts`

- This contains the scripts required for initialisation and installation of all codebases.

`/templates`

- This folder holds template files for the `docker-compose.yml` file and the Dockerfile (which is used for the Frontend codebase).

`/frontend` (after running `task init` or `task init-frontend`)

- The folder containing the NextJS installation

`/backend` (after running `task init` or `task init-cms`)

- The folder containing the Directus installation

## TO DO

- Add more NextJS library options (auth, Directus SDK, utilities, styled-components)
- Configure Directus storage location options
- Codegeneration for frontend components
- Proxy for local domains
- Build and deploy steps
- Check and use correct shell script versions based on OS
- Add option to choose between other databases (MySQL, MariaDB, SQlite)
- Add option to select between an existing (or local) database or a new one
- Generate dynamic environment variables
- Update documentation

## Could haves

- Choose between a Vite based React installation or NextJS
- Add Nuxt/Vue as an option
- Make TypeScript mandatory

## How to contribute

If you have ideas that could improve the project, feel free to contribute by submitting a PR. In addition, helping develop open tickets and bug reports will ensure success.
