From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Thu, 04 May 2006 16:39:48 +0000
Subject: [PATCH] sparc: show device name in /proc/dvma_map
Message-Id: <20060504163948.GC25582@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch will set the device name in a resource, which will be shown
in /proc/dvma_map.

Please apply. Thanks,
-- 
Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

--- 2.6.16-rc2/arch/sparc/kernel/ioport.c.orig	2006-05-04 16:32:12.000000000 +0100
+++ 2.6.16-rc2/arch/sparc/kernel/ioport.c	2006-05-04 16:34:56.000000000 +0100
@@ -274,6 +274,11 @@
 	if (mmu_map_dma_area(dma_addrp, va, res->start, len_total) != 0)
 		goto err_noiommu;
 
+	/* Set the resource name, if known. */
+	if (sdev) {
+		res->name = sdev->prom_name;
+	}
+
 	return (void *)res->start;
 
 err_noiommu:
