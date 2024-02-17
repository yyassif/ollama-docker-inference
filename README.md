# Inference Ollama Using Docker based on NGINX Proxy Manager using a custom ApiKey (Just like OpenAI).

In the realm of LLMs Era we deleve into creating a infernce API of Ollama within a Docker container and assign it to an Nginx Proxy Manager in order to use it outside of our hosted Virtual Private Server (VPS).

## Compatibilty Features 🎯

- **Fast and Efficient**: Due to the use of an external dedicated server.
- **Cloud-Based**: Cloud-First adapatibility by design.
- **OS Compatibile**: It runs everywhere since it only offers a static base Api url & an ApiKey.

## Getting Started 🚀

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

So as to deploy and spin up a running version of this on your cloud after.

### Prerequisites 📋

Ensure you have the following installed:

- Docker
- Docker Compose

### 60 seconds Installation 💽

You can find the installation documentation [here](https://docs.docker.com/engine/install/ubuntu/).

- **Step 0**: Uninstall all conflicting packages:

  ```bash
  for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
  ```

- **Step 1**: Set up Docker's apt repository:

  ```bash
  # Add Docker's official GPG key:
  sudo apt-get update
  sudo apt-get install ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
  ```

- **Step 2**: Install the Docker packages:

  ```bash
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  ```

- **Step 3**: Run Docker Without Sudo

  ```bash
  sudo groupadd docker
  sudo usermod -aG docker $USER
  sudo chown $USER:docker /var/run/docker.sock
  sudo chown -R $USER:docker /var/run/docker
  ```

## Installation

Since we're relying on docker, and we've installed docker by now.

Run the following command to get your project running in one second.

```bash
docker compose up -d
```

To test the inference Api run the following shell script (It outputs: _Ollama is running_):

```bash
bash tryApi.sh
```

The above script runs the following script:

```bash
curl -I 'http://localhost:5050/' --header 'apikey: yassif+NiAyz2OCU97Jq2CRY5vzWqEk0jLrIkSd0zSMrviASL71R'
```

```bash
docker compose down
```

To shutdown the project:

## License 📄

This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details
