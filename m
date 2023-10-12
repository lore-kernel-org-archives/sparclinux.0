Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36025CDB46E
	for <sparclinux@archiver.kernel.org>; Thu, 12 Oct 2023 19:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442527AbjJLTzZ (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 15:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442316AbjJLTzY (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 12 Oct 2023 15:55:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633D5B7
        for <sparclinux@vger.kernel.org>; Thu, 12 Oct 2023 12:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=RiC4LbDPsvm1R/hBxKAIvjDYl7LcGAsJmWP/V7VNH+o=; b=jIePl0DkLsVwMFydPLTuL2K4Kx
        wFd5BIbew8STEqAyXac6ItdamjwFZtQMzYE5fCMa4KeyrxGdQ0rre1qELgcyrPPY2r8ScIUVjfadi
        EORyS2LricGRBMF7HrpH00P94zh3FPFP5N9nmeoltMVdiiljA7wJOjduaZKgEYfKmpHuLGgVi2zws
        MmcCbTiXxmLdRqD4ihmgaJorGVC4cUNzZjbXKdx2qbKwtieFdtTW6hOyZUhZhs1gLU4LeHUKZkyEe
        G6Ssbjxq7Knh4O0qJKVEsUizq0jg968qX8mmLA4Iz90GtJ9TtTV5BqRMl7SL9at1f+iwNWpaXlsix
        CevzuGJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qr1mD-001Bif-Qo
        for sparclinux@vger.kernel.org; Thu, 12 Oct 2023 19:55:21 +0000
Date:   Thu, 12 Oct 2023 20:55:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     sparclinux@vger.kernel.org
Subject: [willy@infradead.org: [PATCH 2/2] sparc: Allow nesting of lazy MMU
 mode]
Message-ID: <ZShPKbi30H3yYd31@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Oops, wrong email address.

----- Forwarded message from "Matthew Wilcox (Oracle)" <willy@infradead.org> -----

Date: Thu, 12 Oct 2023 20:54:15 +0100
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-sparc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Michael
	Ellerman <mpe@ellerman.id.au>, Erhard Furtner <erhard_f@mailbox.org>,
	David Woodhouse <dwmw2@infradead.org>, Juergen Gross <jgross@suse.com>
Subject: [PATCH 2/2] sparc: Allow nesting of lazy MMU mode
X-Mailer: git-send-email 2.37.1

As noted in commit 49147beb0ccb ("x86/xen: allow nesting of same lazy
mode"), we can now nest calls to arch_enter_lazy_mmu_mode().  Use ->active
as a counter instead of a flag and only drain the batch when the counter
hits 0.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Fixes: bcc6cc832573 ("mm: add default definition of set_ptes()")
---
 arch/sparc/mm/tlb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index b44d79d778c7..a82c7c32e47d 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -54,16 +54,15 @@ void arch_enter_lazy_mmu_mode(void)
 {
 	struct tlb_batch *tb = this_cpu_ptr(&tlb_batch);
 
-	tb->active = 1;
+	tb->active++;
 }
 
 void arch_leave_lazy_mmu_mode(void)
 {
 	struct tlb_batch *tb = this_cpu_ptr(&tlb_batch);
 
-	if (tb->tlb_nr)
+	if ((--tb->active == 0) && tb->tlb_nr)
 		flush_tlb_pending();
-	tb->active = 0;
 }
 
 static void tlb_batch_add_one(struct mm_struct *mm, unsigned long vaddr,
-- 
2.40.1


----- End forwarded message -----
