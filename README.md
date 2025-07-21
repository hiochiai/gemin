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

## Getting Started

Run the `init` command to perform the initial setup. This is a multi-step process due to the containerized environment.

### Step 1: Start the Authentication Process

```bash
gemin init
```

This command starts the Gemini CLI and guides you through the initial setup:

1.  **Theme Selection**: Choose your preferred CLI appearance.
2.  **Authentication Method**: Select "Login with Google".
3.  The CLI will display a message like `Logging in with Google... Please restart Gemini CLI to continue.` and then exit.

### Step 2: Retrieve the Authentication URL

After the first step, run `gemin` again.

```bash
gemin
```

The CLI will now display an authentication URL.

The authentication web page will not automatically open in your browser. **You must manually copy the full URL and paste it into your web browser.**

### Step 3: Authorize and Enter the Code

1.  After opening the URL in your browser, log in with your Google account and grant the necessary permissions.
2.  A **verification code** will be displayed in your browser.
3.  Copy this code and paste it back into the waiting terminal.

Once the code is entered correctly, authentication is complete. You can start chatting with Gemini. To start a new session in the future, simply run `gemin`.

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
*→ Removes existing config and runs `gemini --yolo` inside the container to start the multi-step authentication process.*

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