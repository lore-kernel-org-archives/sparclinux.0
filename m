From: Jurij Smakov <jurij@wooyd.org>
Date: Mon, 01 Feb 2010 21:30:40 +0000
Subject: SILO problems
Message-Id: <20100201213040.GA3361@droopy.oc.cox.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
List-Id: <sparclinux.vger.kernel.org>
References: <498D413B.2060009@neb.rr.com>
In-Reply-To: <498D413B.2060009@neb.rr.com>
To: sparclinux@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

While preparing an update for Debian's SILO package, I ran into a 
problem: the version built from the current git tree [0] fails to boot 
on my SunBlade 1000 box with the following messages:

SUNW,Sun-Blade-1000 (2 X UltraSPARC-III) , No Keyboard
Copyright 1998-2004 Sun Microsystems, Inc.  All rights reserved.
OpenBoot 4.16.4, 2048 MB memory installed, Serial #51831895.
Ethernet address 0:3:ba:16:e4:57, Host ID: 8316e457.



Rebooting with command: boot                                          
Boot device: disk  File and args: 
SILO Version 1.4.14
boot: 
Allocated 64 Megs of memory at 0x40000000 for kernel
Uncompressing image...
     ERROR: Last Trap: Fast Data Access MMU Miss

Error -256 
{0} ok 

I have confirmed that the "silo: move second to make room for larger 
kernel" commit [1] is causing the breakage, excluding this commit 
makes the system boot normally:

Rebooting with command: boot                                          
Boot device: disk  File and args: 
SILO Version 1.4.14
boot: 
Allocated 64 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 2.6.32
Loading initial ramdisk (7746912 bytes at 0x7F000000 phys, 0x40C00000 virt)...
\
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.16.4 2004/12/18 05:18'
[...]

For now I just plan to exclude this patch from Debian package.

On a related note, I had to apply the attached patch (Signed-off-by: 
Jurij Smakov <jurij@debian.org>) to make SILO build with 2.6.32 kernel 
headers (which, apparently, are defining _LINUX_TYPES_H again).

[0] http://git.kernel.org/?p=linux/kernel/git/davem/silo.git;a=summary
[1] http://git.kernel.org/?p=linux/kernel/git/davem/silo.git;a=commit;h=71816c5699b32bab03e57be6768a562d9568e33b

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC

--82I3+IH0IqGh5yIs
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="silo-linux-types.patch"

diff -aur a/include/ext2fs/ext2fs.h b/include/ext2fs/ext2fs.h
--- a/include/ext2fs/ext2fs.h	2010-01-30 13:40:56.000000000 +0000
+++ b/include/ext2fs/ext2fs.h	2010-01-30 13:47:54.000000000 +0000
@@ -39,7 +39,7 @@
  */
 #define EXT2_LIB_CURRENT_REV	0
 
-#if defined(HAVE_SYS_TYPES_H) && !defined(_LINUX_TYPES_H)
+#if defined(HAVE_SYS_TYPES_H)
 #include <sys/types.h>
 #endif
 
diff -aur a/include/stringops.h b/include/stringops.h
--- a/include/stringops.h	2010-01-30 13:40:56.000000000 +0000
+++ b/include/stringops.h	2010-01-30 13:47:25.000000000 +0000
@@ -7,9 +7,7 @@
 #ifndef __SIZE_TYPE__
 #define __SIZE_TYPE__ long unsigned int
 #endif
-#ifndef _LINUX_TYPES_H
 typedef __SIZE_TYPE__ size_t;
-#endif
 
 /* stringops1.c */
 char *strcpy(char *, const char *);

--82I3+IH0IqGh5yIs--
