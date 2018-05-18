From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Date: Fri, 18 May 2018 20:35:08 +0000
Subject: Re: dma_sync_*_for_cpu and direction=TO_DEVICE (was Re: [PATCH 02/20] dma-mapping: provide a generic
Message-Id: <cecfe6bd-ef1f-1e25-bfcf-992d1f828efb@synopsys.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180511075945.16548-1-hch@lst.de>
	<20180511075945.16548-3-hch@lst.de>
	<bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
	<5ac5b1e3-9b96-9c7c-4dfe-f65be45ec179@synopsys.com>
	<20180518175004.GF17671@n2100.armlinux.org.uk>
In-Reply-To: <20180518175004.GF17671-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>, "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org" <linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org>, "linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org" <linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org>, "linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org" <linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org>, "openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org" <openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org>, "green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org" <monst>

On 05/18/2018 10:50 AM, Russell King - ARM Linux wrote:
> On Fri, May 18, 2018 at 10:20:02AM -0700, Vineet Gupta wrote:
>> I never understood the need for this direction. And if memory serves me
>> right, at that time I was seeing twice the amount of cache flushing !
> It's necessary.  Take a moment to think carefully about this:
>
> 	dma_map_single(, dir)
>
> 	dma_sync_single_for_cpu(, dir)
>
> 	dma_sync_single_for_device(, dir)
>
> 	dma_unmap_single(, dir)

As an aside, do these imply a state machine of sorts - does a driver needs =
to=20
always call map_single first ?

My original point of contention/confusion is the specific combinations of A=
PI and=20
direction, specifically for_cpu(TO_DEV) and for_device(TO_CPU)

Semantically what does dma_sync_single_for_cpu(TO_DEV) even imply for a non=
 dma=20
coherent arch.
Your tables below have "none" for both, implying it is unlikely to be a rea=
l=20
combination (for ARM and ARC atleast).

The other case, actually @dir TO_CPU, independent of for_{cpu, device}=C2=
=A0 implies=20
driver intends to touch it after the call, so it would invalidate any stray=
 lines,=20
unconditionally (and not just for speculative prefetch case).


> In the case of a DMA-incoherent architecture, the operations done at each
> stage depend on the direction argument:
>
> 	map		for_cpu		for_device	unmap
> TO_DEV	writeback	none		writeback	none
> TO_CPU	invalidate	invalidate*	invalidate	invalidate*
> BIDIR	writeback	invalidate	writeback	invalidate
>
> * - only necessary if the CPU speculatively prefetches.
>
> The multiple invalidations for the TO_CPU case handles different
> conditions that can result in data corruption, and for some CPUs, all
> four are necessary.

Can you please explain in some more detail, TO_CPU row, why invalidate is=20
conditional sometimes.
