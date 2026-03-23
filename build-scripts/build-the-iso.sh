#!/bin/bash
#set -e
#tput setaf 0 = black 
#tput setaf 1 = red 
#tput setaf 2 = green
#tput setaf 3 = yellow 
#tput setaf 4 = dark blue 
#tput setaf 5 = purple
#tput setaf 6 = cyan 
#tput setaf 7 = gray 
#tput setaf 8 = light blue
##################################################################################################################
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################
# Funtions

echo "##################################################################"
tput setaf 2
echo "First run the version script"
tput sgr0
echo "##################################################################"

sleep 2

clean_cache() {
    if [[ "$1" == "yes" ]]; then
    	echo "##################################################################"
    	tput setaf 2
        echo "Cleaning the cache from /var/cache/pacman/pkg/"
        tput sgr0
        echo "##################################################################"
        yes | sudo pacman -Scc
    elif [[ "$1" == "no" ]]; then
        echo "Skipping cache cleaning."
    else
        echo "Invalid option. Use: clean_cache yes | clean_cache no"
    fi
}

remove_buildfolder() {

    if [[ -z "$buildFolder" ]]; then
        echo "Error: \$buildFolder is not set. Please define it before using this function."
        return 1
    fi

    if [[ "$1" == "yes" ]]; then
        if [[ -d "$buildFolder" ]]; then
        	echo "##################################################################"
    		tput setaf 3
            echo "Deleting the build folder ($buildFolder) - this may take some time..."
            tput sgr0
            sudo rm -rf "$buildFolder"
            echo "##################################################################"
        else
        	echo "##################################################################"
            echo "No build folder found. Nothing to delete."
            echo "##################################################################"
        fi
    elif [[ "$1" == "no" ]]; then
        echo "Skipping build folder removal."
    else
        echo "Invalid option. Use: remove_buildfolder yes | remove_buildfolder no"
    fi
}

installed_dir=$(dirname $(readlink -f $(basename `pwd`)))

echo
echo "################################################################## "
tput setaf 3
echo "Message (Credits to Erik from Angel G.)"
echo
echo "Do not run this file as root or add sudo in front"
echo "Run this script as a user"
echo
echo "You can add a personal local repo to the iso build if you want"
echo "https://www.youtube.com/watch?v=TqFuLknCsUE"
echo
echo "You can learn to create your own iso on the basis of Kiro"
echo "That project is called Buildra"
echo "https://youtu.be/3jdKH6bLgUE"
echo "https://youtu.be/mH52To8DvlI"
tput sgr0
echo "################################################################## "
echo

sleep 3

# message for BTRFS 
if 	lsblk -f | grep btrfs > /dev/null 2>&1 ; then
	echo
	echo "################################################################## "
	tput setaf 3
	echo "Message"
	echo
    echo "This script may cause issues on a Btrfs filesystem"
    echo "Make backups before continuing"
    echo "Continue at your own risk"
    echo
    echo "Press CTRL + C to stop the script now"
    tput sgr0
    echo
    for i in $(seq 10 -1 0); do
    	echo -ne "Continuing in $i seconds... \r"
    	sleep 1
    done
    echo
fi

echo
echo "################################################################## "
tput setaf 2
echo "Phase 1 : "
echo "- Setting General parameters"
tput sgr0
echo "################################################################## "
echo

	#Let us set the desktop"
	#First letter of desktop is small letter

	desktop="plasma"

	xrayVersion='v26.02.16.01'

	isoLabel='xray-'$xrayVersion'-x86_64.iso'

	# setting of the general parameters
	archisoRequiredVersion="archiso 84-1"
	buildFolder=$HOME"/xray-build"
	outFolder=$HOME"/xray-Out"

	# If you want to add packages from the chaotics-aur repo then
	# change the variable to true and add the package names
	# that are hosted on chaotics-aur in the packages.x86_64 at the bottom

	chaoticsrepo=true
	xlibre=false

	if [[ "$chaoticsrepo" == "true" ]]; then
	    if pacman -Q chaotic-keyring &>/dev/null && pacman -Q chaotic-mirrorlist &>/dev/null; then
	        echo "################################################################## "
			tput setaf 2
			echo "Chaotic keyring and mirrorlist are both installed"
			tput sgr0
			echo "################################################################## "
	    else
	        if [[ -f "$installed_dir/get-the-keys-and-mirrors-chaotic-aur.sh" ]]; then
	        	echo "################################################################## "
				tput setaf 3
				echo "Installing both Chaotic packages as we are missing"
				echo "chaotic-keyring and chaotic-mirrorlist"
    			echo "You can remove them later with pacman -R ..."
				tput sgr0
				echo "################################################################## "
	            bash "$installed_dir/get-the-keys-and-mirrors-chaotic-aur.sh"
	        else
		        echo "################################################################## "
				tput setaf 1
				echo "Error: Installation script not found at $installed_dir"
				tput sgr0
				echo "################################################################## "          
	            exit 1
	        fi
	    fi
	fi
	
