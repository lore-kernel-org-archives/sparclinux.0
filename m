From: Chris Newport <crn@netunix.com>
Date: Tue, 22 Feb 2005 16:55:10 +0000
Subject: Patch: SILO/first-isofs/isofs.c (Fix Sun4c)
Message-Id: <421B63EE.4040405@netunix.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040509050709090602060905"
List-Id: <sparclinux.vger.kernel.org>
References: <20050222162933.GA25092@internal>
In-Reply-To: <20050222162933.GA25092@internal>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------040509050709090602060905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


This small patch fixes silo-1.4.8/first-isofs/isofs.c
Copying an int into a string is not a good idea.

Sun4c now loads second.b and the kernel, but still
barfs loading the initrd.

boot:
Loaded kernel version 2.4.27
Loading initial ramdisk (905216 bytes at 0x0 phys, 0x300000 virt)...
Data Access ExceptionType b (boot), c(continue), or n (new command mode)
 >

Does anyone know what is wrong here ?


--------------040509050709090602060905
Content-Type: text/plain;
 name="isofs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isofs.patch"

--- silo-1.4.8/first-isofs/isofs.c.orig	2005-02-22 13:26:47.000000000 +0000
+++ silo-1.4.8/first-isofs/isofs.c	2005-02-22 16:31:01.000000000 +0000
@@ -68,7 +68,7 @@
 		*s++ = (ap->boot_dev_ctrl & 07) + '0';
 		*s++ = ',';
 		// Hopefully it's never > 10
-		*s++ = ap->boot_dev_unit;
+		*s++ = (ap->boot_dev_unit & 07) + '0';
 		*s++ = ','; 
 		*s++ = '0';
 		*s++ = ')';

--------------040509050709090602060905--
