# kyanite

[![build-ublue](https://github.com/pliveyns/kyanite/actions/workflows/build.yml/badge.svg)](https://github.com/pliveyns/kyanite/actions/workflows/build.yml)

Customized Fedora Silverblue image, based on Universal Blue startingpoint.
For more info, check out the [uBlue homepage](https://universal-blue.org/) and the [main uBlue repo](https://github.com/ublue-os/main/)

See also the [Make Your Own-page in the documentation](https://universal-blue.org/tinker/make-your-own/) for quick setup instructions for setting up your own repository.

## Installation

To rebase an existing Silverblue/Kinoite installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/pliveyns/kyanite:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/pliveyns/kyanite:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