echo
echo "################################################################## "
tput setaf 2
echo "Phase 1.5 :"
echo "- Backing up home directory ACLs"
tput sgr0
echo "################################################################## "
echo

# Check if home directory has default ACLs
if getfacl ~ 2>/dev/null | grep -q "default:"; then
	echo "Default ACLs detected in home directory - backing up and removing temporarily"

	# Backup current ACLs from home directory
	ACL_BACKUP_FILE="/tmp/home_acl_backup_$$.txt"
	getfacl -R ~ > "$ACL_BACKUP_FILE" 2>/dev/null
	echo "ACLs backed up to $ACL_BACKUP_FILE"

	# Set trap to restore ACLs on exit/interrupt
	restore_acls() {
		if [ -f "$ACL_BACKUP_FILE" ]; then
			echo
			echo "Restoring ACLs from backup..."
			setfacl --restore="$ACL_BACKUP_FILE" 2>/dev/null
			rm -f "$ACL_BACKUP_FILE"
			echo "ACLs restored"
		fi
	}
	trap restore_acls EXIT INT TERM

	# Remove default ACLs from home to prevent inheritance
	echo "temporarily removing default ACLs from home directory..."
	setfacl -k ~
	echo "Default ACLs removed"
	HAS_ACLS=true
else
	echo "No default ACLs found in home directory - skipping ACL management"
	HAS_ACLS=false
fi
echo


echo
echo "################################################################## "
tput setaf 2
echo "Phase 2 :"
echo "- Checking if archiso/grub is installed"
echo "- Saving current archiso version to readme"
tput sgr0
echo "################################################################## "
echo

	package="archiso"

	#----------------------------------------------------------------------------------

	#checking if application is already installed or else install
	if pacman -Qi $package &> /dev/null; then

			echo "$package is already installed"

	else

		echo "################################################################"
		echo "######### Installing $package with pacman"
		echo "################################################################"

		sudo pacman -S --noconfirm $package

	fi

	# Just checking if installation was successful
	if pacman -Qi $package &> /dev/null; then

		echo 

	else

		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		exit 1
	fi

	package="grub"

	#----------------------------------------------------------------------------------

	#checking if application is already installed or else install
	if pacman -Qi $package &> /dev/null; then

			echo "$package is already installed"

	else

		echo "################################################################"
		echo "######### Installing $package with pacman"
		echo "################################################################"

		sudo pacman -S --noconfirm $package

	fi

	# Just checking if installation was successful
	if pacman -Qi $package &> /dev/null; then

		echo

	else

		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!!!!!!!  "$package" has NOT been installed"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		exit 1
	fi

	# overview
	
	echo "################################################################## "
	tput setaf 2
	echo "Overview"
	tput sgr0
	echo "################################################################## "
	echo "Building the desktop                   : "$desktop
	echo "Building version                       : "$xrayVersion
	echo "Iso label                              : "$isoLabel
	echo "Build folder                           : "$buildFolder
	echo "Out folder                             : "$outFolder
	echo "################################################################## "
	echo

echo
echo "################################################################## "
tput setaf 2
echo "Phase 3 :"
echo "- Deleting the build folder if one exists"
echo "- Copying the Archiso folder to build folder"
tput sgr0
echo "################################################################## "
echo

	remove_buildfolder yes
	echo
	echo "Copying the Archiso folder to build work"
	echo
	mkdir $buildFolder
	cp -r ../archiso $buildFolder/archiso

echo "################################################################## "
tput setaf 2
echo "Phase 4 :"
echo "- Importing xlibre key if enabled"
tput sgr0
echo "################################################################## "
echo
	
	if [[ "$xlibre" == "true" ]]; then

		# Import xlibre key
		if ! sudo arch-chroot $buildFolder/archiso/airootfs pacman-key -f 73580DE2EDDFA6D6 &> /dev/null; then
			echo "Importing xlibre GPG key"
			sudo arch-chroot $buildFolder/archiso/airootfs /bin/bash -c "
				curl -sS https://x11libre.net/repo/arch_based/x86_64/0x73580DE2EDDFA6D6.gpg | gpg --import -
				pacman-key --recv-keys 73580DE2EDDFA6D6
				pacman-key --lsign-key 73580DE2EDDFA6D6
			"
		fi

		# Add xlibre repo
		if ! grep -q '\[xlibre\]' $buildFolder/archiso/airootfs/etc/pacman.conf; then
			echo "Adding xlibre repository"
			echo '[xlibre]' | sudo tee -a $buildFolder/archiso/airootfs/etc/pacman.conf
			echo 'Server = https://x11libre.net/repo/arch_based/x86_64/' | sudo tee -a $buildFolder/archiso/airootfs/etc/pacman.conf
		fi
	fi

