Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61377EB64DA
	for <sparclinux@archiver.kernel.org>; Wed, 12 Jul 2023 04:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjGLEqd (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 12 Jul 2023 00:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjGLEqc (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 12 Jul 2023 00:46:32 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299E21736
        for <sparclinux@vger.kernel.org>; Tue, 11 Jul 2023 21:46:30 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-577497ec6c6so68903657b3.2
        for <sparclinux@vger.kernel.org>; Tue, 11 Jul 2023 21:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689137189; x=1691729189;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4LOZtvGEF5g0eQvRdR0fiwT6tMgm62bdW0dz/Hhyqlk=;
        b=J1OyC/PzRxAcAnxReOGyZoimdKHV4sne6EV+ZF5GnSzIGkj49DIxf8CJZXSiYaLo8O
         rQDVnXnu0y21FRcOCZP0OeEhb8w1Ae51u8RxjVwTlnPwlHyRZu5pHWxjcdG3sLbNOkgm
         l9DRu2V+r91JT6sg8uxZ0xdueMEWKHVeYHw/ucTn/rvDkwQeKDUMIXdd66/4pn+ZPDqc
         bbexzf/2xXArSFmFzEjH5dtsWbOgASWzeyhuG3Z+bgzkYYJreHWjygSN0MaZVhpwfXUc
         /vz1Ww9YOcG9dsJAekHocNmUdgaeY/Jq/K6dI5tFUgzSXd3eubGhE9SWhC2zJPkylOJH
         UPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689137189; x=1691729189;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4LOZtvGEF5g0eQvRdR0fiwT6tMgm62bdW0dz/Hhyqlk=;
        b=ckIbXQ0TElZevtP/CfdQRU27nzyySot8T75T6y1eV5NMZNOD6pXQ2CjQh4JZ7WRctI
         ZgCOf/EJnm6+Rp7ZcVVgSXIxsWK48FrBZFFzcY1XpXr0X6X1v/Qjiboqtx0pT08pza1i
         jL8OQmHH756ptlHWlFq6HPSfEAmxt80t46PdTh2LQXkQhuSXHlcNziNs7BBeHkPoKgvt
         NdjfWQLKN00ky2WmdHCR5veHrher85eOyf/b/sfTgNBkI3IjZ+Y6pgrqJvrrJ+a18PdD
         Y2nRwdtMkdufzXv5cIncZdXta5/ppbAoQBRTafQaNNeBnSXkxw2Z/lZvR8RQW+k7hWYQ
         lumQ==
X-Gm-Message-State: ABy/qLbGARHYLOXAQ4dJWTcP56cQpFC2qczYvpcH07yLpV8f25QbXPIH
        1+dmwZj3Lq7m8vRSBb+4TZiSpw==
X-Google-Smtp-Source: APBJJlGajCIPfwdsjGp7sM9eUSR1neGCrgzZWT479LGOvJujy6hRuJqugeEnCaM3mBFakTQjRwJQ+w==
X-Received: by 2002:a81:5dd6:0:b0:562:16d7:e6eb with SMTP id r205-20020a815dd6000000b0056216d7e6ebmr17894738ywb.40.1689137189022;
        Tue, 11 Jul 2023 21:46:29 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j126-20020a0df984000000b005772e9388cdsm969335ywf.62.2023.07.11.21.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 21:46:28 -0700 (PDT)
Date:   Tue, 11 Jul 2023 21:46:23 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 13/13] mm/pgtable: notes on pte_offset_map[_lock]()
In-Reply-To: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
Message-ID: <b791c3b0-25c6-a263-d785-d564344eb644@google.com>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Add a block of comments on pte_offset_map_lock(), pte_offset_map() and
pte_offset_map_nolock() to mm/pgtable-generic.c, to help explain them.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/pgtable-generic.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index fa9d4d084291..4fcd959dcc4d 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -315,6 +315,50 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
 	return pte;
 }
 
+/*
+ * pte_offset_map_lock(mm, pmd, addr, ptlp), and its internal implementation
+ * __pte_offset_map_lock() below, is usually called with the pmd pointer for
+ * addr, reached by walking down the mm's pgd, p4d, pud for addr: either while
+ * holding mmap_lock or vma lock for read or for write; or in truncate or rmap
+ * context, while holding file's i_mmap_lock or anon_vma lock for read (or for
+ * write). In a few cases, it may be used with pmd pointing to a pmd_t already
+ * copied to or constructed on the stack.
+ *
+ * When successful, it returns the pte pointer for addr, with its page table
+ * kmapped if necessary (when CONFIG_HIGHPTE), and locked against concurrent
+ * modification by software, with a pointer to that spinlock in ptlp (in some
+ * configs mm->page_table_lock, in SPLIT_PTLOCK configs a spinlock in table's
+ * struct page).  pte_unmap_unlock(pte, ptl) to unlock and unmap afterwards.
+ *
+ * But it is unsuccessful, returning NULL with *ptlp unchanged, if there is no
+ * page table at *pmd: if, for example, the page table has just been removed,
+ * or replaced by the huge pmd of a THP.  (When successful, *pmd is rechecked
+ * after acquiring the ptlock, and retried internally if it changed: so that a
+ * page table can be safely removed or replaced by THP while holding its lock.)
+ *
+ * pte_offset_map(pmd, addr), and its internal helper __pte_offset_map() above,
+ * just returns the pte pointer for addr, its page table kmapped if necessary;
+ * or NULL if there is no page table at *pmd.  It does not attempt to lock the
+ * page table, so cannot normally be used when the page table is to be updated,
+ * or when entries read must be stable.  But it does take rcu_read_lock(): so
+ * that even when page table is racily removed, it remains a valid though empty
+ * and disconnected table.  Until pte_unmap(pte) unmaps and rcu_read_unlock()s
+ * afterwards.
+ *
+ * pte_offset_map_nolock(mm, pmd, addr, ptlp), above, is like pte_offset_map();
+ * but when successful, it also outputs a pointer to the spinlock in ptlp - as
+ * pte_offset_map_lock() does, but in this case without locking it.  This helps
+ * the caller to avoid a later pte_lockptr(mm, *pmd), which might by that time
+ * act on a changed *pmd: pte_offset_map_nolock() provides the correct spinlock
+ * pointer for the page table that it returns.  In principle, the caller should
+ * recheck *pmd once the lock is taken; in practice, no callsite needs that -
+ * either the mmap_lock for write, or pte_same() check on contents, is enough.
+ *
+ * Note that free_pgtables(), used after unmapping detached vmas, or when
+ * exiting the whole mm, does not take page table lock before freeing a page
+ * table, and may not use RCU at all: "outsiders" like khugepaged should avoid
+ * pte_offset_map() and co once the vma is detached from mm or mm_users is zero.
+ */
 pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
 			     unsigned long addr, spinlock_t **ptlp)
 {
-- 
2.35.3

