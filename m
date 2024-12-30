Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A141A23A9
	for <sparclinux@vger.kernel.org>; Mon, 30 Dec 2024 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549735; cv=none; b=uMw2OKGPUU9bvGXmnqjer8b+k7D4daMQGnmruUo3doZE1wM2frG28Akb+4ohQX8criUzjUCLHyQX3BqxCWNleSH0O0l+cNjJ/XmX0u2CZwIOI4ZwnTqZPS4ypNqgdQvTtHLrUY3G+0hbpgi8TOlp0j0QYe+wbvjT8NcWZP8IbRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549735; c=relaxed/simple;
	bh=eSQ1cqjI0k4SQFzb/dlIm3hCd3v5CZjZJpupq9IDdtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BirTv9mo3jEo/8EaQ7Wkvj7bpb90Pq5VsvoKov+9SVZ03t75YpvJflkJ4CPoawt/lJJgnpXeGxGAuiEmVFhhOKwpCgnInSqRnwr0WqRM0IbNfXpbwmskkG6hoK5bWjd2P0F1k2qk6joEyt1mcGg7Gk0OPlP7EuiQgNgTkFWaiRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fkkQ/Cxs; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fkkQ/Cxs"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21631789fcdso87865085ad.1
        for <sparclinux@vger.kernel.org>; Mon, 30 Dec 2024 01:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735549732; x=1736154532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyzxI6H4ZAISLyWZ1lhQ49SW3wSD1SDR6GIh5AHA3wQ=;
        b=fkkQ/Cxs0W3KUmzY4uZ7gTo6taPzqts1z1s+LhKxsSEnR3BoLO5qnre0TuWPFqjdiI
         oZbHhtRswoYOz51aj23l6M1fZjo/I1mBXx+a7Iai15xRuXyvAHJQHi+jOiOb1Kt1iiWj
         b9yugJcKfuBfMcahL5WcGTkQ2AOO159KQg7pL88kbXV2DsKPGDYO3zoODj1R8Nz1+IVM
         3dgWvyPIq+WT9jjP6YepgFxz8nnK9nW1tA34qbI1rSfyWgLVXlRV8s7tdv2RlahIzFgG
         OZKrVMu0Gki7Vizl9XGtt8CU8qyhtBGzRgbciWyjzphP+sqVbQqRU3xSu4Lv4riW0t9C
         jXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735549732; x=1736154532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyzxI6H4ZAISLyWZ1lhQ49SW3wSD1SDR6GIh5AHA3wQ=;
        b=J4c4ipYIXjEaQ1O7Ne2vqMbrXDI8E0rgQ7za5RmtSX4NFMc9SPmHEZ2nDQNt6niXzY
         GiPzS8BPRh5TSDnzXb5q28vkAJ39MyyftrtQiY+Gaeg5xpr/CbJWUu5xoo/ib3oy71z2
         Q4J7tsjk7hOqTe9M+pLfGL+CVgTYNWJ59+hY3gVznvWNptH7kV0RpJG0jsWCV7AWKnrV
         DdiKHHy9o1IQ8bsHdrw1bqKhZoTnvKPOWtOHCEhJag3w1fKhn73qpnUJUsETBc3i7asG
         gMylPK76pBluVX4uk68skDqjb5Qd32PIWHeZPcXStNkV87QFkf9TccdBpSjrJXdfhJEE
         wpbw==
X-Forwarded-Encrypted: i=1; AJvYcCUhohf3x/vpm5EqvBTCIuLDkWxw36kg9t7kUND2PddVAcK6ETnrLd1tz9W3D1pKp420o/3qcxD4vqUQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzRb3z3XwMYVQddM0GkagLeZgr28xYzCiuCHpKHnK10Kzmfwa2f
	qHccgtuVl1ZWOaNRLYku+WguedlvfogHv4FwFu3+MvdRKzMFAdjxqqE4F66llZ4=
