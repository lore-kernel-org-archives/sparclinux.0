From: Bob Breuer <breuerr@mc.net>
Date: Sat, 29 Oct 2005 21:49:12 +0000
Subject: possible cg6 fix for pixels repeating at display edge or fading
Message-Id: <4363EE58.1090508@mc.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Has anyone else using a cg6 seen the color banding or fading and pixels
on the right side being repeated off to the edges of the monitor?

I think I've found the cause of the problem.  Contrary to the comment,
changing the bt->control register affects something other than the
cursor.  Also, it looks like cg6_bt_init() already sets up the DAC and
this chunk of the code may be redundant.

The following patch seems to work for me on a TGX+.  If you are seeing
problems, can you give this a try and report if it works or not?

Bob


--- linux-2.6.14/drivers/video/cg6.c.orig	2005-06-22 09:04:25.000000000 -0500
+++ linux-2.6.14/drivers/video/cg6.c	2005-10-29 15:25:19.000000000 -0500
@@ -658,7 +658,7 @@ static void cg6_chip_init(struct fb_info
 	/* Disable cursor in Brooktree DAC. */
 	sbus_writel(0x06 << 24, &par->bt->addr);
 	tmp = sbus_readl(&par->bt->control);
-	tmp &= ~(0x03 << 24);
+	tmp |= (0x03 << 24);
 	sbus_writel(tmp, &par->bt->control);
 }



