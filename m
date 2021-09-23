Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC39C433FE
	for <sparclinux@archiver.kernel.org>; Thu, 23 Sep 2021 21:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D53161214
	for <sparclinux@archiver.kernel.org>; Thu, 23 Sep 2021 21:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243390AbhIWVz5 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 23 Sep 2021 17:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbhIWVz5 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 23 Sep 2021 17:55:57 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4D0C061756
        for <sparclinux@vger.kernel.org>; Thu, 23 Sep 2021 14:54:25 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id n23so4126867pfv.4
        for <sparclinux@vger.kernel.org>; Thu, 23 Sep 2021 14:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rO5fvWaAZTv31oC9ovhV41R9OYan3E5Hn4Me7MlHqao=;
        b=PdHGDU8L54UaLJCl120uuECenLtn0S4ozb35+4bYoAq1fUqCCwbpP2gBaj0KTFzYTQ
         Sgrnk3uox0p/1HC8ml/Mld6J4i5VH7np3Dr7QdNEgV9LRr2VpU/g4h+3eiYsdxEdhtfl
         18ZawluARpGS6r6nmGk5zVdSW1AWolmSZSAMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rO5fvWaAZTv31oC9ovhV41R9OYan3E5Hn4Me7MlHqao=;
        b=ReRsHKaRkHrs/nEks4RmLyWJIaJcU8ntFtYABa4Dz8jKwIVzlMaW4lssGX2d0D6XWi
         9iJSoN8o3G4ztWZSm/qAe/6HqyAeWnxpUy+35r2MoOfZc02kVBVx7WUdVv8LsLwUBpuq
         v2FahX+GRgrezWgREOLlOYYPdFmJb1OS3oUq8tTx1esRp/fcCNUx69S8CIP+JGZ+ItTj
         5QKu2spYyAdgfyvc2ZCQQ62NmC+YVM2HH9HY5aX3NI6M05p7aNJrjQW7RG1LtxyK0VbU
         g/dAzmx/8JWvE1TT35Nkt/8IPbwfmwciFNdjmSFfJNxw8iHbiLuwSorYp0PNRS6MolqI
         fxsA==
X-Gm-Message-State: AOAM530XLzRuQ0z/fl18SM4/E09lnVx9JvZsTsk2vJPfYynk5PxnshNC
        esgz57bDTJROrA8xkT4ldxqet9iyuyq4eg==
X-Google-Smtp-Source: ABdhPJz5pVycUAUnPkUoOj5EEeIyMN3UD7MqL9edoLVG3kOmI/4nCNwkI7uYkijol2fWRb/a5DtjVw==
X-Received: by 2002:a62:b515:0:b0:42c:1d6e:3697 with SMTP id y21-20020a62b515000000b0042c1d6e3697mr6728074pfe.23.1632434064858;
        Thu, 23 Sep 2021 14:54:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s4sm6474569pfw.182.2021.09.23.14.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 14:54:24 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        sparclinux@vger.kernel.org, Nicolas Schier <n.schier@avm.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] sparc: Add missing "FORCE" target when using if_changed
Date:   Thu, 23 Sep 2021 14:54:18 -0700
Message-Id: <20210923215418.3936726-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1740; h=from:subject; bh=Hi7mcbZQHql8JSSHs4df7iME4Qh5LyRhGPXmEIr0KIM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhTPeK0F/lnHe1QtyWqYJaRZ7GdQ4iM4IHlTaipc+D HmZ0Y06JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYUz3igAKCRCJcvTf3G3AJpdaD/ 9CSsUqhdMc08Bxkzl4r+hGn7L0dUJO/0ix9wg5V3/6Dbh+mB/eqcwCvq9kGRbvGCWt6O/V62mxv4Vl SbJGH5PTiDVkCArO/liNSHWtJ5KxsK4qyPveSCi2p+yNjgH6kezcnft6x2jUG24XDHund4Go9P06V5 wRlFBaqQFUF6BqnG3vEcKlOir0nAxSE6q6KkBnZc6v8fYp6wpg0Yppe+wZ6IIZN8wNSgoC2SnjirVz nqD6eq/kbu8U9S+SAUP/vDN5W7hoSSBigBmiuMX4hSTjICopx2bUZFLT88rw1MuWtb4+AKbuMkITiW 3WTptPf1hhI2bPayOMW8+whe23hba/Qlrgq0PjuT92CpYAjUB/MFbfaS5fhwhN9w8seCKmxPTCCGJD iDyuIo2oPMwUW6zVP9wsf1HGhmaNmEBVvcN3SzPRR/xkfhJgEnbpFOU/Py1RzDY9yUs/DJ2v1Pu8Bi KnU1plyHY4P/IE0Ai8EZwvY0Lm0p2CTJ/zAcWvEj/yrfZ7Zux+luanfw6lEePxyLQhRgW3wZL/4FMZ 1rH2w/KfbbtU6w9biWSpduSNz+e91L4ftIy+oS33AlRZAXK/CoX1aZtu6CbLvHZozK+vFxkck9pdJw dLNMRNRKGkWUE36n6XVs0vUkPLGAUk0b145ol/m0ssFMO+P4tuSpclAVoQzw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Fix observed warning:

    /builds/linux/arch/sparc/boot/Makefile:35: FORCE prerequisite is missing

Fixes: e1f86d7b4b2a5213 ("kbuild: warn if FORCE is missing for if_changed(_dep,_rule) and filechk")
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
I'm not sure if this should go via sparc or via kbuild. :)
---
 arch/sparc/boot/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
index 849236d4eca4..45e5c76d449e 100644
--- a/arch/sparc/boot/Makefile
+++ b/arch/sparc/boot/Makefile
@@ -22,7 +22,7 @@ ifeq ($(CONFIG_SPARC64),y)
 
 # Actual linking
 
-$(obj)/zImage: $(obj)/image
+$(obj)/zImage: $(obj)/image FORCE
 	$(call if_changed,gzip)
 	@echo '  kernel: $@ is ready'
 
@@ -31,7 +31,7 @@ $(obj)/vmlinux.aout: vmlinux FORCE
 	@echo '  kernel: $@ is ready'
 else
 
-$(obj)/zImage: $(obj)/image
+$(obj)/zImage: $(obj)/image FORCE
 	$(call if_changed,strip)
 	@echo '  kernel: $@ is ready'
 
@@ -44,7 +44,7 @@ OBJCOPYFLAGS_image.bin := -S -O binary -R .note -R .comment
 $(obj)/image.bin: $(obj)/image FORCE
 	$(call if_changed,objcopy)
 
-$(obj)/image.gz: $(obj)/image.bin
+$(obj)/image.gz: $(obj)/image.bin FORCE
 	$(call if_changed,gzip)
 
 UIMAGE_LOADADDR = $(CONFIG_UBOOT_LOAD_ADDR)
@@ -56,7 +56,7 @@ quiet_cmd_uimage.o = UIMAGE.O $@
                      -r -b binary $@ -o $@.o
 
 targets += uImage
-$(obj)/uImage: $(obj)/image.gz
+$(obj)/uImage: $(obj)/image.gz FORCE
 	$(call if_changed,uimage)
 	$(call if_changed,uimage.o)
 	@echo '  Image $@ is ready'
-- 
2.30.2

