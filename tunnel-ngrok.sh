
#!/data/data/com.termux/files/usr/bin/bash

echo "⬇️ Inštalujem ngrok pre Termux..."

pkg install -y wget unzip

# Stiahni ngrok binárku
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip -O ngrok.zip

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
