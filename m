From: Christoph Hellwig <hch@lst.de>
Date: Wed, 07 Oct 2020 07:44:47 +0000
Subject: [PATCH 3/3] fbdev/sbuslib: avoid compat_alloc_user_space in fbiogetputcmap
Message-Id: <20201007074447.797968-4-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20201007074447.797968-1-hch@lst.de>
In-Reply-To: <20201007074447.797968-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, "David S. Miller" <davem@davemloft.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org, linux-fbdev@vger.kernel.org

Rewrite fbiogetputcmap to call the low-level sbusfb_ioctl_{put,get}cmap
helpers directly and thus avoid usage of the deprecated
compat_alloc_user_space API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/video/fbdev/sbuslib.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/sbuslib.c b/drivers/video/fbdev/sbuslib.c
index 1c3bf1cb8dccd7..ef74e3e6326a06 100644
--- a/drivers/video/fbdev/sbuslib.c
+++ b/drivers/video/fbdev/sbuslib.c
@@ -188,23 +188,23 @@ EXPORT_SYMBOL(sbusfb_ioctl_helper);
 static int fbiogetputcmap(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
 	struct fbcmap32 __user *argp = (void __user *)arg;
-	struct fbcmap __user *p = compat_alloc_user_space(sizeof(*p));
+	struct fbcmap kc;
 	u32 addr;
 	int ret;
 
-	ret = copy_in_user(p, argp, 2 * sizeof(int));
+	ret = get_user(kc.index, &argp->index);
+	ret |= get_user(kc.count, &argp->count);
 	ret |= get_user(addr, &argp->red);
-	ret |= put_user(compat_ptr(addr), &p->red);
+	kc.red = compat_ptr(addr);
 	ret |= get_user(addr, &argp->green);
-	ret |= put_user(compat_ptr(addr), &p->green);
+	kc.green = compat_ptr(addr);
 	ret |= get_user(addr, &argp->blue);
-	ret |= put_user(compat_ptr(addr), &p->blue);
+	kc.blue = compat_ptr(addr);
 	if (ret)
 		return -EFAULT;
-	return info->fbops->fb_ioctl(info,
-			(cmd = FBIOPUTCMAP32) ?
-			FBIOPUTCMAP_SPARC : FBIOGETCMAP_SPARC,
-			(unsigned long)p);
+	if (cmd = FBIOPUTCMAP32)
+		return sbusfb_ioctl_putcmap(&kc, info);
+	return sbusfb_ioctl_getcmap(&kc, info);
 }
 
 int sbusfb_compat_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
-- 
2.28.0
