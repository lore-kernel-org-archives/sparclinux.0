Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3A11FA8E7
	for <sparclinux@vger.kernel.org>; Wed, 11 Dec 2024 23:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733959699; cv=none; b=kZkOM0HmnxUua4sxdJzoRbvRiqeeCKg+iTgOYpmWBiuIfv0v3GCtLQrewraUK3wbkKO02cLd95/1vZ4IM4soZinLpyLZykiWsYKhbiP+QdoAdKCes1dWf0bf2sxcGKAHwQF4kuG8O/Sk5f/V+3kI7kY3lipO6UHIDZepnHBmx6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733959699; c=relaxed/simple;
	bh=/lMssxhouWcBXo7JAyWkdnKcOZ00wUnq0ZyKJQ3+mOI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=InYkIKg4F6udGaHjeBWPhF35EHAXkQMhuSdRpxqi0sQiDr/n8F1La9kX+AFuisSWKlLLV4dQR9i6noXdUsrEgm5UzN8v3NjCmeG1TJybiHbyWhNurbNE+TSsK5wXJCHUSMAeoC2Znk/TcnfDm1B8t2Fu8Y7GsPctwBnAmgFM33E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WPqaYw9L; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPqaYw9L"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-725e59e41d2so24096b3a.0
        for <sparclinux@vger.kernel.org>; Wed, 11 Dec 2024 15:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733959695; x=1734564495; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wxiw+xEGORRKxhtCLZq/pFo2CvQKmbacY9QkYe3JDdE=;
        b=WPqaYw9LUFgWq/usG611a2q5dJ+0bswcVHjB1VEsglst26pjGKbx5+yorenqrSUB6G
         /yJ+GAFbZqJezHNpTJF7PbdJrNVTRlJ90HUfg/lvJQQzpD/Hlh9CXsjfAdiuQeA9rCbk
         YeXFCsefU0C47ntB51g++MZP4Ip2kthpuRH9EnbeQlM9JdHJlF75GkRnZ6txe7r2BT6p
         P8y+XapmUAUxrHMQjTjKYEtTcuHJ1U7okLnDY3tXqc+VIFtcUTWWBvHjbNKrMY1LU59u
         +OKEhLfwKGs6p14i9t9f68Zyt4pDXXIrZ1dGIa12OUAuzA6psXV7I1kzhcK+k6hk8Y1/
         TZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733959695; x=1734564495;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxiw+xEGORRKxhtCLZq/pFo2CvQKmbacY9QkYe3JDdE=;
        b=Sd5a+adN5lBDir7sBflXNVie7l2RG02b3SbMxk3gF+ycra6i+gBAFMpqLD0clJr1f6
         7u28ovdO8nH8p7fsi848whf3nlgitxO9A5vEcKM3TieNlKQFg1Wm8pe27saIZxB7swBj
         Eh0ZSNNpah2E8i2awsl371eN7fiVUeJ55AvG0CeMZXJKDVlHgbIqnQzYak59dUmSFvgn
         8yGCAMrVC78l/3Kn5F7RZLHNycjmiA/4qry8MdKhr2jeDybvrMXky9aQ1ypcvsuIp/tM
         ykgc/+tyjoItV+cVj48zADJmrYsNTMMlMt2xlaknqv/dKmOjUghihRNWzZnzjxsDCe5G
         C5Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXwOSLdNinrXb13c0hpyaDwI6PmXM25iRgPb3fdVd9JRzR9ggp5+s9jPaWRCupj77FOjgXQYs5j3+pV@vger.kernel.org
X-Gm-Message-State: AOJu0YwPpTg7IkCIPBOToRHp/finDJ9/nZRSw/PRfqK2eO8XrtZormph
	fagxVuF/s2A4zVhS3GG54soXJ69J2Av2e6fwb6rrh2IaisSXRiXX2KtxDd0yODVQVV6/s3Xw9XE
	bt5OyF/Z6lHUPX5X6K/EZwA==
