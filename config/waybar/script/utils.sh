#!/usr/bin/env bash
safe_num() {
  local val="$1"
  if [[ "$val" =~ ^[0-9]+$ ]]; then
    echo "$val"
  else
    echo 0
  fi
}

default_iface() {
  ip route show default 2>/dev/null | awk '{print $5; exit}'
}

class_high() {
  local v="$1" w="$2" c="$3"
  if ((v >= c)); then
    echo "critical"
  elif ((v >= w)); then
    echo "warning"
  else
    echo ""
  fi
}

class_low() {
  local v="$1" w="$2" c="$3"
  if ((v <= c)); then
    echo "critical"
  elif ((v <= w)); then
    echo "warning"
  else
    echo ""
  fi
}

center_text() {
  local text="$1" width="$2"
  local len=${#text}
  local total_padding=$((width - len))
  local left=$((total_padding / 2))
  local right=$((total_padding - left))
  printf '%*s%s%*s' "$left" "" "$text" "$right" ""
}

to_json() {
  local text="$1" class="$2" tooltip="${3:-$1}"
  printf '{"text":"%s","class":"%s","tooltip":"%s"}\n' "$text" "$class" "$tooltip"
}

nth_existing_workspace() {
  local n="$1"
  hyprctl workspaces -j 2>/dev/null | jq -r --argjson n "$n" \
    'map(.id) | sort | .[$n - 1] // empty'
}

workspace_index() {
  local id="$1"

  hyprctl workspaces -j 2>/dev/null |
    jq -r --argjson id "$id" '
        map(.id)
        | sort
        | map(select(. <= $id))
        | length
    '
}

get_hypr_state() {
  local cache="/tmp/waybar-hypr-state.json"
  local lock="/tmp/waybar-hypr-state.lock"
  local max_age_ms=120

  (
    flock -w 1 200
    local now mtime=0
    now=$(date +%s%3N)
    [[ -f "$cache" ]] && mtime=$(date -r "$cache" +%s%3N 2>/dev/null || echo 0)

    if ((now - mtime > max_age_ms)); then
      {
        printf '{"active":'
        hyprctl activeworkspace -j
        printf ',"clients":'
        hyprctl clients -j
        printf ',"workspaces":'
        hyprctl workspaces -j
        printf '}'
      } >"$cache"
    fi
  ) 200>"$lock"

  cat "$cache" 2>/dev/null
}

NTF_QUEUE_DIR="/tmp/waybar-ntf-queue"
NTF_STATE_FILE="/tmp/waybar-ntf-current"
NTF_DISPLAY_SECONDS=8

queue_message() {
  local text="$1"
  mkdir -p "$NTF_QUEUE_DIR"
  local id
  id=$(date +%s%N)
  printf '%s' "$text" >"${NTF_QUEUE_DIR}/${id}"
}

get_current_queued_message() {
  local now
  now=$(date +%s)

  if [[ -f "$NTF_STATE_FILE" ]]; then
    local expiry text
    IFS='|' read -r expiry text <"$NTF_STATE_FILE"
    if [[ -n "$expiry" ]] && ((now < expiry)); then
      echo "$text"
      return 0
    fi
  fi

  local next
  next=$(ls -1 "$NTF_QUEUE_DIR" 2>/dev/null | sort -n | head -1)

  if [[ -n "$next" ]]; then
    local text expiry
    text=$(cat "${NTF_QUEUE_DIR}/${next}")
    rm -f "${NTF_QUEUE_DIR}/${next}"
    expiry=$((now + NTF_DISPLAY_SECONDS))
    printf '%s|%s' "$expiry" "$text" >"$NTF_STATE_FILE"
    echo "$text"
    return 0
  fi

  rm -f "$NTF_STATE_FILE"
  return 1
}

post_message() {
  local text="$1" ttl="${2:-4}"
  local expiry=$(($(date +%s) + ttl))
  printf '%s|%s\n' "$expiry" "$text" >/tmp/waybar-mda-message
}

get_pending_message() {
  local file="/tmp/waybar-mda-message"
  [[ -f "$file" ]] || return 1

  local expiry text
  IFS='|' read -r expiry text <"$file"
  local now
  now=$(date +%s)

  if [[ -n "$expiry" ]] && ((now < expiry)); then
    echo "$text"
    return 0
  else
    rm -f "$file"
    return 1
  fi
}
