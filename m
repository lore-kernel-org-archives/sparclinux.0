Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE2DC83003
	for <sparclinux@archiver.kernel.org>; Thu,  8 Jun 2023 19:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbjFHTLM (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 8 Jun 2023 15:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbjFHTLK (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 8 Jun 2023 15:11:10 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0CD30C1
        for <sparclinux@vger.kernel.org>; Thu,  8 Jun 2023 12:11:04 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b29c972e00so34168a34.1
        for <sparclinux@vger.kernel.org>; Thu, 08 Jun 2023 12:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686251462; x=1688843462;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1YvWeTkG3kfP7WDkFLxY3Kk7w85fUEyISH4lFagFGGw=;
        b=zI2n2c7OkddkeoVughk/breFog0Z+EugvTVCVE29AxlIwAuw/EXjuVVrGwHMRC2bhf
         x0zQuSLbArDGG85kKSwsyOqR0pmFFom/E7xSbaqroxyuObbaGosDK+M/+SoF1AtELCEy
         bwiSK0YoqwXYs8RFX4mr6F5bpRQfVt01fhKCwqENzESWm7Dhrz7vfiQry977lpQgtzrZ
         wnC//NTYAzqdTpQsJYqSSYM/JJ1rR9aCAEjxg8RoVlpIwLkFMrqySi29YtVXSpE8PojR
         NAOs9BLAS5JJ+VzpPEvMOGrhcKbJ9tQKHA0AjGKdBMYv+rB/+u255TZMPygFcoEpIAK5
         9xvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686251462; x=1688843462;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YvWeTkG3kfP7WDkFLxY3Kk7w85fUEyISH4lFagFGGw=;
        b=gXGmXfzTnQ3q4nqxQKuHXlMQj0cTQCP70Q1AIFustCw9xQsENwDtnEUJjBgU180D7l
         HZ8MDiBGgEE/TlkZkWlPsdAh2VYvwy4+BIzFOQZGTfltaFutTg+ZSqcYBq/lLYVNY2na
         +slrK+58WKZMXSvaIH3328SlGgHnrYUR3qYlFI2wWTJVj2BKcSUgwHdxmcgN7dyb9mFE
         tVe7YUSJtDDPB63ylqKaFFGPf1IWxZHsWp3LXW8L4jzpt/jmUp51QVHTFUf92c0slel1
         CEXqu1Sd1iDopF/SKcnvIjWKq4z4JwKVMOBkWwNTtnHo/8JlTrQ3jzErHaOIJk+169F8
         dOdQ==
X-Gm-Message-State: AC+VfDy7vPLRm6whj+5qOQcG74uOQxaZdct8fa0WLToaaG4No6kT/Hyn
        GZL3bV8IRAopRjxLRIdGny064A==
X-Google-Smtp-Source: ACHHUZ5JMT1Kov7YopWmoAdbj6VCmy1YpW57EN24ghxD3DbymGPoxfTUoK+9WA1xlwUdsIzRTkW8Cg==
X-Received: by 2002:a05:6359:38f:b0:128:7ef8:805f with SMTP id eg15-20020a056359038f00b001287ef8805fmr5080226rwb.6.1686251462249;
        Thu, 08 Jun 2023 12:11:02 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a17-20020a81bb51000000b00545a08184fdsm87881ywl.141.2023.06.08.12.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 12:11:01 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:10:57 -0700 (PDT)
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
        Peter Zijlstra <peterz@infradead.org>,
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
        Alexander Gordeev <agordeev@linux.ibm.com>,
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
Subject: [PATCH v2 01/23] arm: allow pte_offset_map[_lock]() to fail
In-Reply-To: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
Message-ID: <813429a1-204a-1844-eeae-7fd72826c28@google.com>
References: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

In rare transient cases, not yet made possible, pte_offset_map() and
pte_offset_map_lock() may not find a page table: handle appropriately.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/arm/lib/uaccess_with_memcpy.c | 3 +++
 arch/arm/mm/fault-armv.c           | 5 ++++-
 arch/arm/mm/fault.c                | 3 +++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
index e4c2677cc1e9..2f6163f05e93 100644
--- a/arch/arm/lib/uaccess_with_memcpy.c
+++ b/arch/arm/lib/uaccess_with_memcpy.c
@@ -74,6 +74,9 @@ pin_page_for_write(const void __user *_addr, pte_t **ptep, spinlock_t **ptlp)
 		return 0;
 
 	pte = pte_offset_map_lock(current->mm, pmd, addr, &ptl);
+	if (unlikely(!pte))
+		return 0;
+
 	if (unlikely(!pte_present(*pte) || !pte_young(*pte) ||
 	    !pte_write(*pte) || !pte_dirty(*pte))) {
 		pte_unmap_unlock(pte, ptl);
diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index 0e49154454a6..ca5302b0b7ee 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -117,8 +117,11 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 	 * must use the nested version.  This also means we need to
 	 * open-code the spin-locking.
 	 */
-	ptl = pte_lockptr(vma->vm_mm, pmd);
 	pte = pte_offset_map(pmd, address);
+	if (!pte)
+		return 0;
+
+	ptl = pte_lockptr(vma->vm_mm, pmd);
 	do_pte_lock(ptl);
 
 	ret = do_adjust_pte(vma, address, pfn, pte);
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 2418f1efabd8..83598649a094 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -85,6 +85,9 @@ void show_pte(const char *lvl, struct mm_struct *mm, unsigned long addr)
 			break;
 
 		pte = pte_offset_map(pmd, addr);
+		if (!pte)
+			break;
+
 		pr_cont(", *pte=%08llx", (long long)pte_val(*pte));
 #ifndef CONFIG_ARM_LPAE
 		pr_cont(", *ppte=%08llx",
-- 
2.35.3

