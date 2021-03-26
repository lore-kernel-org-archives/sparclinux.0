Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B190C4345B
	for <sparclinux@archiver.kernel.org>; Fri, 26 Mar 2021 13:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A0E61A1D
	for <sparclinux@archiver.kernel.org>; Fri, 26 Mar 2021 13:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhCZNqD (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 26 Mar 2021 09:46:03 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:12301 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230204AbhCZNoz (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Fri, 26 Mar 2021 09:44:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F6NWR0RJyz9v039;
        Fri, 26 Mar 2021 14:44:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 9W4f4_9sN-cN; Fri, 26 Mar 2021 14:44:50 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F6NWQ6dmTz9tyyV;
        Fri, 26 Mar 2021 14:44:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 578328B8C7;
        Fri, 26 Mar 2021 14:44:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5xMrUPFYBqHf; Fri, 26 Mar 2021 14:44:51 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DC4E08B8C9;
        Fri, 26 Mar 2021 14:44:50 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 681D967611; Fri, 26 Mar 2021 13:44:51 +0000 (UTC)
Message-Id: <3d5d4281f264ec634f17252b6fef558ca4334243.1616765870.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1616765869.git.christophe.leroy@csgroup.eu>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 04/17] powerpc: Convert to GENERIC_CMDLINE
To:     will@kernel.org, danielwa@cisco.com, robh@kernel.org,
        daniel@gimpelevich.san-francisco.ca.us
Cc:     linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        microblaze <monstr@monstr.eu>, linux-mips@vger.kernel.org,
        nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org,
        linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Date:   Fri, 26 Mar 2021 13:44:51 +0000 (UTC)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

This updates the powerpc code to use the new cmdline building function.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig            | 37 +--------------------------------
 arch/powerpc/kernel/prom_init.c | 17 +++++++--------
 2 files changed, 8 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 386ae12d8523..5181efd7757e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -167,6 +167,7 @@ config PPC
 	select EDAC_SUPPORT
 	select GENERIC_ATOMIC64			if PPC32
 	select GENERIC_CLOCKEVENTS_BROADCAST	if SMP
+	select GENERIC_CMDLINE
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_VULNERABILITIES	if PPC_BARRIER_NOSPEC
@@ -886,42 +887,6 @@ config PPC_DENORMALISATION
 	  Add support for handling denormalisation of single precision
 	  values.  Useful for bare metal only.  If unsure say Y here.
 
-config CMDLINE
-	string "Initial kernel command string"
-	default ""
-	help
-	  On some platforms, there is currently no way for the boot loader to
-	  pass arguments to the kernel. For these platforms, you can supply
-	  some command-line options at build time by entering them here.  In
-	  most cases you will need to specify the root device here.
-
-choice
-	prompt "Kernel command line type" if CMDLINE != ""
-	default CMDLINE_FROM_BOOTLOADER
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
-
-endchoice
-
 config EXTRA_TARGETS
 	string "Additional default image types"
 	help
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index ccf77b985c8f..157d508e9fe9 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -152,7 +152,7 @@ static struct prom_t __prombss prom;
 static unsigned long __prombss prom_entry;
 
 static char __prombss of_stdout_device[256];
-static char __prombss prom_scratch[256];
+static char __prombss prom_scratch[COMMAND_LINE_SIZE];
 
 static unsigned long __prombss dt_header_start;
 static unsigned long __prombss dt_struct_start, dt_struct_end;
@@ -765,22 +765,19 @@ static unsigned long prom_memparse(const char *ptr, const char **retptr)
  * Early parsing of the command line passed to the kernel, used for
  * "mem=x" and the options that affect the iommu
  */
+#define cmdline_strlcat prom_strlcat
+#include <linux/cmdline.h>
+
 static void __init early_cmdline_parse(void)
 {
 	const char *opt;
-
-	char *p;
 	int l = 0;
 
-	prom_cmd_line[0] = 0;
-	p = prom_cmd_line;
-
 	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE) && (long)prom.chosen > 0)
-		l = prom_getprop(prom.chosen, "bootargs", p, COMMAND_LINE_SIZE-1);
+		l = prom_getprop(prom.chosen, "bootargs", prom_scratch,
+				 COMMAND_LINE_SIZE - 1);
 
-	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) || l <= 0 || p[0] == '\0')
-		prom_strlcat(prom_cmd_line, " " CONFIG_CMDLINE,
-			     sizeof(prom_cmd_line));
+	__cmdline_build(prom_cmd_line, l > 0 ? prom_scratch : NULL, sizeof(prom_scratch));
 
 	prom_printf("command line: %s\n", prom_cmd_line);
 
-- 
2.25.0

