# Silverblue-ZFS

[![build-silverblue-zfs](https://github.com/0ranki/silverblue-zfs/actions/workflows/build.yml/badge.svg)](https://github.com/0ranki/silverblue-zfs/actions/workflows/build.yml)

This is a customized Universal Blue image with the OpenZFS kernel module installed.

See [upstream Universal Blue](https://github.com/ublue-os/main/) repo for more detailed instructions how
to rebase to this image.

Image uses CoreOS' `stable` kernel from [Universal Blue kernel-cache image](https://ghcr.io/ublue-os/coreos-stable-kernel) and
matching ZFS kmod RPMs from [Universal Blue `akmods-zfs` image](https://ghcr.io/ublue-os/akmods-zfs) are installed.

Other additions, subject to change:
- RPM firefox removed
- Sanoid installed from [gregw/extras COPR](https://copr.fedorainfracloud.org/coprs/gregw/extras)