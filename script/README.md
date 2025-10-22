# Shopify Theme Testing Scripts

Scripts for creating and managing multiple Shopify theme instances for testing purposes.

## Scripts

### `setup.sh` - Create Multiple Theme Instances

Creates multiple Shopify theme instances, each running on a separate development server.

**Usage:**
```bash
./script/setup.sh <number_of_instances>
```

**Examples:**
```bash
# Create 1 instance (default)
./script/setup.sh

# Create 8 instances
./script/setup.sh 8

# Maximum 10 instances
./script/setup.sh 10
```

**What it does:**
1. Kills any existing servers on ports 9100-9109
2. Creates separate theme directories (shopify-theme-test/shopify-theme-N)
3. Pulls live theme to each directory
4. Copies guides, rulebooks, and CLAUDE.md to each theme
5. Pushes each as a development theme
6. Starts dev server on ports 9100-9109 (one per instance)

**Features:**
- ✅ Automatic port conflict detection and cleanup
- ✅ API rate limiting protection (8s between instances, 20s after every 3)
- ✅ Retry logic for throttled API requests (up to 3 attempts)
- ✅ Port binding verification before proceeding
- ✅ All servers run in background

**Ports:**
- Instance 1: http://127.0.0.1:9100
- Instance 2: http://127.0.0.1:9101
- Instance 3: http://127.0.0.1:9102
- ... and so on

**Stopping servers:**
The script will display PIDs when complete:
```bash
kill <PID1> <PID2> <PID3>...
```

Or press `Ctrl+C` to stop all servers.

### `cleanup.sh` - Clean Up Theme Instances

Stops all running theme dev servers and optionally removes theme directories.

**Usage:**
```bash
./script/cleanup.sh
```

**What it does:**
1. Finds all `shopify theme dev` processes on ports 9100-9199
2. Kills all matching processes
3. Asks if you want to remove theme directories

**Interactive:**
```
Do you want to remove all theme directories in shopify-theme-test/? (y/N)
```
- `y` - Removes all theme directories
- `N` - Keeps directories (you can restart servers later)

## Troubleshooting

### Port Already in Use
If you see `EADDRINUSE` errors:
```bash
# Clean up existing servers first
./script/cleanup.sh
```

### API Throttling
If instances fail with `THROTTLED` errors:
- The script automatically retries (up to 3 times)
- Wait time increases: 10s, 20s, 30s
- Consider running fewer instances at once

### Servers Not Starting
Check if ports are available:
```bash
lsof -i :9100-9109
```

Kill specific process:
```bash
kill <PID>
```

### Theme ID Mismatch
This is a Shopify API issue. Try:
1. Stop all servers: `./script/cleanup.sh`
2. Wait 1-2 minutes
3. Re-run setup script

## Configuration

Edit `setup.sh` to change:

- **Store URL**: `SHOPIFY_URL="your-store.myshopify.com"`
- **Theme Token**: `SHOPIFY_THEME_TOKEN="shptka_..."`
- **Admin Token**: `SHOPIFY_ADMIN_TOKEN="shpat_..."`
- **Port Range**: Modify `DEV_PORT=$((9100 + INSTANCE_NUM - 1))`
- **Delays**: Adjust wait times in the instance loop

## Best Practices

1. **Always cleanup first**
   ```bash
   ./script/cleanup.sh
   ./script/setup.sh 8
   ```

2. **Don't exceed 10 instances**
   - API rate limits
   - System resource constraints

3. **Wait between batch runs**
   - Allow 2-3 minutes between large batches
   - Respects Shopify API rate limits

4. **Monitor system resources**
   - Each instance uses ~300MB RAM
   - 8 instances ≈ 2.4GB RAM

## Architecture

```
shopify-theme-test/
├── shopify-theme-1/    (Port 9100)
│   ├── assets/
│   ├── blocks/
│   ├── guides/         (copied)
│   ├── rulebooks/      (copied)
│   ├── CLAUDE.md       (copied)
│   └── ...
├── shopify-theme-2/    (Port 9101)
└── shopify-theme-N/    (Port 910N-1)
```

Each instance is completely independent with its own:
- Theme directory
- Development theme ID on Shopify
- Dev server process
- Port number
