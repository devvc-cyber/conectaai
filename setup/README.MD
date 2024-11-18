# Install and configure git-credential-manager

sudo dnf install git
git config --global user.name "devvc-cyber"
git config --global user.email rafael@volvecare.com
ssh-keygen -t rsa -b 4096 -C "rafael@volvecare.com"
ssh-keygen -t rsa -b 4096 -C "seuemail@exemplo.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
sudo dnf install epel-release
xclip -selection clipboard < ~/.ssh/id_ed25519.pub

# add ssh key to github

git clone https://github.com/devvc-cyber/conectaai.git
