Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CC932F774;
	Wed,  7 Jan 2026 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767782548; cv=none; b=BMAYPJps3L2JT1P5QJqGg24v6bD0Xm5+OOzCWZAOZscYhfSxcqaBM8V2kU28YbIQT9yHL8zM5BgDqtj1BzxkoH83nExh0pH7SGsphOLcmuWTHCrlEkJukkgj1icGCIsiPIMon7eqye3gdH6CQLDwG/QUiL/umlHCCPsqbesxoqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767782548; c=relaxed/simple;
	bh=l3Mol18O1O3dGTzBtcAc8uE/dCFe/Q7JtlvbdQwtpcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SlyLs53a0c314pbcsyUoC41psptUb/fiJ7gmg3AbOFK0nWXGS/inkcaXCNwCKw4tEAbVvVouLCVTY898wD0Si/u76TDZVBjqT+oCN1j4/ysmkcEVdKAIBCxIWZEOf5FEzcgLKRKDr3rQ94h+natqEQaevKFm6Wm+5V7fgeQoWT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dM3Aij/h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dM3Aij/h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E0CC4CEF7;
	Wed,  7 Jan 2026 10:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767782547;
	bh=l3Mol18O1O3dGTzBtcAc8uE/dCFe/Q7JtlvbdQwtpcM=;
	h=From:To:Cc:Subject:Date:From;
	b=dM3Aij/hxvpsln3d9kZKfztgWjlc/yCCzdxhpzd3wRs3cWGm5J/RUd+Bxv5V8RiX5
	 ZiYCSMJa69C/MdU5S6q/wFOzfjfCxBJIaKOzx8NmkAPyqO1Hw2cJDyRcFDc3THxhYS
	 BlYKSbZXNLlFp4LLIccK02bHBmzEag1fYCcPI1GfidMUea5O9nZ8bV9vdPD5hbPpHj
	 K9nmsKBiKJjwYq4s6mPKm3P2FID1LBJYLlw4kfTagBgk28oBczcl9VrTT6pAdXZHtS
	 vOd0/tFKGoDyuOsoEI+/bRWUyX7wKnkfxlmP8joBuTKYCr39fyIuoS+PBpyhOnYx1g
	 d0RkYNKBrGpdA==
From: alexs@kernel.org
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org (open list:SPARC + UltraSPARC (sparc/sparc64)),
	linux-kernel@vger.kernel.org (open list)
Cc: Alex Shi <alexs@kernel.org>,
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
Subject: [PATCH v2] arch/sparc: fix unused variable warning
Date: Wed,  7 Jan 2026 18:41:44 +0800
Message-ID: <20260107104145.51416-1-alexs@kernel.org>
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

