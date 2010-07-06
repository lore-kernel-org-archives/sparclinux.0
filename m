From: Andres Salomon <dilinger@queued.net>
Date: Tue, 06 Jul 2010 03:25:01 +0000
Subject: Re: [PATCH 2/4] sparc: break out some prom device-tree building
Message-Id: <20100707051548.2c44f30c@debxo>
List-Id: <sparclinux.vger.kernel.org>
References: <20100629193618.5a840b8e@dev.queued.net>
	<AANLkTilme2uAoXjorUEzam9j_xosR8kl70W8PS71d-Th@mail.gmail.com>
	<20100707040734.05d625af@debxo>
	<20100705.192221.241453945.davem@davemloft.net>
In-Reply-To: <20100705.192221.241453945.davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: wmb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, pgf-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org

On Mon, 05 Jul 2010 19:22:21 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Andres Salomon <dilinger@queued.net>
> Date: Wed, 7 Jul 2010 04:07:34 +0000
> 
> >  - For the pdt, calling into the prom once for each property/node to
> >    create a fdt, and then unflattening it.  This is better than the
> >    previous option, but I don't think the prom->fdt code will be
> > very nice.
> 
> I'll need this on sparc64 at some point to support kexec() anyways.
> 
> So at least for sparc you can assume that a something-->fdt translator
> is going to exist at some point in the future regardless of what
> happens here.
> 


Sounds like we have a winner.  I'll concentrate on that, thanks for
the heads up.
