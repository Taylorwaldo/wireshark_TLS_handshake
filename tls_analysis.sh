#!/bin/bash

# TLS Analysis Setup Script for Kali Linux

echo "TLS Analysis Setup Starting..."

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root: sudo ./tls_analysis.sh"
    exit 1
fi

# Check if tshark is installed
if ! command -v tshark &> /dev/null; then
    echo "Installing Wireshark..."
    apt update && apt install -y wireshark
fi

# Get network interface
echo "Available interfaces:"
ip link show | grep -E '^[0-9]+:' | cut -d: -f2 | sed 's/^ *//'

read -p "Enter interface (eth0, wlan0, etc): " INTERFACE

# Create capture file
CAPTURE_FILE="tls_capture_$(date +%Y%m%d_%H%M%S).pcap"

echo "Starting capture on $INTERFACE..."
echo "Capture file: $CAPTURE_FILE"

# Start capture
tshark -i "$INTERFACE" -w "$CAPTURE_FILE" -f "port 443" &
TSHARK_PID=$!

# Generate TLS traffic
sleep 2
curl -s https://www.wikipedia.org > /dev/null &
curl -s https://www.google.com > /dev/null &

echo "Capturing for 30 seconds..."
sleep 30

# Stop capture
kill $TSHARK_PID 2>/dev/null

echo "Capture complete."

# Show results
TOTAL_PACKETS=$(tshark -r "$CAPTURE_FILE" | wc -l)
TLS_PACKETS=$(tshark -r "$CAPTURE_FILE" -Y "tls" | wc -l)

echo "Results:"
echo "Total packets: $TOTAL_PACKETS"
echo "TLS packets: $TLS_PACKETS"
echo "File saved: $CAPTURE_FILE"

echo ""
echo "Next steps:"
echo "1. sudo wireshark"
echo "2. Open file: $CAPTURE_FILE"
echo "3. Apply filter: tls"
echo "4. Analyze handshake packets"
