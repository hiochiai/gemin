# GemIn

**GemIn** is a tool for running the **Gem**ini CLI **in**side a Docker container. By using this tool, you don't need to install Node.js on your host system. GemIn is designed to make your Gemini CLI experience safe, clean, and easy.

It offers several key advantages:
- **Safe Execution**: AI agents run securely in an isolated container.
- **Clean Environment**: No need to install Node.js on your host system.
- **Easy User Switching**: Seamlessly switch between different authenticated users for various projects or accounts.

## Prerequisites

- Docker
- Google Account (for using Gemini API)

## Installation

```bash
curl -L -o gemin https://github.com/hiochiai/gemin/releases/latest/download/gemin
chmod +x gemin
sudo mv gemin /usr/local/bin/
```

## Quick Start

### 1. Initial Setup

Run the `init` command to perform the initial setup.

```bash
gemin init
```

This command guides you through the Gemini CLI configuration process:

1.  **Theme Selection**: Choose the CLI appearance.
2.  **Authentication**: Select "Login with Google" and follow the authentication link displayed in the terminal.
3.  **Start Chatting**: After setup, the Gemini CLI starts in interactive mode.

> [!IMPORTANT]
> Since this runs in a container, the authentication web page will not automatically open in your browser. Please manually click the displayed link to proceed with authentication.

<details>
<summary>Terminal output example</summary>

```
Code Assist login required.
Attempting to open authentication page in your browser.
Otherwise navigate to:

https://accounts.google.com/o/oauth2/v2/auth?redirect_uri=http%3A%2F%2Flocalhost%3A58923%2Foauth2callback&access_type=offline&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcloud-platform%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.profile&state=7b4f8e2d9c1a6e5f0b3d8a7e4c9f2b5e8a1d4c7f0e3b6a9d2f5e8b1c4a7e0d3f6&response_type=code&client_id=123456789012-abcd1234efgh5678ijkl9012mnop3456.apps.googleusercontent.com


Waiting for authentication...
```
</details>

Once you exit the CLI, you can start a new session anytime by simply running `gemin`.

## Commands

### `gemin` (default)

Runs the Gemini CLI inside a container, mounting the current directory.

**Basic usage:**
```bash
gemin
```
*→ Equivalent to `gemini --yolo` inside the container.*

**With Gemini CLI Options:**
```bash
gemin --all-files
```
*→ Equivalent to `gemini --yolo --all-files` inside the container.*

> [!NOTE]
> The `--sandbox` option is not available.

### `gemin init`

Performs the initial setup for the Gemini CLI.

**Usage:**
```bash
gemin init
```
*→ Removes existing config and runs `gemini --debug --yolo` inside the container.*

> [!WARNING]
> The `init` command uses `docker run` with the `--network host` option to allow the authentication callback from Google. This means the container shares the host's network stack, which can have security implications.

### `gemin pull`

Pulls the latest gemin image from the GitHub Container Registry.

```bash
gemin pull
```

## Configuration

### Configuration Directory

Configuration files are stored in `~/.gemin` by default. You can customize this using the `GEMIN_CONFIG_DIR` environment variable.

### Environment Variables

You can customize GemIn's behavior using the following environment variables.

| Variable | Description | Default Value | Used by Commands |
| :--- | :--- | :--- | :--- |
| `GEMIN_CONFIG_DIR` | Specifies a custom configuration directory. Useful for switching between authenticated users. | `~/.gemin` | `gemin`, `gemin init` |
| `GEMIN_IMAGE` | Specifies a custom Docker image. | `ghcr.io/hiochiai/gemin` | `gemin`, `gemin init`, `gemin pull` |
| `GOOGLE_CLOUD_PROJECT` | Specifies the Google Cloud Project ID to use for authentication. This is saved to a `.env` file within the configuration directory during `init`. | (none) | `gemin init` |

**Example: Switching between users**

```bash
# Set up user1 (default)
gemin init

# Set up user2 with a different configuration directory
GEMIN_CONFIG_DIR=~/.gemin-user2 gemin init

# Run as user1
gemin

# Run as user2
GEMIN_CONFIG_DIR=~/.gemin-user2 gemin
```

**Example: Specifying a Project ID during setup**

```bash
GOOGLE_CLOUD_PROJECT=your-project-id gemin init
```

## Uninstallation

To uninstall GemIn completely:

```bash
# Remove the binary
sudo rm /usr/local/bin/gemin

# Remove default configuration directory
rm -rf ~/.gemin

# Remove Docker image
docker rmi ghcr.io/hiochiai/gemin:latest
```

> [!NOTE]
> If you have created other configuration directories using the `GEMIN_CONFIG_DIR` environment variable, please remove them manually.

## License

This project is released under the MIT License. See the [LICENSE](LICENSE) file for details.