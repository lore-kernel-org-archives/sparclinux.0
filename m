Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B310D200114
	for <sparclinux@vger.kernel.org>; Wed, 11 Dec 2024 23:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733959711; cv=none; b=bane6QSAtUCFSXUl2+eAI4a2VkOV9qMcj9dtvC9ceEEjIsw/z4pprGVix7N+lSQCtydzI7vQAx67NCisUJt5cz3XSQDl0mJ6Fc8JxbGt4MuBAQKakvzzPr8WxtLNkvV6vz/HrHtq3eVMvCOZKJY0OY3wROmGkd4N6+kb2ZfcTzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733959711; c=relaxed/simple;
	bh=MlGm5TTjfr6vCXVALZb0EK8yBbfELhsbFEVcKacrZbw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NiT8Jv83woXKj/mME04P2JXHhH8PNsQsKPwGnjWuDsHhiTkslknZWsxpcoJX/i9vg6jUyq7/QQlRI6WGqeDoATEtE4UzB6yDlO1osWxpTa280XNOpvJ78toRsTlDp0jZATZqIH+Q4wBtaIvtdxuQrRJ6SB6N5dT3v6yLD/4Yt6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dhku2VAb; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dhku2VAb"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-727c59ecb9fso20607b3a.1
        for <sparclinux@vger.kernel.org>; Wed, 11 Dec 2024 15:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733959708; x=1734564508; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oHbDZ++mGE8tEdFCxijZAS2pZkYuZT5989Fg2aOx0oY=;
        b=Dhku2VAbxZZM2UN/YnJNvFaxTc/yGPJX2iNH3/E8Kn5N7E+9GLNcR1E4TWMtU888V2
         pOEj3iHLM5J+oL8wnVNZjcjrV+aZf6KfNKQp3OK2mHMdXtoN7tGqfzRDGJ1kpCGLGd2R
         RYnjy7KmrVmvRudOYpi6kFbxJSVhcud+fQXn7QgvYIZw6uumG8p3T242Y7QJq8sl0XwO
         7uvnFLqIm+Y/ptnTZpsLF8C817Kdnt9NS8rYWUYBPQybU1nm8HdsiGlj2ic+Gl1GmN+T
         z8hUsVb2Iro5yXN72RdeXqd+mBHF1951GcmXIqCbVO54aUT7QoMWKzvtI3xdoh6CevNj
         aglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733959708; x=1734564508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHbDZ++mGE8tEdFCxijZAS2pZkYuZT5989Fg2aOx0oY=;
        b=v+Xh8OV6h6sDrZXWhlPYWkipeymujp1Y/oXwzzZmMlNK5zuZVAvKCa3dBi4vV8Z/uA
         +IcK1RpTu+Qol2TrRFaVYV/9ncXn0S+V0PAHFPH96zMZu9dcB9NS0TgrL0bD0g8tUOCT
         fOcYrDmZxFviFOD0tlHB4JgzFtrGQm8+JMvLZdkFNZiUkbo/R8N/i+anuKG5QzZqrGbb
         FT1EyEffBuQFfdfUQXrnmIS56skD3FyAuZZCnMxZG6fDbesHNknc1Q5P0xpZWPmOGbPD
         AcWUgci/AzUWPTiyvqROKFz70Q7uua7bpPRwybvgv2Hkn/HrVnAosjI57tB9pEGCeZC8
         V3KA==
X-Forwarded-Encrypted: i=1; AJvYcCURMQU+TwwliDkGeTtcOB7IsUVPT3MKpwpErl3zOvdQPA4efqFj+U0Aq2Es4ZjxgbpJQx/toE21NiTs@vger.kernel.org
X-Gm-Message-State: AOJu0YygU6ijVXiTqT3Ij20+KsBPNWlNkbIjlupC+XQ6GpoPOI/Kz1jY
	Vls/L4Jh8OUbPSPQj99DWqhClMEfDeTE/vuydWVo4y8s5Qb52YHubn/dZINiNnnDsKH8e2mnMf7
	9+W/kWlAWqh3iqLRnycUDbg==
X-Google-Smtp-Source: AGHT+IGlmctwmnr0LOvk4eyOoUS2Mz0NPFGCSegKhSqs8wGodxRb0W3o7XrsirlslhQ66CcLZRwSCG2H88EXSdEssw==
X-Received: from pgbdl12.prod.google.com ([2002:a05:6a02:d0c:b0:7fd:1eba:c2dd])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:150b:b0:1e0:d89e:f5cc with SMTP id adf61e73a8af0-1e1ceaabbb2mr1312325637.11.1733959708164;
 Wed, 11 Dec 2024 15:28:28 -0800 (PST)
Date: Wed, 11 Dec 2024 15:27:54 -0800
In-Reply-To: <20241211232754.1583023-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211232754.1583023-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241211232754.1583023-17-kaleshsingh@google.com>
Subject: [PATCH mm-unstable v2 16/16] mm: Respect mmap hint before THP
 alignment if allocation is possible
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

Commit 249608ee4713 ("mm: respect mmap hint address when aligning for THP")
fallsback to PAGE_SIZE alignment instead of THP alignment
for anonymous mapping as long as a hint address is provided by the user
-- even if we weren't able to allocate the unmapped area at the hint
address in the end.

This was done to address the immediate regression in anonymous mappings
where the hint address were being ignored in some cases; due to commit
efa7df3e3bb5 ("mm: align larger anonymous mappings on THP boundaries").

It was later pointed out that this issue also existed for file-backed
mappings from file systems that use thp_get_unmapped_area() for their
.get_unmapped_area() file operation.

The same fix was not applied for file-backed mappings since it would
mean any mmap requests that provide a hint address would be only
PAGE_SIZE-aligned regardless of whether allocation was successful at
the hint address or not.

Instead, use arch_mmap_hint() to first attempt allocation at the hint
address and fallback to THP alignment if there isn't sufficient VA space
to satisfy the allocation at the hint address.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 mm/huge_memory.c | 17 ++++++++++-------
 mm/mmap.c        |  1 -
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2da5520bfe24..426761a30aff 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1097,6 +1097,16 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
 	loff_t off_align = round_up(off, size);
 	unsigned long len_pad, ret, off_sub;
 
+	/*
+	 * If allocation at the address hint succeeds; respect the hint and
+	 * don't try to align to THP boundary;
+	 *
+	 * Or if an the requested extent is invalid return the error immediately.
+	 */
+	addr = arch_mmap_hint(filp, addr, len, off, flags);
+	if (addr)
+		return addr;
+
 	if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall())
 		return 0;
 
@@ -1117,13 +1127,6 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
 	if (IS_ERR_VALUE(ret))
 		return 0;
 
-	/*
-	 * Do not try to align to THP boundary if allocation at the address
-	 * hint succeeds.
-	 */
-	if (ret == addr)
-		return addr;
-
 	off_sub = (off - ret) & (size - 1);
 
 	if (test_bit(MMF_TOPDOWN, &current->mm->flags) && !off_sub)
diff --git a/mm/mmap.c b/mm/mmap.c
index 76dd6acdf051..3286fdff26f2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -814,7 +814,6 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 	if (get_area) {
 		addr = get_area(file, addr, len, pgoff, flags);
 	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && !file
-		   && !addr /* no hint */
 		   && IS_ALIGNED(len, PMD_SIZE)) {
 		/* Ensures that larger anonymous mappings are THP aligned. */
 		addr = thp_get_unmapped_area_vmflags(file, addr, len,
-- 
2.47.0.338.g60cca15819-goog

