Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A1BC32796
	for <sparclinux@archiver.kernel.org>; Tue, 23 Aug 2022 10:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347591AbiHWKGh (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 23 Aug 2022 06:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352657AbiHWKGE (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 23 Aug 2022 06:06:04 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11157CB50
        for <sparclinux@vger.kernel.org>; Tue, 23 Aug 2022 01:52:18 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id z20so12882031ljq.3
        for <sparclinux@vger.kernel.org>; Tue, 23 Aug 2022 01:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=BrSRYpaIPrj7QXIedFdUE7igCjiXfv4ewWPbR3LgBJw=;
        b=dbPtpC7Rc0ZKREyNr2W5lwqSxMvDUa+itVWsY8G79AtA/EowpL7NIG7YsD+bNONSz/
         bssuDhG3UYO1G7BoNJzRyk6A7TbTTdtzpDd63I2pqKLjr4MOfZDzgZ+mKWWYFHRP8bK7
         fJBJRLz4OA7fDmhaMxj6yobSNmH2k4j5g6vwhhHoBJ0w0s/zxknx8kZbvlbVDK8JBx1m
         R+6M4FAk+60k61Q4UQ1uiY49HNiy5A2hO8OU57KqSPQlKFiJRCY4Y668XGZgSS03GWCt
         Qom0NknHBk6aG8kRxOPDhZiSJkUhrc3ppKZ2yCcFlDgntU06/XWCP5fGu50cKIGCgeMZ
         4lCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=BrSRYpaIPrj7QXIedFdUE7igCjiXfv4ewWPbR3LgBJw=;
        b=5MzJheTvMtNZIitLCXfa149tJ4fGpQPSuieTDb24Y/5BP5NTtEpb7JcTY1YzfPPLcy
         jJVOxWRx3LoZFQj9a23zK63PTMCeHSWTNkw6daLuX6zppdSeaTvQ/2OfW2ZOz/VTKO2h
         VAFSHySuks+Fz29iQhC8xQu1Vpzy8rSThXla4uRk3xc9wzylt4vpJXnrC16+TqY/5ZUC
         AvhXMMATZJuZmqVHxdgTwCToS6j5GKlPthlBw6dNN/L49GqR9o7Vl70wOxVTBogjr8oE
         G+v55dYOP3hwokpx7jClfH6eMgLtnZkSytm/biq9HJcwgS1DR9VyXVpK4wa6Lm4LXtrG
         eF2A==
X-Gm-Message-State: ACgBeo0wb3d70fGay1a15Sg7WftE4tlo8bW8oM4X7OEl95zHTPODUfMw
        50OWdhqK5tyALHH9Fl6SybG0KBGvbVQSKg==
X-Google-Smtp-Source: AA6agR7UZrjRNW4pnsz3uQOlskORf8OUaZPdGEZs8IfOIlOvNIjmmfR7ORqdiy+CeNf6DlkeeuzhJQ==
X-Received: by 2002:a2e:3515:0:b0:25e:7139:345f with SMTP id z21-20020a2e3515000000b0025e7139345fmr6502936ljz.129.1661244737040;
        Tue, 23 Aug 2022 01:52:17 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id h34-20020a0565123ca200b0048b37d29256sm726247lfv.63.2022.08.23.01.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 01:52:16 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     sparclinux@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>,
        linux-arch@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] sparc64: Fix the generic IO helpers
Date:   Tue, 23 Aug 2022 10:50:14 +0200
Message-Id: <20220823085014.208791-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

This enables the Sparc to use <asm-generic/io.h> to fill in the
missing (undefined) [read|write]sq I/O accessor functions.

This is needed if Sparc[64] ever wants to uses CONFIG_REGMAP_MMIO
which has been patches to use accelerated _noinc accessors
such as readsq/writesq that Sparc64, while being a 64bit platform,
as of now not yet provide.

This comes with the requirement that everything the architecture
already provides needs to be defined, rather than just being,
say, static inline functions.

Bite the bullet and just provide the definitions and make it work.
Compile-tested on sparc64.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/linux-arm-kernel/202208201639.HXye3ke4-lkp@intel.com/
Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/sparc/include/asm/io.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/sparc/include/asm/io.h b/arch/sparc/include/asm/io.h
index 2eefa526b38f..88da27165c01 100644
--- a/arch/sparc/include/asm/io.h
+++ b/arch/sparc/include/asm/io.h
@@ -19,4 +19,35 @@
 #define writel_be(__w, __addr)	__raw_writel(__w, __addr)
 #define writew_be(__l, __addr)	__raw_writew(__l, __addr)
 
+/*
+ * These defines are necessary to use the generic io.h for filling in
+ * the missing parts of the API contract. This is because the platform
+ * uses (inline) functions rather than defines and the generic helper
+ * fills in the undefined.
+ */
+/* These are static inlines on 64BIT only */
+#if defined(__sparc__) && defined(__arch64__)
+#define memset_io memset_io
+#define memcpy_fromio memcpy_fromio
+#define memcpy_toio memcpy_toio
+#endif
+#define pci_iomap pci_iomap
+#define pci_iounmap pci_iounmap
+#define ioremap_np ioremap_np
+#define ioport_map ioport_map
+#define ioport_unmap ioport_unmap
+#define readsb readsb
+#define readsw readsw
+#define readsl readsl
+#define writesb writesb
+#define writesw writesw
+#define writesl writesl
+#define insb insb
+#define insw insw
+#define insl insl
+#define outsb outsb
+#define outsw outsw
+#define outsl outsl
+#include <asm-generic/io.h>
+
 #endif
-- 
2.37.2