X-Google-Smtp-Source: AGHT+IF4fNavDkLG8tRoFUmw2gnTJz71oU9t6WKhM2RNFmEQvjdeJ2dIL8s2CnxPdes2eHu66I58PC2AE4yum4CFsw==
X-Received: from pgbdp11.prod.google.com ([2002:a05:6a02:f0b:b0:7fd:4c8f:e6a1])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:258a:b0:1e1:a829:bfb6 with SMTP id adf61e73a8af0-1e1cea52239mr1772079637.3.1733959695421;
 Wed, 11 Dec 2024 15:28:15 -0800 (PST)
Date: Wed, 11 Dec 2024 15:27:47 -0800
In-Reply-To: <20241211232754.1583023-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211232754.1583023-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241211232754.1583023-10-kaleshsingh@google.com>
Subject: [PATCH mm-unstable v2 09/16] mm: parisc: Introduce arch_align_mmap_hint()
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

Introduce parisc arch_mmap_hint() and define HAVE_ARCH_MMAP_HINT.
This is a preparatory patch, no functional change is introduced.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v2:
  - MAP_FIXED case is also handled in arch_mmap_hint() since this is just a
    special case of the hint addr being "enforced", per Yang Shi.
  - Consolidate error handling in arch_mmap_hint().

 arch/parisc/include/asm/pgtable.h |  1 +
 arch/parisc/kernel/sys_parisc.c   | 53 +++++++++++++++++--------------
 2 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index babf65751e81..73987357c78e 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -505,6 +505,7 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
+#define HAVE_ARCH_MMAP_HINT
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
index f852fe274abe..c1702d481e33 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -96,24 +96,16 @@ unsigned long mmap_upper_limit(struct rlimit *rlim_stack)
 
 enum mmap_allocation_direction {UP, DOWN};
 
-static unsigned long arch_get_unmapped_area_common(struct file *filp,
-	unsigned long addr, unsigned long len, unsigned long pgoff,
-	unsigned long flags, enum mmap_allocation_direction dir)
+unsigned long arch_mmap_hint(struct file *filp, unsigned long addr,
+			     unsigned long len, unsigned long pgoff,
+			     unsigned long flags)
 {
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma, *prev;
 	unsigned long filp_pgoff;
-	int do_color_align;
-	struct vm_unmapped_area_info info = {
-		.length = len
-	};
+	bool do_color_align;
 
 	if (unlikely(len > TASK_SIZE))
 		return -ENOMEM;
 
-	do_color_align = 0;
-	if (filp || (flags & MAP_SHARED))
-		do_color_align = 1;
 	filp_pgoff = GET_FILP_PGOFF(filp);
 
 	if (flags & MAP_FIXED) {
@@ -128,18 +120,33 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 		return addr;
 	}
 
-	if (addr) {
-		if (do_color_align)
-			addr = COLOR_ALIGN(addr, filp_pgoff, pgoff);
-		else
-			addr = PAGE_ALIGN(addr);
+	do_color_align = filp || (flags & MAP_SHARED);
 
-		vma = find_vma_prev(mm, addr, &prev);
-		if (TASK_SIZE - len >= addr &&
-		    (!vma || addr + len <= vm_start_gap(vma)) &&
-		    (!prev || addr >= vm_end_gap(prev)))
-			return addr;
-	}
+	if (do_color_align)
+		addr = COLOR_ALIGN(addr, filp_pgoff, pgoff);
+	else
+		addr = PAGE_ALIGN(addr);
+
+	return generic_mmap_hint(filp, addr, len, pgoff, flags);
+}
+
+static unsigned long arch_get_unmapped_area_common(struct file *filp,
+	unsigned long addr, unsigned long len, unsigned long pgoff,
+	unsigned long flags, enum mmap_allocation_direction dir)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long filp_pgoff;
+	bool do_color_align;
+	struct vm_unmapped_area_info info = {
+		.length = len
+	};
+
+	addr = arch_mmap_hint(filp, addr, len, pgoff, flags);
+	if (addr)
+		return addr;
+
+	filp_pgoff = GET_FILP_PGOFF(filp);
+	do_color_align = filp || (flags & MAP_SHARED);
 
 	info.align_mask = do_color_align ? (PAGE_MASK & (SHM_COLOUR - 1)) : 0;
 	info.align_offset = shared_align_offset(filp_pgoff, pgoff);
-- 
2.47.0.338.g60cca15819-goog