X-Gm-Gg: ASbGnctofYYE4H2h4STk4n++AoKsAKU0XakPckfo72JiRoqCT/DO69/4kHQBuplW5PJ
	/TYOvXLpDy9xdQ59PHcDMpBpfjVEMal0gKYl4D0DE+F6tAGDRWeIR7Ji1qoCUSNVV74m6tggRFM
	oaIdBnbVEmPbbEV/WvlJ9c25fXZpPQg83oBqgz+kS1mlWMkPAqGrhLqsgZysZiGUL4WZEH/b8Ga
	seLF9w1k8VfgS9N+B7PIImFdtqxj5rtGeR/lPmoXlP5DSinR2+sRYd5w33GJxNx/CPwOu40pRGf
	1cL5/dUTOERN/RvY369vww==
X-Google-Smtp-Source: AGHT+IEXAwBIqSClrkb4EYoc2OhmhpgilmCz/IsEh6Chc/FsWIzsRB3p/FpLbUSGkXAy0ZMKjVVExg==
X-Received: by 2002:a05:6a20:4320:b0:1e6:50a0:f982 with SMTP id adf61e73a8af0-1e650a0fa30mr7283235637.20.1735549732420;
        Mon, 30 Dec 2024 01:08:52 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm17057841a12.4.2024.12.30.01.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 01:08:51 -0800 (PST)
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
Subject: [PATCH v4 01/15] Revert "mm: pgtable: make ptlock be freed by RCU"
Date: Mon, 30 Dec 2024 17:07:36 +0800
Message-Id: <b59adb960b2075822a6e57efc7a52e7eb7780068.1735549103.git.zhengqi.arch@bytedance.com>
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

This reverts commit 2f3443770437e49abc39af26962d293851cbab6d.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/mm.h       |  2 +-
 include/linux/mm_types.h |  9 +--------
 mm/memory.c              | 22 ++++++----------------
 3 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d61b9c7a3a7b0..c49bc7b764535 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2925,7 +2925,7 @@ void ptlock_free(struct ptdesc *ptdesc);
 
 static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
-	return &(ptdesc->ptl->ptl);
+	return ptdesc->ptl;
 }
 #else /* ALLOC_SPLIT_PTLOCKS */
 static inline void ptlock_cache_init(void)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 90ab8293d714a..6b27db7f94963 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -434,13 +434,6 @@ FOLIO_MATCH(flags, _flags_2a);
 FOLIO_MATCH(compound_head, _head_2a);
 #undef FOLIO_MATCH
 
-#if ALLOC_SPLIT_PTLOCKS
-struct pt_lock {
-	spinlock_t ptl;
-	struct rcu_head rcu;
-};
-#endif
-
 /**
  * struct ptdesc -    Memory descriptor for page tables.
  * @__page_flags:     Same as page flags. Powerpc only.
@@ -489,7 +482,7 @@ struct ptdesc {
 	union {
 		unsigned long _pt_pad_2;
 #if ALLOC_SPLIT_PTLOCKS
-		struct pt_lock *ptl;
+		spinlock_t *ptl;
 #else
 		spinlock_t ptl;
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index b9b05c3f93f11..9423967b24180 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7034,34 +7034,24 @@ static struct kmem_cache *page_ptl_cachep;
 
 void __init ptlock_cache_init(void)
 {
-	page_ptl_cachep = kmem_cache_create("page->ptl", sizeof(struct pt_lock), 0,
+	page_ptl_cachep = kmem_cache_create("page->ptl", sizeof(spinlock_t), 0,
 			SLAB_PANIC, NULL);
 }
 
 bool ptlock_alloc(struct ptdesc *ptdesc)
 {
-	struct pt_lock *pt_lock;
+	spinlock_t *ptl;
 
-	pt_lock = kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
-	if (!pt_lock)
+	ptl = kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
+	if (!ptl)
 		return false;
-	ptdesc->ptl = pt_lock;
+	ptdesc->ptl = ptl;
 	return true;
 }
 
-static void ptlock_free_rcu(struct rcu_head *head)
-{
-	struct pt_lock *pt_lock;
-
-	pt_lock = container_of(head, struct pt_lock, rcu);
-	kmem_cache_free(page_ptl_cachep, pt_lock);
-}
-
 void ptlock_free(struct ptdesc *ptdesc)
 {
-	struct pt_lock *pt_lock = ptdesc->ptl;
-
-	call_rcu(&pt_lock->rcu, ptlock_free_rcu);
+	kmem_cache_free(page_ptl_cachep, ptdesc->ptl);
 }
 #endif
 
-- 
2.20.1

