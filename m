From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Mon, 19 Sep 2005 04:18:47 +0000
Subject: Re: Blade 100, 2.6.13.2, atyfb
Message-Id: <1127103527.2639.3.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-z1pipB3PNrdDBS5YvNxB"
List-Id: <sparclinux.vger.kernel.org>
References: <432E23F3.9030603@gentoo.org>
In-Reply-To: <432E23F3.9030603@gentoo.org>
To: sparclinux@vger.kernel.org


--=-z1pipB3PNrdDBS5YvNxB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2005-09-18 at 22:35 -0400, Kumba wrote:
> Couple minor issues noted on Blade 100 running a 2.6.13.2 kernel.  They're 
> probably already known, but...
> 
> A) atyfb seems h0rked still.  I think this has been looked at, but I don't 
> recall a resolution yet.

I can confirm this as well.

> B) atyfb's build seems broken due to the following:
> 
>    LD      vmlinux
> drivers/built-in.o: In function `atyfb_xl_init':
> : undefined reference to `aty_st_lcd'
> make: *** [vmlinux] Error 1
> 
> The attached patch (attempts to) correct for this based on some studying of the 
> function causing the problem.

Aurora's had a similar patch in our 2.6 kernel for some time now. The
only difference is that we move the int i; variable declaration inside
the conditional to avoid unnecessary compiler noise. 

(I thought I had sent this to the list long ago, but I didn't. My bad.)

Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

~spot
-- 
Tom "spot" Callaway: Red Hat Senior Sales Engineer || GPG ID: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

--=-z1pipB3PNrdDBS5YvNxB
Content-Disposition: attachment; filename=linux-2.6.11-atyfb-nolcd.patch
Content-Type: text/x-patch; name=linux-2.6.11-atyfb-nolcd.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.11/drivers/video/aty/xlinit.c.BAD	2005-03-04 20:01:29.526690531 -0500
+++ linux-2.6.11/drivers/video/aty/xlinit.c	2005-03-04 20:04:49.384307555 -0500
@@ -174,7 +174,7 @@ int atyfb_xl_init(struct fb_info *info)
 	const struct xl_card_cfg_t * card = &card_cfg[xl_card];
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	union aty_pll pll;
-	int i, err;
+	int err;
 	u32 temp;
 	
 	aty_st_8(CONFIG_STAT0, 0x85, par);
@@ -252,9 +252,12 @@ int atyfb_xl_init(struct fb_info *info)
 	aty_st_le32(0xEC, 0x00000000, par);
 	aty_st_le32(0xFC, 0x00000000, par);
 
+#if defined (CONFIG_FB_ATY_GENERIC_LCD)
+	int i;
 	for (i=0; i<sizeof(lcd_tbl)/sizeof(lcd_tbl_t); i++) {
 		aty_st_lcd(lcd_tbl[i].lcd_reg, lcd_tbl[i].val, par);
 	}
+#endif
 
 	aty_st_le16(CONFIG_STAT0, 0x00A4, par);
 	mdelay(10);

--=-z1pipB3PNrdDBS5YvNxB--

