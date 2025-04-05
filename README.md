# Terraform Tools

Helpful scripts and tools for working with Terraform in a structured project environment.

## Overview

This repo contains utilities that make working with Terraform easier in projects with standardised directory structure. The main tool is a Terraform wrapper script that:

- Works from any directory in your project (defaults to `infrastructure/terraform`)
- Automatically detects your Terraform configuration location
- Sources environment variables for authentication from an environment variable file (defaults to `.env`)
- Auto-initializes when necessary

## Installation

### Option 1: Quick Install

Run the install script to add the tools to your $PATH:

```bash
./install.sh
```

This will:
- Make the script(s) executable
- Add the bin directory to your PATH by modifying your shell configuration file (~/.bashrc or ~/.zshrc)
- Tell you how to update your current shell session

### Option 2: Manual Installation

If you prefer more control over the installation:

1. Make the scripts executable:
   ```bash
   chmod +x bin/*
   ```

2. Either:
   - Add the bin directory to your PATH:
     ```bash
     export PATH="/path/to/terraform-tools/bin:$PATH"
     ```
   - Create symlinks to your personal bin directory:
     ```bash
     ln -s /path/to/terraform-tools/bin/tf ~/bin/tf
     ```

## Usage

### Terraform Wrapper (tf)

The main tool is a (simple) Terraform wrapper that finds your Terraform configuration and runs commands in the correct context:

```bash
# Initialize Terraform
tf init

# Create a plan
tf plan

# Apply changes
tf apply

# Any other Terraform command
tf <command> [arguments]
```

#### Features

- **Dynamic project detection**: Works from any directory in your project
    - Project root is determined by reversing the directory tree until the infrastructure directory is found.
- **Auto-initialization**: Automatically runs `terraform init` when needed
- **Environment variables**: Sources `.env` file from project root if available
    - This helps with current Azure provider requirement to supply Tenant and Subscription IDs outside of the Az CLI tool
- **Argument passing**: Forwards all additional arguments to Terraform

#### Expected Project Structure

By default, the tool expects your Terraform configuration to be in an `infrastructure/terraform` directory within your project:

```
your-project/
├── infrastructure/
│   └── terraform/
│       ├── main.tf
│       └── ...
└── ...
```

## Advanced Configuration

If you want to customize the tools, you can modify:

- The subdirectory name in the `tf` script (update the `TF_SUBDIR` variable)
- The environment variables file (update the `DOTENV` variable)
- The shell configuration file in the `install.sh` script

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
