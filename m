Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7470C433ED
	for <sparclinux@archiver.kernel.org>; Fri, 23 Apr 2021 06:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AAB8611ED
	for <sparclinux@archiver.kernel.org>; Fri, 23 Apr 2021 06:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbhDWG4l (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 23 Apr 2021 02:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhDWG4l (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 23 Apr 2021 02:56:41 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA2DC061574;
        Thu, 22 Apr 2021 23:56:05 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q10so34555794pgj.2;
        Thu, 22 Apr 2021 23:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=YwCnxkXVRrLVAcaZu7Tt0zFvI7AfeBQzqeihkPgPDZI=;
        b=NaWkQ+BKCNjiXFDZ7Gm7qkfb+cJ/DGSYgJRYtzo2BQ/S0kNrXOG/tOEvqPoFozf41I
         V9kBPzwz334k6KoPzxFPxUcB0zk11tsoFDO6yAYzzRvTGP9ecUIcqyrig+GgVz2OC9Cd
         8PeScAxx+jY4wnRFFfqNxhCD8RFlecYKzTeTaFtMffcuTquHcqX7ojsmA3W4mEDlgRab
         Zn0qrMm2GgQ7Grsm2Sr2CzNN23g5nSqHqISvx4KBUulvAdXlmU8YQhjoya08B1LY0aHw
         k9VUhUTl4bPNZdDRPw8l8f4K14YF34yexHFY9LDDDspiUGpQxfhL+lExtjWlVqzuaSlT
         SJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=YwCnxkXVRrLVAcaZu7Tt0zFvI7AfeBQzqeihkPgPDZI=;
        b=RdtRp7SiXfJHkgGBnCE6GpDLXtdu5gtRLBaWFNsYzORqEr8EKvkaa0wh8mS7NXK4rO
         fyXF4pp0J1PiK8LbcuR8gRun/xR0/95G0Ap9qp2QHy+R0FylxSYzdsnnoHkBOmM8Erij
         IkcE2kotJhJN7wXFrTXX9TVCb2UHx2MBnkOK4Yor1XsZ9FK12cmMrCE9H8sOrOtCHEie
         kVt2zGgh5d1vUor9JB/L8BmsuGaUH0qsTX6uVPsua+ffhgaej1SQAJX4KvTgi5aJ1Adc
         SWXDabqFuvny6DoVNDlOudUF2KN1kps87kcS4SCG4FqPaWULrLPHgCtSU6wI0rHv/wjk
         k6lg==
X-Gm-Message-State: AOAM530DMZ9EsIn2yDZRyM/OsQH4bwhiqQ+oE5sdxcb1c/qFKVaU2QrU
        e/izZ+lzzORKSa7OWbW1HuBypymYQBr++xFx
X-Google-Smtp-Source: ABdhPJyJGsZ5F+USbYFqWRFWnoyY8uMqzjmeA4ZPw6lDk25CG2uV6vZifGZvrq8auO/UhvauDrZ/Rg==
X-Received: by 2002:a63:d915:: with SMTP id r21mr2444317pgg.69.1619160965221;
        Thu, 22 Apr 2021 23:56:05 -0700 (PDT)
Received: from shreya-VirtualBox ([122.167.91.182])
        by smtp.gmail.com with ESMTPSA id 31sm3872335pgw.3.2021.04.22.23.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 23:56:03 -0700 (PDT)
Date:   Fri, 23 Apr 2021 12:25:58 +0530
From:   Shreya Ajith <shreya.ajithchb@gmail.com>
To:     davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        davem@davemloft.net
Subject: [PATCH]sbus:char:bbc_i2c:Replaced header file asm/io.h with
 linux/io.h
Message-ID: <20210423065558.d5gy3zpxus6gsyc2@shreya-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Replaced header file asm/io.h with linux/io.h

Signed-off-by:Shreya Ajith <shreya.ajithchb@gmail.com>
---
 drivers/sbus/char/bbc_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sbus/char/bbc_i2c.c b/drivers/sbus/char/bbc_i2c.c
index 537e55cd038d..a4a38a405b6f 100644
--- a/drivers/sbus/char/bbc_i2c.c
+++ b/drivers/sbus/char/bbc_i2c.c
@@ -16,7 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <asm/bbc.h>
-#include <asm/io.h>
+#include <linux/io.h>
 
 #include "bbc_i2c.h"
 
-- 
2.25.1

