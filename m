From: Christoph Hellwig <hch@lst.de>
Date: Mon, 07 Nov 2005 04:06:57 +0000
Subject: [PATCH] remove kbio.h
Message-Id: <20051107040657.GC16485@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The old keyboard driver is gone in 2.6, so the only user left are the
compat ioctls.


Index: linux-2.6/arch/sparc64/kernel/ioctl32.c
=================================--- linux-2.6.orig/arch/sparc64/kernel/ioctl32.c	2005-11-06 20:22:05.000000000 +0100
+++ linux-2.6/arch/sparc64/kernel/ioctl32.c	2005-11-06 20:22:09.000000000 +0100
@@ -14,7 +14,6 @@
 #include <linux/ncp_fs.h>
 #include <linux/syscalls.h>
 #include <asm/fbio.h>
-#include <asm/kbio.h>
 #include <asm/vuid_event.h>
 #include <asm/envctrl.h>
 #include <asm/display7seg.h>
@@ -471,16 +470,6 @@
 COMPATIBLE_IOCTL(FBIOGCURPOS)
 COMPATIBLE_IOCTL(FBIOGCURMAX)
 /* Little k */
-COMPATIBLE_IOCTL(KIOCTYPE)
-COMPATIBLE_IOCTL(KIOCLAYOUT)
-COMPATIBLE_IOCTL(KIOCGTRANS)
-COMPATIBLE_IOCTL(KIOCTRANS)
-COMPATIBLE_IOCTL(KIOCCMD)
-COMPATIBLE_IOCTL(KIOCSDIRECT)
-COMPATIBLE_IOCTL(KIOCSLED)
-COMPATIBLE_IOCTL(KIOCGLED)
-COMPATIBLE_IOCTL(KIOCSRATE)
-COMPATIBLE_IOCTL(KIOCGRATE)
 COMPATIBLE_IOCTL(VUIDSFORMAT)
 COMPATIBLE_IOCTL(VUIDGFORMAT)
 /* Little v, the video4linux ioctls */
Index: linux-2.6/include/asm-sparc/kbio.h
=================================--- linux-2.6.orig/include/asm-sparc/kbio.h	2005-11-06 20:21:53.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,56 +0,0 @@
-#ifndef __LINUX_KBIO_H
-#define __LINUX_KBIO_H
-
-/* Return keyboard type */
-#define KIOCTYPE    _IOR('k', 9, int)
-/* Return Keyboard layout */
-#define KIOCLAYOUT  _IOR('k', 20, int)
-
-enum {
-    TR_NONE,
-    TR_ASCII,			/* keyboard is in regular state */
-    TR_EVENT,			/* keystrokes sent as firm events */
-    TR_UNTRANS_EVENT		/* EVENT+up and down+no translation */
-};
-
-/* Return the current keyboard translation */
-#define KIOCGTRANS  _IOR('k', 5, int)
-/* Set the keyboard translation */
-#define KIOCTRANS   _IOW('k', 0, int)
-
-/* Send a keyboard command */
-#define KIOCCMD     _IOW('k', 8, int)
-
-/* Return if keystrokes are being sent to /dev/kbd */
-
-/* Set routing of keystrokes to /dev/kbd */
-#define KIOCSDIRECT _IOW('k', 10, int)
-
-/* Set keyboard leds */
-#define KIOCSLED    _IOW('k', 14, unsigned char)
-
-/* Get keyboard leds */
-#define KIOCGLED    _IOR('k', 15, unsigned char)
-
-/* Used by KIOC[GS]RATE */
-struct kbd_rate {
-	unsigned char delay;	/* Delay in Hz before first repeat.	*/
-	unsigned char rate;	/* In characters per second (0..50).	*/
-};
-
-/* Set keyboard rate */
-#define KIOCSRATE   _IOW('k', 40, struct kbd_rate)
-
-/* Get keyboard rate */
-#define KIOCGRATE   _IOW('k', 41, struct kbd_rate)
-
-/* Top bit records if the key is up or down */
-#define KBD_UP      0x80
-
-/* Usable information */
-#define KBD_KEYMASK 0x7f
-
-/* All keys up */
-#define KBD_IDLE    0x75
-
-#endif /* __LINUX_KBIO_H */
Index: linux-2.6/include/asm-sparc64/kbio.h
=================================--- linux-2.6.orig/include/asm-sparc64/kbio.h	2005-11-06 20:21:53.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,56 +0,0 @@
-#ifndef __LINUX_KBIO_H
-#define __LINUX_KBIO_H
-
-/* Return keyboard type */
-#define KIOCTYPE    _IOR('k', 9, int)
-/* Return Keyboard layout */
-#define KIOCLAYOUT  _IOR('k', 20, int)
-
-enum {
-    TR_NONE,
-    TR_ASCII,			/* keyboard is in regular state */
-    TR_EVENT,			/* keystrokes sent as firm events */
-    TR_UNTRANS_EVENT		/* EVENT+up and down+no translation */
-};
-
-/* Return the current keyboard translation */
-#define KIOCGTRANS  _IOR('k', 5, int)
-/* Set the keyboard translation */
-#define KIOCTRANS   _IOW('k', 0, int)
-
-/* Send a keyboard command */
-#define KIOCCMD     _IOW('k', 8, int)
-
-/* Return if keystrokes are being sent to /dev/kbd */
-
-/* Set routing of keystrokes to /dev/kbd */
-#define KIOCSDIRECT _IOW('k', 10, int)
-
-/* Set keyboard leds */
-#define KIOCSLED    _IOW('k', 14, unsigned char)
-
-/* Get keyboard leds */
-#define KIOCGLED    _IOR('k', 15, unsigned char)
-
-/* Used by KIOC[GS]RATE */
-struct kbd_rate {
-	unsigned char delay;	/* Delay in Hz before first repeat.	*/
-	unsigned char rate;	/* In characters per second (0..50).	*/
-};
-
-/* Set keyboard rate */
-#define KIOCSRATE   _IOW('k', 40, struct kbd_rate)
-
-/* Get keyboard rate */
-#define KIOCGRATE   _IOW('k', 41, struct kbd_rate)
-
-/* Top bit records if the key is up or down */
-#define KBD_UP      0x80
-
-/* Usable information */
-#define KBD_KEYMASK 0x7f
-
-/* All keys up */
-#define KBD_IDLE    0x75
-
-#endif /* __LINUX_KBIO_H */
