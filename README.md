 <img src="https://images2.imgbox.com/b1/19/gp7ReKqs_o.png"> 

## Xray_OS 
This is my own personal and customized Archlinux instance, that I decided to compile it into a single ISO, this ISO contains all of my personal configs, settings and packages, that I normally use by default in Arch.

Currently is a project just for my personal use, I share it with the public, just in case someone wants to test it for fun, but is not really something that I created to be a competitor or to convince someone of replacing their current OS with mine.

## So what is included in the distro?

# Several package-managers
Just the usual but with a little bit more just for the sake to help potential curious users who are not exactly powerusers or savy-linux-users per say. Things like pacmac-all which is a graphical user interface package manager known in the menu launcher as "Add/Remove Software", which by the way can be configured to include several versions of known package formats and sources, like, packages from the AUR, Flatpaks, Snaps and may be others, also Discover is included which is also an excellent GUI (remember: Graphical User Interface), package manager that can handle mainly Flatpaks and also native Archlinux pkgs, this last is thanks to the inclusion of the "packagekit-qt6" which allows Discover to take packages directly from the available Archlinux repos in pacman.conf (except may be the ones from the CHAOTIC-AUR), and last but not least Octopi package manager is also included, which is a GUI pkg-manager but it is less graphical compare to the other 2 named previously.

# NVIDIA-DRIVERS or AMD-DRIVERS
In case of AMD, almost not to much is needed when it comes to drivers, since the Linux Kernel has a very well known support towards AMD products, when it comes to NVIDIA-drivers the support is excellent, NVIDIA-KERNEL-MODULES (DKMS modules) are well pre-configured to do all of the necessary processes after every transaction from an update, in case NVIDIA is not being used but rather AMD, then a script will automatically delete all of the NVIDIA-drivers, same if non NVIDIA or AMD drivers are being used, then it will automatically delete all related drivers regarding that. The NVIDIA-drivers that are being used are the current "nvidia-open-dkms" drivers, plus the rest of the necessary NVIDIA-drivers like "lib32-opencl-nvidia" and so on, you can check the pkglist inside the "archiso" folder to see the specific related pkgs.

# General Essential Tweaks to improve the experience in Archlinux
Little tweaks like support for things like switcheroo-control, supergfxctl, fstrim.timer (better performance for NVME or SSD drives), bluetooth, snapd support, almost all the essential pkgs for software-development, a fix for the missing title bar in Davinci Resolve in KDE-Plasma, KDE-Plasma preconfigured nicely, CHAOTIC-AUR integraded already, all necessary programs, custom-repos that included pkgs that are normally not available in the extra-official Archlinus repos, improvementss to the shell and several terminals in their settings, apps and dependencies for gaming, some good wallpapers to have fun with and other things here and there.

## Conclusion
Like I said at the beginning, this is my personal Archlinux instance, that I created for me, for my use, to have my settings, my preferences, my style of how I like to set my distro, I created for myself, so don't expect this to be something different or revolutionary, this is just useful if for some reason you like my settings and theming and instead of doing yourself all of this manually in Archlinux, then you can download this and start using this already pre-configured ISO.

![Desktop 2](https://github.com/Xray-OS/xray_os/assets/143856402/847105ac-5e33-4e80-b2b8-ea10675a0429)

<img src="https://images2.imgbox.com/a5/e5/VcjlKerg_o.png">

<img src="https://images2.imgbox.com/91/a3/bmepo64s_o.jpg">


<img src="https://images2.imgbox.com/79/d9/c0B6V9le_o.png" width="100" height="92">
