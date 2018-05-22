From: Christoph Hellwig <hch@lst.de>
Date: Tue, 22 May 2018 11:53:20 +0000
Subject: Re: [PATCH 04/20] arm-nommu: use generic dma_noncoherent_ops
Message-Id: <20180522115320.GA14530@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180511075945.16548-1-hch@lst.de>
	<20180511075945.16548-5-hch@lst.de>
	<20180511091114.GA16141@n2100.armlinux.org.uk>
In-Reply-To: <20180511091114.GA16141-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

On Fri, May 11, 2018 at 10:11:15AM +0100, Russell King - ARM Linux wrote:
> > +void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
> > +		size_t size, enum dma_data_direction dir)
> 
> Please no.  There is a lot of history of these (__dma_page_cpu_to_dev etc)
> functions being abused by out of tree drivers, because they think they
> know better.  This is stopped by making them static and ensuring that
> drivers have no access to these functions.
> 
> Please do not re-expose these to the global kernel.
> 
> While it may make things easier for a cross-architecture point of view,
> it makes it a lot easier for people to abuse these private APIs.

The point of this series, which isn't fully archived yet, is to
consolidate the direct mapping dma code, that is all dma_map_ops
instances except for iommus.  It is in fact in many ways modelled
after the ARM code.  For that we need the architectures to supply
the cache maintainance routines.

However, even if they now appear in dma-noncoherent.h they are NOT
and will NOT be exported, so using them directly from drivers won't
easily be possible.

I'll drop the arm-nommu patch for now, but I will pester your with this
again once arm is the last architecture not sharing the common code.

> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> According to speedtest.net: 8.21Mbps down 510kbps up
---end quoted text---
