From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 06 Jul 2010 10:17:33 +0000
Subject: Re: [PATCH 2/4] sparc: break out some prom device-tree building
Message-Id: <1278411453.1665.273.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <20100629193618.5a840b8e@dev.queued.net>
	<AANLkTilme2uAoXjorUEzam9j_xosR8kl70W8PS71d-Th@mail.gmail.com>
	<20100707040734.05d625af@debxo>
	<20100705.192221.241453945.davem@davemloft.net>
	<20100707051548.2c44f30c@debxo>
In-Reply-To: <20100707051548.2c44f30c@debxo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andres Salomon <dilinger-pFFUokh25LWsTnJN9+BGXg@public.gmane.org>
Cc: wmb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, pgf-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>


> Sounds like we have a winner.  I'll concentrate on that, thanks for
> the heads up.

Note that the conversion from OF -> fdt that powerpc does is a bit
"special". The code isn't quite a "wrapper" but almost. It shared pretty
much no symbols or variables with the rest of the kernel.

There are various reasons for that. It has to run -very- early, in fact,
before we do anything else at boot time, since we run off OF existing
environment (stack etc...) at at whatever address the kernel is loaded,
ie. before we relocate it down to 0.

To deal with that, we use compile/linker tricks to generate
pseudo-relocatable code (with limitations) and funny macros when
accessing global symbols.

In addition, we have various workarounds for powerpc specific
implementation issues (OF bugs, but also instanciating the IOMMU tables
on Power4, starting secondary CPUs and parking them in a wait loop,
etc...).

Thus I'm not sure there's that much benefit in trying to make that code
common with other archs, and possibly a lot of pain involved.

Cheers,
Ben.
 

