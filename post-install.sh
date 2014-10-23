#!/bin/bash

#set -x

export PATH="$PATH:$PROGRAMFILES/git/bin:$PROGRAMFILES/OpenShift-RHC"
fullname="$1"
rhlogin="$2"
libraServerURL="${3##*/}"
rhlogin="$4"
password="$5"

echo "Configurando seu ambiente Git..." 
echo "================================" 
echo
cd $HOMEPATH
git config --global user.name "$fullname"
git config --global user.email "$rhlogin"
git config --global push.default simple

if ! [ -e .ssh/id_rsa ]; then
   [ -d .ssh ] || mkdir .ssh
   ssh-keygen -t rsa -N '' -f .ssh/id_rsa
   chmod 600 .ssh/*
fi
echo
echo "Ambiente Git configurado"
echo "========================"

#clear
cat <<EOF

+===========================================+
|    A configuração do RHC será iniciada    |
|                                           |
|    Responda "yes" para as perguntas       |
|                                           |
|    Pressione [ENTER] para continuar...    |
+===========================================+
EOF
read

rhc setup --server "$libraServerURL" --rhlogin "$rhlogin" --password "$password" --clean --create-token

cat <<EOF
+===========================================+
|    O RHC terminou a configuração          |
|                                           |
|    Pressione [ENTER] para continuar...    |
+===========================================+
EOF
read

