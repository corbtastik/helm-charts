#!/bin/bash
function todos-webui-template() {
  export NAMESPACE=todos
  export RELEASE_NAME=todos-webui-1
  helm template --namespace $NAMESPACE $RELEASE_NAME src/todos-webui > .rendered/$RELEASE_NAME.yaml
}

function todos-webui-install() {
  export NAMESPACE=todos
  export RELEASE_NAME=todos-webui-1
  helm install --namespace $NAMESPACE $RELEASE_NAME src/todos-webui
}

function usage() {
  echo "== Usage =========================="
  echo "   make.sh todos-webui-template    "
  echo "   make.sh todos-webui-install     "
  echo "   make.sh todos-webui-uninstall   "
  echo "==================================="
}

if [ $# -eq 0 ]; then
    usage
    exit 1
fi

$1