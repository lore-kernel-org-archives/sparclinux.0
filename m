From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 15 Dec 2018 06:30:18 +0000
Subject: Re: [PATCH 3/6] sparc: remove the sparc32_dma_ops indirection
Message-Id: <20181215063018.GA11415@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20181208174115.16237-1-hch@lst.de>
	<20181208174115.16237-4-hch@lst.de>
In-Reply-To: <20181208174115.16237-4-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, linux-mips-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, "Matwey V. Kornilov" <matwey-TTlVxmypnbovJsYlp49lxw@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sat, Dec 08, 2018 at 09:41:12AM -0800, Christoph Hellwig wrote:
> There is no good reason to have a double indirection for the sparc32
> dma ops, so remove the sparc32_dma_ops and define separate dma_map_ops
> instance for the different IOMMU types.
> 

Except maybe this:

scsi host0: esp
scsi host0: Data transfer overflow.
scsi host0: cur_residue[0] tot_residue[-36] len[36]
scsi 0:0:0:0: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
scsi target0:0:0: Beginning Domain Validation
scsi host0: Data transfer overflow.
scsi host0: cur_residue[0] tot_residue[-36] len[36]
scsi host0: Data transfer overflow.
scsi host0: cur_residue[0] tot_residue[-36] len[36]
scsi host0: Data transfer overflow.
scsi host0: cur_residue[0] tot_residue[-36] len[36]
scsi host0: Data transfer overflow.
scsi host0: cur_residue[0] tot_residue[-36] len[36]

and so on, until qemu is terminated. This is seen with all sparc32
qemu emulations. Reverting the patch fixes the problem.

Guenter
