# Silverblue-ZFS

This is a customized Universal Blue image with the OpenZFS kernel module installed.

See [upstream Universal Blue](https://github.com/ublue-os/main/) repo for more detailed instructions how
to rebase to this image.

The ZFS modules are built against the latest latest ublue-os:main image, Fedora 40 at the time of writing.
Building the modules is basically taken straight from [Fedora CoreOS](https://github.com/coreos/layering-examples/tree/main/build-zfs-module)
example, except the base image used to detect the correct version is `ublue-os:main`.

## Known issues
The build fails consistently once a week. Most likely Fedora repos are already serving a newer kernel version,
while the pulled ublue image is still on the older kernel version. Next day's build succeeds, so this only means
a day without an updated image every week.

Dependencies for Jim Salter's excellent [Sanoid/Syncoid](https://github.com/jimsalterjrs/sanoid) might become
preinstalled at some stage, but for now I've decided to keep everything close to `ublue-os:main`. Suggestions,
issues and pull requests are welcome.
