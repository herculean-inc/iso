#!/usr/bin/bash

# clone repo
git clone https://github.com/herculean-inc/workspaces-material-shell.git /usr/share/gnome-shell/extensions/workspaces-material-shell@herculean-inc

# directories
DCONF_SETTINGS_DIR="/etc/dconf/db/local.d"
WORKSPACES_DESKTOP="$DCONF_SETTINGS_DIR/00-workspaces-desktop"

# make sure local.d exists
mkdir -p $DCONF_SETTINGS_DIR

# write settings file
cat << EOF > $WORKSPACES_DESKTOP

[org/gnome/shell]
enabled-extensions=['workspaces-material-shell@herculean-inc']

[org/gnome/desktop/interface]
font-name="Roboto Light 11"
document-font-name="Roboto 11"

EOF

# load new settings
dconf update

#gsettings set org.gnome.desktop.interface font-name "Roboto Light 11"
#gsettings set org.gnome.desktop.interface document-font-name "Roboto 11"
