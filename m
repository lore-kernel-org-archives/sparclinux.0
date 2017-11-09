From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 09 Nov 2017 13:41:22 +0000
Subject: Re: [PATCH] video: fbdev: remove dead igafb driver
Message-Id: <2322572.JefbQec2Tl@amdc3058>
List-Id: <sparclinux.vger.kernel.org>
References: <CGME20171018125650epcas1p40c181757104f1cb73b1a41596a63b465@epcas1p4.samsung.com>
 <20171018.142214.436255812332803507.davem@davemloft.net>
 <201710181645.32708.linux@rainbow-software.org>
In-Reply-To: <201710181645.32708.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, glaubitz@physik.fu-berlin.de, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, bhumirks@gmail.com

On Wednesday, October 18, 2017 04:45:31 PM Ondrej Zary wrote:
> On Wednesday 18 October 2017, David Miller wrote:
> > From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > Date: Wed, 18 Oct 2017 15:14:27 +0200
> >
> > > Hi Bartlomiej!
> > >
> > > On 10/18/2017 02:56 PM, Bartlomiej Zolnierkiewicz wrote:
> > >> igafb driver hasn't compiled since at least kernel v2.6.34 as
> > >> commit 6016a363f6b5 ("of: unify phandle name in struct device_node")
> > >> missed updating igafb.c to use dp->phandle instead of dp->node.
> > >
> > > Would it take a lot of work to port the driver to the new interface?
> > >
> > > I'm not sure which SPARC machines use this particular framebuffer, but
> > > my plans are to fix up all these old framebuffer drivers. I have
> > > already
> > > received several Amiga (Zorro) graphics cards for testing the updated
> > > drivers on Amiga.
> > >
> > > It could be that I actually have this particular SPARC framebuffer in
> > > my hardware collection.
> >
> > Unless you have a 32-bit sparc laptop, you don't have a machine that
> > will use this driver.
> 
> There are also some x86 PCI cards using this chip.

Interesting, the driver has never supported x86 (it has always been
SPARC32 specific). Once somebody has the card we can think about adding
proper DRM driver for it (shouldn't be that hard). In the meantime I've
queued the patch removing dead igafb driver for 4.15.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

