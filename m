From: Bob Breuer <breuerr@mc.net>
Date: Wed, 10 Nov 2004 03:18:56 +0000
Subject: Fix for HyperSPARC DMA errors
Message-Id: <419188A0.3010307@mc.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I found a solution for the HyperSPARC DMA problems in 2.6.  This allows
my SS20 with HyperSPARCs to boot to single user.  It's not efficient,
but I hope it points out whats needed for a proper fix.  Seems that the
iotlb entries need to flushed to ram or uncached since the iommu changes
between 2.5.60 and 2.5.70.

The second part seems to be needed to allow consistent sbus dma mappings
to be cached on HyperSPARC.  I have also tested this change on 2.4.27
with no noticeable difference.  Can anyone prove if it helps or hurts?

Bob


--- linux-2.6.9/arch/sparc/mm/iommu.c.orig	2004-10-18 16:55:29.000000000 -0500
+++ linux-2.6.9/arch/sparc/mm/iommu.c	2004-11-07 17:25:24.000000000 -0600
@@ -173,6 +173,7 @@ static u32 iommu_get_one(struct page *pa
  	}

  	iommu_viking_flush_iotlb(iopte0, npages);
+	flush_cache_all(); // hack to fix dma errors with hypersparc

  	return busa0;
  }
--- linux-2.6.9/arch/sparc/mm/srmmu.c.orig	2004-10-18 16:54:32.000000000 -0500
+++ linux-2.6.9/arch/sparc/mm/srmmu.c	2004-11-07 13:15:57.000000000 -0600
@@ -1463,6 +1463,7 @@ static void __init poke_hypersparc(void)
  static void __init init_hypersparc(void)
  {
  	srmmu_name = "ROSS HyperSparc";
+	srmmu_modtype = HyperSparc;

  	init_vac_layout();


