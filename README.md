# Claw-for-WeChat — Chat Backup

OpenClaw WeChat 聊天记录自动备份

## 📂 文件结构

| 文件 | 说明 |
|------|------|
| `*.jsonl` | 原始对话数据（OpenClaw session 格式） |
| `sessions.json` | 会话索引 |
| `SUMMARY.md` | 会话概览 |
| `readable/*.md` | 📖 人类可读 Markdown（手机也能看） |

## 🔄 在新设备恢复记忆

```bash
# 1. 克隆备份
git clone git@github.com:kuiba-online/Claw-for-WeChat.git /tmp/restore
cd /tmp/restore

# 2. 拷回 session 文件
cp sessions.json *.jsonl ~/.openclaw/agents/main/sessions/

# 3. 重启 OpenClaw
```

或者一行命令：
```bash
curl -sL https://raw.githubusercontent.com/kuiba-online/Claw-for-WeChat/main/restore.sh | bash
```

恢复后 Nova 就能读取所有历史对话了 ✨
