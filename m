From: Andres Salomon <dilinger@queued.net>
Date: Mon, 30 Aug 2010 18:49:46 +0000
Subject: Re: [PATCH 9/9] x86: OLPC: add OLPC device-tree support
Message-Id: <20100830144946.5c0bce22@debxo>
List-Id: <sparclinux.vger.kernel.org>
References: <20100628215407.2017bf2f@debian> <20100829235100.6dcedcb8@debxo>
	<20100830000751.2b845d05@debxo>
	<AANLkTi=EMkZLiAG7-ni8_7K=qtAriv=AfSUZ58661jNY@mail.gmail.com>
In-Reply-To: <AANLkTi=EMkZLiAG7-ni8_7K=qtAriv=AfSUZ58661jNY-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: pgf-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mitch Bradley <wmb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

On Mon, 30 Aug 2010 12:14:57 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Sun, Aug 29, 2010 at 10:07 PM, Andres Salomon
> <dilinger@queued.net> wrote:
> >
> > Make use of PROC_DEVICETREE to export the tree, and sparc's
> > PROMTREE code to call into OLPC's Open Firmware to build the tree.
> >
> > This also adds an init hook to proc_device_tree_init so that we can
> > ensure the device tree has been built prior to the proc_root_init
> > stuff attempting to populate /proc/device-tree.
> 
> I'm not clear as to why this is needed.  I would expect OLPC platform
> setup code would take care of extracting the device tree well before
> the kernel gets to setting up the representation in /proc/device-tree.
> 
> g.
> 

For simplicity; the OLPC platform setup code runs very early during
boot.  I preferred to keep that as minimal as possible, and defer
device tree allocation until the x86 mm code has finished initializing
(this skipping all the fun bootmem/etc work that'll be happening for
x86 soon).

Of course, once it's done initializing, one can either hardcode an
olpc_init_devtree call at the end of x86's setup_arch, or we can add a
generic hook for late devtree initialization right before proc
populates /proc/device-tree.  I chose the latter, but it could easily
be changed to the former if folks feel strongly about it.

I would've normally just used an initcall for it, but the proc_devtree
code runs prior to any of the initcall hooks.
