# Task 5: Firewall Configuration

## Objective
Install and configure firewall with rules to allow SSH only from a specific IP, allow HTTP access, and allow traffic on port 8000.

---

## Environment
- OS: CentOS Stream 9
- Firewall Tool: firewalld (UFW not available on CentOS)
- Server IP: 192.168.231.128
- Windows Host IP: 192.168.231.1

---

## Why firewalld Instead of UFW?
UFW is Ubuntu/Debian based. CentOS Stream 9 uses **firewalld** as its default firewall manager.
```
sudo dnf install -y ufw
# Error: No match for argument: ufw 
# Solution: Use firewalld instead 
```

---

## Steps Executed

### 1. Check firewalld is Running
```bash
sudo systemctl status firewalld
```
Expected output:
```
Active: active (running) ✅
```

### 2. Add SSH Rule FIRST (Your Windows IP Only)
```bash
sudo firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="192.168.231.1" port port="22" protocol="tcp" accept'
```

### 3. Allow HTTP (Port 80)
```bash
sudo firewall-cmd --permanent --add-service=http
```

### 4. Allow Port 8000
```bash
sudo firewall-cmd --permanent --add-port=8000/tcp
```

### 5. Set Default Zone to Drop
```bash
sudo firewall-cmd --set-default-zone=drop
```

### 6. Reload Firewall to Apply Rules
```bash
sudo firewall-cmd --reload
```

### 7. Enable firewalld on Boot
```bash
sudo systemctl enable firewalld
```

---

## Firewall Rules Summary

| Port | Protocol | Action | From |
|------|----------|--------|------|
| 22 | TCP | ALLOW | 192.168.231.1 only |
| 80 | TCP | ALLOW | Anywhere |
| 8000 | TCP | ALLOW | Anywhere |
| All others | Any | DROP | Anywhere |

---

## Verification Commands

### Check All Rules
```bash
sudo firewall-cmd --list-all
```
Output:
```
drop (active)
  target: DROP
  services: http
  ports: 8000/tcp
  rich rules:
    rule family="ipv4" source address="192.168.231.1"
    port port="22" protocol="tcp" accept
```

### Check Default Zone
```bash
sudo firewall-cmd --get-default-zone
```
Expected: `drop` ✅

### Check Active Zones
```bash
sudo firewall-cmd --get-active-zones
```

### Test SSH (from Windows IP - should work ✅)
```
PuTTY → 192.168.231.128:22 → connects successfully
```

### Test HTTP
```
Browser → http://192.168.231.128 → page loads ✅
```

### Test Port 8000
```
Browser → http://192.168.231.128:8000 → Docker app loads ✅
```

### Test SSH from Different IP (should fail ❌)
```
Any other IP → SSH → Connection dropped ✅
```

---

## Security Explanation

### Before Task 5
```
Default zone = public
Port 22 → Open to EVERYONE ❌ (not secure)
```

### After Task 5
```
Default zone = drop
Port 22  → Open ONLY to 192.168.231.1 ✅
Port 80  → Open to everyone (HTTP) ✅
Port 8000→ Open to everyone (Docker app) ✅
Others   → Dropped by default ✅
```
---

## Expected Outcome
✅ SSH access restricted explicitly and allowed to specific IP (192.168.231.1) only
✅ HTTP access allowed from anywhere
✅ Port 8000 accessible for Docker application
✅ All other unauthorized access dropped
