From: Christoph Hellwig <hch@lst.de>
Date: Wed, 07 Oct 2020 07:44:45 +0000
Subject: [PATCH 1/3] fbdev/sbuslib: remove FBIOSCURSOR/FBIOGCURSOR leftovers
Message-Id: <20201007074447.797968-2-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20201007074447.797968-1-hch@lst.de>
In-Reply-To: <20201007074447.797968-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, "David S. Miller" <davem@davemloft.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org, linux-fbdev@vger.kernel.org

There are no actual implementations of FBIOSCURSOR/FBIOGCURSOR left, so
don't bother with a compat handler for it, and remove the remaining
definitions as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/include/asm/fbio.h       | 29 -----------------------------
 arch/sparc/include/asm/fbio.h      | 13 -------------
 arch/sparc/include/uapi/asm/fbio.h | 15 ---------------
 drivers/video/fbdev/sbuslib.c      | 30 ------------------------------
 4 files changed, 87 deletions(-)

diff --git a/arch/m68k/include/asm/fbio.h b/arch/m68k/include/asm/fbio.h
index 590b923c470d3e..90ae409c6bdb4e 100644
--- a/arch/m68k/include/asm/fbio.h
+++ b/arch/m68k/include/asm/fbio.h
@@ -97,21 +97,6 @@ struct fbgattr {
 #define FBIOSVIDEO _IOW('F', 7, int)
 #define FBIOGVIDEO _IOR('F', 8, int)
 
-struct fbcursor {
-        short set;              /* what to set, choose from the list above */
-        short enable;           /* cursor on/off */
-        struct fbcurpos pos;    /* cursor position */
-        struct fbcurpos hot;    /* cursor hot spot */
-        struct fbcmap cmap;     /* color map info */
-        struct fbcurpos size;   /* cursor bit map size */
-        char __user *image;     /* cursor image bits */
-        char __user *mask;      /* cursor mask bits */
-};
-
-/* set/get cursor attributes/shape */
-#define FBIOSCURSOR     _IOW('F', 24, struct fbcursor)
-#define FBIOGCURSOR     _IOWR('F', 25, struct fbcursor)
- 
 /* set/get cursor position */
 #define FBIOSCURPOS     _IOW('F', 26, struct fbcurpos)
 #define FBIOGCURPOS     _IOW('F', 27, struct fbcurpos)
@@ -312,20 +297,6 @@ struct  fbcmap32 {
 
 #define FBIOPUTCMAP32	_IOW('F', 3, struct fbcmap32)
 #define FBIOGETCMAP32	_IOW('F', 4, struct fbcmap32)
-
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
 #endif
 
 #endif /* __LINUX_FBIO_H */
diff --git a/arch/sparc/include/asm/fbio.h b/arch/sparc/include/asm/fbio.h
index 02654cb95dec57..348994cc142973 100644
--- a/arch/sparc/include/asm/fbio.h
+++ b/arch/sparc/include/asm/fbio.h
@@ -57,17 +57,4 @@ struct  fbcmap32 {
 #define FBIOPUTCMAP32	_IOW('F', 3, struct fbcmap32)
 #define FBIOGETCMAP32	_IOW('F', 4, struct fbcmap32)
 
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
 #endif /* __LINUX_FBIO_H */
diff --git a/arch/sparc/include/uapi/asm/fbio.h b/arch/sparc/include/uapi/asm/fbio.h
index 0dafe2c1eab740..bda278c2a7d091 100644
--- a/arch/sparc/include/uapi/asm/fbio.h
+++ b/arch/sparc/include/uapi/asm/fbio.h
@@ -94,21 +94,6 @@ struct fbgattr {
 #define FBIOSVIDEO _IOW('F', 7, int)
 #define FBIOGVIDEO _IOR('F', 8, int)
 
-struct fbcursor {
-        short set;              /* what to set, choose from the list above */
-        short enable;           /* cursor on/off */
-        struct fbcurpos pos;    /* cursor position */
-        struct fbcurpos hot;    /* cursor hot spot */
-        struct fbcmap cmap;     /* color map info */
-        struct fbcurpos size;   /* cursor bit map size */
-        char __user *image;     /* cursor image bits */
-        char __user *mask;      /* cursor mask bits */
-};
-
-/* set/get cursor attributes/shape */
-#define FBIOSCURSOR     _IOW('F', 24, struct fbcursor)
-#define FBIOGCURSOR     _IOWR('F', 25, struct fbcursor)
- 
 /* set/get cursor position */
 #define FBIOSCURPOS     _IOW('F', 26, struct fbcurpos)
 #define FBIOGCURPOS     _IOW('F', 27, struct fbcurpos)
diff --git a/drivers/video/fbdev/sbuslib.c b/drivers/video/fbdev/sbuslib.c
index 01a7110e61a76a..176dbfb5d3efca 100644
--- a/drivers/video/fbdev/sbuslib.c
+++ b/drivers/video/fbdev/sbuslib.c
@@ -214,32 +214,6 @@ static int fbiogetputcmap(struct fb_info *info, unsigned int cmd, unsigned long
 			(unsigned long)p);
 }
 
-static int fbiogscursor(struct fb_info *info, unsigned long arg)
-{
-	struct fbcursor __user *p = compat_alloc_user_space(sizeof(*p));
-	struct fbcursor32 __user *argp =  (void __user *)arg;
-	compat_uptr_t addr;
-	int ret;
-
-	ret = copy_in_user(p, argp,
-			      2 * sizeof (short) + 2 * sizeof(struct fbcurpos));
-	ret |= copy_in_user(&p->size, &argp->size, sizeof(struct fbcurpos));
-	ret |= copy_in_user(&p->cmap, &argp->cmap, 2 * sizeof(int));
-	ret |= get_user(addr, &argp->cmap.red);
-	ret |= put_user(compat_ptr(addr), &p->cmap.red);
-	ret |= get_user(addr, &argp->cmap.green);
-	ret |= put_user(compat_ptr(addr), &p->cmap.green);
-	ret |= get_user(addr, &argp->cmap.blue);
-	ret |= put_user(compat_ptr(addr), &p->cmap.blue);
-	ret |= get_user(addr, &argp->mask);
-	ret |= put_user(compat_ptr(addr), &p->mask);
-	ret |= get_user(addr, &argp->image);
-	ret |= put_user(compat_ptr(addr), &p->image);
-	if (ret)
-		return -EFAULT;
-	return info->fbops->fb_ioctl(info, FBIOSCURSOR, (unsigned long)p);
-}
-
 int sbusfb_compat_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
@@ -248,8 +222,6 @@ int sbusfb_compat_ioctl(struct fb_info *info, unsigned int cmd, unsigned long ar
 	case FBIOGATTR:
 	case FBIOSVIDEO:
 	case FBIOGVIDEO:
-	case FBIOGCURSOR32:	/* This is not implemented yet.
-				   Later it should be converted... */
 	case FBIOSCURPOS:
 	case FBIOGCURPOS:
 	case FBIOGCURMAX:
@@ -258,8 +230,6 @@ int sbusfb_compat_ioctl(struct fb_info *info, unsigned int cmd, unsigned long ar
 		return fbiogetputcmap(info, cmd, arg);
 	case FBIOGETCMAP32:
 		return fbiogetputcmap(info, cmd, arg);
-	case FBIOSCURSOR32:
-		return fbiogscursor(info, arg);
 	default:
 		return -ENOIOCTLCMD;
 	}
-- 
2.28.0