echo "################################################################## "
tput setaf 2
echo "Phase 5 :"
#echo "- Deleting any files in /etc/skel"
#echo "- Getting the last version of bashrc in /etc/skel"
echo "- Removing the old packages.x86_64 file from build folder"
echo "- Copying the new packages.x86_64 file to the build folder"
tput sgr0
echo "################################################################## "
echo

	# echo "Deleting any files in /etc/skel"
	# rm -rf $buildFolder/archiso/airootfs/etc/skel/.* 2> /dev/null
	# echo

	# echo "Getting the last version of bashrc in /etc/skel"
	# echo
	# wget https://raw.githubusercontent.com/erikdubois/edu-shells/refs/heads/main/etc/skel/.bashrc-latest -O $buildFolder/archiso/airootfs/etc/skel/.bashrc

	echo "Removing the old packages.x86_64 file from build folder"
	rm $buildFolder/archiso/packages.x86_64
	echo

	echo "Copying the new packages.x86_64 file to the build folder"
	cp -f ../archiso/packages.x86_64 $buildFolder/archiso/packages.x86_64
	echo

	# Nvidia driver selection
	# open | 580xx | 390xx
	nvidia_driver="open"

 	##############################################
 	# Nvidia driver selection
 	##############################################

 	PACKAGES_FILE="$buildFolder/archiso/packages.x86_64"

