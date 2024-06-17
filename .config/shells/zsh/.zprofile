# XDG User directories.
# =====================
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CURRENT_DESKTOP="X-Generic"
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state

# Xorg.
# =====
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export XRESOURCES="$XDG_CONFIG_HOME"/X11/xresources
export XSERVERRC="$XDG_CONFIG_HOME"/X11/xserverrc

# Environment variables.
# ======================
export -U PATH path FPATH fpath MANPATH manpath
export -UT INFOPATH infopath
export EDITOR=nvim
export LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH"
export MINECWAFT="/home/justcausewhynot/.local/share/PrismLauncher/instances"
export notes="/home/justcausewhynot/Documents/Notes"
export PATH="${PATH}:$HOME/.local/bin:$HOME/.local/share/dwm/statusbar-scripts"
export TERMINAL=st
export VISUAL=nvim
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json
