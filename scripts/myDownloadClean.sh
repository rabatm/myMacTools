#!/bin/bash

# Définir le chemin du dossier "Téléchargements"
downloads_dir="$HOME/Downloads"

# Adresse e-mail de destination
email_dest="martin.dev@ik.me"

# Vérifier si le dossier existe
if [ -d "$downloads_dir" ]; then
    # Envoyer un e-mail avant de supprimer les fichiers
    echo "Le script va supprimer tous les éléments du dossier 'Téléchargements'." | mail -s "Suppression des téléchargements" "$email_dest"

    sleep 10
    # Supprimer tous les fichiers et dossiers dans le dossier "Téléchargements"
    rm -rf "$downloads_dir"/*
    echo "Tous les éléments du dossier 'Téléchargements' ont été supprimés."
else
    echo "Le dossier 'Téléchargements' n'existe pas."
fi