From: Meelis Roos <mroos@linux.ee>
Date: Thu, 04 Apr 2019 15:38:53 +0000
Subject: Re: 5.1-rc1: mpt init crash in scsi_map_dma, dma_4v_map_sg on sparc64
Message-Id: <7b11ce84-5b66-8fb4-d05f-85e07ef54635@linux.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <dbed1f7e-cf7b-0e87-841e-e4dd1eb1ed23@linux.ee>
	<20190403193609.GA23720@infradead.org>
	<f18f2366-677b-ae82-1865-f22e7087179e@linux.ee>
	<20190404140529.GA18649@infradead.org>
In-Reply-To: <20190404140529.GA18649-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, MPT-FusionLinux.pdl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-scsi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

>> Yes, reverting this commit makes my T1000 boot.
> 
> Does the patch attached to the last mail work as well?

Sorry for misreading your mail - tested now and yes, it works.

-- 
Meelis Roos
