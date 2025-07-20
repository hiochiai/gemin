# GemIn

**GemIn** is a tool for running the **Gem**ini CLI **in**side a Docker container. By using this tool, you don't need to install Node.js on your host system. AI agents run safely in an isolated container environment, providing a clean and easy Gemini execution environment.

## Prerequisites

- Docker
- Google Account (for using Gemini API)

## Installation

```bash
curl -L -o gemin https://github.com/hiochiai/gemin/releases/latest/download/gemin
chmod +x gemin
sudo mv gemin /usr/local/bin/
```

## Uninstallation

To uninstall GemIn completely:

```bash
# Remove the binary
sudo rm /usr/local/bin/gemin

# Remove configuration directory
rm -rf ~/.gemin

# Remove Docker image
docker rmi ghcr.io/hiochiai/gemin:latest
```

## Quick Start

### 1. Initial Setup

```bash
gemin init
```

This command performs the Gemini CLI configuration process and automatically starts interactive mode after setup completion. This follows exactly the same setup procedure as a regular Gemini CLI installation:

1. **Theme Selection** - Choose the CLI appearance
2. **Authentication Method Selection** - Usually select "Login with Google"  
3. **Authentication Execution** - A Google authentication link will be displayed in the terminal
4. **Interactive Mode** - After setup completion, the Gemini CLI starts and you can begin chatting

**Important**: Since this runs in a container, the authentication web page will not automatically open in your browser. Please manually click the displayed link to proceed with authentication.

Terminal output example:
```
Code Assist login required.
Attempting to open authentication page in your browser.
Otherwise navigate to:

https://accounts.google.com/o/oauth2/v2/auth?redirect_uri=http%3A%2F%2Flocalhost%3A58923%2Foauth2callback&access_type=offline&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcloud-platform%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.profile&state=7b4f8e2d9c1a6e5f0b3d8a7e4c9f2b5e8a1d4c7f0e3b6a9d2f5e8b1c4a7e0d3f6&response_type=code&client_id=123456789012-abcd1234efgh5678ijkl9012mnop3456.apps.googleusercontent.com


Waiting for authentication...
```

After successful authentication, the Gemini CLI will start in interactive mode, and you can start chatting.

Once you exit the CLI, you can run interactive mode anytime by simply running the `gemin` command. You do not need to run `gemin init` again unless you want to reset your configuration.

## Command List

### `gemin` (default)

Runs the Gemini CLI inside a container. The current directory is mounted into the container.

**Basic usage:**
```bash
gemin
```

*→ Equivalent to running `gemini --yolo` inside the container*

**Add Gemini CLI Options:**
```bash
gemin --all-files
```

*→ Equivalent to running `gemini --yolo --all-files` inside the container*

> [!IMPORTANT]
> The `--sandbox` option is not available.

### `gemin init`

Performs the initial setup for the Gemini CLI. After the setup is complete, it automatically starts an interactive session.

**Usage:**
```bash
gemin init
```

*→ Removes existing config and runs `gemini --debug --yolo` inside the container*

> [!IMPORTANT]
> When using the `init` command, this tool uses `docker run` with the `--network host` option to allow the authentication callback from Google. This means the container shares the host's network stack, which can have security implications. Please be aware of this when running the initial setup.

**Specifying Google Cloud Project ID:**
```bash
GOOGLE_CLOUD_PROJECT=your-project-id gemin init
```

*→ Removes existing config, saves GOOGLE_CLOUD_PROJECT to .env, and runs `gemini --debug --yolo` inside the container*

### `gemin pull`

Pulls the latest gemin image from the GitHub Container Registry.

```bash
gemin pull
```

## Configuration

Configuration files are stored in the `~/.gemin` directory.

## License

This project is released under the MIT License. See the [LICENSE](LICENSE) file for details.
