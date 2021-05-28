Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727F8C47087
	for <sparclinux@archiver.kernel.org>; Fri, 28 May 2021 04:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 538AF610FA
	for <sparclinux@archiver.kernel.org>; Fri, 28 May 2021 04:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhE1EJj (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 28 May 2021 00:09:39 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:50669 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhE1EJi (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 28 May 2021 00:09:38 -0400
X-Greylist: delayed 135290 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 May 2021 00:09:38 EDT
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 14S47JsI029078;
        Fri, 28 May 2021 13:07:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 14S47JsI029078
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1622174839;
        bh=eCaXXEaS9iNAFPd8MjrkGhV7FV2xPRig2DCKM2Obfno=;
        h=From:To:Cc:Subject:Date:From;
        b=s4NjdZwR7kUHALBOMuoO71qORYQnyaQ8x9S+/eaYmCZ8s9h+8fNKxB7GuXPj1vRX5
         fV/IXsNZV+2JzttplssmphqGXaqHtfXXlFSKFN/mJBXrSAunYMVbfwA/+MrvxmnpJG
         x8DBfdW/NBa20Auie9l++veei3ekKBCut4FYJqvgEojdYfnwHGvNM2B98KrwHsP0AQ
         a8e6tNUgqO7hK53nrEK+ZlJD9DmcFAXEPPoB3Sc6+Ideuicy6nrv0n7Dp5QLHm1CZz
         Vb4HrrFAxjN/7u+qz/5bkEvJIRmwnsdhQwxlnKbUo9kE6aoO2/t4h4A248Iyp9yz62
         XeXALSyS0eJOw==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] sparc: syscalls: use pattern rules to generate syscall headers
Date:   Fri, 28 May 2021 13:07:17 +0900
Message-Id: <20210528040717.2162382-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Use pattern rules to unify similar build rules between 32-bit and 64-bit.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sparc/kernel/syscalls/Makefile | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/kernel/syscalls/Makefile b/arch/sparc/kernel/syscalls/Makefile
index 0f2ea5bcb0d7..d63f18dd058d 100644
--- a/arch/sparc/kernel/syscalls/Makefile
+++ b/arch/sparc/kernel/syscalls/Makefile
@@ -10,25 +10,15 @@ syshdr := $(srctree)/scripts/syscallhdr.sh
 systbl := $(srctree)/scripts/syscalltbl.sh
 
 quiet_cmd_syshdr = SYSHDR  $@
-      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --emit-nr --abis $(abis) $< $@
+      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --emit-nr --abis common,$* $< $@
 
 quiet_cmd_systbl = SYSTBL  $@
-      cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis $(abis) $< $@
+      cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis common,$* $< $@
 
-$(uapi)/unistd_32.h: abis := common,32
-$(uapi)/unistd_32.h: $(syscall) $(syshdr) FORCE
+$(uapi)/unistd_%.h: $(syscall) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-$(uapi)/unistd_64.h: abis := common,64
-$(uapi)/unistd_64.h: $(syscall) $(syshdr) FORCE
-	$(call if_changed,syshdr)
-
-$(kapi)/syscall_table_32.h: abis := common,32
-$(kapi)/syscall_table_32.h: $(syscall) $(systbl) FORCE
-	$(call if_changed,systbl)
-
-$(kapi)/syscall_table_64.h: abis := common,64
-$(kapi)/syscall_table_64.h: $(syscall) $(systbl) FORCE
+$(kapi)/syscall_table_%.h: $(syscall) $(systbl) FORCE
 	$(call if_changed,systbl)
 
 uapisyshdr-y		+= unistd_32.h unistd_64.h
-- 
2.27.0

