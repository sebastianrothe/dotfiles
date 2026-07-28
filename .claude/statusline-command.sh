#!/bin/sh
# ABOUTME: statusline-command.sh — Claude Code status line script
# ABOUTME: Shows model, context usage, token counts, current directory, and git branch

input=$(cat)

# --- Formatting helpers ---
# Abbreviates a token count with a K/M suffix, dot as decimal point (e.g. 45800 -> 45.8K)
format_tokens() {
  LC_NUMERIC=C awk -v n="$1" 'BEGIN {
    if (n >= 1000000) printf "%.1fM", n / 1000000;
    else if (n >= 1000) printf "%.1fK", n / 1000;
    else printf "%d", n;
  }'
}

# --- Model ---
model=$(echo "$input" | jq -r '.model.display_name // .model.id // "unknown"')

# --- Context window ---
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
total_tokens=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
input_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')

# --- Session cost ---
cost_usd=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')

# --- Current directory (up to 3 components) ---
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
home="$HOME"
short_path="${cwd/#$home/\~}"
short_path=$(echo "$short_path" | awk -F'/' '{
  n=NF; start=n-2;
  if(start<1) start=1;
  out="";
  for(i=start;i<=n;i++){
    if(out!="") out=out"/";
    out=out$i
  }
  if(substr($0,1,1)=="~" && start>1) out=".../" out;
  print out
}')

# --- Git branch (skip optional lock) ---
branch=""
if [ -n "$cwd" ] && [ -d "$cwd/.git" ] || git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
fi

# --- Assemble output ---
# Colors: cyan=model, yellow=context, white=tokens, blue=cost, green=dir, magenta=branch
printf "\033[36m%s\033[0m" "$model"

if [ -n "$used_pct" ] && [ -n "$total_tokens" ] && [ -n "$input_tokens" ]; then
  used_pct_rounded=$(printf "%.0f" "$used_pct")
  printf "  \033[33m%s%% used\033[0m  \033[37m%s / %s tokens\033[0m" \
    "$used_pct_rounded" "$(format_tokens "$input_tokens")" "$(format_tokens "$total_tokens")"
elif [ -n "$used_pct" ]; then
  used_pct_rounded=$(printf "%.0f" "$used_pct")
  printf "  \033[33m%s%% used\033[0m" "$used_pct_rounded"
fi

if [ -n "$cost_usd" ]; then
  printf "  \033[34m\$%s\033[0m" "$(LC_NUMERIC=C awk -v n="$cost_usd" 'BEGIN { printf "%.2f", n }')"
fi

printf "  \033[32m%s\033[0m" "$short_path"

if [ -n "$branch" ]; then
  printf "  \033[35m(%s)\033[0m" "$branch"
fi
