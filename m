From: David Miller <davem@davemloft.net>
Date: Sun, 09 Dec 2018 04:57:53 +0000
Subject: Re: [PATCH 4/6] sparc: remove not required includes from dma-mapping.h
Message-Id: <20181208.205753.909472854043389455.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20181208174115.16237-1-hch@lst.de>
	<20181208174115.16237-5-hch@lst.de>
In-Reply-To: <20181208174115.16237-5-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hch-jcswGhMUV9g@public.gmane.org
Cc: linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ezequiel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, linux-mips-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, matwey-TTlVxmypnbovJsYlp49lxw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Christoph Hellwig <hch@lst.de>
Date: Sat,  8 Dec 2018 09:41:13 -0800

> The only thing we need to explicitly pull in is the defines for the
> CPU type.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David S. Miller <davem@davemloft.net>