# 	case "$nvidia_driver" in
#
# 	    open)
# 	    	echo
# 			echo "################################################################## "
# 			tput setaf 2
# 			echo "Using NVIDIA open drivers"
# 			tput sgr0
# 			echo "################################################################## "
# 			echo
# 			sleep 2
#
# 	        # Ensure open drivers are present
# 	        sed -i '/^nvidia-580xx/d' "$PACKAGES_FILE"
# 	        sed -i '/^nvidia-390xx/d' "$PACKAGES_FILE"
#
# 	        sed -i '/^nvidia-open-dkms/d' "$PACKAGES_FILE"
# 	        sed -i '/^nvidia-utils/d' "$PACKAGES_FILE"
# 	        sed -i '/^nvidia-settings/d' "$PACKAGES_FILE"
#
# 	        echo "nvidia-open-dkms"   >> "$PACKAGES_FILE"
# 	        echo "nvidia-utils"       >> "$PACKAGES_FILE"
# 	        echo "nvidia-settings"    >> "$PACKAGES_FILE"
# 	        ;;
#
# 	    580xx)
# 	    	echo "################################################################## "
# 			tput setaf 2
# 			echo "Using NVIDIA 580xx legacy drivers"
# 			tput sgr0
# 			echo "################################################################## "
# 			echo
# 	        sleep 2
#
# 	        # Remove open drivers
# 	        sed -i '/^nvidia-open-dkms/d' "$PACKAGES_FILE"
# 	        sed -i '/^nvidia-utils/d' "$PACKAGES_FILE"
# 	        sed -i '/^nvidia-settings/d' "$PACKAGES_FILE"
#
# 	        # Remove old 580xx entries if any
# 	        sed -i '/^nvidia-580xx/d' "$PACKAGES_FILE"
#
# 	        # Add legacy drivers
# 	        echo "nvidia-580xx-dkms"     >> "$PACKAGES_FILE"
# 	        echo "nvidia-580xx-utils"    >> "$PACKAGES_FILE"
# 	        echo "nvidia-580xx-settings" >> "$PACKAGES_FILE"
# 	        ;;
#
# 	    390xx)
# 	    	echo "################################################################## "
# 			tput setaf 2
# 			echo "Using NVIDIA 390xx legacy drivers"
# 			tput sgr0
# 			echo "################################################################## "
# 			echo
# 	        sleep 2
#
# 	        # Remove open drivers
# 	        sed -i '/^nvidia-open-dkms/d' "$PACKAGES_FILE"
# 	        sed -i '/^nvidia-utils/d' "$PACKAGES_FILE"
# 	        sed -i '/^nvidia-settings/d' "$PACKAGES_FILE"
#
# 	        # Remove old 390xx entries if any
# 	        sed -i '/^nvidia-390xx/d' "$PACKAGES_FILE"
# 	        sed -i '/^nvidia-580xx/d' "$PACKAGES_FILE"
#
# 	        # Add legacy drivers
# 	        echo "nvidia-390xx-dkms"     >> "$PACKAGES_FILE"
# 	        echo "nvidia-390xx-utils"    >> "$PACKAGES_FILE"
# 	        echo "nvidia-390xx-settings" >> "$PACKAGES_FILE"
# 	        ;;
# 	    *)
# 	        echo "Unknown NVIDIA driver option: $nvidia_driver"
# 	        echo "Valid options: open | 580xx | 390xx"
# 	        exit 1
# 	        ;;
#
# 	esac

	# If building XFCE, comment out Plasma-specific packages
	if [[ "$desktop" == "xfce4" ]]; then
		echo "################################################################## "
		tput setaf 3
		echo "Commenting out Plasma packages for XFCE build"
		tput sgr0
		echo "################################################################## "

		# Comment out specific packages
		sed -i '/^xray-kde-settings/d' "$PACKAGES_FILE"
		sed -i '/^plasma/d' "$PACKAGES_FILE"
		sed -i '/^dolphin/d' "$PACKAGES_FILE"
		sed -i '/^dolphin-plugins/d' "$PACKAGES_FILE"
		sed -i '/^kio-admin/d' "$PACKAGES_FILE"
		sed -i '/^kdegraphics-thumbnailers/d' "$PACKAGES_FILE"
		sed -i '/^ark/d' "$PACKAGES_FILE"
		sed -i '/^kcalc/d' "$PACKAGES_FILE"
		sed -i '/^gwenview/d' "$PACKAGES_FILE"
		sed -i '/^spectacle/d' "$PACKAGES_FILE"
		sed -i '/^kdeconnect/d' "$PACKAGES_FILE"
		sed -i '/^kwalletmanager/d' "$PACKAGES_FILE"
		sed -i '/^konsole/d' "$PACKAGES_FILE"
		sed -i '/^tolitica-plasma-theme/d' "$PACKAGES_FILE"
		sed -i '/^xray-kde-dark/d' "$PACKAGES_FILE"
		sed -i '/^arch-kde-theme/d' "$PACKAGES_FILE"
		sed -i '/^dtos-kde-theme/d' "$PACKAGES_FILE"
		sed -i '/^viper-kde-theme/d' "$PACKAGES_FILE"
	fi

	# If building PLASMA, comment out Xfce4-specific packages
	if [[ "$desktop" == "plasma" ]]; then
		echo "################################################################## "
		tput setaf 3
		echo "Commenting out Xfce4 packages for Plasma build"
		tput sgr0
		echo "################################################################## "

		# Comment out specific packages xray-xfce-settings
		sed -i '/^xfce4/d' "$PACKAGES_FILE"
		sed -i '/^xfce4-goodies/d' "$PACKAGES_FILE"
		sed -i '/^xray-xfce-settings/d' "$PACKAGES_FILE"
		sed -i '/^gvfs/d' "$PACKAGES_FILE"
		sed -i '/^gvfs-afc/d' "$PACKAGES_FILE"
		sed -i '/^gvfs-gphoto2/d' "$PACKAGES_FILE"
		sed -i '/^gvfs-mtp/d' "$PACKAGES_FILE"
		sed -i '/^gvfs-nfs/d' "$PACKAGES_FILE"
		sed -i '/^gvfs-smb/d' "$PACKAGES_FILE"
		sed -i '/^gvfs-dnssd/d' "$PACKAGES_FILE"
		sed -i '/^flameshot/d' "$PACKAGES_FILE"
		sed -i '/^archlinux-tweak-tool-git/d' "$PACKAGES_FILE"
		sed -i '/^variety/d' "$PACKAGES_FILE"
		sed -i '/^vlc/d' "$PACKAGES_FILE"
		sed -i '/^xcape/d' "$PACKAGES_FILE"
		sed -i '/^arandr/d' "$PACKAGES_FILE"
		sed -i '/^catfish/d' "$PACKAGES_FILE"
		sed -i '/^evince/d' "$PACKAGES_FILE"
		sed -i '/^file-roller/d' "$PACKAGES_FILE"
		sed -i '/^gnome-disk-utility/d' "$PACKAGES_FILE"
		sed -i '/^gnome-keyring/d' "$PACKAGES_FILE"
		sed -i '/^gnome-screenshot/d' "$PACKAGES_FILE"
		sed -i '/^nomacs/d' "$PACKAGES_FILE"
		sed -i '/^playerctl/d' "$PACKAGES_FILE"
		sed -i '/^polkit-gnome/d' "$PACKAGES_FILE"
		sed -i '/^qt5ct/d' "$PACKAGES_FILE"
		sed -i '/^gittyup/d' "$PACKAGES_FILE"
		sed -i '/^hardcode-fixer-git/d' "$PACKAGES_FILE"
		sed -i '/^mugshot/d' "$PACKAGES_FILE"
		sed -i '/^autorandr/d' "$PACKAGES_FILE"
		sed -i '/^volumeicon/d' "$PACKAGES_FILE"
		sed -i '/^surfn-icons-git/d' "$PACKAGES_FILE"
		sed -i '/^numix-icon-theme-git/d' "$PACKAGES_FILE"
		sed -i '/^numix-circle-icon-theme-git/d' "$PACKAGES_FILE"
		sed -i '/^sardi-icons/d' "$PACKAGES_FILE"
	fi

	# If xlibre is enabled, modify the package list
	if [[ "$xlibre" == "true" ]]; then
		echo "################################################################## "
		tput setaf 3
		echo "Modifying package list to replace xorg with xlibre if enabled"
		tput sgr0
		echo "################################################################## "

		# Remove xorg server
		sed -i '/^xorg-server/d' "$PACKAGES_FILE"

		# Convert xf86-input-* to xlibre-input-*
		sed -i 's/^xf86-input-/xlibre-input-/g' "$PACKAGES_FILE"

		# Convert xf86-video-* to xlibre-video-*
		sed -i 's/^xf86-video-/xlibre-video-/g' "$PACKAGES_FILE"

		# Uncomment xlibre-specific packages
		sed -i 's/^#xlibre-/xlibre-/g' "$PACKAGES_FILE"

		echo "xf86 packages converted to xlibre equivalents"
		echo "xlibre-specific packages enabled"

		# Ensure xlibre-xserver-common is in the list (if not already added by uncommenting)
		grep -q '^xlibre-xserver-common$' "$PACKAGES_FILE" || echo "xlibre-xserver-common" >> "$PACKAGES_FILE"

		echo "xf86 packages converted to xlibre equivalents"
		echo "xlibre-specific packages enabled"
	fi

