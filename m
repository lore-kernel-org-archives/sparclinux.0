From: Ondrej Zary <linux@rainbow-software.org>
Date: Wed, 18 Oct 2017 14:45:31 +0000
Subject: Re: [PATCH] video: fbdev: remove dead igafb driver
Message-Id: <201710181645.32708.linux@rainbow-software.org>
List-Id: <sparclinux.vger.kernel.org>
References: <CGME20171018125650epcas1p40c181757104f1cb73b1a41596a63b465@epcas1p4.samsung.com>
 <62038aaa-7245-25be-a5db-7253eaad5cc3@physik.fu-berlin.de>
 <20171018.142214.436255812332803507.davem@davemloft.net>
In-Reply-To: <20171018.142214.436255812332803507.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, bhumirks@gmail.com

On Wednesday 18 October 2017, David Miller wrote:
> From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Date: Wed, 18 Oct 2017 15:14:27 +0200
>
> > Hi Bartlomiej!
> >
> > On 10/18/2017 02:56 PM, Bartlomiej Zolnierkiewicz wrote:
> >> igafb driver hasn't compiled since at least kernel v2.6.34 as
> >> commit 6016a363f6b5 ("of: unify phandle name in struct device_node")
> >> missed updating igafb.c to use dp->phandle instead of dp->node.
> >
> > Would it take a lot of work to port the driver to the new interface?
> >
> > I'm not sure which SPARC machines use this particular framebuffer, but
> > my plans are to fix up all these old framebuffer drivers. I have
> > already
> > received several Amiga (Zorro) graphics cards for testing the updated
> > drivers on Amiga.
> >
> > It could be that I actually have this particular SPARC framebuffer in
> > my hardware collection.
>
> Unless you have a 32-bit sparc laptop, you don't have a machine that
> will use this driver.

There are also some x86 PCI cards using this chip.

-- 
Ondrej Zary
