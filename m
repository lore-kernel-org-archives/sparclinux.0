From: David Miller <davem@davemloft.net>
Date: Sun, 29 Jul 2007 07:39:40 +0000
Subject: Re: ioctl32 warning on framebuffer
Message-Id: <20070729.003940.21594458.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0707272220560.1678@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0707272220560.1678@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Fri, 27 Jul 2007 22:23:53 +0300 (EEST)

> ioctl32(Xorg:1892): Unknown cmd fd(6) cmd(40584606){t:'F';sz:88} arg(ffdabb4c) on /dev/fb0 
> ioctl32(Xorg:1892): Unknown cmd fd(6) cmd(40184600){t:'F';sz:24} arg(ffdabb54) on /dev/fb0

Please give this patch a try:

diff --git a/drivers/video/sbuslib.c b/drivers/video/sbuslib.c
index 34ef859..963a454 100644
--- a/drivers/video/sbuslib.c
+++ b/drivers/video/sbuslib.c
@@ -190,17 +190,6 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
 EXPORT_SYMBOL(sbusfb_ioctl_helper);
 
 #ifdef CONFIG_COMPAT
-struct  fbcmap32 {
-	int             index;          /* first element (0 origin) */
-	int             count;
-	u32		red;
-	u32		green;
-	u32		blue;
-};
-
-#define FBIOPUTCMAP32	_IOW('F', 3, struct fbcmap32)
-#define FBIOGETCMAP32	_IOW('F', 4, struct fbcmap32)
-
 static int fbiogetputcmap(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
 	struct fbcmap32 __user *argp = (void __user *)arg;
@@ -223,20 +212,6 @@ static int fbiogetputcmap(struct fb_info *info, unsigned int cmd, unsigned long
 			(unsigned long)p);
 }
 
-struct fbcursor32 {
-	short set;		/* what to set, choose from the list above */
-	short enable;		/* cursor on/off */
-	struct fbcurpos pos;	/* cursor position */
-	struct fbcurpos hot;	/* cursor hot spot */
-	struct fbcmap32 cmap;	/* color map info */
-	struct fbcurpos size;	/* cursor bit map size */
-	u32	image;		/* cursor image bits */
-	u32	mask;		/* cursor mask bits */
-};
-
-#define FBIOSCURSOR32	_IOW('F', 24, struct fbcursor32)
-#define FBIOGCURSOR32	_IOW('F', 25, struct fbcursor32)
-
 static int fbiogscursor(struct fb_info *info, unsigned long arg)
 {
 	struct fbcursor __user *p = compat_alloc_user_space(sizeof(*p));
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index e440a7b..2bc1428 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -115,6 +115,10 @@
 #include <linux/dvb/video.h>
 #include <linux/lp.h>
 
+#ifdef CONFIG_SPARC
+#include <asm/fbio.h>
+#endif
+
 static int do_ioctl32_pointer(unsigned int fd, unsigned int cmd,
 			      unsigned long arg, struct file *f)
 {
@@ -3493,6 +3497,22 @@ IGNORE_IOCTL(VFAT_IOCTL_READDIR_SHORT32)
 
 /* loop */
 IGNORE_IOCTL(LOOP_CLR_FD)
+
+#ifdef CONFIG_SPARC
+/* Sparc framebuffers, handled in sbusfb_compat_ioctl() */
+IGNORE_IOCTL(FBIOGTYPE)
+IGNORE_IOCTL(FBIOSATTR)
+IGNORE_IOCTL(FBIOGATTR)
+IGNORE_IOCTL(FBIOSVIDEO)
+IGNORE_IOCTL(FBIOGVIDEO)
+IGNORE_IOCTL(FBIOSCURPOS)
+IGNORE_IOCTL(FBIOGCURPOS)
+IGNORE_IOCTL(FBIOGCURMAX)
+IGNORE_IOCTL(FBIOPUTCMAP32)
+IGNORE_IOCTL(FBIOGETCMAP32)
+IGNORE_IOCTL(FBIOSCURSOR32)
+IGNORE_IOCTL(FBIOGCURSOR32)
+#endif
 };
 
 #define IOCTL_HASHSIZE 256
diff --git a/include/asm-sparc64/fbio.h b/include/asm-sparc64/fbio.h
index 500026d..b9215a0 100644
--- a/include/asm-sparc64/fbio.h
+++ b/include/asm-sparc64/fbio.h
@@ -2,6 +2,7 @@
 #define __LINUX_FBIO_H
 
 #include <linux/compiler.h>
+#include <linux/types.h>
 
 /* Constants used for fbio SunOS compatibility */
 /* (C) 1996 Miguel de Icaza */
@@ -299,4 +300,31 @@ struct fb_clut32 {
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
