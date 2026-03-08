#!/bin/bash

ORIGEN="/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media"
DESTINO="$HOME/whatsapp-backup/data"

mkdir -p "$DESTINO/images"
mkdir -p "$DESTINO/videos"
mkdir -p "$DESTINO/audios"
mkdir -p "$DESTINO/gifs"

cp -ru "$ORIGEN/WhatsApp Images/" "$DESTINO/images/"
cp -ru "$ORIGEN/WhatsApp Video/" "$DESTINO/videos/"
cp -ru "$ORIGEN/WhatsApp Audio/" "$DESTINO/audios/"
cp -ru "$ORIGEN/WhatsApp Voice Notes/" "$DESTINO/audios/"
cp -ru "$ORIGEN/WhatsApp Animated Gifs/" "$DESTINO/gifs/"

cd $HOME/whatsapp-backup

git add .
git commit -m "Backup WhatsApp $(date)"
git push origin main

echo "Backup enviado a GitHub"