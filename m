From: David Miller <davem@davemloft.net>
Date: Wed, 24 Oct 2007 22:28:45 +0000
Subject: Re: arch/sparc64/kernel/iommu_common.c:237: error: implicit
Message-Id: <20071024.152845.07025481.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024211102.GA5842@keid.carnet.hr>
In-Reply-To: <20071024211102.GA5842@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Wed, 24 Oct 2007 23:11:02 +0200

> Hi,
> 
> Just tried 2.6.24-rc1... but:
> 
> arch/sparc64/kernel/iommu_common.c: In function 'prepare_sg':
> arch/sparc64/kernel/iommu_common.c:237: error: implicit declaration of function 'next_sg'
> cc1: warnings being treated as errors
> arch/sparc64/kernel/iommu_common.c:237: warning: assignment makes pointer from integer without a cast
> make[1]: *** [arch/sparc64/kernel/iommu_common.o] Error 1
> 
> The error looks like a simple typo - should this be sg_next(), like
> elsewhere in the file? It compiles the file when I replace that.

Yep, I tossed that fix to Jens last night, it should show up
in Linus's tree soon:

diff --git a/arch/sparc64/kernel/iommu_common.c b/arch/sparc64/kernel/iommu_common.c
index b70324e..efd5dff 100644
--- a/arch/sparc64/kernel/iommu_common.c
+++ b/arch/sparc64/kernel/iommu_common.c
@@ -234,7 +234,7 @@ unsigned long prepare_sg(struct scatterlist *sg, int nents)
 	dma_sg->dma_length = dent_len;
 
 	if (dma_sg != sg) {
-		dma_sg = next_sg(dma_sg);
+		dma_sg = sg_next(dma_sg);
 		dma_sg->dma_length = 0;
 	}
 
