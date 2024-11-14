# Install and configure git-credential-manager

sudo dnf install git
git config --global user.name "devvc-cyber"
git config --global user.email rafael@volvecare.com
git config --global credential.credentialStore gpg 

wget https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.6.0/gcm-linux_amd64.2.6.0.tar.gz


git clone https://github.com/devvc-cyber/conectaai.git
