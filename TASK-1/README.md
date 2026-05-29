# Task 1: Server Setup and SSH Configuration

## Objective
Provision a Linux server, configure SSH connectivity, and implement passwordless authentication using SSH key-based login.

---

## Environment
- OS: CentOS Stream 9
- User: atchaya (admin)
- Server IP: 192.168.231.128
- SSH Tool: PuTTY (Windows)

---

## Steps Executed

### 1. Provision Linux Server
Installed CentOS Stream 9 as a local virtual machine with the following configuration:
- Keyboard: English (US)
- Language: English (United States)
- Timezone: Asia/Kolkata
- Software: Server
- User: atchaya (with admin rights)
- Network: NAT

### 2. Enable SSH Service
```bash
sudo systemctl enable --now sshd
```

### 3. Allow SSH Through Firewall
```bash
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload
```

### 4. Verify SSH is Running
```bash
sudo systemctl status sshd
```

### 5. Generate SSH Key Pair on Server
```bash
ssh-keygen -t rsa -b 4096
```
- Accepted default file location: `~/.ssh/id_rsa`
- No passphrase set (pressed Enter)

This generates two files:

| `~/.ssh/id_rsa` | Private key |
| `~/.ssh/id_rsa.pub` | Public key |

### 6. Add Public Key to Authorized Keys
```bash
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh
```

### 7. Verify Permissions
```bash
ls -la ~/.ssh/
```
output:
```
drwx------  .ssh              (700)
-rw-------  authorized_keys   (600)
-rw-------  id_rsa
-rw-r--r--  id_rsa.pub
```

### 8. Copy Private Key to Windows
```bash
cat ~/.ssh/id_rsa
```
- Copied output to Notepad
- Saved as `taskkey.pem`

### 9. Convert .pem to .ppk Using PuTTYgen
1. Opened PuTTYgen on Windows
2. Clicked **Load** → selected `taskkey.pem`
3. Clicked **Save private key** → saved as `taskkey.ppk`

### 10. Connect via PuTTY Using SSH Key
1. Opened PuTTY
2. Host Name: `192.168.231.128`
3. Port: `22`
4. Navigated to **Connection → SSH → Auth → Credentials**
5. Browsed and selected `taskkey.ppk`
6. Clicked **Open** → logged in as `atchaya`

### 11. Disable Password Authentication
```bash
sudo nano /etc/ssh/sshd_config
```
Changed the following lines:
```
PasswordAuthentication no
PubkeyAuthentication yes
PermitRootLogin no
```
```bash
sudo systemctl restart sshd
```

### 12. Add User to Sudoers (Passwordless sudo) [to avoid using root account created a user atchaya with admin rights to execute commands]
```bash
sudo visudo
```
Added line:
```
atchaya ALL=(ALL) NOPASSWD: ALL
```
## Verification
```bash
# Connect via PuTTY with .ppk key - no password prompted ✅
ssh atchaya@192.168.231.128
```
---

## Expected Outcome
✅ Secure remote access to the server using SSH keys without password authentication.
