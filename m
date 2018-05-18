From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Fri, 18 May 2018 21:33:10 +0000
Subject: Re: dma_sync_*_for_cpu and direction=TO_DEVICE (was Re: [PATCH 02/20] dma-mapping: provide a generic
Message-Id: <20180518213309.GG17671@n2100.armlinux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20180511075945.16548-1-hch@lst.de>
	<20180511075945.16548-3-hch@lst.de>
	<bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
	<5ac5b1e3-9b96-9c7c-4dfe-f65be45ec179@synopsys.com>
	<20180518175004.GF17671@n2100.armlinux.org.uk>
	<182840dedb4890a88c672b1c5d556920bf89a8fb.camel@synopsys.com>
In-Reply-To: <182840dedb4890a88c672b1c5d556920bf89a8fb.camel-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>, "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org" <linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org>, "linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org" <linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org>, "Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org" <linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org>, "openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org" <openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org>, "green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, monstr@mons

On Fri, May 18, 2018 at 07:57:34PM +0000, Alexey Brodkin wrote:
> Hi Russel,

That's Russell.

> On Fri, 2018-05-18 at 18:50 +0100, Russell King - ARM Linux wrote:
> > It's necessary.  Take a moment to think carefully about this:
> > 
> >         dma_map_single(, dir)
> > 
> >         dma_sync_single_for_cpu(, dir)
> > 
> >         dma_sync_single_for_device(, dir)
> > 
> >         dma_unmap_single(, dir)
> > 
> > In the case of a DMA-incoherent architecture, the operations done at each
> > stage depend on the direction argument:
> > 
> >         map             for_cpu         for_device      unmap
> > TO_DEV  writeback       none            writeback       none
> > TO_CPU  invalidate      invalidate*     invalidate      invalidate*
> > BIDIR   writeback       invalidate      writeback       invalidate
> > 
> > * - only necessary if the CPU speculatively prefetches.
> 
> I think invalidation of DMA buffer is required on for_cpu(TO_CPU) even
> if CPU doesn't preferch - what if we reuse the same buffer for multiple
> reads from DMA device?

That's fine - for non-coherent DMA, the CPU caches will only end up
containing data for that memory if:
- the CPU speculatively fetches data from that memory, or
- the CPU explicitly touches that memory

> > The multiple invalidations for the TO_CPU case handles different
> > conditions that can result in data corruption, and for some CPUs, all
> > four are necessary.
> 
> I would agree that map()/unmap() a quite a special cases and so depending
> on direction we need to execute in them either for_cpu() or for_device()
> call-backs depending on direction.
> 
> As for invalidation in case of for_device(TO_CPU) I still don't see
> a rationale behind it. Would be interesting to see a real example where
> we benefit from this.

Yes, you could avoid that, but depending how you structure the
architecture implementation, it can turn out to be a corner case.
The above table is precisely how 32-bit ARM is implemented, because
the way we implement them is based on who owns the memory - the "map"
and "for_device" operations translate internally to a cpu-to-device
ownership transition of the buffer.  Similar for "unmap" and "to_cpu".
It basically avoids having to add additional functions at the lower
implementation levels.

> > Things get more interesting if the implementation behind the DMA API has
> > to copy data between the buffer supplied to the mapping and some DMA
> > accessible buffer:
> > 
> >         map             for_cpu         for_device      unmap
> > TO_DEV  copy to dma     none            copy to dma     none
> > TO_CPU  none            copy to cpu     none            copy to cpu
> > BIDIR   copy to dma     copy to cpu     copy to dma     copy to cpu
> > 
> > So, in both cases, the value of the direction argument defines what you
> > need to do in each call.
> 
> Interesting enough in your seond table (which describes more complicated
> case indeed) you set "none" for for_device(TO_CPU) which looks logical
> to me.
> 
> So IMHO that's what make sense:
> ---------------------------->8-----------------------------
>         map             for_cpu         for_device      unmap
> TO_DEV  writeback       none            writeback       none
> TO_CPU  none            invalidate      none            invalidate*
> BIDIR   writeback       invalidate      writeback       invalidate*
> ---------------------------->8-----------------------------

That doesn't make sense for the TO_CPU case.  If the caches contain
dirty cache lines, and you're DMAing from the device to the system
RAM, other system activity can cause the dirty cache lines to be
evicted (written back) to memory which the DMA has already overwritten.
The result is data corruption.  So, you really can't have "none" in
the "map" case there.

Given that, the "for_cpu" case becomes dependent on whether the CPU
speculatively prefetches.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
