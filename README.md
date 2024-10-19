# Silverblue-ZFS

[![build-silverblue-zfs](https://github.com/0ranki/silverblue-zfs/actions/workflows/build.yml/badge.svg)](https://github.com/0ranki/silverblue-zfs/actions/workflows/build.yml)

This is a customized Universal Blue image with the OpenZFS kernel module installed.

See [upstream Universal Blue](https://github.com/ublue-os/main/) repo for more detailed instructions how
to rebase to this image.

Image uses CoreOS' `stable` kernel from [Universal Blue kernel-cache image](https://ghcr.io/ublue-os/coreos-stable-kernel) and
matching ZFS kmod RPMs from [Universal Blue `akmods-zfs` image](https://ghcr.io/ublue-os/akmods-zfs) are installed.

Other additions, subject to change:
- Sanoid installed from [gregw/extras COPR](https://copr.fedorainfracloud.org/coprs/gregw/extras)
- Other added packages (along with their deps):
  - tailscale
  - hstr
  - VS Code
  - Yaru theme

## Fork & customize

To fork & customize, make your necessary edits in `build.sh`.

Adding or removing layered packages is simple using the `ADDPKGS` and `RMPKGS` variables in the script.
