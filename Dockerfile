FROM ubuntu:18.04

# Setup ENV vars
ENV DEBIAN_FRONTEND=noninteractive

# Install required system libs
RUN apt-get update && apt-get install -y lsb-release && apt-get clean all
RUN apt install -y software-properties-common
RUN add-apt-repository -y ppa:git-core/ppa
RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y curl
RUN apt-get install -y wget
RUN apt-get install -y python3
RUN apt-get install -y jq
RUN apt install -y python3
RUN apt-get install -y python3-pip
RUN apt-get install -y python3-setuptools

# Install 1password
RUN pip3 install --upgrade pip
RUN curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
RUN echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | tee /etc/apt/sources.list.d/1password.list
RUN mkdir -p /etc/debsig/policies/AC2D62742012EA22/
RUN curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
RUN apt-get update 
RUN apt install -y 1password

# Install Python libs: yq, bcrypt, pyaml & cryptography
RUN pip3 install yq
RUN pip3 install bcrypt
RUN pip3 install pyyaml
RUN pip3 install cryptography
RUN pip3 install onepasswordconnectsdk

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install ArgoCD client
RUN curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
RUN chmod +x /usr/local/bin/argocd

# Install Helm client
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
RUN chmod 700 get_helm.sh
RUN ./get_helm.sh

# Install Vault Client
RUN apt-get install gpg
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg >/dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
RUN apt update && apt install vault
RUN apt-get install --reinstall -y vault

# Run helper script
ENTRYPOINT ["/root/install.sh"]
