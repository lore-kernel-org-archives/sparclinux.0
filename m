Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94796207A32;
	Wed,  7 Jan 2026 06:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768147; cv=none; b=h9JMr/CGcoSMR9giJe32rP+0/kH50TnBxmzIqXU1fi/H0539oYnsMnTJqBiM9PaA0vaGNzNhOyVm9Q2xaScbIb51HbFrY3D+iBYDCabaddy69kDRajfrnUwXEBikjCDZ95R4WJ4TbEXo/1u87daTPOHzZER5PiVpBC16hTuMOA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768147; c=relaxed/simple;
	bh=l3Mol18O1O3dGTzBtcAc8uE/dCFe/Q7JtlvbdQwtpcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g0VEmfLwyXvRqKbV8ShST22ho+6OYaRnEj2mNOYXl/YdivV3Ap8Mgum98wgSEsqwz5YIO7AQldHvCVB+i5Q6aW9MfXq4y/B1XP/M4dSkNs1fIRcPhfPMZHxa+vosuyr2JbcHwTpGRJF/Rk//K000g8CSArvVPmnZduKD3JQgqlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gizqjOMv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gizqjOMv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C8FC4CEF7;
	Wed,  7 Jan 2026 06:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767768147;
	bh=l3Mol18O1O3dGTzBtcAc8uE/dCFe/Q7JtlvbdQwtpcM=;
	h=From:To:Cc:Subject:Date:From;
	b=gizqjOMvvlQwYHworxcZsDHD2u/nZbsSB1pNde8rgonMp5wEE10PLrfsDllXeS/lv
	 k8wlTrpFB+NL+QwuXjZBPn6H1EvMLdlkCix47fr4JXU8MLt04thfR17X5V2zdFqm5g
	 2Kfh4JLEyJdilA/+gjc6UUqFdi/tpHQrfwv3zEPZ9UyCWV7gm2XYoSC4Qumy6CFPmQ
	 T56DdJzp4bqBWUOLrndK+/S/EsBF/KVkEA2obVON3NoSzm5l4nAye2BlXtdX6gmbLT
	 HZ/BPO/Ero+QbPKOGmHvI9QXFLHQFZMB0vvrkTurRH6Tcc0OAv4QuRObh5ly6toSAr
	 uYIsBKVI/j07w==
From: alexs@kernel.org
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org (open list:SPARC + UltraSPARC (sparc/sparc64)),
	linux-kernel@vger.kernel.org (open list)
Cc: linux-kernel@vger.kernel.org,
	Alex Shi <alexs@kernel.org>,
	kernel test robot <lkp@intel.com>,
	sparclinux@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Zi Yan <ziy@nvidia.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] arch/sparc: fix unused vaiable warning error
Date: Wed,  7 Jan 2026 14:42:08 +0800
Message-ID: <20260107064209.15461-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

   arch/sparc/mm/init_64.c: In function 'arch_hugetlb_valid_size':
   arch/sparc/mm/init_64.c:361:24: warning: variable 'hv_pgsz_idx' set but not used [-Wunused-but-set-variable]
     361 |         unsigned short hv_pgsz_idx;
         |                        ^~~~~~~~~~~

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: sparclinux@vger.kernel.org
Cc: Matthew Wilcox  <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Mike Rapoport  <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: David S. Miller <davem@davemloft.net>
---
 arch/sparc/mm/init_64.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index df9f7c444c39..ba19d23d4040 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -358,30 +358,24 @@ static void __init pud_huge_patch(void)
 bool __init arch_hugetlb_valid_size(unsigned long size)
 {
 	unsigned int hugepage_shift = ilog2(size);
-	unsigned short hv_pgsz_idx;
 	unsigned int hv_pgsz_mask;
 
 	switch (hugepage_shift) {
 	case HPAGE_16GB_SHIFT:
 		hv_pgsz_mask = HV_PGSZ_MASK_16GB;
-		hv_pgsz_idx = HV_PGSZ_IDX_16GB;
 		pud_huge_patch();
 		break;
 	case HPAGE_2GB_SHIFT:
 		hv_pgsz_mask = HV_PGSZ_MASK_2GB;
-		hv_pgsz_idx = HV_PGSZ_IDX_2GB;
 		break;
 	case HPAGE_256MB_SHIFT:
 		hv_pgsz_mask = HV_PGSZ_MASK_256MB;
-		hv_pgsz_idx = HV_PGSZ_IDX_256MB;
 		break;
 	case HPAGE_SHIFT:
 		hv_pgsz_mask = HV_PGSZ_MASK_4MB;
-		hv_pgsz_idx = HV_PGSZ_IDX_4MB;
 		break;
 	case HPAGE_64K_SHIFT:
 		hv_pgsz_mask = HV_PGSZ_MASK_64K;
-		hv_pgsz_idx = HV_PGSZ_IDX_64K;
 		break;
 	default:
 		hv_pgsz_mask = 0;
-- 
2.43.0

