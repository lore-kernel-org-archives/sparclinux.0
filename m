From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 07 Oct 2005 05:39:12 +0000
Subject: Re: [PATCH RESEND] Fix p9100 framebuffer in 2.6
Message-Id: <1128663552.6766.35.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-+Y+XqVFUyU9ehvtCZw7i"
List-Id: <sparclinux.vger.kernel.org>
References: <1128633573.6766.1.camel@localhost.localdomain>
In-Reply-To: <1128633573.6766.1.camel@localhost.localdomain>
To: sparclinux@vger.kernel.org


--=-+Y+XqVFUyU9ehvtCZw7i
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-10-06 at 21:46 -0700, David S. Miller wrote:
> From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
> Date: Thu, 06 Oct 2005 16:19:33 -0500
> 
> > RESEND:
> 
> -ENOPATCH

OK, lets try again...

~spot
-- 
Tom "spot" Callaway: Red Hat Senior Sales Engineer || GPG ID: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

--=-+Y+XqVFUyU9ehvtCZw7i
Content-Disposition: attachment; filename=linux-2.6.11-sparc-p9100fix.patch
Content-Type: text/x-patch; name=linux-2.6.11-sparc-p9100fix.patch; charset=utf-8
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
 

--=-+Y+XqVFUyU9ehvtCZw7i--

