Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F2AC2FF;
	Tue, 17 Feb 2026 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771348348; cv=none; b=nuLFwArDBHa3AcPFliBXle1SRP09r3bN1qzTyKS5K/fsJ45MyQhCtvg7xuxbrVhEQtFPVW6YvQ8P7QYwSoiTYyEN6l3QY2+kiUPKnBvlHgQfeq628CpmuBY4Jl7u7RIwPi6FgmzrXYKN6RV4o2mT+p3RljmEVXuFdz1iEK/AuB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771348348; c=relaxed/simple;
	bh=Ohk7JZfMGYVYHDbCAI2a01pLXMjZtqwC/Ifyi4pOclI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pv7ZWx9+Pd6DKA6CmxLYpE5brnloDqnhBYPcpIRBu0L/7UAg/oHTSIvAROZfYHT1LU8HlfpwoXE0Y+3w6J5hu5rBd/UFRGTr1HKOlD3jPQCZVxgNSZJt4zFTN50vDkb34cupqOKJEcE2+hfmrsnvmNxKN15MSuM3iI8mI2HRUdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=DawjNCp4; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="DawjNCp4"
From: stian@itx.no
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1771348345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZSHvxpn6bENLCn//lw0hG0Y52AylKINCwWDBfZmUuM=;
	b=DawjNCp4+LFDL9zrhVicTm6q/a3UHbCIzSEGfwuwpkZDCBVB+7xb6dpaVtgmv6ed1IG4Nz
	YH2uq4lpCh8dcLXVyDmkmiGNigMdtx/4t7R8Uk8yxiAY4jsSmgGtyBOOIJoB2FYQfNP2SK
	E5bYTMACRlWsT3qwqG2Iy3Y5ZXA9IGA=
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Stian Halseth <stian@itx.no>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Leon Romanovsky <leon@kernel.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] sparc: Fix page alignment in dma mapping
Date: Tue, 17 Feb 2026 18:10:19 +0100
Message-ID: <20260217171104.5643-3-stian@itx.no>
In-Reply-To: <60c8265afe8be501a9eb5c811c5b564b0842b156.camel@physik.fu-berlin.de>
References: <60c8265afe8be501a9eb5c811c5b564b0842b156.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stian Halseth <stian@itx.no>

'phys' may include an offset within the page, while 'base_paddr' is already
page-aligned. This caused incorrect DMA mapping in dma_4u_map_phys and
dma_4v_map_phys.

Fix both functions by masking phys with IO_PAGE_MASK or subtracting the
page offset, covering both generic SPARC code and sun4v.

Fixes: 38c0d0ebf520 ("sparc: Use physical address DMA mapping")
Reported-by: Stian Halseth <stian@itx.no>
Closes: https://github.com/sparclinux/issues/issues/75
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

