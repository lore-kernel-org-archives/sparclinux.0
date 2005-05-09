From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Mon, 09 May 2005 15:09:31 +0000
Subject: [PATCH] Fix p9100 framebuffer in 2.6
Message-Id: <1115651371.3017.58.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-b0mfw+bMgG5W0JQ7aLZc"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-b0mfw+bMgG5W0JQ7aLZc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached patch fixes the p9100 framebuffer so that text is viewable
(not black on black, like it was before the patch). The linux logo
displays for a very short period of time, then is replaced by a grey
box. This leads me to believe that this framebuffer would have problems
in X, but since there hasn't been a weitek driver for X in several
millennia, this isn't something that I can confirm or deny.

But this patch does get color console working on my SPARCbook 3TX.

Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

~spot
-- 
Tom "spot" Callaway: Red Hat Sales Engineer || GPG Fingerprint: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

--=-b0mfw+bMgG5W0JQ7aLZc
Content-Disposition: attachment; filename=linux-2.6.11-sparc-p9100fix.patch
Content-Type: text/x-patch; name=linux-2.6.11-sparc-p9100fix.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

--- linux-2.6.11/drivers/video/p9100.c.BAD	2005-05-05 19:43:10.703531238 -0400
+++ linux-2.6.11/drivers/video/p9100.c	2005-05-05 19:44:17.947308630 -0400
@@ -288,6 +288,9 @@ static void p9100_init_one(struct sbus_d
 	all->par.physbase = sdev->reg_addrs[2].phys_addr;
 
 	sbusfb_fill_var(&all->info.var, sdev->prom_node, 8);
+	all->info.var.red.length = 8;
+	all->info.var.green.length = 8;
+	all->info.var.blue.length = 8;
 
 	linebytes = prom_getintdefault(sdev->prom_node, "linebytes",
 				       all->info.var.xres);
@@ -323,6 +326,7 @@ static void p9100_init_one(struct sbus_d
 		kfree(all);
 		return;
 	}
+	fb_set_cmap(&all->info.cmap, &all->info);
 
 	list_add(&all->list, &p9100_list);
 

--=-b0mfw+bMgG5W0JQ7aLZc--

