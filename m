Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8AEC4320E
	for <sparclinux@archiver.kernel.org>; Sat,  7 Aug 2021 20:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8636960EC0
	for <sparclinux@archiver.kernel.org>; Sat,  7 Aug 2021 20:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhHGUuT (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 7 Aug 2021 16:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50419 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229882AbhHGUuS (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sat, 7 Aug 2021 16:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628369400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=sz8B19iZOKGMJ6EdmHryUsLjJMtkphPwU0rE5odAY5c=;
        b=JkaR+K+66bLuw9j2htzvgMW+BJRwSqn2vdy8B7iJ/hfGSC3FricjVk1OLs2x5yAoEhJU4/
        ggojocBvX+TUJQCpADSzxO9ExnGnAa9qMP0yRvudzcQmcJeJzIwnPFKqmEKiGSwmKu5kHk
        m3VL+S4yjfrmPztcHhLHCQv6Q6cjIro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-Egatw2qiNcyRuKj5p5975A-1; Sat, 07 Aug 2021 16:49:57 -0400
X-MC-Unique: Egatw2qiNcyRuKj5p5975A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D075C801AEB;
        Sat,  7 Aug 2021 20:49:55 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96C331007606;
        Sat,  7 Aug 2021 20:49:55 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 177KnsfW003455;
        Sat, 7 Aug 2021 16:49:54 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 177Knr6g003451;
        Sat, 7 Aug 2021 16:49:54 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Sat, 7 Aug 2021 16:49:53 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
cc:     Jakub Jelinek <jakub@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Milan Broz <gmazyland@gmail.com>
Subject: [PATCH] sparc64: fix boot on UltraSparcIII+
Message-ID: <alpine.LRH.2.02.2108071604110.30513@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi

I have Sun Blade 2000 with two UltraSparcIII+ processors and 8GB RAM. The 
kernel doesn't work on it (the last working version is 3.17).

If I put printk's at these two positions in kernel_physical_mapping_init():
	printk("kernel_physical_mapping_init: %lx\n", (long)mem_section[0]);
        kvmap_linear_patch[0] = 0x01000000; /* nop */
        flushi(&kvmap_linear_patch[0]);
        flush_all_kernel_tsbs();
        __flush_tlb_all();
	printk("kernel_physical_mapping_init: %lx\n", (long)mem_section[0]);
I get different values (the second value is 0) which indicates that the
linear bootmem mapping is not equivalent to the kernel page table mapping.
This mismatch causes crash on boot.

When I compiled the kernel with CONFIG_DEBUG_PAGEALLOC, the kernel boots
fine. CONFIG_DEBUG_PAGEALLOC disables 4M mapping, so the problem is with
it.

I have created this patch that disables large pages on UltraSparcIII and
UltraSparcIII+. It makes the kernel boot.

Do you have an idea why large pages don't work on UltraSparcIII? (they
work on UltraSparcII fine) Do you have some idea what I should test to
make them work?

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 arch/sparc/kernel/ktlb.S |   11 +++++++++++
 arch/sparc/mm/init_64.c  |    7 +++++++
 2 files changed, 18 insertions(+)

Index: linux-stable/arch/sparc/mm/init_64.c
===================================================================
--- linux-stable.orig/arch/sparc/mm/init_64.c	2021-08-07 16:28:26.000000000 +0200
+++ linux-stable/arch/sparc/mm/init_64.c	2021-08-07 16:40:21.000000000 +0200
@@ -1882,6 +1882,10 @@ static void __init kernel_physical_mappi
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	use_huge = false;
 #endif
+
+	if (tlb_type == cheetah || tlb_type == cheetah_plus)
+		use_huge = false;
+
 	for (i = 0; i < pall_ents; i++) {
 		unsigned long phys_start, phys_end;
 
@@ -2691,6 +2695,9 @@ static void __init sun4u_pgprot_init(voi
 	kern_linear_pte_xor[0] |= (_PAGE_CP_4U | _PAGE_CV_4U |
 				   _PAGE_P_4U | _PAGE_W_4U);
 
+	if (tlb_type == cheetah || tlb_type == cheetah_plus)
+		kern_linear_pte_xor[0] &= ~_PAGE_SZ4MB_4U;
+
 	for (i = 1; i < 4; i++)
 		kern_linear_pte_xor[i] = kern_linear_pte_xor[0];
 
Index: linux-stable/arch/sparc/kernel/ktlb.S
===================================================================
--- linux-stable.orig/arch/sparc/kernel/ktlb.S	2021-08-07 16:28:26.000000000 +0200
+++ linux-stable/arch/sparc/kernel/ktlb.S	2021-08-07 17:03:45.000000000 +0200
@@ -150,7 +150,18 @@ kvmap_dtlb_4v:
 	 */
 	KERN_TSB_LOOKUP_TL1(%g4, %g6, %g5, %g1, %g2, %g3, kvmap_dtlb_load)
 #else
+	sethi		%hi(tlb_type), %g1
+	lduw		[%g1 + %lo(tlb_type)], %g1
+	sub		%g1, 1, %g1
+	cmp		%g1, 1
+	bgu,pt		%xcc, use_4m_tsb
+	 nop
+
+	KERN_TSB_LOOKUP_TL1(%g4, %g6, %g5, %g1, %g2, %g3, kvmap_dtlb_load)
+	ba,pt		%xcc, kvmap_linear_patch
+	 nop
 	/* Correct TAG_TARGET is already in %g6, check 4mb TSB.  */
+use_4m_tsb:
 	KERN_TSB4M_LOOKUP_TL1(%g6, %g5, %g1, %g2, %g3, kvmap_dtlb_load)
 #endif
 	/* Linear mapping TSB lookup failed.  Fallthrough to kernel

