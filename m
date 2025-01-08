Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E931C1A9B35
	for <sparclinux@vger.kernel.org>; Wed,  8 Jan 2025 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319588; cv=none; b=QQ78fc/gqTU8iWdHblemHp4liFQR7X5dX6r6ScqfpszpIWpPfK5hps9c+4IRyvJan1v7UMKPXJ/isBoiH8FxvZ6DDzQoBMoHghbEwY80+7joi9ky+S+nQ1mNYDVL1NCWV/A8YNAoIZbHkNJJLXj/e/YsURrR4LrcHzdBKg9wA/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319588; c=relaxed/simple;
	bh=ma5h64nM92pGVw8WsUJDDYGPNfXZFgLftucZEsbzZpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IGK6gBUL6pOMdP4AUYxJ52glh490rbiwFwA1QvYih7CK13mPh6usEEsshlUM0MN/5FSvKqBtSdpCGX4I836npmnJ+UxagBuecjROebHkWyrHAWDkvDuEIznanajN3hl/MHNY6U+Mp21zyTUjveSU5q2coXebPCVuGfnUW0oQT1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lkjsf6mt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lkjsf6mt"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216395e151bso7101885ad.0
        for <sparclinux@vger.kernel.org>; Tue, 07 Jan 2025 22:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319586; x=1736924386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgpljFzcR37DW+k0izImY02NXJU+2N4CamZhPf6BMmU=;
        b=lkjsf6mtx7iieDBNQgHtDsNwfH81+Ahx5znscEAY+uMyGeqVwDbxKilg3fHzJFKf7m
         yyZZ7rtjWp0OBVs0551xO1oX49k2Oy9EQMjn5paprIo8V/l6Yy5iT6s9+oCibH4HIooX
         31HtOM0khddPN9cF0IM7JQ96jiBOW7NVDLoFWud+rNan94G1yv//xmjhloxmIF8XRxhm
         AEouloJS4x6ju49vfHa+FORb2R7BT80AgfdZjVlEvUA4SMjvzUUAK93CguXuZ6a55P1A
         ZALeoJVB36ib9+/NtHSGuMIWrm0PG9Xjbzz1sB9Ynbww8v5X85/P8EQZcFSLqhbymKos
         VSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319586; x=1736924386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgpljFzcR37DW+k0izImY02NXJU+2N4CamZhPf6BMmU=;
        b=cKST3KV+wrwxV1+8fvCNmVmrs7yndb/+opZU0o8INk8xt4zQIhQ8gsq1Csh1h681LA
         QR8wVzq+sY5VoO1aG7SOQYi8nohr3cfqvebILY8rLQ86XGhvxTctQCXkpHB0gevERMwY
         Qqf9pGeze0vUgqi2k8bd5GIrXihXW3Xlag4HmWqSVgTJiiRCxrc7wHQh4ZS4V0wSyDGA
         zuw8geYsl+Rkmufg7virq9SlgFThWned7ugMR0/bw9PlhxkTkz2s0naW5a4sAkNCzixJ
         OrQDZs0LJxSBe49POwPdaNaJ6rbofev6QRrWu1t/2ej06KfHTUPc4A8VM8yfxAD/0h5r
         RB2g==
X-Forwarded-Encrypted: i=1; AJvYcCULUPisF4cdtH3zDHROgOwXP0HxDhsaVmOFM3aCWUNYPQqY6aX+h+GuqV5Xo++Ie8umqRiieMiAmtjt@vger.kernel.org
X-Gm-Message-State: AOJu0YxzeHPw5KG5BS52FQZAGXQtuI/nrNOTARjcStIjWoMmUzgBgO5n
	2Z3CMXBR7TAXc5k+yB0zhq8sJOjUSmFu2AqbMotDOZhw6u13yz+ST9oTRN4sZbg=
X-Gm-Gg: ASbGncusVFwsHu2xkah7wTH5UyTeuNQzrqP8mxRmtHfzFoLWg7sDrBHWGjuKhrDv+OW
	gGLnNAeif9mEsx7BC4lTm0OVj5qBB8bUuw3ROBbvlyoiWnmwva9K7VsbLRm9BdFTHLJJHmdAR8Y
	UzR0pJE60r3gKbqrYSf4v2EM6N3wvAFvqdiaT9EV/M7l45g5Sth8Aowdo1ju5gQuAT7LrNoSIkG
	NalaW450SR0bj3g9V+VpyREGvd83EJIQ9f1ROyRLlwlDafnto2QR+fGJCcfcfQ5rpkC8v8bdBDH
	zLRhXFT2cs5eAn35xsUONQzrLRI=
X-Google-Smtp-Source: AGHT+IEXmx6aGyXUatDDUSC3BIwwvJRBe2xxgGmNdG6bwRG2a4u7PgHO01+qr8GDOf9tBGHx3RRkKg==
X-Received: by 2002:a17:902:fc4d:b0:216:5db1:5dc1 with SMTP id d9443c01a7336-21a83bb9991mr32206305ad.1.1736319586298;
        Tue, 07 Jan 2025 22:59:46 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.22.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 22:59:45 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	alex@ghiti.fr,
	andreas@gaisler.com,
	palmer@dabbelt.com,
	tglx@linutronix.de,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	yuzhao@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org,
	rientjes@google.com,
	vishal.moola@gmail.com,
	arnd@arndb.de,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	ryan.roberts@arm.com
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arch@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v5 02/17] riscv: mm: Skip pgtable level check in {pud,p4d}_alloc_one
Date: Wed,  8 Jan 2025 14:57:18 +0800
Message-Id: <93a1c6bddc0ded9f1a9f15658c1e4af5c93d1194.1736317725.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1736317725.git.zhengqi.arch@bytedance.com>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kevin Brodsky <kevin.brodsky@arm.com>

{pmd,pud,p4d}_alloc_one() is never called if the corresponding page
table level is folded, as {pmd,pud,p4d}_alloc() already does the
required check. We can therefore remove the runtime page table level
checks in {pud,p4d}_alloc_one. The PUD helper becomes equivalent to
the generic version, so we remove it altogether.

This is consistent with the way arm64 and x86 handle this situation
(runtime check in p4d_free() only).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgalloc.h | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index f52264304f772..8ad0bbe838a24 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -12,7 +12,6 @@
 #include <asm/tlb.h>
 
 #ifdef CONFIG_MMU
-#define __HAVE_ARCH_PUD_ALLOC_ONE
 #define __HAVE_ARCH_PUD_FREE
 #include <asm-generic/pgalloc.h>
 
@@ -88,15 +87,6 @@ static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd,
 	}
 }
 
-#define pud_alloc_one pud_alloc_one
-static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
-{
-	if (pgtable_l4_enabled)
-		return __pud_alloc_one(mm, addr);
-
-	return NULL;
-}
-
 #define pud_free pud_free
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 {
@@ -118,15 +108,11 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 #define p4d_alloc_one p4d_alloc_one
 static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	if (pgtable_l5_enabled) {
-		gfp_t gfp = GFP_PGTABLE_USER;
-
-		if (mm == &init_mm)
-			gfp = GFP_PGTABLE_KERNEL;
-		return (p4d_t *)get_zeroed_page(gfp);
-	}
+	gfp_t gfp = GFP_PGTABLE_USER;
 
-	return NULL;
+	if (mm == &init_mm)
+		gfp = GFP_PGTABLE_KERNEL;
+	return (p4d_t *)get_zeroed_page(gfp);
 }
 
 static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
-- 
2.20.1

