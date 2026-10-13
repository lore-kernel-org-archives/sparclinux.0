Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1797550E580;
	Tue, 13 Oct 2026 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898670; cv=none; b=UNI35MYRn17VrLs4AgbKIyYnKUbvCAUieuHAtZYX0cfPO6SlA0nlqJFWo1VyLcxgJgu0DccENGHelWvZIkjYfa7ENUpM6YzzpizopQ7+xzWlRlCNS/Ia7L1GZkJ7ijG8tqldTB5RBk/RebzuCiQ4fH3jJtFUpkwYcD51qECmNzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898670; c=relaxed/simple;
	bh=GlG8edv97We/CoHLCE4Q8YyrXgO7e6kjzdjflj7nWSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NKQ6b3Jt80XPk1wn+bGMXu+Sh3/PRxTgkx4SBuqb/k2dK8hjlu1r6+zQ99XK/1Ycto7amENZAa0ai/2qsmav7NxW88RygDjCxDHhg8T12zn0XkEN7OS7Vw2poUS6co2dwUH1C/ffgBBcztwJwRpcMlR+YO0/bi0bwovyt+kDioQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=o1mIPOIq; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="o1mIPOIq"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791898666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5yJANoPuUlL/fW+OAdGzUSdjIluVwHdP74wcXebJ6YY=;
	b=o1mIPOIq13WLafLA0zl2+CODeyij70KLkxj6n2zLMEdHp1SGA2GUJH6AEWR8fDOl7LQdSz
	LnnPuwXT9qp1lDrMdT8qcNB+hLHRlglK+L4ElfScjs1BLZ7JvJuYmuUKrpvPIfh0its3Qg
	YqdthW7AIRMzciZ/tG4qD9CNEC2c0RQ=
To: Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH] sparc64: Use relaxed ordering for DMA_FROM_DEVICE mappings on sun4v
Date: Tue, 13 Oct 2026 15:37:30 +0200
Message-ID: <20261013133731.1795299-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sun4v IOMMU and ATU mappings carry a relaxed ordering attribute, but
dma_4v_map_phys() and dma_4v_map_sg() set it only when the caller
passes DMA_ATTR_WEAK_ORDERING. Some network drivers do, storage drivers
do not. Without it every device write into memory is strictly ordered,
which on a T7-1 (M7) caps DMA reads at about 280 MiB/s per PCIe device
while writes run at full speed.

Set the attribute for every DMA_FROM_DEVICE streaming mapping. Devices
report completion through coherent memory or an interrupt, which stay
strictly ordered, and a strictly ordered write does not pass the writes
before it.

T7-1, fio 1M sequential read, QD32:

                      before        after
  NVMe (PM1725, x4)   281 MiB/s     3169 MiB/s
  SATA SSD (mpt3sas)  278 MiB/s      502 MiB/s

Closes: https://github.com/sparclinux/issues/issues/114
Signed-off-by: Stian Halseth <stian@itx.no>
---
Tested on a T7-1 (M7) and a T4-1:

- T7: fresh RAID1 on two NVMe drives, 192 GB fio crc32c write+verify
  and md check: no errors, mismatch_cnt 0.
- T7 and T4: file checksums on the SAS boot mirrors identical to a
  strictly ordered kernel; no new messages in dmesg.
- 4k random read and sequential writes unchanged.

 arch/sparc/kernel/pci_sun4v.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 61f14b4c8f90d..4dd17b65dd6cc 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -403,7 +403,7 @@ static dma_addr_t dma_4v_map_phys(struct device *dev, phys_addr_t phys,
 	if (direction != DMA_TO_DEVICE)
 		prot |= HV_PCI_MAP_ATTR_WRITE;
 
-	if (attrs & DMA_ATTR_WEAK_ORDERING)
+	if (direction == DMA_FROM_DEVICE || (attrs & DMA_ATTR_WEAK_ORDERING))
 		prot |= HV_PCI_MAP_ATTR_RELAXED_ORDER;
 
 	local_irq_save(flags);
@@ -503,7 +503,7 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 	if (direction != DMA_TO_DEVICE)
 		prot |= HV_PCI_MAP_ATTR_WRITE;
 
-	if (attrs & DMA_ATTR_WEAK_ORDERING)
+	if (direction == DMA_FROM_DEVICE || (attrs & DMA_ATTR_WEAK_ORDERING))
 		prot |= HV_PCI_MAP_ATTR_RELAXED_ORDER;
 
 	outs = s = segstart = &sglist[0];
-- 
2.43.0

