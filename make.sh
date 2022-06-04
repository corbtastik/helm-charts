#!/bin/bash
NAMESPACE=${NAMESPACE:-todos}
RELEASE_NAME=${RELEASE_NAME:-todos1}

function todos-webui-template() {
  helm template --namespace $NAMESPACE $RELEASE_NAME src/todos-webui > .rendered/$RELEASE_NAME.yaml
}

function todos-webui-install() {
  helm install --namespace $NAMESPACE $RELEASE_NAME src/todos-webui
}

function todos-webui-uninstall() {
  helm uninstall --namespace $NAMESPACE $RELEASE_NAME
}

function todos-app-template() {
  helm template --namespace $NAMESPACE $RELEASE_NAME src/todos-app > .rendered/$RELEASE_NAME.yaml
}

function todos-app-install() {
  helm install --namespace $NAMESPACE $RELEASE_NAME src/todos-app
}

function todos-app-uninstall() {
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