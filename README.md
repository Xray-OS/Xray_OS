# Viper(Xray_OS)

<img src="https://images2.imgbox.com/12/9e/wqMmWy0F_o.png" alt="Alt text" width="300"/>
Xray The bear

![Xray_OS Logo](https://img.shields.io/badge/Kernel:-Linux-blue?style=for-the-badge)
![Version](https://img.shields.io/badge/Version:-18-green?style=for-the-badge)
![Arch Based](https://img.shields.io/badge/Based%20on:-Arch%20-1793d1?style=for-the-badge)

## Overview
Viper (Xray_OS) is a personal Arch Linux-based distribution created for my personal use - it's not intended as a competitor to other distributions. This is a curated system with custom tools and fixes for several use cases.

👉 Website: [Visit Viper's page](https://xray-os.github.io/xray_os-website/)

## Key Features

- **🛠️ Custom AUR Helper** - Tolito-AUR-helper gets primarily curated in-house PKGBUILDs, AUR and custom configured repositories as fallback
- **📦 Curated Packages** - Fixed and improved PKGBUILDs for some broken AUR packages
- **🎨 Custom Wallpapers** - Original Viper wallpapers (not sourced from elsewhere)
- **🖥️ Smart GPU Detection** - Automatically detects and removes unused GPU drivers during installation
- **🎬 DaVinci Resolve Support** - Easy installation via Tolito-AUR-helper
- **📋 Tolitica Welcome App** - Custom welcome application with useful system options

## Unique Features

### Arch7z-Installer/Viper-Installer
- Viper custom installer (Currently been fixed, it'll be back)
- Custom partitioning option
- Swap is optional
- Works on VMs
- Made with the QT framework
- Beautiful and elegant UI
- Minimal
- BTRFS and EXT4 only
- UEFI/GPT only

### Tolito-AUR-helper
- Custom AUR helper that builds and downloads packages on the fly primarily from Viper's curated repo, but also from AUR and optionals added repos, ChaoiticAUR added as an extra repo already
- Fixes some broken AUR packages (like DaVinci Resolve installation errors) ---> (Notify if it's still working please..)
- Automatically falls back to standard AUR or even optional added repos like ChaoticAUR repos (added by default) if a package is not available

### Tolitica Welcome App
- Custom welcome application with useful system options
- Provides easy access to system configuration and tools
- Option to change your shell
- Several options to configured the system after a fresh install, including removing or leave packages for gaming, stores, flatpak, snapd and others
- Option to enable/disable terminal theming (Fish only)
- Integraded with Arch7z-Installer and Calamares Installer (Arch7z-Installer it's been fixed at the moment, please have patience)

### Smart Installation Features
- **GPU Driver Detection**: Automatically detects your GPU and removes unused drivers
- **DaVinci Resolve Fix**: Resolves missing title bar issues in DaVinci Resolve on KDE Plasma
- **Custom Wallpapers**: Includes original Viper wallpapers

### Important Notes
- This is a **personal ISO** created for personal use
- **Not a commercial competitor** to other distributions
- GPU driver detection feature works good, but it will be improved eventually
- Have patient for fixes because this distro is only mantained by literally just one person

## System Requirements

### Minimum Requirements
- **CPU**: x86_64 processor (64-bit)
- **RAM**: 4 GB minimum
- **Storage**: 25 GB available disk space
- **Graphics**: Any graphics card with basic driver support

### Recommended Requirements
- **CPU**: Multi-core x86_64 processor
- **RAM**: 8 GB or more
- **Storage**: 70 GB+ SSD storage
- **Graphics**: Dedicated graphics card for optimal performance

## Download
**Current Status**: ISO under active development
- **Project Page**: [SourceForge](https://sourceforge.net/projects/xray-os/)

## What Makes This Different

### DaVinci Resolve Made Easy
Normally, downloading DaVinci Resolve from the AUR gives installation errors. With Viper's Tolito-AUR-helper, you can:
- Download and install DaVinci Resolve easily
- Get it installed on the fly without errors
- Access curated PKGBUILDs that fix some broken AUR packages
- Fixed title bar issues in DaVinci Resolve

### Personal Touch
- Created as a personal ISO for specific needs
- Not intended to compete with major distributions unless people take interest in the project and stop discriminating it because it's a Venezuelan project
- Focuses on innovation, creation, usability and solving real-world package installation issues
- Includes original custom wallpapers
- Custom tools to manage the system
- Adjusted for almost every use case primarily as a workstation

## Community & Support

- **Project Page**: [SourceForge](https://sourceforge.net/projects/xray-os/)
- **Issues**: Report bugs and feature requests on SourceForge
- **Discussions**: Community forums and discussions

## License

Viper is semi open-source but is not LIBRE. Individual components may have their own licenses.

## Contributing

We welcome contributions!, some people think this project it's useless because of it's humble origins, if you ever let aside the discrimination and you think this is a great system please contribute to it

---

*Viper - It’s not a Linux fork. It’s the Linux you never expected*
