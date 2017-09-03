#!/usr/bin/env bash
set -e

INIT_ORG="${HOME}/.emacs.d/init.org"
INIT_EL="${HOME}/.emacs.d/init.el"

if [ -e $INIT_ORG ]
then
    echo 'Removing existing init.org symlink.'
    rm $INIT_ORG
fi

CUR_DIR=$(pwd)
BEAUTIFUL_DIR=`dirname $0`
BEAUTIFUL_INIT_ORG="${BEAUTIFUL_DIR}/init.org"

mkdir -p ~/.emacs.d


if [ ! -L $BEAUTIFUL_INIT_ORG  ]
then
    echo "Creating Symlink: ${BEAUTIFUL_INIT_ORG} -> ~/init.org"
    ln -s $BEAUTIFUL_INIT_ORG $INIT_ORG
fi

echo -e "\n\nConverting ~/.emacs.d/init.org -> ~/.emacs.d/init.el -> LOADING..."
emacs --batch --eval "(progn (require 'org) (org-babel-tangle-file \"${INIT_ORG}\") (load-file \"${INIT_EL}\"))"

echo -e "\n\nDone."
