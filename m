From: Kumba <kumba@gentoo.org>
Date: Mon, 19 Sep 2005 02:35:31 +0000
Subject: Blade 100, 2.6.13.2, atyfb
Message-Id: <432E23F3.9030603@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090206010800000200000803"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------090206010800000200000803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Couple minor issues noted on Blade 100 running a 2.6.13.2 kernel.  They're 
probably already known, but...

A) atyfb seems h0rked still.  I think this has been looked at, but I don't 
recall a resolution yet.

B) atyfb's build seems broken due to the following:

   LD      vmlinux
drivers/built-in.o: In function `atyfb_xl_init':
: undefined reference to `aty_st_lcd'
make: *** [vmlinux] Error 1

The attached patch (attempts to) correct for this based on some studying of the 
function causing the problem.


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond

--------------090206010800000200000803
Content-Type: text/plain;
 name="sparc64-atyfb_xl_init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sparc64-atyfb_xl_init.patch"

--- drivers/video/aty/xlinit.c.orig	2005-09-18 21:50:18.000000000 -0400
+++ drivers/video/aty/xlinit.c	2005-09-18 21:50:28.000000000 -0400
@@ -252,9 +252,11 @@ int atyfb_xl_init(struct fb_info *info)
 	aty_st_le32(0xEC, 0x00000000, par);
 	aty_st_le32(0xFC, 0x00000000, par);
 
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
 	for (i=0; i<sizeof(lcd_tbl)/sizeof(lcd_tbl_t); i++) {
 		aty_st_lcd(lcd_tbl[i].lcd_reg, lcd_tbl[i].val, par);
 	}
+#endif
 
 	aty_st_le16(CONFIG_STAT0, 0x00A4, par);
 	mdelay(10);

--------------090206010800000200000803--
