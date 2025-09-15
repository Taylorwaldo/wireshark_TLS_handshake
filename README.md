# Wireshark TLS Handshake Analysis

My first time learning Wireshark by analyzing TLS handshakes in Kali Linux.

## What This Is

A simple guide to capture and analyze TLS/SSL handshakes using Wireshark. Perfect for beginners who want to understand how HTTPS connections work under the hood.

## Quick Start

1. **Run the automation script:**
```bash
chmod +x tls_analysis.sh
sudo ./tls_analysis.sh
```

2. **Open Wireshark:**
```bash
sudo wireshark
```

3. **Load the capture file** and apply filter: `tls`

4. **Analyze these key packets:**
   - Client Hello (cipher suites offered)
   - Server Hello (cipher suite selected) 
   - Change Cipher Spec (encryption confirmed)

## Files Included

- `tls_analysis.sh` - Automated capture script
- Sample analysis screenshots
- This README

## Requirements

- Kali Linux
- Root access
- Internet connection

## Results

Successfully captured and analyzed TLS 1.3 handshakes showing:
- Modern cipher suites (AES-128-GCM-SHA256)
- Perfect Forward Secrecy
- Faster handshake compared to TLS 1.2
- Encrypted server responses
