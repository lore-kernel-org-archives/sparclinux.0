From: Christoph Hellwig <hch@lst.de>
Date: Mon, 07 Nov 2005 04:07:47 +0000
Subject: [PATCH] remove vuid_event.h
Message-Id: <20051107040747.GD16485@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I don't know if we ever implemented this, but the only user in any 2.6
tree are the compat ioctls.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/include/asm-m68k/vuid_event.h
=================================--- linux-2.6.orig/include/asm-m68k/vuid_event.h	2005-11-06 20:21:34.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,4 +0,0 @@
-#ifndef _M68K_VUID_EVENT_H
-#define _M68K_VUID_EVENT_H
-#include <asm-sparc/vuid_event.h>
-#endif
Index: linux-2.6/include/asm-sparc/vuid_event.h
=================================--- linux-2.6.orig/include/asm-sparc/vuid_event.h	2005-11-06 20:21:34.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,41 +0,0 @@
-/* SunOS Virtual User Input Device (VUID) compatibility */
-
-
-typedef struct firm_event {
-	unsigned short id;	  /* tag for this event */
-	unsigned char  pair_type; /* unused by X11 */
-        unsigned char  pair;	  /* unused by X11 */
-        int            value;	  /* VKEY_UP, VKEY_DOWN or delta */
-        struct timeval time;
-} Firm_event;
-
-enum {
-    FE_PAIR_NONE,
-    FE_PAIR_SET,
-    FE_PAIR_DELTA,
-    FE_PAIR_ABSOLUTE
-};
-
-/* VUID stream formats */
-#define VUID_NATIVE     0	/* Native byte stream format */
-#define VUID_FIRM_EVENT 1	/* send firm_event structures */
-
-/* ioctls */
-    /* Set input device byte stream format (any of VUID_{NATIVE,FIRM_EVENT}) */
-#define VUIDSFORMAT   _IOW('v', 1, int)
-    /* Retrieve input device byte stream format */
-#define VUIDGFORMAT   _IOR('v', 2, int)
-
-/* Possible tag values */
-/*    mouse buttons: */
-#define MS_LEFT         0x7f20
-#define MS_MIDDLE       0x7f21
-#define MS_RIGHT        0x7f22
-/*    motion: */
-#define LOC_X_DELTA     0x7f80
-#define LOC_Y_DELTA     0x7f81
-#define LOC_X_ABSOLUTE  0x7f82  /* X compat, unsupported */
-#define LOC_Y_ABSOLUTE  0x7f83  /* X compat, unsupported */
-
-#define VKEY_UP   0
-#define VKEY_DOWN 1
Index: linux-2.6/include/asm-sparc64/vuid_event.h
=================================--- linux-2.6.orig/include/asm-sparc64/vuid_event.h	2005-11-06 20:21:34.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,40 +0,0 @@
-/* SunOS Virtual User Input Device (VUID) compatibility */
-
-typedef struct firm_event {
-	unsigned short id;	  /* tag for this event */
-	unsigned char  pair_type; /* unused by X11 */
-        unsigned char  pair;	  /* unused by X11 */
-        int            value;	  /* VKEY_UP, VKEY_DOWN or delta */
-        struct timeval time;
-} Firm_event;
-
-enum {
-    FE_PAIR_NONE,
-    FE_PAIR_SET,
-    FE_PAIR_DELTA,
-    FE_PAIR_ABSOLUTE
-};
-
-/* VUID stream formats */
-#define VUID_NATIVE     0	/* Native byte stream format */
-#define VUID_FIRM_EVENT 1	/* send firm_event structures */
-
-/* ioctls */
-    /* Set input device byte stream format (any of VUID_{NATIVE,FIRM_EVENT}) */
-#define VUIDSFORMAT   _IOW('v', 1, int)
-    /* Retrieve input device byte stream format */
-#define VUIDGFORMAT   _IOR('v', 2, int)
-
-/* Possible tag values */
-/*    mouse buttons: */
-#define MS_LEFT         0x7f20
-#define MS_MIDDLE       0x7f21
-#define MS_RIGHT        0x7f22
-/*    motion: */
-#define LOC_X_DELTA     0x7f80
-#define LOC_Y_DELTA     0x7f81
-#define LOC_X_ABSOLUTE  0x7f82  /* X compat, unsupported */
-#define LOC_Y_ABSOLUTE  0x7f83  /* X compat, unsupported */
-
-#define VKEY_UP   0
-#define VKEY_DOWN 1
Index: linux-2.6/arch/sparc64/kernel/ioctl32.c
=================================--- linux-2.6.orig/arch/sparc64/kernel/ioctl32.c	2005-11-06 20:22:09.000000000 +0100
+++ linux-2.6/arch/sparc64/kernel/ioctl32.c	2005-11-06 20:22:14.000000000 +0100
@@ -14,7 +14,6 @@
 #include <linux/ncp_fs.h>
 #include <linux/syscalls.h>
 #include <asm/fbio.h>
-#include <asm/vuid_event.h>
 #include <asm/envctrl.h>
 #include <asm/display7seg.h>
 #include <asm/openpromio.h>
@@ -470,8 +469,6 @@
 COMPATIBLE_IOCTL(FBIOGCURPOS)
 COMPATIBLE_IOCTL(FBIOGCURMAX)
 /* Little k */
-COMPATIBLE_IOCTL(VUIDSFORMAT)
-COMPATIBLE_IOCTL(VUIDGFORMAT)
 /* Little v, the video4linux ioctls */
 COMPATIBLE_IOCTL(_IOR('p', 20, int[7])) /* RTCGET */
 COMPATIBLE_IOCTL(_IOW('p', 21, int[7])) /* RTCSET */
