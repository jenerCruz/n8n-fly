

# Python
pip install -r requirements.txt

# n8n on Fly.io

This repository provides instructions and configuration for hosting n8n on Fly.io. n8n is a workflow automation tool that allows you to connect various services and automate tasks.

![N8N Setup Process](assets/n8n-setup.png)

## Prerequisites

- A Fly.io account
- Fly CLI installed on your machine
- Basic knowledge of command line operations

## Installation

### 1. Install Fly.io CLI

For Windows, open PowerShell and run:

```powershell
powershell -Command "iwr https://fly.io/install.ps1 -useb | iex"
```

For other operating systems, visit [Fly.io's installation guide](https://fly.io/docs/hands-on/install-flyctl/).

### 2. Launch Your n8n Instance

1. Clone this repository:
```bash
git clone https://github.com/gijs-epping/n8n-fly.git
cd n8n-fly
```

2. Launch your app with Fly.io:
```bash
fly launch
```

### 3. Configure Your Application

During the launch process, you'll need to configure several settings:

1. **App Name**: Choose a unique name for your application (e.g., "n8ntestonfly")
   - This will be used in your app's URL: `https://[app-name].fly.dev`

2. **Region**: Select your preferred region (e.g., "Amsterdam, Netherlands")
   - Choose a region close to your location for better performance

3. **Resources**: Default configuration includes:
   - Shared CPU (1x)
   - 1GB RAM
   - No additional services (Postgres, Redis, etc.)

4. **Environment Variables**: Make sure to set these in your `fly.toml`:
   - `N8N_HOST`: Must match your app URL
   - `WEBHOOK_URL`: Must match your app URL

### 4. Important Notes

- The application will automatically stop when idling to save resources
- Your app will be accessible at `https://[app-name].fly.dev`
- First-time access will require setting up an owner account

## Configuration Reference

### fly.toml Example

```toml
app = "n8ntestonfly"  # Your unique app name
primary_region = "ams" # Your chosen region
```

### Access Your Application

After deployment, you can access your n8n instance at:
```
https://[app-name].fly.dev/
```

## First-Time Setup

1. Visit your newly deployed app URL
2. Complete the owner account setup:
   - Enter your email
   - Create a secure password (8+ characters, including numbers and capital letters)
   - Fill in your first and last name

## Troubleshooting

### Common Issues and Solutions

#### 1. Deployment Failures
- **Issue**: `fly launch` fails
  ```bash
  Error: failed to fetch an image or build from source
  ```
  **Solution**: 
  - Verify your internet connection
  - Check if Fly.io services are up
  - Run `fly status` to check your authentication
  - Try `fly auth login` to reauthenticate

#### 2. Configuration Issues
- **Issue**: Application not starting properly
  **Solution**:
  1. Check your `fly.toml` configuration:
     ```bash
     fly status
     fly logs
     ```
  2. Verify these essential configurations:
     ```toml
     app = "your-unique-app-name"
     primary_region = "ams"  # or your chosen region
     
     [env]
     N8N_HOST = "https://your-app-name.fly.dev"
     WEBHOOK_URL = "https://your-app-name.fly.dev"
     ```

#### 3. Connection Issues
- **Issue**: Cannot access the n8n interface
  **Solutions**:
  1. Verify DNS propagation:
     ```bash
     fly status
     ```
  2. Check if the application is running:
     ```bash
     fly apps list
     fly status
     ```
  3. Inspect logs for errors:
     ```bash
     fly logs
     ```

#### 4. Resource Issues
- **Issue**: Application crashes or performs poorly
  **Solutions**:
  1. Check resource usage:
     ```bash
     fly status
     ```
  2. Adjust resources in `fly.toml`:
     ```toml
     [services]
       [[services.concurrency]]
         type = "connections"
         hard_limit = 25
         soft_limit = 20
     
     [[vm]]
       cpu_kind = "shared"
       cpus = 1
       memory_mb = 1024
     ```

#### 5. Auto-stop Issues
- **Issue**: Application stops unexpectedly
  **Note**: This is expected behavior as mentioned in deployment notes
  **Solutions**:
  1. Check auto-stop settings:
     ```bash
     fly status
     ```
  2. Modify auto-stop behavior in `fly.toml`:
     ```toml
     [services]
       auto_stop_machines = true
       auto_start_machines = true
       min_machines_running = 0
     ```

#### 6. Database Connection Issues
- **Issue**: Cannot connect to database
  **Solutions**:
  1. Verify database settings:
     ```bash
     fly redis list  # for Redis
     fly postgres list  # for PostgreSQL
     ```
  2. Check connection strings in environment variables
  3. Ensure database service is running:
     ```bash
     fly status
     ```

### Debug Commands Reference

Useful commands for troubleshooting:
```bash
fly logs  # View application logs
fly status  # Check application status
fly secrets list  # View configured secrets
fly regions list  # View available regions
fly scale show  # Check current resource allocation
```

### Getting Help

If you're still experiencing issues:

1. Visit [Fly.io Status Page](https://status.fly.io/)
2. Check [n8n Community Forums](https://community.n8n.io/)
3. Review [Fly.io Documentation](https://fly.io/docs/)
4. Join [n8n Discord](https://discord.gg/n8n)
5. Open an issue in this repository with:
   - Detailed error description
   - Relevant logs
   - Steps to reproduce
   - Your `fly.toml` configuration (with sensitive data removed)

## Support

For support, please:

- Check the [n8n documentation](https://docs.n8n.io/)
- Visit the [Fly.io documentation](https://fly.io/docs/)
- Open an issue in this repository

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

[MIT License](LICENSE)