WORK_MAIL=$1
PERSONAL_MAIL=$2
WORKPLACE=$(echo "$WORK_MAIL" | cut -d @ -f2 | cut -d . -f1)
PERSONAL_PLACE=$(echo "$PERSONAL_MAIL" | cut -d @ -f2 | cut -d . -f1)

# generate work pem file
ssh-keygen -C "$WORK_MAIL" << END_OF_INPUTS
~/.ssh/$WORKPLACE
END_OF_INPUTS

# generate personal pem file
ssh-keygen -C "$PERSONAL_MAIL" << END_OF_INPUTS
~/.ssh/$PERSONAL_PLACE
END_OF_INPUTS

# homebrew
curl -fsSL -o install.sh https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
rm install.sh

brew tap hashicorp/tap
brew tap snyk/tap
brew install jq yq helm awscli bash-completion hashicorp/tap/vault hashicorp/tap/boundary hashicorp/tap/consul terraform snyk nvm
# the --cask option install the gui version of all these apps. It's technically not necessary and the apps
# could be installed w/o the cask option in the command above but I didn't wanna forget what casks are, so here we are
# and also if there are ambiguous names it'll choose the cask (gui)
brew install --cask postman visual-studio-code firefox brave-browser spotify intellij-idea-ce whatsapp docker slack \
      notion discord gather

nvm i node

cat > ~/.bash_aliases <<EOF
alias identity=". identity \"$@\""
EOF

# we add the bash profile stuff after brew installing (bash-completion)
kubectl completion bash >/etc/bash_completion.d/kubectl
cat > ~/.bash_profile <<EOF
# ssh auto-completion (and others?)
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
# custom bash-completion
#try getting source $(pwd)/identity-completion.bash else move the scripts to an appropriate dir
source /Users/minenhlesithole/Desktop/skadush/setup/completion/identity.bash
source /Users/minenhlesithole/Desktop/skadush/setup/completion/kubectl
export PATH=$PATH:/Users/minenhlesithole/Desktop/skadush/setup/bin
source <(kubectl completion bash)
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
source ~/.bash_aliases
EOF
source ~/.bash_profile

cat > ~/.ssh/config <<EOF
Host ssh.dev.azure.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/lipapayments
Host hosted-agents-vms
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/hosted-agents-vms.pem
  User ubuntu
  HostName 10.3.11.216
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/skadush
  HostName github.com
EOF
