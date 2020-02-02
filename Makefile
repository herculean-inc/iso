# Configuration settings
DISTRO_CODE?=workspaces
DISTRO_VERSION?=19.10

DISTRO_EPOCH?=$(shell date +%s)
DISTRO_DATE?=$(shell date +%Y%m%d)

ISO_NAME?=$(DISTRO_CODE)_$(DISTRO_VERSION)

# local user name
GPG_NAME?=`id -un`
# Workspaces Debug Key
GPG_SIGNING_KEY?="D4DB34C8"

PROPOSED?=0
NVIDIA?=0

# Enable local (pop_os hosted) apt mirror
FAST_MIRROR?=0

# Include automatic variables
include mk/automatic.mk

# Include Ubuntu definitions
include mk/ubuntu.mk

# Language packages
include mk/language.mk

# Include configuration file
include config/$(DISTRO_CODE)/$(DISTRO_VERSION).mk

# Standard target - build the ISO
iso: $(ISO)

tar: $(TAR)

usb: $(USB)

# Complete target - build zsync file, SHA256SUMS, and GPG signature
all: $(ISO) $(ISO).zsync $(BUILD)/SHA256SUMS $(BUILD)/SHA256SUMS.gpg

serve: all
	cd $(BUILD) && python3 -m http.server 8909

# Popsicle target
popsicle: $(ISO)
	sudo popsicle-gtk "$(ISO)"

# Clean target
include mk/clean.mk

# Germinate target
include mk/germinate.mk

# QEMU targets
include mk/qemu.mk

# Chroot targets
include mk/chroot.mk

# Update targets
include mk/update.mk

# ISO targets
include mk/iso.mk

# Force target
FORCE:
