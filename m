Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192931F8665
	for <sparclinux@vger.kernel.org>; Wed, 11 Dec 2024 23:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733959694; cv=none; b=O+Wz1GI+qWOuqqzaQDgXRn0ZmnF9PEjZwdY8PQnBh+PioKTzpnrLld5ds3JkpnhebdyfN0+Ozr6eCYdbcc4uE0TxfylERFXb2ZGP5SHd5RcVeLMJ6A4QbMNbWkSmkW6LUoej8CtjXwS95f4LkylDdyHLEDuRCWFNIoBURcYDgdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733959694; c=relaxed/simple;
	bh=WNz9MY3T4BNNlqu11Rf0CyS+w9rSVzKPgNdD4KY5WCw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tWD4zsb5ArQBV5mIXvg1snX0HLGMEbSEIAVKlMT48spfAmJR/z8/sVxU1onvf+gNzVqXGDSAMZvOeZ6FOiySvmdV4ve9FemLUkg+VSVmChdP+GMsZodDWQDbWdHsWE4IpNm/OQXrQ7ppfF5k2y0CI0I0ten6hzXRGrNeE7fdj2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UC15JYSD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UC15JYSD"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7f72112de23so35414a12.1
        for <sparclinux@vger.kernel.org>; Wed, 11 Dec 2024 15:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733959691; x=1734564491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SCptMPgkqno2A/YzE5Va18QE7zdNUHtEUd5zzpUozKw=;
        b=UC15JYSDAm2GAotOPsUvKMWvjsrHx/B4c0V3D/A8VAjwQSkTSK5fx2ddQiJR0tl6sA
         EhOcsuUVX2+2B4sZ6oOThtpyT0eAKig2mLU6I4v5pRaR3VRnrhWkMtED4XNIofeG4WVl
         vIZpD7XnZxnFb1/xFzVdVJS4XihMcjKmZGXAQFfphbNqt2yqlzoKzwWmzSpNaGLE2vKe
         C/cv1NStk2OzFNXE/PebL2BdbWFR1l4/YlI7Sho9RxXx+VVqhJAhb4KBggKY1fhWEPtO
         POvovPIund02i5CUq0xnNhJO5dehaFb1szn2a7S+6LSjBKAPHXWjMqqv1vjzkeSjfbno
         Pcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733959691; x=1734564491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SCptMPgkqno2A/YzE5Va18QE7zdNUHtEUd5zzpUozKw=;
        b=AJcecgpZT0qFOGU4EGNg1XdAKjVBY9zOvRTmDFygBcjUYzam22PPiVzxcGRzqnTCMy
         BGL+K9ljI2yJ6WfCzczD/H6H1xX4sfEJpWf4ZIwTre+qMsKICBsdX8KaXaZoJb4vH2Q4
         fx7pixqw+w7gYDe1pFFL9J6U/N054siMPx+DroB91ZGj17vqhBKr0iurTiMXUCTLJG0S
         WyTgHuXmui1V5ZmwLEYvWCKUdtezPMzbUPI2z24biFRtHnXzv8XJ3ipWSHO3C1LtxGaA
         rm1mi7UdZNFzZS6rubLCGDYCuIWWw3fAIw8lY5LgxkYzLdq9Q5+NG3RBa1R1333wu4oy
         ywJA==
X-Forwarded-Encrypted: i=1; AJvYcCVFQpBic8M5tjHlvfthjqZOfW8cpyeAApCoiA2j3cdysxiE9j8q+dHkvJSXZOhyWr2HPez/5oFrhsEI@vger.kernel.org
X-Gm-Message-State: AOJu0YzTN+C6/3rx/tVndpd+Q36PibKUxzWZCeP2MVf2e3TRaDKs59rb
	Q4gaEy9Y5ylmBwfwmdBzE4sUBNXTIx3gxG4MrVge5WC5AuqtK2RxHhZPDinK6gEP4JFZbGjhlaY
	1rCBKDwkR7Bqu5BGCO9Z5xg==
X-Google-Smtp-Source: AGHT+IFbvN9gPDak20G0G+YmM9pMBv8oAuiEUiRl+GFZxjvR/H2lZBtc+wP+WVSCEq90xAWHwKXzIcf2MC+rzJKWTA==
X-Received: from pfxa2.prod.google.com ([2002:a05:6a00:1d02:b0:725:c7de:e052])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:e306:b0:1db:e922:9eaf with SMTP id adf61e73a8af0-1e1ceb2e4dfmr1374719637.27.1733959691453;
 Wed, 11 Dec 2024 15:28:11 -0800 (PST)
