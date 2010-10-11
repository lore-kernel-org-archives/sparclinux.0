From: Andres Salomon <dilinger@queued.net>
Date: Mon, 11 Oct 2010 06:50:15 +0000
Subject: Re: [PATCH 1/7] sparc: make drivers/of/pdt.c no longer sparc-only
Message-Id: <20101010235015.2954811f@uxo>
List-Id: <sparclinux.vger.kernel.org>
References: <20101010014358.30cb74b5@debxo> <20101010020905.1e27c1b4@debxo>
	<20101011040443.GA23588@angua.secretlab.ca>
In-Reply-To: <20101011040443.GA23588-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>

On Sun, 10 Oct 2010 22:04:43 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Sun, Oct 10, 2010 at 02:09:05AM -0700, Andres Salomon wrote:
> > Whoops, that should've been 1/5, not 1/7.  Two additional x86
> > patches snuck in there that are already in Grant's test-devicetree
> > branch.
> 
> Note that of the two patches I'm carrying in test-devicetree, only one
> of them is actually able to move into linux-next at this present time.
> 
> 1) of/irq: remove references to NO_IRQ in drivers/of/platform.c
> 
> I'm putting this one into next-devicetree now
> 
> 2) x86/of: define irq functions to allow drivers/of/* to build on x86
> 
> I've not yet received an ack from the x86 maintainers on this, so I
> cannot put it into my next branch.  (Sorry I didn't notice this
> earlier; it just dawned on me as I was looking over which patches I
> needed to move over).  The same goes for the patch that actaully adds
> OF support for x86 OLPC.  I'll need an ack from x86 folks before I
> merge it.
> 
> g.

Okay.  For reference, that patch is:

https://patchwork.kernel.org/patch/168662/

x86 folks, mind reviewing and providing an Ack or Nack?
