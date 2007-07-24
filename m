From: Gustavo Zacarias <gustavoz@gentoo.org>
Date: Tue, 24 Jul 2007 17:24:25 +0000
Subject: [PATCH] Make silo use glibc elf.h instead of kernel headers
Message-Id: <46A635C9.1030303@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050706010104050609060801"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------050706010104050609060801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


This patch builds silo against glibc elf.h since linux/elf.h is gone in 
newer headers. Also removes the asm/page.h include which is also gone.

-- 
Gustavo Zacarias
Gentoo/SPARC monkey

--------------050706010104050609060801
Content-Type: text/plain;
 name="silo-elf.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="silo-elf.patch"

diff -Nura silo/second/main.c silo-1.4.13/second/main.c
--- silo/second/main.c	2007-07-24 11:04:12.000000000 -0300
+++ silo-1.4.13/second/main.c	2007-07-24 11:09:04.000000000 -0300
@@ -25,8 +25,7 @@
 /* TODO: This file is a good candidate for rewrite from scratch.  */
 
 #include <silo.h>
-#include <asm/page.h>
-#include <linux/elf.h>
+#include <elf.h>
 #include <stringops.h>
 
 #ifndef NULL

--------------050706010104050609060801--
