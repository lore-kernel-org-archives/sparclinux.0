Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C0CC2BB3F
	for <sparclinux@archiver.kernel.org>; Wed, 15 Nov 2023 21:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344834AbjKOVDk (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 15 Nov 2023 16:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344864AbjKOVDR (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 15 Nov 2023 16:03:17 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C436E19B4;
        Wed, 15 Nov 2023 13:03:04 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-586ae6edf77so60038eaf.1;
        Wed, 15 Nov 2023 13:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700082184; x=1700686984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HndBEd7u5Loyr+XdPZa263m8QGx9J0Y/drl+5lW3Pc=;
        b=qLZgwmtoih2zDoq3bijqOJD7QL3G3Wpwt/W9rTin6YvQaUHijUyoFtMHnZu+XTJYQM
         XU7cSlP+tp7l/aJ+YVrHDsMs0R7MBaBPzX0hryULIpTX1rVOUQwBZ7LSYcmM8RmpiJB1
         PRLsLzMK0UjfprH0nQ0HarzXhhkm6GULVcxvmaa94Bsc2twvrFPgJMkf8hG9TEV3ze4d
         MjZySbsvNCjH2UeONubd6b1gDHsn/Q/J25qwv9lIarQy3OBZmBKYJess8MSsJ67wlNOO
         psJy8fXyn3jU9SxtWS9ao4HHbEH0EsHdQ4YPFUTGNGwIIwSfKSv6g6beJFBjSCit8zdP
         H5Lw==
X-Gm-Message-State: AOJu0YwJeH1U5ckmUzQN2oDWXjIe18vTupSp5ofPRr35iGuYyXtmsniM
        aUXlHaHWchd3/s/OOYO18w==
X-Google-Smtp-Source: AGHT+IGq5bU0cpGXD/rSuCv1lrNeCQPraEwHtONqu4M5KkgUDcgqxtCsdWcUxnK5nODmz+lDlormRQ==
X-Received: by 2002:a4a:7658:0:b0:57b:86f5:701c with SMTP id w24-20020a4a7658000000b0057b86f5701cmr15335887ooe.4.1700082184041;
        Wed, 15 Nov 2023 13:03:04 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a2-20020a4ad5c2000000b00586d187ed06sm790908oot.48.2023.11.15.13.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 13:03:03 -0800 (PST)
Received: (nullmailer pid 3745039 invoked by uid 1000);
        Wed, 15 Nov 2023 21:03:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] sparc: Use device_get_match_data()
Date:   Wed, 15 Nov 2023 15:02:57 -0600
Message-ID: <20231115210258.3744896-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/sparc/kernel/pci_sabre.c  |  9 +++++----
 arch/sparc/kernel/pci_schizo.c | 13 +++++++------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/kernel/pci_sabre.c b/arch/sparc/kernel/pci_sabre.c
index 3c38ca40a22b..a84598568300 100644
--- a/arch/sparc/kernel/pci_sabre.c
+++ b/arch/sparc/kernel/pci_sabre.c
@@ -13,7 +13,10 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 
 #include <asm/apb.h>
 #include <asm/iommu.h>
@@ -456,7 +459,6 @@ static void sabre_pbm_init(struct pci_pbm_info *pbm,
 static const struct of_device_id sabre_match[];
 static int sabre_probe(struct platform_device *op)
 {
-	const struct of_device_id *match;
 	const struct linux_prom64_registers *pr_regs;
 	struct device_node *dp = op->dev.of_node;
 	struct pci_pbm_info *pbm;
@@ -466,8 +468,7 @@ static int sabre_probe(struct platform_device *op)
 	const u32 *vdma;
 	u64 clear_irq;
 
-	match = of_match_device(sabre_match, &op->dev);
-	hummingbird_p = match && (match->data != NULL);
+	hummingbird_p = (uintptr_t)device_get_match_data(&op->dev);
 	if (!hummingbird_p) {
 		struct device_node *cpu_dp;
 
diff --git a/arch/sparc/kernel/pci_schizo.c b/arch/sparc/kernel/pci_schizo.c
index 23b47f7fdb1d..5d8dd4949586 100644
--- a/arch/sparc/kernel/pci_schizo.c
+++ b/arch/sparc/kernel/pci_schizo.c
@@ -11,7 +11,10 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/numa.h>
 
 #include <asm/iommu.h>
@@ -1459,15 +1462,13 @@ static int __schizo_init(struct platform_device *op, unsigned long chip_type)
 	return err;
 }
 
-static const struct of_device_id schizo_match[];
 static int schizo_probe(struct platform_device *op)
 {
-	const struct of_device_id *match;
+	unsigned long chip_type = (unsigned long)device_get_match_data(&op->dev);
 
-	match = of_match_device(schizo_match, &op->dev);
-	if (!match)
+	if (!chip_type)
 		return -EINVAL;
-	return __schizo_init(op, (unsigned long)match->data);
+	return __schizo_init(op, chip_type);
 }
 
 /* The ordering of this table is very important.  Some Tomatillo
-- 
2.42.0

