From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Wed, 20 Oct 2004 19:05:10 +0000
Subject: Help Wanted: Floppy and CG3 Problems using Linux-2.6.8.1.
Message-Id: <Pine.LNX.4.10.10410201927410.10087-100000@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all,

I am having a lot of trouble getting things up and running on my sparc
clone. I have applied a patch to get the PROM Console working and I would
like some help getting the CGthree console up and running as the code has
changed substantially from the V2.2 kernels and I can't find the areas of
code to change.
In addition, it would be nice if the floppy was detected. The 2.2.x
kernels also fail to find it.

The console problems are:
1) The console blanks at the point then it switches from the prom console
to the frame buffer console. (There is an error in cg3.c as both blanking
and unblanking to the same thing. I thought that I had fixed this with the
patch below [based on the code from the 2.2.26 kernel] but this had no
effect. Maybe I changed the wrong case).

diff -ruNpd linux-2.6.8.1/drivers/video/cg3.c
linux-2.6.8.1-p02/drivers/video/cg
3.c
--- linux-2.6.8.1/drivers/video/cg3.c   Sat Aug 14 11:55:35 2004
+++ linux-2.6.8.1-p02/drivers/video/cg3.c       Wed Oct 20 16:57:10 2004
@@ -209,7 +209,7 @@ cg3_blank(int blank, struct fb_info *inf
        case 3: /* VESA blank (hsync off) */
        case 4: /* Poweroff */
                val = sbus_readl(&regs->control);
-               val |= CG3_CR_ENABLE_VIDEO;
+               val &= ~CG3_CR_ENABLE_VIDEO;
                sbus_writel(val, &regs->control);
                par->flags |= CG3_FLAG_BLANKED;
                break;
 
2) Using a serial console I managed to get a bit further and found thet
the frame buffer console is being set up to be 144x56. It should be 80x34
(same as the prom). What file is the setting fro this in as I would liek
to change it for my kernel.

3) The Zilog serial ports are aperaing in the frame buffer memory area
(0xFE000000 - 0xFEFFFFFF). They are at 0xfe007004 and 0xfe007000. Any
clues as to why the code has not allocated the frame buffer memory as per
the prom. According to the prom, they should be at:
	reg: 00000001.f1000000.00000008
        address:  ffd02000
and
	reg:  00000001.f0000000.00000008
	address:  ffd00000

According to the prom, the cgthree should be at:
	reg:  00000001.fe000000.01000000
	address:  ffd80000

I have not found if the cgthree driver is getting the address from the
prom. If it does, can someone let me know so that I can add in some 
debug printk's to verify that it is getting it right.

The floppy problem is a mistery to me.
The prom node entry is:
        Node 0xffec0344
                name:  'fd'
                reg:  00000001.f7200000.00000008
                address:  ffd18000
                intr:  0000000b.00000000
                device_type:  'block'

SunOS 4.1.1 has no trouble locating it (in OBIO) so why does linux fail to
find it ? The controller (according to the SunOS man page) is an 82072 and
this FDC is supported in the driver code (drivers/block/floppy.c).

I am not a subscriber to the mailing list (yet) so could any one
responding please ensure that my email address is in the list of
recipients.

Help and advice regarding these and any other known sparc1
sun4c/linux-2.6.8 issues would be much appriciated.

Regards
	Mark Fortescue.
mailto: mark@mtfhpc.demon.co.uk.


