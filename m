From: Meelis Roos <mroos@linux.ee>
Date: Thu, 04 Apr 2019 07:11:43 +0000
Subject: Re: 5.1-rc1: mpt init crash in scsi_map_dma, dma_4v_map_sg on sparc64
Message-Id: <f18f2366-677b-ae82-1865-f22e7087179e@linux.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <dbed1f7e-cf7b-0e87-841e-e4dd1eb1ed23@linux.ee>
	<20190403193609.GA23720@infradead.org>
In-Reply-To: <20190403193609.GA23720-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, MPT-FusionLinux.pdl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-scsi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

> I think this might have been this commit:
> 
> commit 24132a419c68f1d69eb8ecc91b3c80d730ecbb59
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Fri Feb 15 09:30:28 2019 +0100
> 
>      sparc64/pci_sun4v: allow large DMA masks
> 
> the patch below adds a few missing checks and hopefully should fix
> your problem.  If not can you try to revert the commit to check if
> my theory was correct to start with?
Yes, reverting this commit makes my T1000 boot.

-- 
Meelis Roos <mroos@linux.ee>
