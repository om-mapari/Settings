---

## ⚙️ **Git Setup After Installation**

### 🧾 1️⃣ Configure your identity

```bash
git config --global user.name "Om Mapari"        # Set your Git username
git config --global user.email "mapariom05@gmail.com"   # Set your Git email
```

---

### 🔒 2️⃣ Store login credentials securely

```bash
git config --global credential.helper manager    # Use Windows Credential Manager
```

---

### 🔑 3️⃣ Generate SSH key

```bash
ssh-keygen -t ed25519 -C "mapariom05@gmail.com"  # Create SSH key for GitHub
```

👉 Press **Enter** for all prompts (default location is fine).

---

### 📋 4️⃣ Copy SSH public key

```bash
cat ~/.ssh/id_ed25519.pub    # Show your SSH key to copy
```

➡️ Go to **GitHub → Settings → SSH and GPG Keys → New SSH Key**
➡️ Paste and **Save** ✅

---

### 🧠 5️⃣ Test your SSH connection

```bash
ssh -T git@github.com        # Verify SSH connection with GitHub
```

Expected output:

```
Hi Om-mapari! You've successfully authenticated.
```

---

### 📦 6️⃣ Clone a repository

```bash
git clone git@github.com:username/repo.git   # Clone repo using SSH
```

---

### 💾 7️⃣ Commit and push changes

```bash
git add .                      # Stage all changes
git commit -m "Initial commit" # Save changes locally
git push                       # Upload to GitHub
```

---
