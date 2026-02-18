Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2C42F6591;
	Wed, 18 Feb 2026 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771416165; cv=none; b=A2hEuTAPv7wnUC4PPuQ2OZA0uX0K3V0mRLo7iKZNnhls9jus1apKN/stAICf346URbDb1qcxXuBwhy5AbMN1cRK8+QtRsOGGyO34hXlEPHhS6ihMDHhGarxXMC24OmJL8RhHkmw2sdaJxqgKGb+2zmQvlOnI3SU3JfvEw9gRZ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771416165; c=relaxed/simple;
	bh=lFVcKWp7lydqdzf2fycmrgJTC3hAP/pyYAFfQTkreao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G+GlkUKNK4XMrDAOo/kQkvQhBHy99FbtBwmxGmTKixCaJFqq+BDDlnyJqRyG+3CxChi7SBF5jlvpOrAWD0/Ar0NkzMK0r2mMztfKAOi5RVikndqxxlh2HpX5vCdJ9z8vVStdwDMtFuJi9whYfMB3iml+WmsCgXYnyrvlYey1yGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=TrhCyfh+; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="TrhCyfh+"
From: stian@itx.no
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1771416162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YceTr2EILPmfYE2DJGVNspLLsigq/xxpHiCraazo8xc=;
	b=TrhCyfh+isMfpP8qmLUfteE5t2uwdHhpkyFQxMRJksu1eZie0FIpo+9p+jobvdDo1P/iCp
	mkMbErYuRQToE/cdyTVyswLJZJ7KeeKWNlyDdyIPvoGHyKFWlQMgcSpBJBIXbsudr50M7m
	3EU/juLv2auFF9ft2vZ9V7ILp59oXEE=
To: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stian Halseth <stian@itx.no>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH v3] sparc: Fix page alignment in dma mapping
Date: Wed, 18 Feb 2026 13:00:24 +0100
Message-ID: <20260218120056.3366-2-stian@itx.no>
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
Changelog:
v3:
- Use IO_PAGE_MASK for alignment in both dma_4u_map_phys and dma_4v_map_phys
- Align phys before the loop in pci_sun4v.c
- Drop masking inside iommu_batch_add()

v2: https://lore.kernel.org/all/20260217171104.5643-3-stian@itx.no/
- Add Fixes tag
- Add Closes tag
- Trim commit message to 80-column lines
- Remove newlines
- Subject: Remove the "iommu/pci_sun4v:" (generic sparc patch, not specific to sun4v)

v1: https://lore.kernel.org/all/20260217150350.3541-2-stian@itx.no/ 
---
 arch/sparc/kernel/iommu.c     | 2 ++
 arch/sparc/kernel/pci_sun4v.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 46ef88bc9c26..7613ab0ffb89 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -312,6 +312,8 @@ static dma_addr_t dma_4u_map_phys(struct device *dev, phys_addr_t phys,
 	if (direction != DMA_TO_DEVICE)
 		iopte_protection |= IOPTE_WRITE;
 
+	phys &= IO_PAGE_MASK;
+
 	for (i = 0; i < npages; i++, base++, phys += IO_PAGE_SIZE)
 		iopte_val(*base) = iopte_protection | phys;
 
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 791f0a76665f..58ca4148f86b 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -410,6 +410,8 @@ static dma_addr_t dma_4v_map_phys(struct device *dev, phys_addr_t phys,
 
 	iommu_batch_start(dev, prot, entry);
 
+	phys &= IO_PAGE_MASK;
+
 	for (i = 0; i < npages; i++, phys += IO_PAGE_SIZE) {
 		long err = iommu_batch_add(phys, mask);
 		if (unlikely(err < 0L))
-- 
2.53.0

