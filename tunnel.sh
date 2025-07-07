#!/bin/bash

# Nastavenie globálneho npm priečinka v domovskom adresári
echo "🛠️ Nastavujem npm prefix..."
mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'

# Pridanie do PATH, ak tam ešte nie je
if ! grep -q ".npm-global/bin" ~/.bashrc; then
    echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
fi

# Inštalácia localtunnel
echo "⬇️ Inštalujem localtunnel..."
npm install -g localtunnel

# Spustenie tunela
echo "🚀 Spúšťam localtunnel na porte 7000..."
lt --port 7000 --subdomain streamujtest

