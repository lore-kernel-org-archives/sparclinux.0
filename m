Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBC61A254E
	for <sparclinux@vger.kernel.org>; Mon, 30 Dec 2024 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549786; cv=none; b=Pqy6Lhzqgv9+P0pL2x/GWp0jsuqe+ZVonnVIouZreYoB68wCeWRb2uCffIrJuXUQkq8KCQvCCuLdXHL18T6p8qqmmF3wlijeK9ex2sMqwtfO1ASjKgy8d3zD9f49q77AVDxWGNivaJfCsa7h81aZLIw2ApF8Up2eFE83sw++hwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549786; c=relaxed/simple;
	bh=jiyynG1cSpqMCUPKcTsBXQhnImP0khzMQlCaAfJaSPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FGEs/Y4v2V6PaCP+3qzmng5hRYJ3ezksQ7HN/CkwupTjQoK4Qj2FyXFOXGrXo9we+2d5kUdqKq8oe01h9SnW6ntzmUv5gyjXjEmxr93uqtSZVTdoDuaCg2fOez+62XcZsAfeP/KU/lcF3wMxOqL7OteGwDM7dPSCFJJmUgluwQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fdipIao0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fdipIao0"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216395e151bso83725475ad.0
        for <sparclinux@vger.kernel.org>; Mon, 30 Dec 2024 01:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735549783; x=1736154583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYmLHVK0AtU6ilI7ucnXt5jLNeYE7S1uMrvnVL/VK/o=;
        b=fdipIao0MfSzxuzWBCZMky5alX88xvN/MbnJ7aPPBrjTGMYdonXH3cQrXGOHC5BHGE
         1CbLRJGaZxP1k1OqLK5kcQIBeZFLwaPeflUsR6iUfioW884T1x2GaElMYG8WcXvobHur
         qSyL2ak4CGHxE0+qkv3L3oZZwquzLAy7uhHSGY06u61YsJVW1GyrK7KB3k7iLma6kKHd
         /A7xHVXQyHnufhe1DeBAMI+ir7bl7aIUJ5Q9fy+XvlRUZnCk2K+cttwdro0r0LiMX0h1
         z1uBoeakBxn5ROMm17+siFl282KcIVBDdT0DWK2hUfV+gA1XeXj30OutE3Sw5VsybpCB
         af1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735549783; x=1736154583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYmLHVK0AtU6ilI7ucnXt5jLNeYE7S1uMrvnVL/VK/o=;
        b=hiz8xUx6qdIGui0KHpEnLa8R1jRgZ2tzaW9chyRc3bsTCg7tD5NcAv94iND3DQCpH7
         V2TCQXxt0OoklJGF0+Szq6glKxWzxk4n3sLnegUyszuLrJu1ogmSmX0/mzB7oVGJtnKR
         sihWWso7jgu9FklMxfJKUUMYasepHyLZyFjRGkoJNjCM3yKOHr4vLM55FetgexWouzyz
         kkt+qZvY/+wJjg6iQ2ulM9Ai8tcwbPfnqJcotyTGYMrITTvGlxw58H6FWyWgloPu8qNb
         pYrDDdHLux9TMsvniikqC/dgkUF5MjoDByO/HC21LVlHSl0qxYIOVTQBeZDc83KdZqOc
         yUIA==
X-Forwarded-Encrypted: i=1; AJvYcCVBz5G2XneC7GGVNWvHB+U2lKcJsRzDxDKzx/130ybVkTHvDwTKVVo8yGqRa/GBrjTwboJojvsJKf41@vger.kernel.org
X-Gm-Message-State: AOJu0YxXjlnWrYiMiXMzbiqjI23oDUqYHcoXamKEmnxG70GeHwRTPnOr
	TuWzKkhDztf2/XKt+Li3nFqzs1QxsBbrkF29ZKwiv+WG7rQTZZACt+DShaDw0rQ=
X-Gm-Gg: ASbGncujCxO2MMe0yOFcadUqVtnS0Akgoxvzz6vyhKQzF2V82bT8wCG9XwnunGqf1Lh
	miJ7NJ3618zK/vJm+gwAn9B0nWYg2oxVVKfLUbBjnKGKKusCUfguoy8vJHs6/XvFUGnx4BXHS4Q
	8Xn8Do6fEnrhRkCG38VVEh+6FM9w4h4CRVeddBl/It+UyUSX+PA7KgcrL6QU2nzsvc2HHPbNy3Y
	Lfc0+jLLp8dgPXywOnm2vuBUxD6i8ksFJwnyeDredmJlpNdjGHINvBgoeW/E3ORszlXMJ44lbWW
	GD9BrpXxYsl04FZ2ARAcRA==
X-Google-Smtp-Source: AGHT+IFA+DEWtAOVikEXL1Ne96u+hKYy4bbBxlgPSiON1NV20vNo54NDlhKj2iEhoHPJgNNx6Etn8w==
X-Received: by 2002:a17:903:2a87:b0:216:3f6e:fabd with SMTP id d9443c01a7336-219da5cc2d0mr588821545ad.7.1735549782882;
        Mon, 30 Dec 2024 01:09:42 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm17057841a12.4.2024.12.30.01.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 01:09:42 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
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
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 05/15] arm64: pgtable: use mmu gather to free p4d level page table
Date: Mon, 30 Dec 2024 17:07:40 +0800
Message-Id: <7c12112047ac230809aacd0379259414b9b0d3a3.1735549103.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1735549103.git.zhengqi.arch@bytedance.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like other levels of page tables, also use mmu gather mechanism to free
p4d level page table.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/pgalloc.h |  1 -
 arch/arm64/include/asm/tlb.h     | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 2965f5a7e39e3..1b4509d3382c6 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -85,7 +85,6 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgdp, p4d_t *p4dp)
 	__pgd_populate(pgdp, __pa(p4dp), pgdval);
 }
 
-#define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
 #else
 static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t p4dp, pgdval_t prot)
 {
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index a947c6e784ed2..445282cde9afb 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -111,4 +111,18 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 }
 #endif
 
+#if CONFIG_PGTABLE_LEVELS > 4
+static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4dp,
+				  unsigned long addr)
+{
+	struct ptdesc *ptdesc = virt_to_ptdesc(p4dp);
+
+	if (!pgtable_l5_enabled())
+		return;
+
+	pagetable_p4d_dtor(ptdesc);
+	tlb_remove_ptdesc(tlb, ptdesc);
+}
+#endif
+
 #endif
-- 
2.20.1