Date: Wed, 11 Dec 2024 15:27:45 -0800
In-Reply-To: <20241211232754.1583023-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211232754.1583023-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241211232754.1583023-8-kaleshsingh@google.com>
Subject: [PATCH mm-unstable v2 07/16] mm: loongarch: Introduce arch_mmap_hint()
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, vbabka@suse.cz, yang@os.amperecomputing.com, 
	riel@surriel.com, david@redhat.com, minchan@kernel.org, jyescas@google.com
Cc: linux@armlinux.org.uk, tsbogend@alpha.franken.de, 
	James.Bottomley@HansenPartnership.com, ysato@users.sourceforge.jp, 
	dalias@libc.org, glaubitz@physik.fu-berlin.de, davem@davemloft.net, 
	andreas@gaisler.com, tglx@linutronix.de, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, chris@zankel.net, 
	jcmvbkbc@gmail.com, bhelgaas@google.com, jason.andryuk@amd.com, 
	leitao@debian.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, 
	kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce loongarch arch_mmap_hint() and define HAVE_ARCH_MMAP_HINT.
This is a preparatory patch, no functional change is introduced.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v2:
  - MAP_FIXED case is also handled in arch_mmap_hint() since this is just a
    special case of the hint addr being "enforced", per Yang Shi.
  - Consolidate error handling in arch_mmap_hint().

 arch/loongarch/include/asm/pgtable.h |  1 +
 arch/loongarch/mm/mmap.c             | 49 +++++++++++++++-------------
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index da346733a1da..326a6c4b7488 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -624,6 +624,7 @@ static inline long pmd_protnone(pmd_t pmd)
  */
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
+#define HAVE_ARCH_MMAP_HINT
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/loongarch/mm/mmap.c b/arch/loongarch/mm/mmap.c
index 914e82ff3f65..9e57bb27642f 100644
--- a/arch/loongarch/mm/mmap.c
+++ b/arch/loongarch/mm/mmap.c
@@ -17,15 +17,11 @@
 
 enum mmap_allocation_direction {UP, DOWN};
 
-static unsigned long arch_get_unmapped_area_common(struct file *filp,
-	unsigned long addr0, unsigned long len, unsigned long pgoff,
-	unsigned long flags, enum mmap_allocation_direction dir)
+unsigned long arch_mmap_hint(struct file *filp, unsigned long addr,
+			     unsigned long len, unsigned long pgoff,
+			     unsigned long flags)
 {
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	unsigned long addr = addr0;
-	int do_color_align;
-	struct vm_unmapped_area_info info = {};
+	bool do_color_align;
 
 	if (unlikely(len > TASK_SIZE))
 		return -ENOMEM;
@@ -45,22 +41,31 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 		return addr;
 	}
 
-	do_color_align = 0;
-	if (filp || (flags & MAP_SHARED))
-		do_color_align = 1;
+	do_color_align = filp || (flags & MAP_SHARED);
+
+	if (do_color_align)
+		addr = COLOUR_ALIGN(addr, pgoff);
+	else
+		addr = PAGE_ALIGN(addr);
+
+	return generic_mmap_hint(filp, addr, len, pgoff, flags);
+}
+
+static unsigned long arch_get_unmapped_area_common(struct file *filp,
+	unsigned long addr0, unsigned long len, unsigned long pgoff,
+	unsigned long flags, enum mmap_allocation_direction dir)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long addr = addr0;
+	bool do_color_align;
+	struct vm_unmapped_area_info info = {};
 
 	/* requesting a specific address */
-	if (addr) {
-		if (do_color_align)
-			addr = COLOUR_ALIGN(addr, pgoff);
-		else
-			addr = PAGE_ALIGN(addr);
-
-		vma = find_vma(mm, addr);
-		if (TASK_SIZE - len >= addr &&
-		    (!vma || addr + len <= vm_start_gap(vma)))
-			return addr;
-	}
+	addr = arch_mmap_hint(filp, addr, len, pgoff, flags);
+	if (addr)
+		return addr;
+
+	do_color_align = filp || (flags & MAP_SHARED);
 
 	info.length = len;
 	info.align_mask = do_color_align ? (PAGE_MASK & SHM_ALIGN_MASK) : 0;
-- 
2.47.0.338.g60cca15819-goog

