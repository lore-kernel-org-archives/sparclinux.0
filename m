Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079AA1D7E33
	for <sparclinux@vger.kernel.org>; Tue, 10 Dec 2024 02:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798501; cv=none; b=GvfnNCZOkqeydYQbuc1XJmH1MKKxHljkwTzEzqlnxifR9GvEt7pNYE9hPLOppMFhM+S6RMY08t3UPTF6gmV6EydhdbOk/lp+Ksv6LbOYbITRhAHYF6c+w7tc/tFACCJsuNizjojtawcFPvLmxjUKUNvZ0nwauRNGDMQfF45pYao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798501; c=relaxed/simple;
	bh=jqs4liHINbUXCx3VZQbaX3q5Ukg9r2Vl+j0VT/phcys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UdejFbrLrDhyit40kxX9I5sxERfec0NjP2tq4C7Z2nW2vvoXwbByi1ZULAY54l2miY8AjddA1tnhBj1/HADkWkfagqrw/Kl28Ea3/WPHzXem1H/oaoipVHX9QYwBfoT9GWUj0KvGYmjb2uSst/yRiDDNQ6S0Ce0dA7J3eoXCFas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xscoi4nT; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xscoi4nT"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-725cf25d47bso2144714b3a.2
        for <sparclinux@vger.kernel.org>; Mon, 09 Dec 2024 18:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733798498; x=1734403298; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dnsK0Z+Vsck1DKfgwLToYEVTibYJ9G64XT5/R8jJ9Xw=;
        b=xscoi4nTRqQgcGGmfcKrCqKjKvP09VOI2PndKJb+rsZTRiWE1OmyLGv4nAwSMueLQ7
         tBOiBAhm+fRRfvseMEJiSVQQ7Mej6LJUrRi9vvDVXtnGrcfGLzalYHar87CKzozW7pGI
         BBIylLkZhzvsdqZYNw2tCKkMC2o73lRXRTZFo3WEHfNcnZWPdiGg6iRL7eWwRguYSq5l
         1SE1gT7qMUguCsItr0n4D6muHGSZ5eoU1aNgXHL4olErzDBTgas3bpbDGfYHojXe/QsM
         B6i14ADQJ8glIWvYOX28yIDC/OfWkT+b2H5TGr58AGut6t1yYEnteHDI9r3vTxigdhth
         ptmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733798498; x=1734403298;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dnsK0Z+Vsck1DKfgwLToYEVTibYJ9G64XT5/R8jJ9Xw=;
        b=wmbOTI1+FskdDW7DaMB5haRi/sfN50ZIfJG7xei2ODrPn3CZ6B93g0G+IuNy30AI6g
         OpQnJ4tESv0XJFOu7cZvO5REBdLqYCG937T1Ss+UjKOw27I99ak3jvAE3aByYB22t6e8
         k8VNhE6eYZuH6sQQnSSYObtGbe5bed4Y23LcWAwv28WqHk1AzelHQ0Yo5RasRy8sxJJQ
         /Iq4foDCMzmnsZkal8nULS5/iU0gdqN3Xq1ecwRimF9xtDpUtpS+/KxGMiSmQg6WQoQH
         aki0abWwychGXELDPkuRxV9vQdq8sWCRHRXR6zLfl2XCOa8tYgwTi9wnKKhAoKgZkO0a
         GTWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOMyex8rlgwNQAM4fMwucA+v2V0W2bboQDP6eP4A0Gzoek2sw87rFLzaoMtRS2bYL7lYQDA28D9jZ8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ZbsrvFXu7bTNVTZforc+jjQ8w1D6USNm1BvR7rasRfOr+mAI
	C/whJV8F0x0pp6sgKuMH+7x4dI2sCW1diVWnDiiJhkQmBNb4UBkI2jTBA7ksG0K0Y8yOV6pjvB/
	PGl4duWZiNLrK9fCwxlJo+A==
X-Google-Smtp-Source: AGHT+IEQiVamF/zzJ8w1wfz7OIeUdP3OCsWBSWfXEHphl91Ep+NYy7TdX+lfoJ5W29b7fSm/JmmQj8+pvlj7NXOkkQ==
X-Received: from pfbio2.prod.google.com ([2002:a05:6a00:8e02:b0:725:936f:c305])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7283:b0:1e0:d380:fe71 with SMTP id adf61e73a8af0-1e1b19d4512mr4863730637.0.1733798498297;
 Mon, 09 Dec 2024 18:41:38 -0800 (PST)
Date: Mon,  9 Dec 2024 18:41:10 -0800
In-Reply-To: <20241210024119.2488608-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210024119.2488608-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210024119.2488608-9-kaleshsingh@google.com>
Subject: [PATCH mm-unstable 08/17] mm: mips: Introduce arch_align_mmap_hint()
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, vbabka@suse.cz, yang@os.amperecomputing.com, 
	riel@surriel.com, david@redhat.com
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

Introduce mips arch_mmap_hint() and define HAVE_ARCH_MMAP_HINT.
This is a preparatory patch, no functional change is introduced.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/mips/include/asm/pgtable.h |  1 +
 arch/mips/mm/mmap.c             | 39 +++++++++++++++++++++------------
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index c29a551eb0ca..837f25624369 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -766,5 +766,6 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
  */
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
+#define HAVE_ARCH_MMAP_HINT
 
 #endif /* _ASM_PGTABLE_H */
diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
index 5d2a1225785b..cd09a933aad6 100644
--- a/arch/mips/mm/mmap.c
+++ b/arch/mips/mm/mmap.c
@@ -26,12 +26,31 @@ EXPORT_SYMBOL(shm_align_mask);
 
 enum mmap_allocation_direction {UP, DOWN};
 
+unsigned long arch_mmap_hint(struct file *filp, unsigned long addr,
+			     unsigned long len, unsigned long pgoff,
+			     unsigned long flags)
+{
+	int do_color_align = 0;
+
+	if (!addr)
+		return 0;
+
+	if (filp || (flags & MAP_SHARED))
+		do_color_align = 1;
+
+	if (do_color_align)
+		addr = COLOUR_ALIGN(addr, pgoff);
+	else
+		addr = PAGE_ALIGN(addr);
+
+	return generic_mmap_hint(filp, addr, len, pgoff, flags);
+}
+
 static unsigned long arch_get_unmapped_area_common(struct file *filp,
 	unsigned long addr0, unsigned long len, unsigned long pgoff,
 	unsigned long flags, enum mmap_allocation_direction dir)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
 	unsigned long addr = addr0;
 	int do_color_align;
 	struct vm_unmapped_area_info info = {};
@@ -54,23 +73,15 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 		return addr;
 	}
 
+	/* requesting a specific address */
+	addr = arch_mmap_hint(filp, addr, len, pgoff, flags);
+	if (addr)
+		return addr;
+
 	do_color_align = 0;
 	if (filp || (flags & MAP_SHARED))
 		do_color_align = 1;
 
-	/* requesting a specific address */
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
-
 	info.length = len;
 	info.align_mask = do_color_align ? (PAGE_MASK & shm_align_mask) : 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
-- 
2.47.0.338.g60cca15819-goog