echo
echo "################################################################## "
tput setaf 2
echo "Phase 6 : "
echo "- Adding time to /etc/dev-rel"
echo "- Clean cache"
tput sgr0
echo "################################################################## "
echo

	echo "Adding time to /etc/dev-rel"
	date_build=$(date -d now)
	echo "Iso build on : "$date_build
	sudo sed -i "s/\(^ISO_BUILD=\).*/\1$date_build/" $buildFolder/archiso/airootfs/etc/dev-rel

	# cleaning cache yes or no
	echo
	clean_cache no

echo
echo "################################################################## "
tput setaf 2
echo "Phase 7 :"
echo "- Building the iso - this can take a while - be patient"
tput sgr0
echo "################################################################## "
echo

	[ -d $outFolder ] || mkdir $outFolder
	cd $buildFolder/archiso/
	sudo mkarchiso -v -w $buildFolder -o $outFolder $buildFolder/archiso/

echo
echo "###################################################################"
tput setaf 2
echo "Phase 8 :"
echo "- Creating checksums"
echo "- Copying pgklist"
tput sgr0
echo "###################################################################"
echo

	cd $outFolder

	echo "Creating checksums for : "$isoLabel
	echo "##################################################################"
	echo
	echo "Building sha1sum"
	echo "########################"
	sha1sum $isoLabel | tee $isoLabel.sha1
	echo "Building sha256sum"
	echo "########################"
	sha256sum $isoLabel | tee $isoLabel.sha256
	echo "Building md5sum"
	echo "########################"
	md5sum $isoLabel | tee $isoLabel.md5
	echo
	echo "Moving pkglist.x86_64.txt"
	echo "########################"
	cp $buildFolder/iso/arch/pkglist.x86_64.txt  $outFolder/$isoLabel".pkglist.txt"

echo
echo "##################################################################"
tput setaf 2
echo "Phase 9 :"
echo "- Removing the buildfolder or not"
tput sgr0
echo "################################################################## "
echo

	echo "Deleting the build folder if one exists - takes some time"
	remove_buildfolder no

if [ "$HAS_ACLS" = true ]; then
	echo
	echo "################################################################## "
	tput setaf 2
	echo "Phase 11 :"
	echo "- Restoring home directory ACLs"
	tput sgr0
	echo "################################################################## "
	echo

	restore_acls
fi

echo
echo "##################################################################"
tput setaf 2
echo "DONE"
echo "- Check your out folder :"$outFolder
tput sgr0
echo "################################################################## "
echo
