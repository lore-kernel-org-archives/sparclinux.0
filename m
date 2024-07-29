Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2441984D10;
	Mon, 29 Jul 2024 06:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722235457; cv=none; b=eZyBuq9UnIfcJi5RRaQGzuDYtrPKPQ30Pgw0/W+px6mEoebWDPNthyCub6CIvJJqUYP++ibLrIKPNuuOcaM771BrBh78yyGyIOT+BMbyasteMPD8yHDcTxUkM9P7xTFD0PH4xWMSQF+mDsAxS5rDb/ytJkK9KYoaMLtUtPXPCzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722235457; c=relaxed/simple;
	bh=TBV9wTACyzpErDnIaeSoSzD9b2nZ0a3vathBCa0feuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y+Il+VwB136SuEDaDeVmp5CChAl8d8XWRWnn6b3xd2eZfGgoBLZf+9MpjQDoZZj20+TY5RQE+Uv2B0Abb3XGtgHoeA+w1hPfp0gahzBxBdGT4qhCO40SaYmG9gpMVfeiIWGHBKHO5ZoIqIfXoAEde+kv62v+tSq9T0SKblmHIyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbV7b53v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbV7b53v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E54AC32786;
	Mon, 29 Jul 2024 06:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722235456;
	bh=TBV9wTACyzpErDnIaeSoSzD9b2nZ0a3vathBCa0feuw=;
	h=From:To:Cc:Subject:Date:From;
	b=hbV7b53vH0exB1KWQBRZgD1Szrm+NtA1PoGFvK37J7Ad7eXYJmviGrDo0+NyKtrnG
	 xx6pFG4MN368Fu0uJLzlKZNwNNvo0rzu044GGQKX4wA7DiHgIuAcGH9D/PNvCoUMdc
	 JS9wPj4enjm15mJAY7kN4JdKalJuR6EIbu5dqS+mfXlTGmJ6Ir744GCJIHwZKlDjfa
	 LU02k8rjfgA1PykMAQnnLXeM1S/SSTiIc5fOaajwXByI3ujkkN2JqKwBLHOIApVS7q
	 tgtZADZiHRvKUioLxg0TW6gP9pqWauQCRDY9YGYvrmM9hCxJxJ47DRgP39BzDaq/Cz
	 YITFdlfEJD1fg==
From: alexs@kernel.org
To: "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Christian Brauner <brauner@kernel.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH] arch/sparc: remove unused varible paddrbase in function leon_swprobe()
Date: Mon, 29 Jul 2024 14:49:26 +0800
Message-ID: <20240729064926.3126528-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

commit f22ed71cd602 ("sparc32,leon: SRMMU MMU Table probe fix") change
return value from paddrbase to 'pte', but left the varible here.
That causes a build warning for this varible, so we may remove it.

make --keep-going CROSS_COMPILE=/home/alexs/0day/gcc-14.1.0-nolibc/sparc-linux/bin/sparc-linux- --jobs=16 KCFLAGS= -Wtautological-compare -Wno-error=return-type -Wreturn-type -Wcast-function-type -funsigned-char -Wundef -fstrict-flex-arrays=3 -Wformat-overflow -Wformat-truncation -Wrestrict -Wenum-conversion W=1 O=sparc ARCH=sparc defconfig SHELL=/bin/bash arch/sparc/mm/ mm/ -s
<stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
../arch/sparc/mm/leon_mm.c: In function 'leon_swprobe':
../arch/sparc/mm/leon_mm.c:42:32: warning: variable 'paddrbase' set but not used [-Wunused-but-set-variable]
   42 |         unsigned int lvl, pte, paddrbase;
      |                                ^~~~~~~~~

Signed-off-by: Alex Shi <alexs@kernel.org>
To: linux-kernel@vger.kernel.org
To: sparclinux@vger.kernel.org
To: Christian Brauner <brauner@kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
To: David S. Miller <davem@davemloft.net>
---
 arch/sparc/mm/leon_mm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/sparc/mm/leon_mm.c b/arch/sparc/mm/leon_mm.c
index ec61ff1f96b7..1dc9b3d70eda 100644
--- a/arch/sparc/mm/leon_mm.c
+++ b/arch/sparc/mm/leon_mm.c
@@ -39,12 +39,10 @@ unsigned long leon_swprobe(unsigned long vaddr, unsigned long *paddr)
 	unsigned int ctxtbl;
 	unsigned int pgd, pmd, ped;
 	unsigned int ptr;
-	unsigned int lvl, pte, paddrbase;
+	unsigned int lvl, pte;
 	unsigned int ctx;
 	unsigned int paddr_calc;
 
-	paddrbase = 0;
-
 	if (srmmu_swprobe_trace)
 		printk(KERN_INFO "swprobe: trace on\n");
 
@@ -73,7 +71,6 @@ unsigned long leon_swprobe(unsigned long vaddr, unsigned long *paddr)
 			printk(KERN_INFO "swprobe: pgd is entry level 3\n");
 		lvl = 3;
 		pte = pgd;
-		paddrbase = pgd & _SRMMU_PTE_PMASK_LEON;
 		goto ready;
 	}
 	if (((pgd & SRMMU_ET_MASK) != SRMMU_ET_PTD)) {
@@ -96,7 +93,6 @@ unsigned long leon_swprobe(unsigned long vaddr, unsigned long *paddr)
 			printk(KERN_INFO "swprobe: pmd is entry level 2\n");
 		lvl = 2;
 		pte = pmd;
-		paddrbase = pmd & _SRMMU_PTE_PMASK_LEON;
 		goto ready;
 	}
 	if (((pmd & SRMMU_ET_MASK) != SRMMU_ET_PTD)) {
@@ -124,7 +120,6 @@ unsigned long leon_swprobe(unsigned long vaddr, unsigned long *paddr)
 			printk(KERN_INFO "swprobe: ped is entry level 1\n");
 		lvl = 1;
 		pte = ped;
-		paddrbase = ped & _SRMMU_PTE_PMASK_LEON;
 		goto ready;
 	}
 	if (((ped & SRMMU_ET_MASK) != SRMMU_ET_PTD)) {
@@ -147,7 +142,6 @@ unsigned long leon_swprobe(unsigned long vaddr, unsigned long *paddr)
 			printk(KERN_INFO "swprobe: ptr is entry level 0\n");
 		lvl = 0;
 		pte = ptr;
-		paddrbase = ptr & _SRMMU_PTE_PMASK_LEON;
 		goto ready;
 	}
 	if (srmmu_swprobe_trace)
-- 
2.43.0

