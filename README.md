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

## Installation ⚙️

Since we're relying on Docker, and we've installed Docker by now.

### SELinux Consideration (For Linux Users)

If you're using SELinux on your system, you need to adjust the file security contexts to ensure your containerized services can access the necessary configuration files. Run the following commands before starting the container:

```bash
sudo chcon -Rt svirt_sandbox_file_t ./nginx.conf
sudo chcon -Rt svirt_sandbox_file_t ./apikeys.conf
```

These commands modify the SELinux file context to allow your Docker container to access the `nginx.conf` and `apikeys.conf` files.

### Spin up the Docker instance.

Run the following command to get your project running in one second.

```bash
docker compose up -d
```

### Generate the Secret Key:

Before running the project, you need to generate a secret key. Use the ./gen-secret-key.sh script to create this key:

```bash
bash ./gen-secret-key.sh
```

After generating the secret key, you need to add it to the `apikeys.conf` file. The format should be:

```bash
  "your_secret_key" "your_username";
```

For example:

```bash
"secret-cd443ce0628a6e333a82T3BlbkFJcc0da99bbefe734a657f" "tomyjany"
```

### Test the Inference API

The inference API supports both `ApiKey` and `Bearer` headers.

#### Via the `curl` Command:

To test the inference Api run the shell curl command (It should output: _Ollama is running_):

```bash
curl -I 'http://localhost:5050' -H 'apikey: secret-e24827bf59bac39e5900T3BlbkFJ3580c6008f369cad46f8'
```

Or,

```bash
curl -I 'http://localhost:5050' -H 'Authorization: Bearer secret-e24827bf59bac39e5900T3BlbkFJ3580c6008f369cad46f8'
```



#### Via the OpenAI-API Compatibility:

Ollama now has built-in compatibility with the OpenAI Chat Completions API, making it possible to use more tooling and applications with Ollama locally.

* OpenAI Python Library:

```python
import OpenAI from 'openai'

const openai = new OpenAI({
  baseURL: 'http://localhost:5050/v1',
  apiKey: 'secret-e24827bf59bac39e5900T3BlbkFJ3580c6008f369cad46f8', 
})

response = client.chat.completions.create(
  model="llama2",
  messages=[
    {"role": "system", "content": "You are an assistant in coding."},
    {"role": "user", "content": "What year was Python invented?"},
    {"role": "assistant", "content": "Python was first released on February 20, 1991."},
    {"role": "user", "content": "What big features it had?"}
  ]
)
print(response.choices[0].message.content)
```

* OpenAI JavaScript Library:

```js
import OpenAI from 'openai'

const openai = new OpenAI({
  baseURL: 'http://localhost:5050/v1',
  apiKey: 'secret-e24827bf59bac39e5900T3BlbkFJ3580c6008f369cad46f8',
})

const completion = await openai.chat.completions.create({
  model: 'llama2',
  messages: [
    { role: "system", content: "You are an assistant in coding." },
    { role: "user", content: "What year was Python invented?" },
    { role: "assistant", content: "Python was first released on February 20, 1991." },
    { role: "user", content: "What big features it had?" },
  ],
})

console.log(completion.choices[0].message.content)
```

### Shut Down the Project

To shut down the project, run:

```bash
docker compose down
```

## License 📄

This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details
