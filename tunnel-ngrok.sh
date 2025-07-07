#!/data/data/com.termux/files/usr/bin/bash

echo "⬇️ Inštalujem ngrok pre Termux (64-bit ARM)..."

pkg install -y wget unzip

# Zmažeme starú verziu
rm -f ngrok ngrok.zip

# Stiahneme 64-bit ARM verziu
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm64.zip -O ngrok.zip

unzip -o ngrok.zip
chmod +x ngrok

echo ""
echo "✅ Ngrok pripravený!"

echo ""
echo "🧪 Zadaj svoj Ngrok authtoken:"
read -p "🔑 Authtoken: " TOKEN

./ngrok config add-authtoken $TOKEN

echo ""
echo "🚀 Spúšťam HTTPS tunel na localhost:7000..."
./ngrok http 7000
