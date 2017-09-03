#!/usr/bin/env bash
set -e

INIT_ORG="${HOME}/.emacs.d/init.org"
INIT_EL="${HOME}/.emacs.d/init.el"
DOT_EMACS="${HOME}/.emacs"

if [ -e $INIT_ORG ]
then
    echo -e "\n\nBacking up existing ~/.emacs.d/init.org"
    mv $INIT_ORG  $INIT_ORG.bbkup
fi

if [ -e $DOT_EMACS ]
then
    echo -e "\n\nBacking up ~/.emacs"
    mv $DOT_EMACS $DOT_EMACS.bbkup
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
emacs --batch --eval "(progn (require 'org) (org-babel-load-file \"${INIT_ORG}\"))"

# set ~/.emacs content to load from the org file
echo -e "(require 'org)\n(org-babel-load-file \"${INIT_ORG}\")\n;; Edit the beautiful-emacs/init.org file instead!" > $DOT_EMACS

echo -e "\n\nDone."
