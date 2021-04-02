Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FADC43470
	for <sparclinux@archiver.kernel.org>; Fri,  2 Apr 2021 15:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D937C61056
	for <sparclinux@archiver.kernel.org>; Fri,  2 Apr 2021 15:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbhDBPS1 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 2 Apr 2021 11:18:27 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:61689 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235472AbhDBPSN (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Fri, 2 Apr 2021 11:18:13 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FBkFr3RcWz9v2m8;
        Fri,  2 Apr 2021 17:18:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id GxtO1UqBUW7x; Fri,  2 Apr 2021 17:18:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FBkFr2PTSz9v2ls;
        Fri,  2 Apr 2021 17:18:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 34FB48BB7B;
        Fri,  2 Apr 2021 17:18:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BmkAXxz0r5S7; Fri,  2 Apr 2021 17:18:10 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D1B498BB79;
        Fri,  2 Apr 2021 17:18:09 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A374467989; Fri,  2 Apr 2021 15:18:09 +0000 (UTC)
Message-Id: <2e49b9ae60a90aec8b555946279cab059a2812a4.1617375802.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1617375802.git.christophe.leroy@csgroup.eu>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 08/20] arm: Convert to GENERIC_CMDLINE
To:     will@kernel.org, danielwa@cisco.com, robh@kernel.org,
        daniel@gimpelevich.san-francisco.ca.us, arnd@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        microblaze <monstr@monstr.eu>, linux-mips@vger.kernel.org,
        nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org,
        linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-mm@kvack.org
Date:   Fri,  2 Apr 2021 15:18:09 +0000 (UTC)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

This converts the architecture to GENERIC_CMDLINE.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v4:
- Removed dependency to ATAGS
- Removed the message when forcing
---
 arch/arm/Kconfig              | 38 +----------------------------------
 arch/arm/kernel/atags_parse.c | 13 +++---------
 2 files changed, 4 insertions(+), 47 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5da96f5df48f..1a1808b0eef7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -50,6 +50,7 @@ config ARM
 	select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
 	select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
+	select GENERIC_CMDLINE
 	select GENERIC_IRQ_IPI if SMP
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_EARLY_IOREMAP
@@ -1740,43 +1741,6 @@ config ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND
 
 endchoice
 
-config CMDLINE
-	string "Default kernel command string"
-	default ""
-	help
-	  On some architectures (e.g. CATS), there is currently no way
-	  for the boot loader to pass arguments to the kernel. For these
-	  architectures, you should supply some command-line options at build
-	  time by entering them here. As a minimum, you should specify the
-	  memory size and the root device (e.g., mem=64M root=/dev/nfs).
-
-choice
-	prompt "Kernel command line type" if CMDLINE != ""
-	default CMDLINE_FROM_BOOTLOADER
-	depends on ATAGS
-
-config CMDLINE_FROM_BOOTLOADER
-	bool "Use bootloader kernel arguments if available"
-	help
-	  Uses the command-line options passed by the boot loader. If
-	  the boot loader doesn't provide any, the default kernel command
-	  string provided in CMDLINE will be used.
-
-config CMDLINE_EXTEND
-	bool "Extend bootloader kernel arguments"
-	help
-	  The command-line arguments provided by the boot loader will be
-	  appended to the default kernel command string.
-
-config CMDLINE_FORCE
-	bool "Always use the default kernel command string"
-	help
-	  Always use the default kernel command string, even if the boot
-	  loader passes other arguments to the kernel.
-	  This is useful if you cannot or don't want to change the
-	  command-line options your boot loader passes to the kernel.
-endchoice
-
 config XIP_KERNEL
 	bool "Kernel Execute-In-Place from ROM"
 	depends on !ARM_LPAE && !ARCH_MULTIPLATFORM
diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
index 373b61f9a4f0..ef97ec015c51 100644
--- a/arch/arm/kernel/atags_parse.c
+++ b/arch/arm/kernel/atags_parse.c
@@ -14,6 +14,7 @@
  * is not parsed in any way).
  */
 
+#include <linux/cmdline.h>
 #include <linux/init.h>
 #include <linux/initrd.h>
 #include <linux/kernel.h>
@@ -120,16 +121,8 @@ __tagtable(ATAG_REVISION, parse_tag_revision);
 
 static int __init parse_tag_cmdline(const struct tag *tag)
 {
-#if defined(CONFIG_CMDLINE_EXTEND)
-	strlcat(default_command_line, " ", COMMAND_LINE_SIZE);
-	strlcat(default_command_line, tag->u.cmdline.cmdline,
-		COMMAND_LINE_SIZE);
-#elif defined(CONFIG_CMDLINE_FORCE)
-	pr_warn("Ignoring tag cmdline (using the default kernel command line)\n");
-#else
-	strlcpy(default_command_line, tag->u.cmdline.cmdline,
-		COMMAND_LINE_SIZE);
-#endif
+	cmdline_build(default_command_line, tag->u.cmdline.cmdline);
+
 	return 0;
 }
 
-- 
2.25.0

