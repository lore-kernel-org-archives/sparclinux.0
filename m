From: Meelis Roos <mroos@linux.ee>
Date: Tue, 28 Aug 2018 10:30:50 +0000
Subject: Re: new SBus related DMA warnings in 4.18+git
Message-Id: <alpine.LRH.2.21.1808281330270.13945@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.21.1808260902280.22219@math.ut.ee>
	<20180827154716.GA30492@lst.de>
	<alpine.LRH.2.21.1808272203270.28446@math.ut.ee>
	<20180828092915.GC12488@lst.de>
In-Reply-To: <20180828092915.GC12488-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org

> Based on the other thread here is a new attempt:

  CC      arch/sparc/kernel/of_device_64.o
arch/sparc/kernel/of_device_64.c: In function =A1scan_one_device=A2:
arch/sparc/kernel/of_device_64.c:678:2: error: implicit declaration of func=
tion =A1DMA_BIT_MASK=A2 [-Werror=3Dimplicit-function-declaration]
  op->dev.coherent_dma_mask =3D DMA_BIT_MASK(32);
  ^
arch/sparc/kernel/of_device_64.c:679:24: error: =A1struct platform_device=
=A2 has no member named =A1dma_mask=A2
  op->dev.dma_mask =3D &op->dma_mask;
                        ^
arch/sparc/kernel/of_device_64.c:680:4: error: =A1struct platform_device=A2=
 has no member named =A1dma_mask=A2
  op->dma_mask =3D DMA_BIT_MASK(32);
    ^
cc1: all warnings being treated as errors
scripts/Makefile.build:307: recipe for target 'arch/sparc/kernel/of_device_=
64.o' failed


--=20
Meelis Roos (mroos@linux.ee)
