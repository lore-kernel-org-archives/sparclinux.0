From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Thu, 10 Feb 2005 19:15:23 +0000
Subject: Xorg doesn't work on the cg3
Message-Id: <1108062924.3919.22.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-wf9lAngk5KQUFdeFxKc2"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-wf9lAngk5KQUFdeFxKc2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've been working with Bob Breuer & Peter Jones to try and track the
sparc32 Xorg problems down, and we have made some progress.

Initially, cg14 worked in X, and neither cg3 nor cg6 worked at all.

In order to make the cg3 framebuffer work (aka, console tux logo and
text), a patch was needed (attached as linux-2.6.10-sparc-framebuffer-
fixes.patch).
 
However, X still didn't work for the cg3 or cg6. With an additional
patch, X works for the cg6. This patch is attached as linux-2.6.10-
sparc-fix_putcmap.patch.

But the cg3 remains stubborn. Bob wrote an elaborate test case, attached
to this email as fbtest-new.c. 

In this code, there are 4 tests:
A) FBIOPUTCMAP_FBCON, red, ramp_up -- see the ramp_up.png image
B) FBIOPUTCMAP_FBCON, red, ramp_down -- see the ramp_down.png image
C) FBIOPUTCMAP_SPARC, green, ramp_up -- same pattern as A, but green
D) FBIOPUTCMAP_SPARC, green, ramp_down -- same pattern as B, but green

B should have a red background, and D should have a green background,
but none should be a solid color.

When this code is run on the cg3, the console jumps to tty7, the screen
goes blank, then we get a solid green screen, then back to tty1.

As Bob describes it: Since you never see any red, then A and B are
broken (fb driver problem?). And if you see nothing but solid black or
solid green, then C and D may only be setting the first palette entry,
or first few entries.

Dave, I don't fully understand how cg3 works, but I can't find any
gaping flaws in the cg3.c implementation. Does all of this data provide
you with any insight as to where the actual failure is?

Wli, please apply these two patches, since they get the cg3 console
working and cg6 Xorg functional.

Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora Linux Project Leader

"If you are going through hell, keep going."
-- Sir Winston Churchill

