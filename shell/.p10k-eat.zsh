#!/usr/bin/env zsh
# Simplified prompt configuration for Emacs eat terminal
# Customizable options for a clean, informative prompt

# Configuration options - uncomment/modify as needed
PROMPT_SHOW_USER=false          # Show username@hostname
PROMPT_SHOW_TIME=true           # Show time on right side
PROMPT_SHOW_GIT=true            # Show git branch and status
PROMPT_SHOW_VENV=true           # Show Python virtual environment
PROMPT_SHOW_EXIT_CODE=true      # Show exit code on error
PROMPT_SHOW_JOBS=true           # Show background job count
PROMPT_TWO_LINE=true            # Use two-line prompt

function prompt_simple_eat() {
  local prompt_line=""
  
  # Username@hostname (optional)
  if [[ "$PROMPT_SHOW_USER" == true ]]; then
    prompt_line+="%F{green}%n@%m%f:"
  fi
  
  # Current directory (always shown)
  prompt_line+="%F{blue}%~%f"
  
  # Python virtual environment
  if [[ "$PROMPT_SHOW_VENV" == true ]] && [[ -n "$VIRTUAL_ENV" ]]; then
    local venv_name=$(basename "$VIRTUAL_ENV")
    prompt_line+=" %F{yellow}(${venv_name})%f"
  fi
  
  # Git information
  if [[ "$PROMPT_SHOW_GIT" == true ]]; then
    if git rev-parse --git-dir > /dev/null 2>&1; then
      local branch=$(git branch --show-current 2>/dev/null)
      if [[ -n "$branch" ]]; then
        # Check for dirty status
        if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
          prompt_line+=" %F{yellow}(${branch} ✗)%f"
        else
          prompt_line+=" %F{cyan}(${branch} ✓)%f"
        fi
        
        # Show ahead/behind status
        local ahead_behind=$(git rev-list --left-right --count @{upstream}...HEAD 2>/dev/null)
        if [[ -n "$ahead_behind" ]]; then
          local behind=$(echo "$ahead_behind" | awk '{print $1}')
          local ahead=$(echo "$ahead_behind" | awk '{print $2}')
          if [[ "$ahead" -gt 0 ]]; then
            prompt_line+=" %F{green}↑${ahead}%f"
          fi
          if [[ "$behind" -gt 0 ]]; then
            prompt_line+=" %F{red}↓${behind}%f"
          fi
        fi
      fi
    fi
  fi
  
  # Background jobs
  if [[ "$PROMPT_SHOW_JOBS" == true ]]; then
    local job_count=$(jobs | wc -l | tr -d ' ')
    if [[ "$job_count" -gt 0 ]]; then
      prompt_line+=" %F{yellow}[${job_count}⚙]%f"
    fi
  fi
  
  # Exit code (only if non-zero)
  if [[ "$PROMPT_SHOW_EXIT_CODE" == true ]]; then
    if [[ $? -ne 0 ]]; then
      prompt_line+=" %F{red}[✗ %?]%f"
    fi
  fi
  
  # Build final prompt
  if [[ "$PROMPT_TWO_LINE" == true ]]; then
    PROMPT="${prompt_line}
%F{magenta}❯%f "
  else
    PROMPT="${prompt_line} %F{magenta}❯%f "
  fi
  
  # Right prompt with time
  if [[ "$PROMPT_SHOW_TIME" == true ]]; then
    RPROMPT="%F{240}%*%f"
  else
    RPROMPT=""
  fi
}

# Set up the prompt
precmd_functions+=(prompt_simple_eat)
