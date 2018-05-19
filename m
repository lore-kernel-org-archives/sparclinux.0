From: "hch@lst.de" <hch@lst.de>
Date: Sat, 19 May 2018 06:38:57 +0000
Subject: Re: [PATCH 02/20] dma-mapping: provide a generic dma-noncoherent implementation
Message-Id: <20180519063857.GA18076@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180511075945.16548-1-hch@lst.de>
	<20180511075945.16548-3-hch@lst.de>
	<bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
	<0c5d27e9-2799-eb38-8b09-47a04c48b5c7@gmx.de>
In-Reply-To: <0c5d27e9-2799-eb38-8b09-47a04c48b5c7-Mmb7MZpHnFY@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Helge Deller <deller-Mmb7MZpHnFY@public.gmane.org>
Cc: "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org" <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, "linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org" <linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org>, "linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, James Bottomley <James.Bottomley-d9PhHud1JfjCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>, "linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org" <linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org>, "openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org" <openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org>, "green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-alpha-u79uwXL29TY@public.gmane.org>

On Fri, May 18, 2018 at 10:05:51PM +0200, Helge Deller wrote:
> This patch seems to fix the dma issues I faced on my 32bit B160L parisc box.
> 
> So it leaves only one open issue on parisc:
> Now every 32 bit parisc system is unnecessarily non-coherent.

I diagree with those comments, let me resend the refactored patch
to make it more clear.
