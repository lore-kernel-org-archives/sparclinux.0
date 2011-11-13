From: Rob Landley <rob@landley.net>
Date: Sun, 13 Nov 2011 00:07:01 +0000
Subject: Re: Sparc-32 doesn't work in 3.1.
Message-Id: <4EBF0A25.20604@landley.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040505030708030203030108"
List-Id: <sparclinux.vger.kernel.org>
References: <4EBEAB5A.5020809@landley.net>
In-Reply-To: <4EBEAB5A.5020809@landley.net>
To: Aboriginal Linux <aboriginal@lists.landley.net>, linux-kernel@vger.kernel.org, davem@davemloft.net, tytso@mit.edu, sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------040505030708030203030108
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 11/12/2011 11:22 AM, Rob Landley wrote:
> Still trying to ship an Aboriginal Linux release with the 3.1 kernel,
> but the sparc target broke, as in QEMU's OpenBios goes:
> 
>   Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz).
>   Patching kernel for srmmu[Fujitsu TurboSparc]/iommu
>   Fixup i f029ddfc doesn't refer to a valid instruction at
>   f00de648[95eea000]
>   halt, power off

If anyone would like a reproduction sequence for this, the toolchain I use
(which compiles commit 9933fc0ac1ac14b^1 just fine) is at:

  http://landley.net/aboriginal/downloads/binaries/cross-compiler-sparc.tar.bz2

I configure using the attached miniconfig, ala:

  make allnoconfig KCONFIG_ALLCONFIG=miniconfig.sparc ARCH=sparc

And then:

  PATH=/path/to/cross-compiler-sparc/bin:$PATH make ARCH=sparc \
    CROSS_COMPILE=sparc- -j 3

I then grab the file arch/sparc/boot/image out of the build and run:

  qemu-system-sparc -nographic -no-reboot -kernel image -hda /dev/null -m 256 \
    -append "root=/dev/sda rw init=/sbin/init.sh panic=1 PATH=/bin:/sbin console=ttyS0 HOST=sparc"

If you'd like a working system for comparison (built with the same
toolchain), download:

  http://landley.net/aboriginal/downloads/binaries/system-image-sparc.tar.bz2

And run-emulator.sh out of that.

Rob

--------------040505030708030203030108
Content-Type: text/plain;
 name="miniconfig.sparc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="miniconfig.sparc"

CONFIG_EXPERIMENTAL=y
CONFIG_NO_HZ=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_PCI=y
CONFIG_BINFMT_ELF=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_IDE=y
CONFIG_IDE_GD=y
CONFIG_IDE_GD_ATA=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
CONFIG_SCSI_LOWLEVEL=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_8139CP=y
CONFIG_HW_RANDOM=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_DEV=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT23=y
CONFIG_TMPFS=y
CONFIG_MISC_FILESYSTEMS=y
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_ZLIB=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEVTMPFS=y

CONFIG_VIRTUALIZATION=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_NET=y
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y

CONFIG_SCSI_SUNESP=y
CONFIG_SUNLANCE=y
CONFIG_SERIAL_SUNZILOG=y
CONFIG_SERIAL_SUNZILOG_CONSOLE=y
CONFIG_SUN_MOSTEK_RTC=y


--------------040505030708030203030108--
