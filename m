From: "hch@lst.de" <hch@lst.de>
Date: Fri, 14 Dec 2018 12:21:49 +0000
Subject: Re: [PATCH 1/2] dma-mapping: zero memory returned from dma_alloc_*
Message-Id: <20181214122149.GA7309@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20181214082515.14835-1-hch@lst.de>
	<20181214082515.14835-2-hch@lst.de>
	<1544789518.3270.34.camel@synopsys.com>
In-Reply-To: <1544789518.3270.34.camel-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eugeniy Paltsev <eugeniy.paltsev-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: "linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org" <linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org>, "monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org" <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, "linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org" <linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org>, "linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org" <linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ashutosh.dixit-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashutosh.dixit-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org" <openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org>, "linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>

On Fri, Dec 14, 2018 at 12:12:00PM +0000, Eugeniy Paltsev wrote:
> Hi Christoph,
> 
> do you have any public git repository with all your dma changes?

Most of the tree show up in my misc.git repo for testing.

This series is here:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-alloc-always-zero

There current version of the DMA_ATTR_NON_CONSISTENT series is here:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-noncoherent-allocator.2


> I want to test them for ARC.

Thanks a lot!
