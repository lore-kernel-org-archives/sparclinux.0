From: Matthew Wilcox <willy@debian.org>
Date: Sat, 03 Jan 2004 21:23:08 +0000
Subject: [PATCH] [SPARC] Use drivers/block/Kconfig
Message-Id: <20040103212307.GL6982@parcelfarce.linux.theplanet.co.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Sparc32 is currently missing a way to select CRYPTOLOOP due to not using
drivers/blok/Kconfig.  Since there doesn't seem to be any reason not to,
this patch switches sparc to use the generic Kconfig file.

Index: arch/sparc/Kconfig
=================================RCS file: /var/cvs/linux-2.6/arch/sparc/Kconfig,v
retrieving revision 1.4
diff -u -p -r1.4 Kconfig
--- arch/sparc/Kconfig	28 Sep 2003 04:05:05 -0000	1.4
+++ arch/sparc/Kconfig	3 Jan 2004 21:18:53 -0000
@@ -300,138 +300,7 @@ if !SUN4
 source "drivers/sbus/char/Kconfig"
 endif
 
-
-menu "Block devices"
-
-config BLK_DEV_FD
-	bool "Normal floppy disk support"
-	---help---
-	  If you want to use the floppy disk drive(s) of your PC under Linux,
-	  say Y. Information about this driver, especially important for IBM
-	  Thinkpad users, is contained in <file:Documentation/floppy.txt>.
-	  That file also contains the location of the Floppy driver FAQ as
-	  well as location of the fdutils package used to configure additional
-	  parameters of the driver at run time.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called floppy.
-
-config BLK_DEV_LOOP
-	tristate "Loopback device support"
-	---help---
-	  Saying Y here will allow you to use a regular file as a block
-	  device; you can then create a file system on that block device and
-	  mount it just as you would mount other block devices such as hard
-	  drive partitions, CD-ROM drives or floppy drives. The loop devices
-	  are block special device files with major number 7 and typically
-	  called /dev/loop0, /dev/loop1 etc.
-
-	  This is useful if you want to check an ISO 9660 file system before
-	  burning the CD, or if you want to use floppy images without first
-	  writing them to floppy. Furthermore, some Linux distributions avoid
-	  the need for a dedicated Linux partition by keeping their complete
-	  root file system inside a DOS FAT file using this loop device
-	  driver.
-
-	  The loop device driver can also be used to "hide" a file system in a
-	  disk partition, floppy, or regular file, either using encryption
-	  (scrambling the data) or steganography (hiding the data in the low
-	  bits of, say, a sound file). This is also safe if the file resides
-	  on a remote file server. If you want to do this, you will first have
-	  to acquire and install a kernel patch from
-	  <ftp://ftp.kerneli.org/pub/kerneli/>, and then you need to
-	  say Y to this option.
-
-	  Note that alternative ways to use encrypted file systems are
-	  provided by the cfs package, which can be gotten from
-	  <ftp://ftp.kerneli.org/pub/kerneli/net-source/>, and the newer tcfs
-	  package, available at <http://tcfs.dia.unisa.it/>. You do not need
-	  to say Y here if you want to use one of these. However, using cfs
-	  requires saying Y to "NFS file system support" below while using
-	  tcfs requires applying a kernel patch. An alternative steganography
-	  solution is provided by StegFS, also available from
-	  <ftp://ftp.kerneli.org/pub/kerneli/net-source/>.
-
-	  To use the loop device, you need the losetup utility and a recent
-	  version of the mount program, both contained in the util-linux
-	  package. The location and current version number of util-linux is
-	  contained in the file <file:Documentation/Changes>.
-
-	  Note that this loop device has nothing to do with the loopback
-	  device used for network connections from the machine to itself.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called loop.
-
-	  Most users will answer N here.
-
-config BLK_DEV_NBD
-	tristate "Network block device support"
-	depends on NET
-	---help---
-	  Saying Y here will allow your computer to be a client for network
-	  block devices, i.e. it will be able to use block devices exported by
-	  servers (mount file systems on them etc.). Communication between
-	  client and server works over TCP/IP networking, but to the client
-	  program this is hidden: it looks like a regular local file access to
-	  a block device special file such as /dev/nd0.
-
-	  Network block devices also allows you to run a block-device in
-	  userland (making server and client physically the same computer,
-	  communicating using the loopback network device).
-
-	  Read <file:Documentation/nbd.txt> for more information, especially
-	  about where to find the server code, which runs in user space and
-	  does not need special kernel support.
-
-	  Note that this has nothing to do with the network file systems NFS
-	  or Coda; you can say N here even if you intend to use NFS or Coda.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called nbd.
-
-	  If unsure, say N.
-
-source "drivers/md/Kconfig"
-
-config BLK_DEV_RAM
-	tristate "RAM disk support"
-	---help---
-	  Saying Y here will allow you to use a portion of your RAM memory as
-	  a block device, so that you can make file systems on it, read and
-	  write to it and do all the other things that you can do with normal
-	  block devices (such as hard drives). It is usually used to load and
-	  store a copy of a minimal root file system off of a floppy into RAM
-	  during the initial install of Linux.
-
-	  Note that the kernel command line option "ramdisk=XX" is now
-	  obsolete. For details, read <file:Documentation/ramdisk.txt>.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called rd.
-
-	  Most normal users won't need the RAM disk functionality, and can
-	  thus say N here.
-
-config BLK_DEV_RAM_SIZE
-	int "Default RAM disk size"
-	depends on BLK_DEV_RAM
-	default "4096"
-	help
-	  The default value is 4096. Only change this if you know what are
-	  you doing. If you are using IBM S/390, then set this to 8192.
-
-config BLK_DEV_INITRD
-	bool "Initial RAM disk (initrd) support"
-	depends on BLK_DEV_RAM=y
-	help
-	  The initial RAM disk is a RAM disk that is loaded by the boot loader
-	  (loadlin or lilo) and that is mounted as root before the normal boot
-	  procedure. It is typically used to load modules needed to mount the
-	  "real" root file system, etc. See <file:Documentation/initrd.txt>
-	  for details.
-
-endmenu
+source "drivers/block/Kconfig"
 
 # Don't frighten a common SBus user
 if PCI
@@ -445,6 +314,8 @@ source "drivers/isdn/Kconfig"
 source "drivers/scsi/Kconfig"
 
 source "drivers/fc4/Kconfig"
+
+source "drivers/md/Kconfig"
 
 source "net/Kconfig"
 

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
