From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 02 Oct 2008 21:29:17 +0000
Subject: Re: make install :)
Message-Id: <20081002212916.GA23042@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20080610122333.GA12879@orion.carnet.hr>
In-Reply-To: <20080610122333.GA12879@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jun 10, 2008 at 06:23:10PM +0200, Sam Ravnborg wrote:
> On Tue, Jun 10, 2008 at 02:23:33PM +0200, Josip Rodin wrote:
> > I know I've said this a few months ago already, but can the install target
> > be added eventually? :)
> > 
> > gzip -c vmlinux > vmlinuz && installkernel 2.6.25.5 vmlinuz System.map
> 
> Could you try to cook up a patch then I can take a look.
> I do not have time to do it myself atm.

Sorry it took me so long to respond to this - I'm forwarding what
Martin Habets had sent me below.

(I'm not sure if you want the install: install_modules bit, other
architectures don't do that, and it's probably excessive)

Date: Sun, 1 Apr 2007 22:25:29 +0100
From: Martin Habets <errandir_news@mph.eclipse.co.uk>
To: Josip Rodin <joy@entuzijast.net>
Cc: debian-sparc@lists.debian.org
Message-ID: <20070401212529.GB28439@palantir8>
References: <20070401104643.GA20270@keid.carnet.hr>

Hi Josip,

Wrote it long ago, and have used ever since without a problem.
Sadly it was not accepted upstream, I forgot why.
Patch attached.

Martin

On Sun, Apr 01, 2007 at 12:46:43PM +0200, Josip Rodin wrote:
> Hi,
> 
> Is it just me or is it a bit strange that the vanilla kernel makefiles don't
> include an 'install' target for sparc?
> 
> Just now I did the following, and all went well:
> 
> % gzip -c vmlinux > vmlinuz; sudo installkernel 2.6.20.4 vmlinuz System.map 
> In order to use the new kernel image you have just installed, you
> will need to reboot the machine.  First, however, you will need to
> either make a bootable floppy diskette, re-run LILO, or have GRUB
> installed.
> 
> Checking for ELILO...No
> 
> Checking for LILO...No
> 
> Checking for SILO...Yes
> 
> SILO is installed. To automatically switch to new kernels, point your
> default entry in silo.conf to /boot/vmlinuz-2.6.20.4
> % 
> 
> Sounds like the arch/sparc/boot/Makefile should be patched to call
> a arch/sparc/boot/install.sh, which would be trivial to write?
> 
> -- 
>      2. That which causes joy or happiness.
> 
> 
> -- 
> To UNSUBSCRIBE, email to debian-sparc-REQUEST@lists.debian.org
> with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org
> 

Index: 2.6.13/arch/sparc/boot/Makefile
=================================--- 2.6.13.orig/arch/sparc/boot/Makefile	2005-01-17 12:34:21.000000000 +0000
+++ 2.6.13/arch/sparc/boot/Makefile	2005-09-07 19:15:31.834415464 +0100
@@ -56,3 +56,6 @@
 
 $(obj)/btfix.S: $(obj)/btfixupprep vmlinux FORCE
 	$(call if_changed,btfix)
+
+$(obj)/install: $(obj)/image
+	sh $(srctree)/$(src)/install.sh $(KERNELRELEASE) $< System.map "$(INSTALL_PATH)"
Index: 2.6.13/arch/sparc/Makefile
=================================--- 2.6.13.orig/arch/sparc/Makefile	2005-01-17 12:34:21.000000000 +0000
+++ 2.6.13/arch/sparc/Makefile	2005-09-07 19:15:31.851410694 +0100
@@ -53,9 +53,14 @@
 
 boot := arch/sparc/boot
 
-image tftpboot.img: vmlinux
+image tftpboot.img install: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
+# This makes install trigger the modules as well.
+ifdef CONFIG_MODULES
+install: modules_install
+endif
+
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
@@ -75,4 +80,8 @@
 define archhelp
   echo  '* image        - kernel image ($(boot)/image)'
   echo  '  tftpboot.img - image prepared for tftp'
+  echo  '  install      - Install kernel using'
+  echo  '                 (your) ~/bin/installkernel or'
+  echo  '                 (distribution) /sbin/installkernel or'
+  echo  '                 install to $$(INSTALL_PATH)'
 endef
Index: 2.6.13/arch/sparc/boot/install.sh
=================================--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ 2.6.13/arch/sparc/boot/install.sh	2005-09-07 19:15:31.854409852 +0100
@@ -0,0 +1,45 @@
+#!/bin/sh
+#
+# arch/sparc/boot/install.sh
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 1995 by Linus Torvalds
+#
+# Blatantly stolen from in arch/i386/boot/install.sh by Martin Habets
+#
+# "make install" script for sparc architecture
+#
+# Arguments:
+#   $1 - kernel version
+#   $2 - kernel image file
+#   $3 - kernel map file
+#   $4 - default install path (blank if root directory)
+#
+
+# User may have a custom install script
+
+if [ -x ~/bin/installkernel ]; then exec ~/bin/installkernel "$@"; fi
+if [ -x /sbin/installkernel ]; then exec /sbin/installkernel "$@"; fi
+
+# Default install
+
+# Figure out if this is a compressed image or not.
+target=vmlinux
+if [ -n "`file $2 | grep -i compressed`" ];
+then
+	target=vmlinuz;
+fi
+
+if [ -f $4/$target ]; then
+	mv $4/$target $4/$target.old
+fi
+
+if [ -f $4/System.map ]; then
+	mv $4/System.map $4/System.old
+fi
+
+cat $2 > $4/$target
+cp $3 $4/System.map

-- 
     2. That which causes joy or happiness.
