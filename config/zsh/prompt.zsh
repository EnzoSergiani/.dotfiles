setopt PROMPT_SUBST

# ---------------------------
# Couleurs Zsh natives
# ---------------------------

FG_DIR="%F{blue}"
FG_USER="%F{green}"
FG_GIT="%F{yellow}"
FG_RESET="%f"

# ---------------------------
# Affichage Git détaillé avec symboles
# ---------------------------
GIT_PROMPT_SHOW_UPSTREAM=1

parse_git_details() {
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  [[ -z "$branch" ]] && return

  commits_ahead=""
  commits_behind=""
  branch_tracking=""
  local_symbol=""

  if [[ "$GIT_PROMPT_SHOW_UPSTREAM" -eq 1 ]]; then
    if git rev-parse --abbrev-ref @{u} &>/dev/null; then
      commits_ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null)
      commits_behind=$(git rev-list --count HEAD..@{u} 2>/dev/null)
      if [[ "$commits_ahead" -gt 0 && "$commits_behind" -gt 0 ]]; then
        branch_tracking="↓ $commits_behind↑$commits_ahead"
      elif [[ "$commits_ahead" -gt 0 ]]; then
        branch_tracking="↑ $commits_ahead"
      elif [[ "$commits_behind" -gt 0 ]]; then
        branch_tracking="↓ $commits_behind"
      fi
    else
      local_symbol="L "
    fi
  fi

  local staged_count=0 conflict_count=0 removed_count=0 unstaged_count=0 untracked_count=0
  while IFS= read -r line; do
    case "${line:0:2}" in
    UU | AA | DD) ((conflict_count++)) ;;
    D\  | \ D) ((removed_count++)) ;;
    \?\?) ((untracked_count++)) ;;
    *)
      [[ "${line:0:1}" != " " && "${line:0:1}" != "?" ]] && ((staged_count++))
      [[ "${line:1:1}" != " " ]] && ((unstaged_count++))
      ;;
    esac
  done < <(git status --porcelain 2>/dev/null)

  stash_count=$(git stash list 2>/dev/null | wc -l)

  local clean_symbol="✔"
  status_output=""
  [[ "$staged_count" -gt 0 ]] && status_output+="● $staged_count "
  [[ "$conflict_count" -gt 0 ]] && status_output+="✖ $conflict_count "
  [[ "$removed_count" -gt 0 ]] && status_output+="✖- $removed_count "
  [[ "$unstaged_count" -gt 0 ]] && status_output+="✚ $unstaged_count "
  [[ "$untracked_count" -gt 0 ]] && status_output+="… $untracked_count "
  [[ "$stash_count" -gt 0 ]] && status_output+="⚑ $stash_count "
  [[ -z "$status_output" ]] && status_output="$clean_symbol"

  echo " ${FG_GIT}[${branch}${local_symbol:+ $local_symbol}${branch_tracking:+ $branch_tracking} | ${status_output}${FG_GIT}]${FG_RESET}"
}

setopt PROMPT_SUBST
PS1="${FG_DIR}[%~]${FG_RESET}\$(parse_git_details) %(?.${FG_USER}.${FG_GIT})${FG_RESET}$ "

# ---------------------------
# Prompt principal
# ---------------------------
PS1="${FG_DIR}[%~]${FG_RESET}\$(parse_git_details) %(?.${FG_USER}.${FG_GIT})${FG_RESET}$ "
# PS1="${FG_RESET}[%~]\$(parse_git_details) %(?..)$ ${FG_RESET}"
