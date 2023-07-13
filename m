Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D137FC0015E
	for <sparclinux@archiver.kernel.org>; Thu, 13 Jul 2023 07:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjGMHzj (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 13 Jul 2023 03:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbjGMHzb (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 13 Jul 2023 03:55:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028AB2683
        for <sparclinux@vger.kernel.org>; Thu, 13 Jul 2023 00:55:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJrAY-0000NG-2Y; Thu, 13 Jul 2023 09:55:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJrAV-00E4DG-Fg; Thu, 13 Jul 2023 09:55:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJrAU-004V9x-GK; Thu, 13 Jul 2023 09:55:18 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     sparclinux@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] sparc: Use $(kecho) to announce kernel images being ready
Date:   Thu, 13 Jul 2023 09:52:35 +0200
Message-Id: <20230713075235.2164609-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2062; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ykKEf1GYlFfOeAFBDnZ/LYhBochWckGm4Db+dhGvLFw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkr61CyNpyAMf5w8XxEtC8w1er3afm3YSoi3Si1 BOtFoKVEeeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZK+tQgAKCRCPgPtYfRL+ Ti9qB/9SaocC8F39ZxovFFIxlv+BIA2hyzyeSBOvx6DjWmD1IsqlzVIWo4otKs9rr8ooc5ps62Y muumxk2u8VBWqRoekPKLC5qIQ/Qg6grn0gvao2uUrSvDQhJgt+nAiEu90cOzUga3YpHueUwvlJj UcwNu3U9pjKN5zW3chDN34XpACrdgEkAuobZeyVNF/y0ouyujIxw7LCMxyKpLgjsT3chrLcGno8 a1WH79PXLikCToFUiJ5P1+U5AY1H8xcaLhiVsH9ezqVWNEWjvj5LrExSr4OMsa+ijMHI0AAWBZe 2o+IecaXS66fqgyjm9FkKJ/8/G6HGK7e9uO5Uq/wdXETSfY4
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: sparclinux@vger.kernel.org
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

My build test setup compiles allmodconfig all various architectures
(arm64 m68k powerpc riscv s390 sparc64 x86_64) using make -s. If there
is no warning, the only output is

          kernel: arch/sparc/boot/image is ready
          kernel: arch/sparc/boot/zImage is ready

from the sparc64 build. Copy the incantation from x86 which is silent
when building with make -s and also mentions a version indication.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/sparc/boot/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
index 45e5c76d449e..339c42d35089 100644
--- a/arch/sparc/boot/Makefile
+++ b/arch/sparc/boot/Makefile
@@ -24,16 +24,16 @@ ifeq ($(CONFIG_SPARC64),y)
 
 $(obj)/zImage: $(obj)/image FORCE
 	$(call if_changed,gzip)
-	@echo '  kernel: $@ is ready'
+	@$(kecho) 'Kernel: $@ is ready' '(#'$(or $(KBUILD_BUILD_VERSION),`cat .version`)')'
 
 $(obj)/vmlinux.aout: vmlinux FORCE
 	$(call if_changed,elftoaout)
-	@echo '  kernel: $@ is ready'
+	@$(kecho) 'Kernel: $@ is ready' '(#'$(or $(KBUILD_BUILD_VERSION),`cat .version`)')'
 else
 
 $(obj)/zImage: $(obj)/image FORCE
 	$(call if_changed,strip)
-	@echo '  kernel: $@ is ready'
+	@$(kecho) 'Kernel: $@ is ready' '(#'$(or $(KBUILD_BUILD_VERSION),`cat .version`)')'
 
 # The following lines make a readable image for U-Boot.
 #  uImage   - Binary file read by U-boot
@@ -59,13 +59,13 @@ targets += uImage
 $(obj)/uImage: $(obj)/image.gz FORCE
 	$(call if_changed,uimage)
 	$(call if_changed,uimage.o)
-	@echo '  Image $@ is ready'
+	@$(kecho) 'Kernel: $@ is ready' '(#'$(or $(KBUILD_BUILD_VERSION),`cat .version`)')'
 
 endif
 
 $(obj)/image: vmlinux FORCE
 	$(call if_changed,strip)
-	@echo '  kernel: $@ is ready'
+	@$(kecho) 'Kernel: $@ is ready' '(#'$(or $(KBUILD_BUILD_VERSION),`cat .version`)')'
 
 $(obj)/tftpboot.img: $(obj)/image $(obj)/piggyback System.map $(ROOT_IMG) FORCE
 	$(call if_changed,elftoaout)
-- 
2.39.2

