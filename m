Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FB9C43461
	for <sparclinux@archiver.kernel.org>; Fri, 26 Mar 2021 13:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4684761A2A
	for <sparclinux@archiver.kernel.org>; Fri, 26 Mar 2021 13:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhCZNq7 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 26 Mar 2021 09:46:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:28081 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230227AbhCZNpj (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Fri, 26 Mar 2021 09:45:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F6NWh6NNJz9v03N;
        Fri, 26 Mar 2021 14:45:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id xndv0v1GJYSd; Fri, 26 Mar 2021 14:45:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F6NWh50m3z9v03M;
        Fri, 26 Mar 2021 14:45:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7ED9F8B8CB;
        Fri, 26 Mar 2021 14:45:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fcwQHTDmL2ra; Fri, 26 Mar 2021 14:45:05 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BF2308B8CD;
        Fri, 26 Mar 2021 14:45:04 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 48ABF67611; Fri, 26 Mar 2021 13:45:05 +0000 (UTC)
Message-Id: <63c9c340da826c14ed0c4f0121e723b16f626bc7.1616765870.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1616765869.git.christophe.leroy@csgroup.eu>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 17/17] cmdline: Remove CONFIG_CMDLINE_EXTEND
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
Date:   Fri, 26 Mar 2021 13:45:05 +0000 (UTC)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

All architectures providing CONFIG_CMDLINE_EXTEND
are now converted to GENERIC_CMDLINE.

This configuration item is not used anymore, drop it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 init/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index af0d84662cc2..fa002e3765ab 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -163,12 +163,6 @@ config CMDLINE_FORCE
 	  arguments provided by the bootloader.
 endchoice
 
-config CMDLINE_EXTEND
-	bool
-	default CMDLINE_APPEND
-	help
-	  To be removed once all architectures are converted to generic CMDLINE
-
 config COMPILE_TEST
 	bool "Compile also drivers which will not load"
 	depends on HAS_IOMEM
-- 
2.25.0

