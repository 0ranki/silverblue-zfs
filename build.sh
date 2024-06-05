#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

ZFS_KERNEL_VERSION="$(find /tmp/rpms/kmods/zfs/ -name "kmod-zfs*.rpm" ! -name "*devel*" | sed 's/.*\/kmod-zfs-//; s/\.fc.*$//g' | head -1)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
rpm-ostree override remove kernel kernel-core kernel-modules kernel-modules-extra --replace /tmp/kernel/kernel*.rpm
rpm-ostree override remove zfs-fuse --install /tmp/rpms/kmods/zfs/*.rpm

# this would install a package from rpmfusion
# rpm-ostree install vlc

#### Example for enabling a System Unit File

systemctl enable podman.socket
