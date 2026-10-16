#!/bin/bash

SERVICE_NAME="marzban"
SERVICE_DESCRIPTION="Marzban Service"
SERVICE_DOCUMENTATION="https://github.com/pixonsybertik/Marzban"
MAIN_PY_PATH="$PWD/main.py"
SERVICE_FILE="/etc/systemd/system/$SERVICE_NAME.service"

# Create the service file
cat > $SERVICE_FILE <<EOF
[Unit]
Description=$SERVICE_DESCRIPTION
Documentation=$SERVICE_DOCUMENTATION
After=network.target nss-lookup.target

[Service]
Type=simple
ExecStart=/usr/bin/env python3 $MAIN_PY_PATH
Restart=on-failure
RestartSec=5
WorkingDirectory=$PWD
User=root

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload

echo "Service file created at: $SERVICE_FILE"
echo "You can now enable and start the service with:"
echo "  systemctl enable --now $SERVICE_NAME"
