

# Ada (formerly Xray_OS)
This is my own personal and customized Arch-based Linux instance nobody asked for, that I decided to compile into a single ISO, this ISO contains all of my personal configs, settings and packages, that I normally use by default in Linux.

Currently is a project just for my personal use, I share it with the public, just in case someone wants to test it for fun, but is not really something that I created to be a competitor or to convince someone of replacing their current OS with mine.

# So what is included in the distro?

## Several package-managers
Just the usual but with a little bit more for the sake to help potential curious users who are not exactly savy-linux-users per say. Things like Discover are included which is also an excellent Graphical User Interface, package manager that can handle mainly Flatpak and also some native Linux packages, this last is thanks to the inclusion of the "packagekit-qt6" which allows Discover to take packages directly from the available Arch repos in pacman.conf (except may be the ones from the CHAOTIC-AUR and the AUR in general), and last but not least Octopi package manager is also included, which is a GUI pkg-manager but it is less graphical compare to the other 2 named previously.

## NVIDIA-DRIVERS or AMD-DRIVERS
In case of AMD, almost not to much is needed when it comes to drivers, since the Linux Kernel has a very well known support towards AMD products, though a user still a bit problematic, because some Nvidia pkgs might still get installed even if the user don't really have an Nvidia graphics card, this will be fixed of course. When it comes to NVIDIA-drivers the support is excellent, NVIDIA-KERNEL-MODULES (DKMS modules) are well pre-configured to do all of the necessary processes after every transaction from an update, the NVIDIA-drivers that are being used are the current "nvidia-open-dkms" drivers, plus the rest of the necessary NVIDIA-drivers like "lib32-opencl-nvidia" and so on, you can check the pkglist inside the "archiso" folder to see the specific related pkgs.

## General Essential Tweaks to improve the experience in Archlinux
Little tweaks like support for things like switcheroo-control, supergfxctl, fstrim.timer (better performance for NVME or SSD drives), Bluetooth, Flatpak, KDE-Plasma preconfigured nicely, CHAOTIC-AUR integraded already, all necessary programs, custom-repos that included packages that are normally available in the AUR only, improvementss to the shell and several terminals settings.

## Conclusion
Like I said at the beginning, this is my personal Arch-based Linux OS instance, that I created for me mostly, to have my settings, my preferences, my style of how I like to set a Linux distro, for sure this can get better than what it currently is if people like it and would like to see it being supported, other than that.. is just a matter of time till it dies.

<img src="https://images2.imgbox.com/93/10/eHj7jhXu_o.png">

<img src="https://images2.imgbox.com/a5/e5/VcjlKerg_o.png">

<img src="https://images2.imgbox.com/91/a3/bmepo64s_o.jpg">
