Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17A331A81F
	for <sparclinux@vger.kernel.org>; Tue, 17 Feb 2026 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771341040; cv=none; b=nIsJ1r8PG2/slJMjE3bY1OFQaXr2YUiUZ6+TRK8OuVpqlGv0Wo9Y5ouRll0QXqSpF2iBv3L5rTcp23i31BO4+e8GmjvEQIry58FYZxQHnWJImyteT4DwSfpxQBifklN05QGtUDWqo0JK0WIzZ5AXb9YfuJ5nO0hTPqu2zBvLmCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771341040; c=relaxed/simple;
	bh=nOTvM5vlJeXK5bXAjx9iKKlKJWMXIwFgvz0n52OQFvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fr7Lj1MgQBzMHvBF6Qq6jFQq/0sU9T2O7EU6YauZHbn/5UXGQ5bsYlJMZXhMGp0PVzxOTz/hlaJfGi4hZ1ohuy1P7D3PVv4f/tgm3ok1ogB/tNkyMkDlRqt7JCmCf/po00MtV12Helr2Exkd7IKwLFvmazXaR1fY3J1xwvUaFYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=Ow7rCo2Q; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="Ow7rCo2Q"
From: stian@itx.no
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1771340658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyvFT+upt/5ueMH/lGBAjMmFW9Uk3oB3UsnT523OQYM=;
	b=Ow7rCo2Qpu8se8UBefL7oPhGvr+Lw2bv8IROt8FHY+1cBfMHqEDCwmZv5zEuLgcveD9Olt
	o+PtDDeSHsz3T0iOrSL5Y+rLroCqXQjoP7CFxE8KrNS3nNtUbeToR9nUOyqV9qZHSw+jl3
	IuR/r097OUHBWhBPTyNGP81y9chx7lE=
To: sparclinux@vger.kernel.org
Cc: iommu@lists.linux.dev,
	m.szyprowski@samsung.com,
	Stian Halseth <stian@itx.no>
Subject: [PATCH] sparc: iommu/pci_sun4v: fix page alignment in dma mapping
Date: Tue, 17 Feb 2026 16:03:51 +0100
Message-ID: <20260217150350.3541-2-stian@itx.no>
In-Reply-To: <7131d609-b083-4264-818a-21de38c1c3ed@samsung.com>
References: <7131d609-b083-4264-818a-21de38c1c3ed@samsung.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stian Halseth <stian@itx.no>

'phys' may include an offset within the page, while 'base_paddr' is already page-aligned.
This caused incorrect DMA mapping in dma_4u_map_phys and dma_4v_map_phys.

Fix both functions by masking phys with IO_PAGE_MASK or subtracting the page offset.

Fixes: 38c0d0ebf520 ("sparc: Use physical address DMA mapping")

Reported-by: Stian Halseth <stian@itx.no>
Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Stian Halseth <stian@itx.no>
---
 arch/sparc/kernel/iommu.c     | 2 ++
 arch/sparc/kernel/pci_sun4v.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 46ef88bc9c26..f3755a388ac7 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -312,6 +312,8 @@ static dma_addr_t dma_4u_map_phys(struct device *dev, phys_addr_t phys,
 	if (direction != DMA_TO_DEVICE)
 		iopte_protection |= IOPTE_WRITE;
 
+	phys -= offset_in_page(phys);
+
 	for (i = 0; i < npages; i++, base++, phys += IO_PAGE_SIZE)
 		iopte_val(*base) = iopte_protection | phys;
 
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 791f0a76665f..2f30eeac4861 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -411,7 +411,7 @@ static dma_addr_t dma_4v_map_phys(struct device *dev, phys_addr_t phys,
 	iommu_batch_start(dev, prot, entry);
 
 	for (i = 0; i < npages; i++, phys += IO_PAGE_SIZE) {
-		long err = iommu_batch_add(phys, mask);
+		long err = iommu_batch_add(phys & IO_PAGE_MASK, mask);
 		if (unlikely(err < 0L))
 			goto iommu_map_fail;
 	}
-- 
2.53.0

