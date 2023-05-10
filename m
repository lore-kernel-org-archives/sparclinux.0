Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601C4C77B7C
	for <sparclinux@archiver.kernel.org>; Wed, 10 May 2023 05:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbjEJFB0 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 10 May 2023 01:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbjEJFBX (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 10 May 2023 01:01:23 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B05B49D0
        for <sparclinux@vger.kernel.org>; Tue,  9 May 2023 22:01:21 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-55a5a830238so62444547b3.3
        for <sparclinux@vger.kernel.org>; Tue, 09 May 2023 22:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683694880; x=1686286880;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WSGFooIbg1YnCT+usP0CPskjqWFniw8CJbMJmY8IIY4=;
        b=vuo7rYDMzaDeDPZgzHMtVp+kDDpzRoF+cP2Qnr93hh+pF6J9q5tC6QhVWjQR/dpJZs
         St4YSsmW5E0SKuQmRdibMqMztrKviA12bUxhXRBvVCQgZMikD8H0uj5+E9csqviYPTTF
         W/MWYfjHA/1NssscvDoyXC6tVcA1ciumq+qFhN9YZhl/AUe/TYRGPOpbxUr3CzSoAwDs
         9ZIJx+k2kcTyg+8Yd6pO3A43gfTS5JygrpCg5CjFhHivuRBYVd+ivlToDlbyQHOK26G6
         DP8KUWo0VQTsOYmO3ProNs6agiD4J9mWFi/qWhwm90YAcZbtyMXr/cNFlm/A7CEZL/+P
         HUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683694880; x=1686286880;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSGFooIbg1YnCT+usP0CPskjqWFniw8CJbMJmY8IIY4=;
        b=YOSLt28Sc+5qqhlltx3AXz+66AVu39XK+087NnWWtgeGCdsarN2j5dsCGJu15IKKu1
         xpIxX+cpIMjz9ahCIXUWxTmbLqlOAbz0xH82QiIWuhqb1aXkaGuvUt23JefDtJ8N2wJs
         PglDKMBTETmlxWNLepCu1lFWhoE2vLy+8c/F2TzPxD1ynm2l6bgLm3KNmtMSshgg3tLC
         w+drbZBrW9rMj5Df2cda7OIFTV9Ezmdxzrs/HuBYl5wpmWLRLX6vkfi5mj5dn94cGg3N
         pd17D4tox2q8kgVJ8bygx/E3smF+TdzklQZVUpUuRtFbUGMl0cCn74wnvwf668B9ZJrC
         eaoQ==
X-Gm-Message-State: AC+VfDwOLPnqCmtPecfXCEkdAzoeCjm2JCuCiL0EWNDYxkLbFxU1CD8u
        LivbpwOURb0Sz2p9bOzuej+bQw==
X-Google-Smtp-Source: ACHHUZ5AoVobUeVID967V3Jmnothc2qu5Os8b3JQyJT6HUqgLFH4b1VRwh/1toL1vvMbGclLD2jjcg==
X-Received: by 2002:a0d:d4c3:0:b0:55a:9d84:2e4e with SMTP id w186-20020a0dd4c3000000b0055a9d842e4emr17674451ywd.18.1683694880477;
        Tue, 09 May 2023 22:01:20 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e2-20020a81dd02000000b00559f9e9eabcsm3815388ywn.98.2023.05.09.22.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 22:01:20 -0700 (PDT)
Date:   Tue, 9 May 2023 22:01:16 -0700 (PDT)
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
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 15/23] s390: allow pte_offset_map_lock() to fail
In-Reply-To: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
Message-ID: <94aec8fe-383f-892-dcbf-d4c14e460a7@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

In rare transient cases, not yet made possible, pte_offset_map() and
pte_offset_map_lock() may not find a page table: handle appropriately.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/s390/kernel/uv.c  |  2 ++
 arch/s390/mm/gmap.c    |  2 ++
 arch/s390/mm/pgtable.c | 12 +++++++++---
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index cb2ee06df286..3c62d1b218b1 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -294,6 +294,8 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
 
 	rc = -ENXIO;
 	ptep = get_locked_pte(gmap->mm, uaddr, &ptelock);
+	if (!ptep)
+		goto out;
 	if (pte_present(*ptep) && !(pte_val(*ptep) & _PAGE_INVALID) && pte_write(*ptep)) {
 		page = pte_page(*ptep);
 		rc = -EAGAIN;
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index dc90d1eb0d55..d198fc9475a2 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2549,6 +2549,8 @@ static int __zap_zero_pages(pmd_t *pmd, unsigned long start,
 		spinlock_t *ptl;
 
 		ptep = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+		if (!ptep)
+			break;
 		if (is_zero_pfn(pte_pfn(*ptep)))
 			ptep_xchg_direct(walk->mm, addr, ptep, __pte(_PAGE_INVALID));
 		pte_unmap_unlock(ptep, ptl);
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 6effb24de6d9..3bd2ab2a9a34 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -829,7 +829,7 @@ int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 	default:
 		return -EFAULT;
 	}
-
+again:
 	ptl = pmd_lock(mm, pmdp);
 	if (!pmd_present(*pmdp)) {
 		spin_unlock(ptl);
@@ -850,6 +850,8 @@ int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 	spin_unlock(ptl);
 
 	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
+	if (!ptep)
+		goto again;
 	new = old = pgste_get_lock(ptep);
 	pgste_val(new) &= ~(PGSTE_GR_BIT | PGSTE_GC_BIT |
 			    PGSTE_ACC_BITS | PGSTE_FP_BIT);
@@ -938,7 +940,7 @@ int reset_guest_reference_bit(struct mm_struct *mm, unsigned long addr)
 	default:
 		return -EFAULT;
 	}
-
+again:
 	ptl = pmd_lock(mm, pmdp);
 	if (!pmd_present(*pmdp)) {
 		spin_unlock(ptl);
@@ -955,6 +957,8 @@ int reset_guest_reference_bit(struct mm_struct *mm, unsigned long addr)
 	spin_unlock(ptl);
 
 	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
+	if (!ptep)
+		goto again;
 	new = old = pgste_get_lock(ptep);
 	/* Reset guest reference bit only */
 	pgste_val(new) &= ~PGSTE_GR_BIT;
@@ -1000,7 +1004,7 @@ int get_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 	default:
 		return -EFAULT;
 	}
-
+again:
 	ptl = pmd_lock(mm, pmdp);
 	if (!pmd_present(*pmdp)) {
 		spin_unlock(ptl);
@@ -1017,6 +1021,8 @@ int get_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 	spin_unlock(ptl);
 
 	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
+	if (!ptep)
+		goto again;
 	pgste = pgste_get_lock(ptep);
 	*key = (pgste_val(pgste) & (PGSTE_ACC_BITS | PGSTE_FP_BIT)) >> 56;
 	paddr = pte_val(*ptep) & PAGE_MASK;
-- 
2.35.3

