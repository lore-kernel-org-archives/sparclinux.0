Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C6633D6D8
	for <sparclinux@vger.kernel.org>; Tue, 27 Jan 2026 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769516228; cv=none; b=HMTAPWlQCuDw9Best1Dkj2G5Odo1rBqwXDv6AMpbSg0UMilJ1aJDNAF+AnTyy8TiTXi4McaxRRPmMziBlXr67XVYrWlJHJHE3dhloTlc0YkmVlQJkSr+2PWZ3gNfQH647HbB2L+wOrkX675u3l9t1634BseK881C6Rqd675aT84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769516228; c=relaxed/simple;
	bh=VLhAYRab+uCXbMXmi0FAQowbk8oZ+0XrtFLxtQv6uEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ic0HR6fL2cLkrZnnJy79Sxvo/w7z7kBzMBa941M/aHdoMPi5p217zMlqML1d1DdVymPVu0e7enKGpGTiSqrK0DZ+CjgDhUREWN/YaRawHjsn/n9kF+BixDUrX7ELCQycCf+CUAycctk1SqBeBn9kiWdDW7HQA1eH3cktmoHOr7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PPUTXLwM; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PPUTXLwM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769516225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9S/xSrdX3PQNdvGeiuAn8WfyMx/Wvh3tfYwOBKYci1k=;
	b=PPUTXLwMU1duEHyeudBnwMgqeL0QFNpFSjT+IpgiJrSgmVNwexEAjm3B23aqu5g9VcrKTg
	Aaw90cmNk5t7rMZujqg3RHg4NK585jt1GbWmBoHuCc2OwJwlcNbfr9XVJ72IPkS44CiySj
	6Y7MLvU/JazKo2G7NgIk8Lrczju32XY=
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
Subject: [PATCH v4 8/8] mm: make PT_RECLAIM depends on MMU_GATHER_RCU_TABLE_FREE
Date: Tue, 27 Jan 2026 20:13:01 +0800
Message-ID: <83b034810935a9ff18e425b085e065bb0acb28f3.1769515122.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1769515122.git.zhengqi.arch@bytedance.com>
References: <cover.1769515122.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Qi Zheng <zhengqi.arch@bytedance.com>

The PT_RECLAIM can work on all architectures that support
MMU_GATHER_RCU_TABLE_FREE, except for those that have selected
HAVE_ARCH_TLB_REMOVE_TABLE,so make PT_RECLAIM depends on
MMU_GATHER_RCU_TABLE_FREE && !HAVE_ARCH_TLB_REMOVE_TABLE.

BTW, change PT_RECLAIM to be enabled by default, since nobody should want
to turn it off.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 arch/x86/Kconfig | 1 -
 mm/Kconfig       | 9 ++-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 80527299f859a..0d22da56a71b0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -331,7 +331,6 @@ config X86
 	select FUNCTION_ALIGNMENT_4B
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
 	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
-	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
 	select ARCH_SUPPORTS_SCHED_SMT		if SMP
 	select SCHED_SMT			if SMP
 	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
diff --git a/mm/Kconfig b/mm/Kconfig
index 456e9eaedca39..1f3109b164d86 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1454,14 +1454,9 @@ config ARCH_HAS_USER_SHADOW_STACK
 config HAVE_ARCH_TLB_REMOVE_TABLE
 	def_bool n
 
-config ARCH_SUPPORTS_PT_RECLAIM
-	def_bool n
-
 config PT_RECLAIM
-	bool "reclaim empty user page table pages"
-	default y
-	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
-	select MMU_GATHER_RCU_TABLE_FREE
+	def_bool y
+	depends on MMU_GATHER_RCU_TABLE_FREE && !HAVE_ARCH_TLB_REMOVE_TABLE
 	help
 	  Try to reclaim empty user page table pages in paths other than munmap
 	  and exit_mmap path.
-- 
2.20.1

