From: Bob Breuer <breuerr@mc.net>
Date: Sat, 12 Feb 2005 06:10:00 +0000
Subject: Re: Xorg doesn't work on the cg3
Message-Id: <420D9DB8.8040706@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1108062924.3919.22.camel@localhost.localdomain>
In-Reply-To: <1108062924.3919.22.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Tom 'spot' Callaway wrote:
> But the cg3 remains stubborn.

I came upon this when comparing the mmap address for cg14 and cg3:
cg14.c:	.voff	= CG3_MMAP_OFFSET,
cg3.c:	.poff	= CG3_MMAP_OFFSET,

I have appended a patch to squash this bug.  But a question remains,
how did this bug go undetected like this?  Either the mmap should
have returned an error, or we should have got a segmentation fault
on writes, but it seems that neither one happened.  Any ideas?

Bob


--- linux-2.6.10-clean/drivers/video/cg3.c	2005-01-12 00:11:02.000000000 -0600
+++ linux-2.6.10/drivers/video/cg3.c	2005-02-11 23:33:54.000000000 -0600
@@ -222,8 +222,8 @@ cg3_blank(int blank, struct fb_info *inf

  static struct sbus_mmap_map cg3_mmap_map[] = {
  	{
-		.poff	= CG3_MMAP_OFFSET,
-		.voff	= CG3_RAM_OFFSET,
+		.voff	= CG3_MMAP_OFFSET,
+		.poff	= CG3_RAM_OFFSET,
  		.size	= SBUS_MMAP_FBSIZE(1)
  	},
  	{ .size = 0 }
