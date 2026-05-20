#!/bin/bash
# ============================================================
# OpenClaw Session Restore Script
# Clones backup repo and restores session files so Nova
# can "remember" past conversations on a new device.
# ============================================================
set -e

REPO_URL="git@github.com:kuiba-online/Claw-for-WeChat.git"
BACKUP_DIR="/tmp/openclaw-restore"
SESSIONS_DIR="$HOME/.openclaw/agents/main/sessions"
LOG_FILE="/tmp/openclaw-restore.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "=== Restore started ==="

# 1. Clone backup repo
if [ -d "$BACKUP_DIR" ]; then
    log "Pulling latest backup..."
    cd "$BACKUP_DIR"
    git pull origin main 2>&1 | tee -a "$LOG_FILE"
else
    log "Cloning backup repo..."
    git clone "$REPO_URL" "$BACKUP_DIR" 2>&1 | tee -a "$LOG_FILE"
fi

# 2. Restore session files
log "Restoring session files..."
mkdir -p "$SESSIONS_DIR"

# Copy sessions index
if [ -f "$BACKUP_DIR/sessions.json" ]; then
    cp "$BACKUP_DIR/sessions.json" "$SESSIONS_DIR/sessions.json"
    log "  ✅ sessions.json"
fi

# Copy all JSONL files (skip readable/ and SUMMARY.md)
copied=0
for f in "$BACKUP_DIR"/*.jsonl; do
    if [ -f "$f" ]; then
        cp "$f" "$SESSIONS_DIR/"
        log "  ✅ $(basename "$f")"
        ((copied++)) || true
    fi
done

if [ "$copied" -eq 0 ]; then
    log "  ⚠️ No JSONL files found in backup"
fi

log "=== Restore complete ==="
log "Session files restored to: $SESSIONS_DIR"
log "Restart OpenClaw for changes to take effect."
