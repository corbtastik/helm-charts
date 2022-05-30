#!/bin/bash
function todos-webui-template() {
  NAMESPACE=todos
  RELEASE_NAME=todos-webui-1
  helm template --namespace $NAMESPACE $RELEASE_NAME src/todos-webui > .rendered/$RELEASE_NAME.yaml
}

function todos-webui-install() {
  NAMESPACE=todos
  RELEASE_NAME=todos-webui-1
  helm install --namespace $NAMESPACE $RELEASE_NAME src/todos-webui
}

function todos-webui-uninstall() {
  NAMESPACE=todos
  RELEASE_NAME=todos-webui-1
  helm uninstall --namespace $NAMESPACE $RELEASE_NAME
}

function todos-app-template() {
  NAMESPACE=todos
  RELEASE_NAME=todos-app-1
  helm template --namespace $NAMESPACE $RELEASE_NAME src/todos-app > .rendered/$RELEASE_NAME.yaml
}

function todos-app-install() {
  NAMESPACE=todos
  RELEASE_NAME=todos-app-1
  helm install --namespace $NAMESPACE $RELEASE_NAME src/todos-app
}

function todos-app-uninstall() {
  NAMESPACE=todos
  RELEASE_NAME=todos-app-1
  helm uninstall --namespace $NAMESPACE $RELEASE_NAME
}

function usage() {
  echo "== Usage =========================="
  echo "-- todos-app ----------------------"
  echo "   ./make.sh todos-app-template    "
  echo "   ./make.sh todos-app-install     "
  echo "   ./make.sh todos-app-uninstall   "
  echo "-- todos-webui --------------------"
  echo "   ./make.sh todos-webui-template  "
  echo "   ./make.sh todos-webui-install   "
  echo "   ./make.sh todos-webui-uninstall "
  echo "==================================="
}

if [ $# -eq 0 ]; then
    usage
    exit 1
fi

$1