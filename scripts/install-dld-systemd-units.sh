#!/usr/bin/env bash
# Run ON THE SERVER as root to create a systemd unit for the kernel API only.
# Usage: sudo bash scripts/install-dld-systemd-units.sh
set -e

KERNEL_SVC="/etc/systemd/system/decision-ledger-kernel.service"

echo "Creating $KERNEL_SVC ..."
cat > "$KERNEL_SVC" << 'EOF'
[Unit]
Description=Decision Ledger Kernel API
After=network.target docker.service
Requires=docker.service

[Service]
Type=simple
WorkingDirectory=/opt/decision-ledger-demo
EnvironmentFile=/opt/decision-ledger-demo/.env.kernel
ExecStart=/opt/decision-ledger-demo/kernel
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable decision-ledger-kernel 2>/dev/null || true
echo "Done. Start with: systemctl start decision-ledger-kernel"
echo "Or restart after deploy: systemctl restart decision-ledger-kernel"
