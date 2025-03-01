#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="Xray_OS"
iso_label="Xray_OS"
iso_publisher="XeroArch <https://sourceforge.net/projects/xray-os/>"
iso_application="Xray_OS Live/Rescue CD"
iso_version="v12"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito'
           'uefi-ia32.grub.esp' 'uefi-x64.grub.esp'
           'uefi-ia32.grub.eltorito' 'uefi-x64.grub.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
bootstrap_tarball_compression=('zstd' '-c' '-T0' '--auto-threads=logical' '--long' '-19')
file_permissions=(
  ["/etc/gshadow"]="0:0:600"
  ["/etc/shadow"]="0:0:600"
  ["/root"]="0:0:700"
  ["/root/.gnupg"]="0:0:700"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/etc/polkit-1/rules.d"]="0:0:750"
  ["/etc/sudoers.d"]="0:0:750"
  ["/etc/grub.d/40_custom"]="0:0:755"
  ["/usr/local/bin/xray-snapper"]="0:0:755"
)
