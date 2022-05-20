Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BA1C433EF
	for <sparclinux@archiver.kernel.org>; Fri, 20 May 2022 12:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbiETMMF (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 20 May 2022 08:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346765AbiETMME (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 20 May 2022 08:12:04 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A71A15EA6D
        for <sparclinux@vger.kernel.org>; Fri, 20 May 2022 05:11:59 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9351F3F1F7
        for <sparclinux@vger.kernel.org>; Fri, 20 May 2022 12:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653048717;
        bh=BbZQ2v7/O1XNxv2l6ZiEn/Rj5+K5y5FEa7M1oafefgw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=La3gNyCoGQlRcMD2Jl3/gCT9tGNrHI5p33DAXDh4JVw7sL0wL3dcb+CW/eC2weNur
         5ZFDM0PuQkoUW4oflGEMVcRELyD41ODy16qiTOtMr/PCSctPPAllJbEtEGqlZzBiNX
         xWvs2VvbiQQ2QBqFlbnqlj3PaZ3ko5BEBanFvuPBKzGU8XWxTob/REoSevG1krFLa2
         rOZnhwYlEsVI4WbbtJbFI3wGYQ/3UTAZqY9BNoupiIfoGVtQxZJhb9BwaoDCJGGENb
         yO3V2MeRabZLub+LCZ8d61YOto5OkK8uNeMUU/EVRarY6oMijUsQUs866rFeO9v06l
         UuiUW0KCEUi/Q==
Received: by mail-ej1-f72.google.com with SMTP id qw30-20020a1709066a1e00b006f45e7f44b0so3948852ejc.5
        for <sparclinux@vger.kernel.org>; Fri, 20 May 2022 05:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BbZQ2v7/O1XNxv2l6ZiEn/Rj5+K5y5FEa7M1oafefgw=;
        b=j+5brOPd1U+LZ9bzJ/LuE3iVMx6NGJchkNHs6jxSQMc/D+kueB0SeyT6J2LxdYz9rt
         03tVGFZI9I04JLxikAKTS5ODFxXMswpLVDKUAeE4NhCUKAoeHT1KRdVEeMOQhWtrUf1F
         VXFnaT9FPdjpO0NPHq83eekBdqPRyjVPC4nMwfApXop6JIgR8mEeB+v5nNE6y3y0KaYo
         Qz1h1IqZnjltAMLWk4N279HIsBTCEyN1Dq8hIun+p5z88pTEcD6llr8oRt83r0pyl0q/
         50gf7I6gCnsZqfQKXzGKEnln8mz8T52VLdPvfREGcaY1EcHfbcTcuhUHkj5RUbvVsE4f
         3jWw==
X-Gm-Message-State: AOAM530KqgMwaXXZHSBppX2vCNKBptyHFqHrXANTNKjpxa3URxn2LcS8
        tw/nuxzz0DKzpXP6gsQMB6I4KXSDskkTN+jve3kxxvYmV5sH8rxvlIfHZy66jj51P1M2+GiC6/n
        bKz1KdryfzjFVTBMLdBgLudZ9ZuQ3mtae2DhQklw=
X-Received: by 2002:a17:907:3e07:b0:6f0:270c:1121 with SMTP id hp7-20020a1709073e0700b006f0270c1121mr8481909ejc.137.1653048717232;
        Fri, 20 May 2022 05:11:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJys+rXcRkBah3y4A8Ivr51zp1KXUkCKOzJC77NGpxzecgku3TDy2b6vWrZwTWYFUrWMpOX1dg==
X-Received: by 2002:a17:907:3e07:b0:6f0:270c:1121 with SMTP id hp7-20020a1709073e0700b006f0270c1121mr8481891ejc.137.1653048717052;
        Fri, 20 May 2022 05:11:57 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id ml13-20020a170906cc0d00b006fe90a8459dsm2432866ejb.166.2022.05.20.05.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 05:11:56 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     davem@davemloft.net, sparclinux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] sparc: Kconfig: Fix indentation and add comments
Date:   Fri, 20 May 2022 14:11:53 +0200
Message-Id: <20220520121153.148573-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

While add it, add trailing comments to endif and endmenu statements for
better readability.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/sparc/Kconfig | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 9200bc04701c..3c97725fe75c 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -227,7 +227,7 @@ config HOTPLUG_CPU
 
 if SPARC64
 source "drivers/cpufreq/Kconfig"
-endif
+endif # SPARC64
 
 config US3_MC
 	tristate "UltraSPARC-III Memory Controller driver"
@@ -283,7 +283,7 @@ config FORCE_MAX_ZONEORDER
 
 if SPARC64
 source "kernel/power/Kconfig"
-endif
+endif # SPARC64
 
 config SCHED_SMT
 	bool "SMT (Hyperthreading) scheduler support"
@@ -382,33 +382,33 @@ config UBOOT_LOAD_ADDR
 	hex "uImage Load Address"
 	default 0x40004000
 	help
-	 U-Boot kernel load address, the address in physical address space
-	 where u-boot will place the Linux kernel before booting it.
-	 This address is normally the base address of main memory + 0x4000.
+	  U-Boot kernel load address, the address in physical address space
+	  where u-boot will place the Linux kernel before booting it.
+	  This address is normally the base address of main memory + 0x4000.
 
 config UBOOT_FLASH_ADDR
 	hex "uImage.o Load Address"
 	default 0x00080000
 	help
-	 Optional setting only affecting the uImage.o ELF-image used to
-	 download the uImage file to the target using a ELF-loader other than
-	 U-Boot. It may for example be used to download an uImage to FLASH with
-	 the GRMON utility before even starting u-boot.
+	  Optional setting only affecting the uImage.o ELF-image used to
+	  download the uImage file to the target using a ELF-loader other than
+	  U-Boot. It may for example be used to download an uImage to FLASH with
+	  the GRMON utility before even starting u-boot.
 
 config UBOOT_ENTRY_ADDR
 	hex "uImage Entry Address"
 	default 0xf0004000
 	help
-	 Do not change this unless you know what you're doing. This is
-	 hardcoded by the SPARC32 and LEON port.
+	  Do not change this unless you know what you're doing. This is
+	  hardcoded by the SPARC32 and LEON port.
 
-	 This is the virtual address u-boot jumps to when booting the Linux
-	 Kernel.
+	  This is the virtual address u-boot jumps to when booting the Linux
+	  Kernel.
 
-endmenu
-endif
+endmenu # "U-Boot options"
+endif # SPARC_LEON
 
-endmenu
+endmenu # "Processor type and features"
 
 menu "Bus options (PCI etc.)"
 config SBUS
@@ -478,7 +478,7 @@ config SPARC64_PCI_MSI
 	default y
 	depends on SPARC64_PCI && PCI_MSI
 
-endmenu
+endmenu # "Bus options (PCI etc.)"
 
 config COMPAT
 	bool
-- 
2.32.0

