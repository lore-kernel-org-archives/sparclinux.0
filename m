From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Wed, 25 Aug 2004 00:17:28 +0000
Subject: [PATCH 2.6] Fix typo in bw2.c
Message-Id: <1093393048.10698.8.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-xoI0vgTj/mB0D/tEL+6S"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-xoI0vgTj/mB0D/tEL+6S
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Patch to fix typo in bw2.c, added in 2.6.9-rc1.

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora Linux Project Leader

"If you are going through hell, keep going."
- Sir Winston Churchill

--=-xoI0vgTj/mB0D/tEL+6S
Content-Disposition: attachment; filename=linux-2.6.9rc1-fixbw2.patch
Content-Type: text/x-patch; name=linux-2.6.9rc1-fixbw2.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.8/drivers/video/bw2.c.BAD	2004-08-25 00:38:15.240934784 -0400
+++ linux-2.6.8/drivers/video/bw2.c	2004-08-25 00:38:23.171729120 -0400
@@ -338,7 +338,7 @@
 	}
 #endif
 	all->info.var.red.length = all->info.var.green.length =
-		all->info.var.blue.length = all_info.var.bits_per_pixel;
+		all->info.var.blue.length = all->info.var.bits_per_pixel;
 	all->info.var.red.offset = all->info.var.green.offset =
 		all->info.var.blue.offset = 0;
 

--=-xoI0vgTj/mB0D/tEL+6S--

