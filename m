From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Sun, 09 May 2004 15:30:46 +0000
Subject: Re: sun4c (SS IPX) serial console problem/strangenes.
Message-Id: <20040509153046.GA5767@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200405091508.29649.rezso@rdsor.ro>
In-Reply-To: <200405091508.29649.rezso@rdsor.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, May 09, 2004 at 03:08:29PM +0300, Balint Cristian wrote:

> 1) 	Monitor+KeyBoard --> boot OK, but cgsix being enabled
> half of boot dmesg screen is going on PROM console and only very late swiching to
> framebuffer. I notice that 2.4.x dont do like this.

We don't have control of where console messages go; each driver
registers its console when it's initialized, and the tty/printk
subsystem decides what to write to.  If the framebuffer console does
get registered, and messages are written to it, it's probably working.

> boot: test console=ttyS0,9600 video=sbus:off

I have no idea what that argument is supposed to do, but it doesn't
matter.

> alloc_io_res(cgsix ram): cannot occupy

The TGX+/XGX+ have 4MB framebuffers.  The IO space on sun4c systems is
3MB.  I had hoped that these cards were not supported by Sun on 4c
systems so I wouldn't have to fix this, but that's not the case.
Please test this patch; specifically please take note of any vmalloc
errors.

=== include/asm-sparc/vaddrs.h 1.5 vs edited ==--- 1.5/include/asm-sparc/vaddrs.h	Mon Jan  5 20:26:21 2004
+++ edited/include/asm-sparc/vaddrs.h	Sun May  9 08:30:01 2004
@@ -33,9 +33,9 @@
 
 #define SUN4M_IOBASE_VADDR	0xfd000000 /* Base for mapping pages */
 #define IOBASE_VADDR		0xfe000000
-#define IOBASE_END		0xfe300000
+#define IOBASE_END		0xfe600000
 
-#define VMALLOC_START		0xfe300000
+#define VMALLOC_START		0xfe600000
 
 /* XXX Alter this when I get around to fixing sun4c - Anton */
 #define VMALLOC_END		0xffc00000


-- 
Keith M Wesolowski
