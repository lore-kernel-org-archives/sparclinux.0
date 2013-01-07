From: Jan Engelhardt <jengelh@inai.de>
Date: Mon, 07 Jan 2013 16:18:03 +0000
Subject: Built-in initramfs not recognized
Message-Id: <alpine.LNX.2.01.1301071707210.23886@nerf07.vanv.qr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

I was trying to use CONFIG_INITRAMFS_SOURCE to specify the initramfs 
contents, but this seems to be ignored for sparc64 in the following way.

1. Use CONFIG_INITRAMFS_SOURCE. This causes generation of 
$(obj)/usr/initramfs_data.cpio.xz (I am using 
CONFIG_INITRAMFS_COMPRESSION_XZ=y as well), and 
$(obj)/usr/initramfs_data.o.

initramfs_data.o is placed into vmlinux - verified with looking 
for some bytes of initramfs_data.o in the hexdump of vmlinux.

2. Running elftoaout on vmlinux. The initramfs xz data seems retained, 
again by looking for it in a hexdump.

3. Executing the so-produced vmlinux.aout via the OBP TFTP mechanism 
does not print "Unpacking initramfs" anywhere, and does not execute 
/init either.


Using the piggyback tool by means of

1. not using CONFIG_INITRAMFS_SOURCE
2. make tftpboot.img ROOT_IMG=/mystuff.cpio.xz

does however make the kernel recognize the initramfs environment.