--=-wf9lAngk5KQUFdeFxKc2
Content-Disposition: attachment; filename=linux-2.6.10-sparc-framebuffer-fixes.patch
Content-Type: text/x-patch; name=linux-2.6.10-sparc-framebuffer-fixes.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.9/drivers/video/cg3.c.BAD	2004-12-19 15:51:01.011779676 -0500
+++ linux-2.6.9/drivers/video/cg3.c	2004-12-19 16:03:46.675381116 -0500
@@ -385,6 +385,9 @@ static void cg3_init_one(struct sbus_dev
 	all->par.physbase = sdev->reg_addrs[0].phys_addr;
 
 	sbusfb_fill_var(&all->info.var, sdev->prom_node, 8);
+	all->info.var.red.length = 8;
+	all->info.var.green.length = 8;
+	all->info.var.blue.length = 8;
 	if (!strcmp(sdev->prom_name, "cgRDI"))
 		all->par.flags |= CG3_FLAG_RDI;
 	if (all->par.flags & CG3_FLAG_RDI)
@@ -419,6 +422,7 @@ static void cg3_init_one(struct sbus_dev
 		kfree(all);
 		return;
 	}
+	fb_set_cmap(&all->info.cmap, &all->info);
 
 	cg3_init_fix(&all->info, linebytes);
 

--=-wf9lAngk5KQUFdeFxKc2
Content-Disposition: attachment; filename=linux-2.6.10-sparc-fix_putcmap.patch
Content-Type: text/x-patch; name=linux-2.6.10-sparc-fix_putcmap.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.10/drivers/video/sbuslib.c.sbuslib	2004-12-24 16:34:29.000000000 -0500
+++ linux-2.6.10/drivers/video/sbuslib.c	2005-02-08 23:23:42.941644262 -0500
@@ -108,6 +108,7 @@
 		struct fbcmap __user *c = (struct fbcmap __user *) arg;
 		struct fb_cmap cmap;
 		u16 red, green, blue;
+		u8 red8, green8, blue8;
 		unsigned char __user *ured;
 		unsigned char __user *ugreen;
 		unsigned char __user *ublue;
@@ -128,11 +129,15 @@
 		for (i = 0; i < count; i++) {
 			int err;
 
-			if (get_user(red, &ured[i]) ||
-			    get_user(green, &ugreen[i]) ||
-			    get_user(blue, &ublue[i]))
+			if (get_user(red8, &ured[i]) ||
+			    get_user(green8, &ugreen[i]) ||
+			    get_user(blue8, &ublue[i]))
 				return -EFAULT;
 
+			red = red8 << 8;
+			green = green8 << 8;
+			blue = blue8 << 8;
+
 			cmap.start = index + i;
 			err = fb_set_cmap(&cmap, info);
 			if (err)
@@ -147,6 +152,7 @@
 		unsigned char __user *ublue;
 		struct fb_cmap *cmap = &info->cmap;
 		int index, count, i;
+		u8 red, green, blue;
 
 		if (get_user(index, &c->index) ||
 		    __get_user(count, &c->count) ||
@@ -159,9 +165,12 @@
 			return -EINVAL;
 
 		for (i = 0; i < count; i++) {
-			if (put_user(cmap->red[index + i], &ured[i]) ||
-			    put_user(cmap->green[index + i], &ugreen[i]) ||
-			    put_user(cmap->blue[index + i], &ublue[i]))
+			red = cmap->red[index + i] >> 8;
+			green = cmap->green[index + i] >> 8;
+			blue = cmap->blue[index + i] >> 8;
+			if (put_user(red, &ured[i]) ||
+			    put_user(green, &ugreen[i]) ||
+			    put_user(blue, &ublue[i]))
 				return -EFAULT;
 		}
 		return 0;

--=-wf9lAngk5KQUFdeFxKc2
Content-Disposition: attachment; filename=fbtest-new.c
Content-Type: text/x-csrc; name=fbtest-new.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <linux/vt.h>
#include <linux/kd.h>
#include <linux/fb.h>
#include <asm/fbio.h> /* sun framebuffer ioctl's */

__u16 old_red[256], old_green[256], old_blue[256];
__u16 dark[256];
__u8 ramp_up8[256], ramp_down8[256];
__u16 ramp_up16[256], ramp_down16[256];

/* avoid confusion, be explicit */
#undef FBIOGETCMAP
#undef FBIOPUTCMAP

#define FBIOGETCMAP_FBCON 0x4604
#define FBIOPUTCMAP_FBCON 0x4605

#define FBIOPUTCMAP_SPARC _IOW('F', 3, struct fbcmap)
#define FBIOGETCMAP_SPARC _IOW('F', 4, struct fbcmap)

int main(void)
{
	int tty, fb, my_vt;
	struct vt_stat vt_state;
	int old_kdmode;
	struct fb_fix_screeninfo fb_finfo;
	struct fb_var_screeninfo fb_vinfo;
	struct fbtype sparc_fbtype;
	struct fbcmap sparc_cmap;
	struct fb_cmap fbcon_cmap;
	char *fbmem, *data;
	int x, y;
	const char *str;
	int sunfb, mapoffset;

	if ((tty = open("/dev/tty", O_NOCTTY|O_RDWR)) == -1)
	{
		perror("open console");
		return -1;
	}

	if (ioctl(tty, VT_GETSTATE, &vt_state) < 0)
	{
		perror("get vt state");
		return -1;
	}
	if (ioctl(tty, VT_OPENQRY, &my_vt) < 0)
	{
		perror("query vt");
		return -1;
	}

	printf("Switching from tty%d to tty%d\n", vt_state.v_active, my_vt);
	if (ioctl(tty, VT_ACTIVATE, my_vt) < 0
	  || ioctl(tty, VT_WAITACTIVE, my_vt) < 0)
	{
		perror("switch vt");
		return -1;
	}

	/* prepare for graphics */
	if (ioctl(tty, KDGETMODE, &old_kdmode) < 0)
		perror("kdgetmode");
	else
		printf("old kdmode = %d\n", old_kdmode);
	if (ioctl(tty, KDSETMODE, KD_GRAPHICS) < 0)
		perror("kdsetmode");

	sunfb = 0;
	fbmem = NULL;
	if ((fb = open("/dev/fb0", O_RDWR)) == -1)
	{
		perror("open fb");
		goto err_nofb;
	}

	mapoffset = -1;
	if (ioctl(fb, FBIOGET_FSCREENINFO, &fb_finfo) < 0
	  || ioctl(fb, FBIOGET_VSCREENINFO, &fb_vinfo) < 0)
		perror("get fb info");

	if (ioctl(fb, FBIOGTYPE, &sparc_fbtype) < 0)
	{
		perror("FBIOGTYPE failed\n");
	}
	else
	{
		sunfb = 1;
		switch (sparc_fbtype.fb_type) {
		case FBTYPE_NOTYPE:
			str = "NOTYPE"; break;
		case FBTYPE_SUN3COLOR:
			mapoffset = 0x4000000;
			str = "SUN3COLOR (cg3)"; break;
		case FBTYPE_SUNFAST_COLOR:
			mapoffset = 0x800000;
			str = "SUNFAST_COLOR (cg6)"; break;
		case FBTYPE_MDICOLOR:
			mapoffset = 0x4000000;
			str = "MDICOLOR (cg14)"; break;
		default:
			str = "other"; break;
		}

		printf( "fbtype:\n"
			"  fb_type   = FBTYPE_%s\n"
			"  fb_height = %d\n"
			"  fb_width  = %d\n"
			"  fb_depth  = %d\n"
			"  fb_cmsize = %d\n"
			"  fb_size   = 0x%08x\n",
			str,
			sparc_fbtype.fb_height, sparc_fbtype.fb_width,
			sparc_fbtype.fb_depth, sparc_fbtype.fb_cmsize,
			sparc_fbtype.fb_size);
	}

	if (mapoffset == -1)
	{
		printf("Don't know mmap offset for framebuffer\n");
	}
	else
	{
		fbmem = (char*)mmap(NULL, 512*1024,
			PROT_READ|PROT_WRITE, MAP_SHARED, fb, mapoffset);
		if (fbmem == MAP_FAILED)
		{
			perror("map fb mem");
			fbmem = NULL;
		}
	}

	fbcon_cmap.start = 0;
	fbcon_cmap.len = 256;
	fbcon_cmap.red = old_red;
	fbcon_cmap.green = old_green;
	fbcon_cmap.blue = old_blue;
	ioctl(fb, FBIOGETCMAP_FBCON, &fbcon_cmap);

	if (fbmem)
	for (data=fbmem, y=0; y<256; y++, data+=fb_finfo.line_length)
		for (x=0; x<256; x++)
			data[x] = (x % 16) + (y & 0xf0);


	for (x=0; x<256; x++) {
		dark[x] = 0;
		ramp_up8[x] = x;
		ramp_down8[x] = 255-x;
		ramp_up16[x] = x << 8;
		ramp_down16[x] = (255-x) << 8;
	}

	/* red */
	fbcon_cmap.red = ramp_up16;
	fbcon_cmap.green = dark;
	fbcon_cmap.blue = dark;
	ioctl(fb, FBIOPUTCMAP_FBCON, &fbcon_cmap);
	sleep(2);

	fbcon_cmap.red = ramp_down16;
	ioctl(fb, FBIOPUTCMAP_FBCON, &fbcon_cmap);
	sleep(2);

	if (sunfb)
	{
		sparc_cmap.index = 0;
		sparc_cmap.count = 256;

		/* green */
		sparc_cmap.red = (__u8*)dark;
		sparc_cmap.blue = (__u8*)dark;
		sparc_cmap.green = ramp_up8;
		ioctl(fb, FBIOPUTCMAP_SPARC, &sparc_cmap);
		sleep(2);

		sparc_cmap.green = ramp_down8;
		ioctl(fb, FBIOPUTCMAP_SPARC, &sparc_cmap);
		sleep(2);
	}

	fbcon_cmap.red = old_red;
	fbcon_cmap.green = old_green;
	fbcon_cmap.blue = old_blue;
	ioctl(fb, FBIOPUTCMAP_FBCON, &fbcon_cmap);

	if (fbmem)
		munmap(fbmem, 512*1024);
	close(fb);
err_nofb:
	ioctl(tty, KDSETMODE, old_kdmode);
	ioctl(tty, VT_ACTIVATE, vt_state.v_active);

	close(tty);

	return 0;
}


--=-wf9lAngk5KQUFdeFxKc2
Content-Disposition: attachment; filename=ramp_down.png
Content-Type: image/png; name=ramp_down.png
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAAoAAAAHgCAMAAAACDyzWAAADAFBMVEX/AAD+AAD9AAD8AAD7AAD6
AAD5AAD4AAD3AAD2AAD1AAD0AADzAADyAADxAADwAADvAADuAADtAADsAADrAADqAADpAADoAADn
AADmAADlAADkAADjAADiAADhAADgAADfAADeAADdAADcAADbAADaAADZAADYAADXAADWAADVAADU
AADTAADSAADRAADQAADPAADOAADNAADMAADLAADKAADJAADIAADHAADGAADFAADEAADDAADCAADB
AADAAAC/AAC+AAC9AAC8AAC7AAC6AAC5AAC4AAC3AAC2AAC1AAC0AACzAACyAACxAACwAACvAACu
AACtAACsAACrAACqAACpAACoAACnAACmAAClAACkAACjAACiAAChAACgAACfAACeAACdAACcAACb
AACaAACZAACYAACXAACWAACVAACUAACTAACSAACRAACQAACPAACOAACNAACMAACLAACKAACJAACI
AACHAACGAACFAACEAACDAACCAACBAACAAAB/AAB+AAB9AAB8AAB7AAB6AAB5AAB4AAB3AAB2AAB1
AAB0AABzAAByAABxAABwAABvAABuAABtAABsAABrAABqAABpAABoAABnAABmAABlAABkAABjAABi
AABhAABgAABfAABeAABdAABcAABbAABaAABZAABYAABXAABWAABVAABUAABTAABSAABRAABQAABP
AABOAABNAABMAABLAABKAABJAABIAABHAABGAABFAABEAABDAABCAABBAABAAAA/AAA+AAA9AAA8
AAA7AAA6AAA5AAA4AAA3AAA2AAA1AAA0AAAzAAAyAAAxAAAwAAAvAAAuAAAtAAAsAAArAAAqAAAp
AAAoAAAnAAAmAAAlAAAkAAAjAAAiAAAhAAAgAAAfAAAeAAAdAAAcAAAbAAAaAAAZAAAYAAAXAAAW
AAAVAAAUAAATAAASAAARAAAQAAAPAAAOAAANAAAMAAALAAAKAAAJAAAIAAAHAAAGAAAFAAAEAAAD
AAACAAABAAAAAADdTg5eAAAISUlEQVR4nO3SwxIAgIFEwdi2bdva2LZt297YTnZj27Zt27aNz+hU
zevbu07NAQ5wwAMd+CAHPdjBD3HIQx36MIc93OHnOpg+gO5g+gC6g+kD6A6mD6A7mD6A7mD6ALqD
6QPoDqYPoDuYPoDuYPoAuoPpA+gOpg+gO5g+gO5g+gC6g+kD6I51hCMe6chHOerRjn6MYx7r2Mc5
7vGOv9Z6/3n6ALr1/vP0AXTr/efpA+jW+8/TB9Ct95+nD6Bb7z9PH0C33n+ePoBuvf88fQDdev95
+gC69f7z9AF06/3n6QPo1vvP0wfQrfefpw+gW+8/Tx9At95/nj6Abr3/vBOc8EQnPslJT3byU5zy
VKc+zWlPd/q11vvP0wfQrfefpw+gW+8/Tx9At95/nj6Abr3/PH0A3Xr/efoAuvX+8/QBdOv95+kD
6Nb7z9MH0K33n6cPoFvvP08fQLfef54+gG69/zx9AN16/3n6ALr1/vP0AXTr/eed4YxnOvNZznq2
s5/jnOc693nOe77zr7Xef54+gG69/zx9AN16/3n6ALr1/vP0AXTr/efpA+jW+8/TB9Ct95+nD6Bb
7z9PH0C33n+ePoBuvf88fQDdev95+gC69f7z9AF06/3n6QPo1vvP0wfQrfefpw+gW+8/7wL/c8EL
XfgiF73YxS9xyUtd+jKXvdxa6/3n6QPo1vvP0wfQrfefpw+gW+8/Tx9At95/nj6Abr3/PH0A3Xr/
efoAuvX+8/QBdOv95+kD6Nb7z9MH0K33n6cPoFvvP08fQLfef54+gG69/zx9AN16/3n6ALr1/vMu
f4UrXunKV7nq1a5+jWte69rXue711lrvP08fQLfef54+gG69/zx9AN16/3n6ALr1/vP0AXTr/efp
A+jW+8/TB9Ct95+nD6Bb7z9PH0C33n+ePoBuvf88fQDdev95+gC69f7z9AF06/3n6QPo1vvP0wfQ
rfefd/0b3PBGN77JTW9281vc8la3vs1tb7fWev95+gC69f7z9AF06/3n6QPo1vvP0wfQrfefpw+g
W+8/Tx9At95/nj6Abr3/PH0A3Xr/efoAuvX+8/QBdOv95+kD6Nb7z9MH0K33n6cPoFvvP08fQLfe
f54+gG69/7zb3+GOd7rzXe56t7vf4573uvd97nu/tdb7z9MH0K33n6cPoFvvP08fQLfef54+gG69
/zx9AN16/3n6ALr1/vP0AXTr/efpA+jW+8/TB9Ct95+nD6Bb7z9PH0C33n+ePoBuvf88fQDdev95
+gC69f7z9AF06/3n3f8BD3zQg//3IQ992MMf8chHPfoxj11rvf88fQDdev95+gC69f7z9AF06/3n
6QPo1vvP0wfQrfefpw+gW+8/Tx9At95/nj6Abr3/PH0A3Xr/efoAuvX+8/QBdOv95+kD6Nb7z9MH
0K33n6cPoFvvP08fQLfef97jHv+EJz7pyU956tOe/oz/+/9nPuvZa633n6cPoFvvP08fQLfef54+
gG69/zx9AN16/3n6ALr1/vP0AXTr/efpA+jW+8/TB9Ct95+nD6Bb7z9PH0C33n+ePoBuvf88fQDd
ev95+gC69f7z9AF06/3n6QPo1vvPe85zn/f8F7zwRS9+yUtf9vJXvPJVr15rvf88fQDdev95+gC6
9f7z9AF06/3n6QPo1vvP0wfQrfefpw+gW+8/Tx9At95/nj6Abr3/PH0A3Xr/efoAuvX+8/QBdOv9
5+kD6Nb7z9MH0K33n6cPoFvvP08fQLfef95rXvu617/hjW9681ve+ra3v+Od73r3Wuv95+kD6Nb7
z9MH0K33n6cPoFvvP08fQLfef54+gG69/zx9AN16/3n6ALr1/vP0AXTr/efpA+jW+8/TB9Ct95+n
D6Bb7z9PH0C33n+ePoBuvf88fQDdev95+gC69f7z3vPe973/Ax/80Ic/8tGPffwTn/zUp9da7z9P
H0C33n+ePoBuvf88fQDdev95+gC69f7z9AF06/3n6QPo1vvP0wfQrfefpw+gW+8/Tx9At95/nj6A
br3/PH0A3Xr/efoAuvX+8/QBdOv95+kD6Nb7z9MH0K33n/eZz37u81/44pe+/JWvfu3r3/jmt769
1nr/efoAuvX+8/QBdOv95+kD6Nb7z9MH0K33n6cPoFvvP08fQLfef54+gG69/zx9AN16/3n6ALr1
/vP0AXTr/efpA+jW+8/TB9Ct95+nD6Bb7z9PH0C33n+ePoBuvf+873z3e9//wQ9/9OOf/PRnP//F
L3/167XW+8/TB9Ct95+nD6Bb7z9PH0C33n+ePoBuvf88fQDdev95+gC69f7z9AF06/3n6QPo1vvP
0wfQrfefpw+gW+8/Tx9At95/nj6Abr3/PH0A3Xr/efoAuvX+8/QBdOv95/3mt7/7/R/++Kc//+Wv
f/v7P/75r3+vtd5/nj6Abr3/PH0A3Xr/efoAuvX+8/QBdOv95+kD6Nb7z9MH0K33n6cPoFvvP08f
QLfef54+gG69/zx9AN16/3n6ALr1/vP0AXTr/efpA+jW+8/TB9Ct95+nD6Bb758kSZIkSZIkSZIk
SZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIk
SZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIk
SZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIk
SZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIk+e/wH72gh3K0XnYDAAAAAElFTkSuQmCC


--=-wf9lAngk5KQUFdeFxKc2
Content-Disposition: attachment; filename=ramp_up.png
Content-Type: image/png; name=ramp_up.png
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAAoAAAAHgCAMAAAACDyzWAAADAFBMVEUAAAABAAACAAADAAAEAAAF
AAAGAAAHAAAIAAAJAAAKAAALAAAMAAANAAAOAAAPAAAQAAARAAASAAATAAAUAAAVAAAWAAAXAAAY
AAAZAAAaAAAbAAAcAAAdAAAeAAAfAAAgAAAhAAAiAAAjAAAkAAAlAAAmAAAnAAAoAAApAAAqAAAr
AAAsAAAtAAAuAAAvAAAwAAAxAAAyAAAzAAA0AAA1AAA2AAA3AAA4AAA5AAA6AAA7AAA8AAA9AAA+
AAA/AABAAABBAABCAABDAABEAABFAABGAABHAABIAABJAABKAABLAABMAABNAABOAABPAABQAABR
AABSAABTAABUAABVAABWAABXAABYAABZAABaAABbAABcAABdAABeAABfAABgAABhAABiAABjAABk
AABlAABmAABnAABoAABpAABqAABrAABsAABtAABuAABvAABwAABxAAByAABzAAB0AAB1AAB2AAB3
AAB4AAB5AAB6AAB7AAB8AAB9AAB+AAB/AACAAACBAACCAACDAACEAACFAACGAACHAACIAACJAACK
AACLAACMAACNAACOAACPAACQAACRAACSAACTAACUAACVAACWAACXAACYAACZAACaAACbAACcAACd
AACeAACfAACgAAChAACiAACjAACkAAClAACmAACnAACoAACpAACqAACrAACsAACtAACuAACvAACw
AACxAACyAACzAAC0AAC1AAC2AAC3AAC4AAC5AAC6AAC7AAC8AAC9AAC+AAC/AADAAADBAADCAADD
AADEAADFAADGAADHAADIAADJAADKAADLAADMAADNAADOAADPAADQAADRAADSAADTAADUAADVAADW
AADXAADYAADZAADaAADbAADcAADdAADeAADfAADgAADhAADiAADjAADkAADlAADmAADnAADoAADp
AADqAADrAADsAADtAADuAADvAADwAADxAADyAADzAAD0AAD1AAD2AAD3AAD4AAD5AAD6AAD7AAD8
AAD9AAD+AAD/AAD7MrugAAAISUlEQVR4nO3SwxIAgIFEwdi2bdva2LZt297YTnZj27Zt27aNz+hU
zevbu07NAQ5wwAMd+CAHPdjBD3HIQx36MIc93OHnOpg+gO5g+gC6g+kD6A6mD6A7mD6A7mD6ALqD
6QPoDqYPoDuYPoDuYPoAuoPpA+gOpg+gO5g+gO5g+gC6g+kD6I51hCMe6chHOerRjn6MYx7r2Mc5
7vGOv9Z6/3n6ALr1/vP0AXTr/efpA+jW+8/TB9Ct95+nD6Bb7z9PH0C33n+ePoBuvf88fQDdev95
+gC69f7z9AF06/3n6QPo1vvP0wfQrfefpw+gW+8/Tx9At95/nj6Abr3/vBOc8EQnPslJT3byU5zy
VKc+zWlPd/q11vvP0wfQrfefpw+gW+8/Tx9At95/nj6Abr3/PH0A3Xr/efoAuvX+8/QBdOv95+kD
6Nb7z9MH0K33n6cPoFvvP08fQLfef54+gG69/zx9AN16/3n6ALr1/vP0AXTr/eed4YxnOvNZznq2
s5/jnOc693nOe77zr7Xef54+gG69/zx9AN16/3n6ALr1/vP0AXTr/efpA+jW+8/TB9Ct95+nD6Bb
7z9PH0C33n+ePoBuvf88fQDdev95+gC69f7z9AF06/3n6QPo1vvP0wfQrfefpw+gW+8/7wL/c8EL
XfgiF73YxS9xyUtd+jKXvdxa6/3n6QPo1vvP0wfQrfefpw+gW+8/Tx9At95/nj6Abr3/PH0A3Xr/
efoAuvX+8/QBdOv95+kD6Nb7z9MH0K33n6cPoFvvP08fQLfef54+gG69/zx9AN16/3n6ALr1/vMu
f4UrXunKV7nq1a5+jWte69rXue711lrvP08fQLfef54+gG69/zx9AN16/3n6ALr1/vP0AXTr/efp
A+jW+8/TB9Ct95+nD6Bb7z9PH0C33n+ePoBuvf88fQDdev95+gC69f7z9AF06/3n6QPo1vvP0wfQ
rfefd/0b3PBGN77JTW9281vc8la3vs1tb7fWev95+gC69f7z9AF06/3n6QPo1vvP0wfQrfefpw+g
W+8/Tx9At95/nj6Abr3/PH0A3Xr/efoAuvX+8/QBdOv95+kD6Nb7z9MH0K33n6cPoFvvP08fQLfe
f54+gG69/7zb3+GOd7rzXe56t7vf4573uvd97nu/tdb7z9MH0K33n6cPoFvvP08fQLfef54+gG69
/zx9AN16/3n6ALr1/vP0AXTr/efpA+jW+8/TB9Ct95+nD6Bb7z9PH0C33n+ePoBuvf88fQDdev95
+gC69f7z9AF06/3n3f8BD3zQg//3IQ992MMf8chHPfoxj11rvf88fQDdev95+gC69f7z9AF06/3n
6QPo1vvP0wfQrfefpw+gW+8/Tx9At95/nj6Abr3/PH0A3Xr/efoAuvX+8/QBdOv95+kD6Nb7z9MH
0K33n6cPoFvvP08fQLfef97jHv+EJz7pyU956tOe/oz/+/9nPuvZa633n6cPoFvvP08fQLfef54+
gG69/zx9AN16/3n6ALr1/vP0AXTr/efpA+jW+8/TB9Ct95+nD6Bb7z9PH0C33n+ePoBuvf88fQDd
ev95+gC69f7z9AF06/3n6QPo1vvPe85zn/f8F7zwRS9+yUtf9vJXvPJVr15rvf88fQDdev95+gC6
9f7z9AF06/3n6QPo1vvP0wfQrfefpw+gW+8/Tx9At95/nj6Abr3/PH0A3Xr/efoAuvX+8/QBdOv9
5+kD6Nb7z9MH0K33n6cPoFvvP08fQLfef95rXvu617/hjW9681ve+ra3v+Od73r3Wuv95+kD6Nb7
z9MH0K33n6cPoFvvP08fQLfef54+gG69/zx9AN16/3n6ALr1/vP0AXTr/efpA+jW+8/TB9Ct95+n
D6Bb7z9PH0C33n+ePoBuvf88fQDdev95+gC69f7z3vPe973/Ax/80Ic/8tGPffwTn/zUp9da7z9P
H0C33n+ePoBuvf88fQDdev95+gC69f7z9AF06/3n6QPo1vvP0wfQrfefpw+gW+8/Tx9At95/nj6A
br3/PH0A3Xr/efoAuvX+8/QBdOv95+kD6Nb7z9MH0K33n/eZz37u81/44pe+/JWvfu3r3/jmt769
1nr/efoAuvX+8/QBdOv95+kD6Nb7z9MH0K33n6cPoFvvP08fQLfef54+gG69/zx9AN16/3n6ALr1
/vP0AXTr/efpA+jW+8/TB9Ct95+nD6Bb7z9PH0C33n+ePoBuvf+873z3e9//wQ9/9OOf/PRnP//F
L3/167XW+8/TB9Ct95+nD6Bb7z9PH0C33n+ePoBuvf88fQDdev95+gC69f7z9AF06/3n6QPo1vvP
0wfQrfefpw+gW+8/Tx9At95/nj6Abr3/PH0A3Xr/efoAuvX+8/QBdOv95/3mt7/7/R/++Kc//+Wv
f/v7P/75r3+vtd5/nj6Abr3/PH0A3Xr/efoAuvX+8/QBdOv95+kD6Nb7z9MH0K33n6cPoFvvP08f
QLfef54+gG69/zx9AN16/3n6ALr1/vP0AXTr/efpA+jW+8/TB9Ct95+nD6Bb758kSZIkSZIkSZIk
SZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIk
SZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIk
SZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIk
SZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIkSZIk+e/wH72gh3K0XnYDAAAAAElFTkSuQmCC


--=-wf9lAngk5KQUFdeFxKc2--

