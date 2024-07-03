#!/bin/bash

# Путь к скрипту
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

FILE_NAME="Config"

# Путь для создания конфигурационного файла
CONFIG_FILE="$SCRIPT_DIR/MyAnimVue/MyAnimVue/App/$FILE_NAME.plist"

mkdir -p "$(dirname "$CONFIG_FILE")"

# Запрос значений для ключей
read -p "Write CLIENT_ID: " CLIENT_ID
read -sp "Write CLIENT_SECRET: " CLIENT_SECRET
echo

# Создание конфигурационного файла и добавление базовой структуры
cat <<EOL > "$CONFIG_FILE"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CLIENT_ID</key>
	<string>$CLIENT_ID</string>
	<key>CLIENT_SECRET</key>
	<string>$CLIENT_SECRET</string>
</dict>
</plist>
EOL

echo "$FILE_NAME.plist has been created in $CONFIG_FILE with CLIENT_ID: $CLIENT_ID"