#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

## Package overrides
RMPKGS=(

)

ADDPKGS=(
    hstr
    sanoid
    tailscale
)

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

## Add gregw/extras COPR
curl -so /etc/yum.repos.d/gregw-extras-fedora-40.repo https://copr.fedorainfracloud.org/coprs/gregw/extras/repo/fedora-40/gregw-extras-fedora-40.repo

## Add tailscale repo
cat << EOF > /etc/yum.repos.d/tailscale.repo
[tailscale-stable]
name=Tailscale stable
baseurl=https://pkgs.tailscale.com/stable/fedora/$basearch
enabled=1
type=rpm
repo_gpgcheck=1
gpgcheck=1
gpgkey=https://pkgs.tailscale.com/stable/fedora/repo.gpg
EOF

## Add VS Code repo
cat << EOF > /etc/yum.repos.d/vscode.repo 
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

RMSTRING=""
ADDSTRING=""

for pkg in ${ADDPKGS[@]}; do
    ADDSTRING="${ADDSTRING} --install=${pkg}"
done

for pkg in ${RMPKGS[@]}; do
    RMSTRING="${RMSTRING} --remove=${pkg}"
done

rpm-ostree override replace ${ADDSTRING} ${RMSTRING} /tmp/rpms/kernel/*.rpm /tmp/rpms/zfs/*.rpm

# Auto-load ZFS module
depmod -a "$(rpm -qa kernel --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')" && \
echo "zfs" > /etc/modules-load.d/zfs.conf && \
# we don't want any files on /var
rm -rf /var/lib/pcp

#### Example for enabling a System Unit File

## Just in case, according to https://openzfs.github.io/openzfs-docs/Getting%20Started/Fedora/index.html#installation
echo 'zfs' > /etc/dnf/protected.d/zfs.conf
