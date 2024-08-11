#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

## Package overrides
RMPKGS=(
    firefox
    firefox-langpacks
)

ADDPKGS=(
    sanoid
)

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

## Add gregw/extras COPR
curl -so /etc/yum.repos.d/gregw-extras-fedora-40.repo https://copr.fedorainfracloud.org/coprs/gregw/extras/repo/fedora-40/gregw-extras-fedora-40.repo

## Add systemd timers for periodic ZFS scrubs
cat << EOF > /usr/lib/systemd/zfs-scrub@.service
[Unit]
Description=zpool scrub on %i

[Service]
Nice=19
IOSchedulingClass=idle
KillSignal=SIGINT
ExecStart=/usr/sbin/zpool scrub %i

[Install]
WantedBy=multi-user.target
EOF

cat << EOF > /usr/lib//systemd/system/zfs-scrub@.timer
[Unit]
Description=Weekly zpool scrub on %i

[Timer]
OnCalendar=Mon *-*-* 04:00:00
AccuracySec=1h
Persistent=true

[Install]
WantedBy=multi-user.target
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
