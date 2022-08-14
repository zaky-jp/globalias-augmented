_globalias() {
   # Get last word to the left of the cursor:
   # (z) splits into words using shell parsing
   # (A) makes it an array even if there's only one element
   local word=${${(Az)LBUFFER}[-1]}
   if [[ $GLOBALIAS_FILTER_VALUES[(Ie)$word] -eq 0 ]]; then
      zle _expand_alias
      zle expand-word
   fi
}

globalias() {
  _globalias
  zle self-insert
}

globalias_upon_return() {
  _globalias
  zle accept-line
}

zle -N globalias
zle -N globalias_upon_return

# space expands all aliases, including global
bindkey -M emacs " " globalias
bindkey -M viins " " globalias

# control-space to make a normal space
bindkey -M emacs "^ " magic-space
bindkey -M viins "^ " magic-space

# normal space during searches
bindkey -M isearch " " magic-space

# enter expands all aliases
bindkey -M emacs "^M" globalias_upon_return
bindkey -M viins "^M" globalias_upon_return
