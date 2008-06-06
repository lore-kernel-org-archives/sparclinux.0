From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 06 Jun 2008 21:00:25 +0000
Subject: [PATCH 13/21] sparc: copy asm-sparc64/fbio.h to asm-sparc
Message-Id: <1212786033-4227-13-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

There were only a few trivial changes and a few additions
in the sparc64 variant of this file.
This patch shows the differences before the merge.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 include/asm-sparc/fbio.h |   37 +++++++++++++++++++++++++++++++++++--
 1 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/asm-sparc/fbio.h b/include/asm-sparc/fbio.h
index c2b27e7..b9215a0 100644
--- a/include/asm-sparc/fbio.h
+++ b/include/asm-sparc/fbio.h
@@ -1,6 +1,9 @@
 #ifndef __LINUX_FBIO_H
 #define __LINUX_FBIO_H
 
+#include <linux/compiler.h>
+#include <linux/types.h>
+
 /* Constants used for fbio SunOS compatibility */
 /* (C) 1996 Miguel de Icaza */
 
@@ -38,6 +41,9 @@
 #define FBTYPE_PCI_IGA1682	23
 #define FBTYPE_P9100COLOR	24
 
+#define FBTYPE_PCI_GENERIC	1000
+#define FBTYPE_PCI_MACH64	1001
+
 /* fbio ioctls */
 /* Returned by FBIOGTYPE */
 struct  fbtype {
@@ -97,8 +103,8 @@ struct fbcursor {
         struct fbcurpos hot;    /* cursor hot spot */
         struct fbcmap cmap;     /* color map info */
         struct fbcurpos size;   /* cursor bit map size */
-        char *image;            /* cursor image bits */
-        char *mask;             /* cursor mask bits */
+        char __user *image;     /* cursor image bits */
+        char __user *mask;      /* cursor mask bits */
 };
 
 /* set/get cursor attributes/shape */
@@ -294,4 +300,31 @@ struct fb_clut32 {
 #define LEO_LD_GBL_MAP         0x01009000
 #define LEO_UNK2_MAP           0x0100a000
 
+#ifdef __KERNEL__
+struct  fbcmap32 {
+	int             index;          /* first element (0 origin) */
+	int             count;
+	u32		red;
+	u32		green;
+	u32		blue;
+};
+
+#define FBIOPUTCMAP32	_IOW('F', 3, struct fbcmap32)
+#define FBIOGETCMAP32	_IOW('F', 4, struct fbcmap32)
+
+struct fbcursor32 {
+	short set;		/* what to set, choose from the list above */
+	short enable;		/* cursor on/off */
+	struct fbcurpos pos;	/* cursor position */
+	struct fbcurpos hot;	/* cursor hot spot */
+	struct fbcmap32 cmap;	/* color map info */
+	struct fbcurpos size;	/* cursor bit map size */
+	u32	image;		/* cursor image bits */
+	u32	mask;		/* cursor mask bits */
+};
+
+#define FBIOSCURSOR32	_IOW('F', 24, struct fbcursor32)
+#define FBIOGCURSOR32	_IOW('F', 25, struct fbcursor32)
+#endif
+
 #endif /* __LINUX_FBIO_H */
-- 
1.5.4.1.143.ge7e51

