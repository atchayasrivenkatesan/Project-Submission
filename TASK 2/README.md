# Task 2: Docker Installation and Application Deployment

## Objective
Install Docker, create a Dockerfile to host a custom webpage, build and run a container, and expose it on port 8000.

---

## Environment
- OS: CentOS Stream 9
- User: atchaya
- Server IP: 192.168.231.128
- Image Name: mywebapp:v1
- Container Name: webcon
- Exposed Port: 8000

---

## Steps Executed

### 1. Install Docker Dependencies
```bash
sudo dnf install -y yum-utils
```

### 2. Add Docker Official Repository
```bash
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

### 3. Install Docker
```bash
sudo dnf install -y docker-ce docker-ce-cli containerd.io
```

### 4. Start and Enable Docker Service
```bash
sudo systemctl enable --now docker
sudo systemctl status docker
```

### 5. Add User to Docker Group
```bash
sudo usermod -aG docker atchaya
```

### 6. Create Project Directory
```bash
mkdir ~/myappD
cd ~/myappD
```

### 7. Create index.html
```bash
vi index.html
```

**index.html content:**
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Docker Deployment</title>
</head>
<body style="margin:0; padding:0; background-color:#f4f6f9; font-family:Arial, sans-serif; display:flex; justify-content:center; align-items:center; height:100vh;">

    <div style="background:#ffffff; padding:40px; border-radius:10px; box-shadow:0 4px 15px rgba(0,0,0,0.1); text-align:center; width:90%; max-width:500px;">
        
        <h1 style="color:#2c3e50; margin-bottom:20px;">
            🚀 Successfully Deployed in Docker
        </h1>
        
        <p style="color:#555; font-size:16px; margin-bottom:15px;">
            This application is now running inside a Docker container.
        </p>
        
        <p style="color:#333; font-size:15px; background:#eef2ff; padding:10px; border-radius:6px;">
            📌 Task Submission: This deployment demonstrates successful containerization and execution of the application using Docker.
        </p>

        <p style="margin-top:20px; font-size:12px; color:#888;">
            Deployment Status: Active & Running
        </p>

    </div>

</body>
</html>
```

### 8. Create Dockerfile
```bash
vi Dockerfile
```

**Dockerfile content:**
```dockerfile
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
```

### 9. Build Docker Image and verify
```bash
docker build -t mywebapp:v1 .
docker images
```

### 10. Run Docker Container with restricting the cpu utilization
```bash
docker run -d -p 8000:80 --name webcon --cpus="0.5" mywebapp:v1
```

### 11. Verify Container is Running
```bash
docker ps
```

---
## Project Structure
```
myappD/
├── Dockerfile
└── index.html
```
---

## Verification
```bash
# Check container running
docker ps

# Access in browser
http://192.168.231.128:8000
```
---

## Expected Outcome
✅ Web application accessible through browser at `http://192.168.231.128:8000`
