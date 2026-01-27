Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E5831281F
	for <sparclinux@vger.kernel.org>; Tue, 27 Jan 2026 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769516182; cv=none; b=Qvz4J0A7shi30MFuv6DBoDLZHukhqlrVEUjkq9yKYPfamRtjf9KeTXa/78j/df1obJIaR70WeFc9vkUlyQuKEdr5VrpzLpQrf/En/ikDdNz9TVzJzYSXR4vL4gPn3aa2A1vQOfEAEI8IE+1pav6QBJcgSO/gtrEDshKpl0BKGKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769516182; c=relaxed/simple;
	bh=3/qOwLmLse1jcJWo7VdV7+8vsXqXlSzoLckIVTPe8NE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IsOc/jy18LkLNl9jw99GSTpCxvdevhea18YR4qAB8IuFXakiy88OaCi/7PpOfeyUZ6srecAYJOSegWrKwCD7R8MzUNGJCpesGMDi/tjcNd+FbI0dXw2AjHGWVJZhkWbEs+LdG/2Fp58yWGdxMWq2tj6NJEJVIIvPR0t2Qcp92YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=swOtWBA2; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="swOtWBA2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769516168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rw3Z5uz+wN/jKEhx+ggzBvOdjGW0IdrWnEXd8bGadDI=;
	b=swOtWBA2Pxw+VUT1PgETbtdgbPH5WgWUXEJQKmSqNUXZeFJybWNBgbHHDf61HMLS9e9X+A
	/UbuSve74Y3SLHsizfV5uZHvGuLEqftFCcCvnoYpdjbId1/fyXQalrb4sM1LqT6/gvYfsS
	kGfQpCcXFro2mJes4NEiytnYkfPcksE=
From: Qi Zheng <qi.zheng@linux.dev>
To: david@kernel.org,
	andreas@gaisler.com,
	richard.weiyang@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	dev.jain@arm.com,
	ioworker0@gmail.com,
	linmag7@gmail.com,
	akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-alpha@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-um@lists.infradead.org,
	sparclinux@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 0/8] enable PT_RECLAIM on more 64-bit architectures
Date: Tue, 27 Jan 2026 20:12:53 +0800
Message-ID: <cover.1769515122.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Qi Zheng <zhengqi.arch@bytedance.com>

Changes in v4:
 - convert __HAVE_ARCH_TLB_REMOVE_TABLE to CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE config
 - fix a WARN_ON_ONCE() on sparc64 (and on ppc)
   (reported by Andreas Larsson)
 - collect Acked-by (Hi David, I've kept your Acked-by, feel free to drop it)
 - rebase onto the v6.19-rc7

Changes in v3:
 - modify the commit message in [PATCH v3 1/7] (suggested by David Hildenbrand)
 - make PT_RECLAIM depends on MMU_GATHER_RCU_TABLE_FREE instead of 64BIT
 - collect Acked-by
 - rebase onto the next-20251217

Changelog in v2:
 - fix compilation errors (reported by Magnus Lindholm and kernel test robot)
 - adjust some code style (suggested by Huacai Chen)
 - make PT_RECLAIM user-unselectable (suggested by David Hildenbrand)
 - rebase onto the next-20251119

Hi all,

This series aims to enable PT_RECLAIM on more 64-bit architectures.

On a 64-bit system, madvise(MADV_DONTNEED) may cause a large number of empty PTE
page table pages (such as 100GB+). To resolve this problem, we need to enable
PT_RECLAIM, which depends on MMU_GATHER_RCU_TABLE_FREE.

For these architectures that define its own __tlb_remove_table(), since
their page tables are not of type struct ptdesc, they cannot be supported
PT_RECLAIM.

Therefore, this series first enables MMU_GATHER_RCU_TABLE_FREE on all 64-bit
architectures, then converts __HAVE_ARCH_TLB_REMOVE_TABLE to
CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE config, and finally makes PT_RECLAIM depend on
MMU_GATHER_RCU_TABLE_FREE && !HAVE_ARCH_TLB_REMOVE_TABLE. This way, PT_RECLAIM
can be enabled by default on most 64-bit architectures.

Of course, this will also be enabled on some 32-bit architectures that already
support MMU_GATHER_RCU_TABLE_FREE. That's fine, PT_RECLAIM works well on all
32-bit architectures as well. Although the benefit isn't significant, there's
still memory that can be reclaimed. Perhaps PT_RECLAIM can be enabled on all
32-bit architectures in the future.

Comments and suggestions are welcome!

Thanks,
Qi

Qi Zheng (8):
  mm: change mm/pt_reclaim.c to use asm/tlb.h instead of
    asm-generic/tlb.h
  alpha: mm: enable MMU_GATHER_RCU_TABLE_FREE
  LoongArch: mm: enable MMU_GATHER_RCU_TABLE_FREE
  mips: mm: enable MMU_GATHER_RCU_TABLE_FREE
  parisc: mm: enable MMU_GATHER_RCU_TABLE_FREE
  um: mm: enable MMU_GATHER_RCU_TABLE_FREE
  mm: convert __HAVE_ARCH_TLB_REMOVE_TABLE to
    CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE config
  mm: make PT_RECLAIM depends on MMU_GATHER_RCU_TABLE_FREE

 arch/alpha/Kconfig                   | 1 +
 arch/alpha/include/asm/tlb.h         | 6 +++---
 arch/loongarch/Kconfig               | 1 +
 arch/loongarch/include/asm/pgalloc.h | 7 +++----
 arch/mips/Kconfig                    | 1 +
 arch/mips/include/asm/pgalloc.h      | 7 +++----
 arch/parisc/Kconfig                  | 1 +
 arch/parisc/include/asm/tlb.h        | 4 ++--
 arch/powerpc/Kconfig                 | 1 +
 arch/powerpc/include/asm/tlb.h       | 1 -
 arch/sparc/Kconfig                   | 1 +
 arch/sparc/include/asm/tlb_64.h      | 1 -
 arch/um/Kconfig                      | 1 +
 arch/x86/Kconfig                     | 1 -
 include/asm-generic/tlb.h            | 2 +-
 mm/Kconfig                           | 8 +++-----
 mm/pt_reclaim.c                      | 2 +-
 17 files changed, 23 insertions(+), 23 deletions(-)

-- 
2.20.1

