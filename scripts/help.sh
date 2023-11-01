log_message() {
  echo -e "\033[1;32m$1\033[0m"
}

 log_message "🔧 INSTALLATION:
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
    👉 Run 'task help' to show this message again.
    🔎 Have a look at the Taskfile.yml to see all available commands!"

