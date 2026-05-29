# Task 4: Secure Monitoring Logs with Dedicated User

## Objective
Create a dedicated monitoring user, assign ownership of the monitoring folder, provide full access to the monitoring user, and restrict access for other users.

---

## Environment
- OS: CentOS Stream 9
- Dedicated Monitoring User: L1user
- Admin User: atchaya
- Monitoring Directory: /opt/container-monitor

---

## Steps Executed

### 1. Create Dedicated Monitoring User
```bash
sudo useradd L1user
sudo passwd L1user
```

### 2. Create Monitoring Directory
```bash
sudo mkdir -p /opt/container-monitor/logs
```

### 3. Assign Ownership to L1user
```bash
sudo chown -R L1user:L1user /opt/container-monitor
```

### 4. Give Full Access to L1user, Restrict Others
```bash
sudo chmod -R 700 /opt/container-monitor
```

### 5. Verify Permissions
```bash
ls -la /opt/
ls -la /opt/container-monitor/
ls -la /opt/container-monitor/logs/
```

output:
```
drwx------ L1user L1user container-monitor
drwx------ L1user L1user logs
```

---

## Access Control Explanation

### Permission 700 Breakdown
| Who | Permission |
|-----|-----------|
| L1user (owner) | Read + Write + Execute ✅ |
| Group | No access ❌ |
| Others | No access ❌ |

### User Access Summary
| User | Access | Reason |
|------|--------|--------|
| `L1user` | ✅ Full access | Owner of folder |
| `atchaya` | ✅ Full access | Admin/sudo rights |
| `root` | ✅ Full access | Always has access |
| Others | ❌ No access | 700 permission |

---

### Setting Home directory to logs folder for L1user:

```bash
sudo usermod -d /opt/container-monitor/logs L1user
```
## Verification Commands

### Check L1user Can Access (Should Work ✅)
```bash
su - L1user
ls /opt/container-monitor/
ls /opt/container-monitor/logs/
exit
```

### Check Other Users Cannot Access (Should Fail ❌)
```bash
# Create test user
sudo useradd testuser
su - testuser
ls /opt/container-monitor/
# Result: Permission denied ✅
exit
```

### Check atchaya Access via Sudo (Should Work ✅)
```bash
sudo ls /opt/container-monitor/
```
---

## Expected Outcome
✅ L1user has full access to /opt/container-monitor
✅ Other regular users cannot access the folder
✅ atchaya can still access via sudo
✅ Root can anyways access
