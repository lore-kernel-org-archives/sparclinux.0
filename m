Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C9FC4332F
	for <sparclinux@archiver.kernel.org>; Thu,  7 Apr 2022 10:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244446AbiDGKg7 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 7 Apr 2022 06:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244506AbiDGKgQ (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 7 Apr 2022 06:36:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E759C12985B;
        Thu,  7 Apr 2022 03:33:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AED7015BF;
        Thu,  7 Apr 2022 03:33:10 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.36.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E739E3F5A1;
        Thu,  7 Apr 2022 03:33:06 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 6/7] mm/mmap: Drop arch_filter_pgprot()
Date:   Thu,  7 Apr 2022 16:02:50 +0530
Message-Id: <20220407103251.1209606-7-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220407103251.1209606-1-anshuman.khandual@arm.com>
References: <20220407103251.1209606-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

There are no platforms left which subscribe ARCH_HAS_FILTER_PGPROT. Hence
drop generic arch_filter_pgprot() and also config ARCH_HAS_FILTER_PGPROT.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/Kconfig | 3 ---
 mm/mmap.c  | 9 +--------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index b1f7624276f8..3f7b6d7b69df 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -762,9 +762,6 @@ config ARCH_HAS_CURRENT_STACK_POINTER
 	  register alias named "current_stack_pointer", this config can be
 	  selected.
 
-config ARCH_HAS_FILTER_PGPROT
-	bool
-
 config ARCH_HAS_VM_GET_PAGE_PROT
 	bool
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 87cb2eaf7e1a..edf2a5e38f4d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -107,20 +107,13 @@ pgprot_t protection_map[16] __ro_after_init = {
 };
 
 #ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT
-#ifndef CONFIG_ARCH_HAS_FILTER_PGPROT
-static inline pgprot_t arch_filter_pgprot(pgprot_t prot)
-{
-	return prot;
-}
-#endif
-
 pgprot_t vm_get_page_prot(unsigned long vm_flags)
 {
 	pgprot_t ret = __pgprot(pgprot_val(protection_map[vm_flags &
 				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]) |
 			pgprot_val(arch_vm_get_page_prot(vm_flags)));
 
-	return arch_filter_pgprot(ret);
+	return ret;
 }
 EXPORT_SYMBOL(vm_get_page_prot);
 #endif	/* CONFIG_ARCH_HAS_VM_GET_PAGE_PROT */
-- 
2.25.1

