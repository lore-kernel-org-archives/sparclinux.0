From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Mon, 16 Apr 2007 20:56:25 +0000
Subject: Re: [PATCH]: Fix for SB100/SB150 bootup hangs
Message-Id: <1176756985.3970.365.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-BcE7gLdix/spklf9F8eT"
List-Id: <sparclinux.vger.kernel.org>
References: <20070305.011139.78710584.davem@davemloft.net>
In-Reply-To: <20070305.011139.78710584.davem@davemloft.net>
To: sparclinux@vger.kernel.org


--=-BcE7gLdix/spklf9F8eT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2007-04-16 at 13:19 -0700, David Miller wrote:
> From: Emanuele Rocca <ema@debian.org>
> Date: Mon, 16 Apr 2007 22:08:40 +0200
> 
> > * David Miller <davem@davemloft.net>, [2007-04-16 12:53 -0700]:
> > >  From: Emanuele Rocca <ema@debian.org>
> > >  Date: Mon, 16 Apr 2007 21:49:58 +0200
> > >  
> > >  > Exactly, blank screen after 'Booting Linux...'.
> > >  
> > >  I have no idea what's going wrong then, and this kind of
> > >  but I can't really work on without physical access to
> > >  the system sorry.  I really need to be in front of the
> > >  computer having this issue and do a lot of test boots
> > >  and debug statment frobbing to try and figure it out.
> > 
> > Want to come to Italy? :-)
> > 
> > BTW, we had reports from Debian users that ran into this bug also on
> > ultra10, and I guess every machine with a Creator 3D card is affected.
> > 
> > Nothing critical, though, given that with atyfb:off everything works
> > properly.
> 
> So the source of the problem is that there is a creatorFB
> card and an atyfb in the same machine?
> 
> Probably you have a screen showing on the creatorFB :-)

Yep. Absolutely. Aurora's got this patch in it, to have the old behavior
on FB ordering, since people expect it.

~spot

--=-BcE7gLdix/spklf9F8eT
Content-Disposition: attachment; filename=linux-2.6.16-sparc64-framebufferorder.patch
Content-Type: text/x-patch; name=linux-2.6.16-sparc64-framebufferorder.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.16.sparc64/drivers/video/Makefile.BAD	2006-06-03 12:17:07.000000000 -0400
+++ linux-2.6.16.sparc64/drivers/video/Makefile	2006-06-03 12:19:09.000000000 -0400
@@ -31,9 +31,6 @@
 obj-$(CONFIG_FB_MATROX)		  += matrox/
 obj-$(CONFIG_FB_RIVA)		  += riva/ vgastate.o
 obj-$(CONFIG_FB_NVIDIA)		  += nvidia/
-obj-$(CONFIG_FB_ATY)		  += aty/ macmodes.o
-obj-$(CONFIG_FB_ATY128)		  += aty/ macmodes.o
-obj-$(CONFIG_FB_RADEON)		  += aty/
 obj-$(CONFIG_FB_SIS)		  += sis/
 obj-$(CONFIG_FB_KYRO)             += kyro/
 obj-$(CONFIG_FB_SAVAGE)		  += savage/
@@ -60,6 +57,9 @@
 obj-$(CONFIG_FB_P9100)            += p9100.o sbuslib.o
 obj-$(CONFIG_FB_TCX)              += tcx.o sbuslib.o
 obj-$(CONFIG_FB_LEO)              += leo.o sbuslib.o
+obj-$(CONFIG_FB_ATY)              += aty/ macmodes.o
+obj-$(CONFIG_FB_ATY128)           += aty/ macmodes.o
+obj-$(CONFIG_FB_RADEON)           += aty/
 obj-$(CONFIG_FB_SGIVW)            += sgivwfb.o
 obj-$(CONFIG_FB_ACORN)            += acornfb.o
 obj-$(CONFIG_FB_ATARI)            += atafb.o

--=-BcE7gLdix/spklf9F8eT--

