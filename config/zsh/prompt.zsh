# ---------------------------
# Couleurs Zsh natives
# ---------------------------

FG_DIR="%F{blue}"
FG_USER="%F{green}"
FG_DIR="%F{blue}"
FG_GIT="%F{yellow}"
FG_RESET="%f"

# ---------------------------
# Affichage Git détaillé avec symboles
# ---------------------------
GIT_PROMPT_SHOW_UPSTREAM=1

parse_git_details() {
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    if [[ -n "$branch" ]]; then
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

        # Statut Git
        staged_count=$(git diff --cached --name-only | wc -l)
        conflict_count=$(git diff --name-only --diff-filter=U | wc -l)
        removed_count=$(git diff --name-only --cached --diff-filter=D | wc -l)
        unstaged_count=$(git diff --name-only | wc -l)
        untracked_count=$(git ls-files --others --exclude-standard | wc -l)
        stash_count=$(git stash list | wc -l)
        clean_symbol="✔"
        status_output=""

        [[ "$staged_count" -gt 0 ]] && status_output+="● $staged_count "
        [[ "$conflict_count" -gt 0 ]] && status_output+="✖ $conflict_count "
        [[ "$removed_count" -gt 0 ]] && status_output+="✖- $removed_count "
        [[ "$unstaged_count" -gt 0 ]] && status_output+="✚ $unstaged_count "
        [[ "$untracked_count" -gt 0 ]] && status_output+="… $untracked_count "
        [[ "$stash_count" -gt 0 ]] && status_output+="⚑ $stash_count "
        [[ -z "$status_output" ]] && status_output="$clean_symbol"

        echo " ${FG_GIT}[${branch}${local_symbol:+ $local_symbol}${branch_tracking:+ $branch_tracking} | ${status_output}${FG_GIT}]${FG_RESET}"
    fi
}

# ---------------------------
# Prompt principal
# ---------------------------
export PS1="${FG_DIR}[%~]${FG_RESET}\$(parse_git_details) %(?.${FG_USER}.${FG_GIT})${FG_RESET}$ "
# export PS1="${FG_RESET}[%~]\$(parse_git_details) %(?..)$ ${FG_RESET}"
