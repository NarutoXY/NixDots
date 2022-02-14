# Fix delete key not working
bindkey "\e[3~" delete-char

# Fix Ctrl+u killing from the cursor instead of the whole line
bindkey \^U backward-kill-line

# substring
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
