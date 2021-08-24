Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF8DC4338F
	for <sparclinux@archiver.kernel.org>; Tue, 24 Aug 2021 03:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0F3B610A4
	for <sparclinux@archiver.kernel.org>; Tue, 24 Aug 2021 03:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbhHXDPc (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 23 Aug 2021 23:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbhHXDPc (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 23 Aug 2021 23:15:32 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176BCC061575;
        Mon, 23 Aug 2021 20:14:49 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 2so3032152pfo.8;
        Mon, 23 Aug 2021 20:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ujYXSWZq8gRvKyXRi7G6XOLOL8lAqLmb1mmsh5E+XjA=;
        b=mvkx5em1+20ktaamwmTTH42frKH8hq/tldNwoGwBHnWIoz6wkHzDvkavMCWGUvZF0b
         p55a9sh06dhU6pZyDayXGRDvoZwSzyfaV9eWe6L7cYRITFLSYvg+31miMUAmSrxV4YWo
         Pe99qEeb2mrneICXbFGwa0Rb79REDQ+H2mYU/EYAVL2Bgv9Y3BKapu4Lhz+vN/qabQ4R
         t7kmczfba82H5976SDxornWzxZ2K42r0jI8gDGZMI03/IDofQVRIoQnc8KzvSikzg57w
         YqrKrdS6QHp1JKPbDLoRZxTVRYI7z1U+VcifjHFIR3CqXnhLANwpDKOFCQJt6GDH3ZR9
         1RLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ujYXSWZq8gRvKyXRi7G6XOLOL8lAqLmb1mmsh5E+XjA=;
        b=Q45c5p7jo45mJi8EQK1KyONBpfPKrgwtOTWuii5t8qgfowg/hkSlnj1nk441P6wpyE
         O3zq9ZJtfn1J5DSmrN349qgrkTClYPOIkpCbXA8BBxqO7UUL3C8AD2bm9WBHCPQuFQ//
         XQ/jkQ49J3pTedjgIgTwvU7rDEJci2KdElXkCYCPKmGnxN8uw6lKjjdKOA4vwEckflgt
         dANJwRrKnQzD311AWtAkgHNJCLWNSDFMIYo70xLBwgnSTL5XlOB/FDCSSebV0iQMpxaP
         ImhtYriynJ+EoB0TaxeCODvs+XmOn39jCJE3bkZcFWqj+B6tFs397pr2PhK5bia/OCqq
         XTgg==
X-Gm-Message-State: AOAM533zXgESIMLDXAxPytS2YdtGHX+4+cme4lPxd7TJnp16dmrjoWlA
        8lLB8CHlcZq7qJj4QzreloKr00kjNg==
X-Google-Smtp-Source: ABdhPJxtinKmjdcQQjSkeFOV6uw8F6kgA55t5xAYu8rVvS0O/8WUESoKyznE+QuKamoRBwaOooUoSw==
X-Received: by 2002:a63:af12:: with SMTP id w18mr1081279pge.221.1629774888350;
        Mon, 23 Aug 2021 20:14:48 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 138sm11594983pfz.187.2021.08.23.20.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 20:14:48 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        Santosh Sivaraj <santosh@fossix.org>, Tejun Heo <tj@kernel.org>
Subject: [PATCH] kernel/watchdog: change prototype of watchdog_nmi_enable()
Date:   Tue, 24 Aug 2021 11:14:35 +0800
Message-Id: <20210824031435.9664-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

The only caller does not handle the return value of
watchdog_nmi_enable(). If there is an error, it seems to be reported by
arch specific code.

Hence changing watchdog_nmi_enable() return value from int to void.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Wang Qing <wangqing@vivo.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Cc: Tejun Heo <tj@kernel.org>
To: sparclinux@vger.kernel.org
To: linux-kernel@vger.kernel.org
---
 arch/sparc/kernel/nmi.c | 8 +++-----
 include/linux/nmi.h     | 2 +-
 kernel/watchdog.c       | 3 +--
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index 060fff95a305..5dcf31f7e81f 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -282,11 +282,11 @@ __setup("nmi_watchdog=", setup_nmi_watchdog);
  * sparc specific NMI watchdog enable function.
  * Enables watchdog if it is not enabled already.
  */
-int watchdog_nmi_enable(unsigned int cpu)
+void watchdog_nmi_enable(unsigned int cpu)
 {
 	if (atomic_read(&nmi_active) == -1) {
 		pr_warn("NMI watchdog cannot be enabled or disabled\n");
-		return -1;
+		return;
 	}
 
 	/*
@@ -295,11 +295,9 @@ int watchdog_nmi_enable(unsigned int cpu)
 	 * process first.
 	 */
 	if (!nmi_init_done)
-		return 0;
+		return;
 
 	smp_call_function_single(cpu, start_nmi_watchdog, NULL, 1);
-
-	return 0;
 }
 /*
  * sparc specific NMI watchdog disable function.
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 750c7f395ca9..b7bcd63c36b4 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -119,7 +119,7 @@ static inline int hardlockup_detector_perf_init(void) { return 0; }
 void watchdog_nmi_stop(void);
 void watchdog_nmi_start(void);
 int watchdog_nmi_probe(void);
-int watchdog_nmi_enable(unsigned int cpu);
+void watchdog_nmi_enable(unsigned int cpu);
 void watchdog_nmi_disable(unsigned int cpu);
 
 /**
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index ad912511a0c0..ea31fcf3b83b 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -95,10 +95,9 @@ __setup("nmi_watchdog=", hardlockup_panic_setup);
  * softlockup watchdog start and stop. The arch must select the
  * SOFTLOCKUP_DETECTOR Kconfig.
  */
-int __weak watchdog_nmi_enable(unsigned int cpu)
+void __weak watchdog_nmi_enable(unsigned int cpu)
 {
 	hardlockup_detector_perf_enable();
-	return 0;
 }
 
 void __weak watchdog_nmi_disable(unsigned int cpu)
-- 
2.29.2

