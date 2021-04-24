Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A158C433ED
	for <sparclinux@archiver.kernel.org>; Sat, 24 Apr 2021 12:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B4D61482
	for <sparclinux@archiver.kernel.org>; Sat, 24 Apr 2021 12:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhDXMQr (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 24 Apr 2021 08:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbhDXMQo (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sat, 24 Apr 2021 08:16:44 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA02FC061574;
        Sat, 24 Apr 2021 05:16:05 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id nk8so11282623pjb.3;
        Sat, 24 Apr 2021 05:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=r1gXv13coxNNVVcBOEf3L5qiNAnvOA7HW7SOkda9D54=;
        b=kYRgP5XiPLgbHJe4oC/WtWzxVkZUMMJtMKtbrsOXJ4/9+LCtE6D13ykYEC2QTTu646
         JR/ZPDaWdJkgcDkeH/30EW8Adn+OtmDUOOYu/M3H9ULIq9PtkxJhmcYZbVLLnyBA6B/K
         O4ipvTEIAyx4KE8gfS8Ktb/ymD9W9EEXVDZDz+bn+evThuaYRQ5PKJvi/wKMcG/agrZa
         zA73L4EBgIiZoP67TG+GRXZXoA5TWq6jTVrHGX/uWZTb7I5j2xaU9eEU526clkn9xh+3
         wI3Bsb0g9NzWZ7AA+DbEnSJyunWzhwhV1kyB/dzeezvWebKfqFoq8CVhpDKE8eCU+fg/
         CA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=r1gXv13coxNNVVcBOEf3L5qiNAnvOA7HW7SOkda9D54=;
        b=lzbs3czZlye7tPsqADnPNIGEszUbxhRxUSCXeWS/0xHbApiN/gv0RPkC5tZKUJFur9
         2PDgTzvOj01NaB4fkRnaQR6/f2w48Kd0dcNZ/evmRdIzNhU8fN00xEFYiCXo7nYn6w/M
         QON+5TbbhWr29Yetdef7ADpR/qz5jzaod/r0WgMq/bs25cyh3YCYKw80ibsRw4di50vY
         8vBFfPv4hGlN19FkdbfrG351ZH6ASsWN3nV5Tvaz8engI5V+IDD1/uG++v0ruVLCmRHb
         CZjb64dyraHeR+59Y0lzIQkIbX7qV5cutC8hY05fAk8NbxtIxxoE4LaGgQr3/k6t6vV7
         8cnQ==
X-Gm-Message-State: AOAM532cpFPIBYNwKufDrCH7u9B79kDhzwy4RfnfZD/lK4XFXK0JodEg
        aatDbl+HAxJQ9jXudVwUUx+y1X80KnM=
X-Google-Smtp-Source: ABdhPJz0jN9trmZRph4TDy9/C1Fz7+hfi1CxGXWxd8ZUP6FzR1JngHBNXrhLTWk5Q9usIHGdCtEFtA==
X-Received: by 2002:a17:90a:c209:: with SMTP id e9mr11134321pjt.104.1619266565523;
        Sat, 24 Apr 2021 05:16:05 -0700 (PDT)
Received: from shreya-VirtualBox ([49.207.225.77])
        by smtp.gmail.com with ESMTPSA id e8sm1167308pfv.177.2021.04.24.05.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 05:16:05 -0700 (PDT)
Date:   Sat, 24 Apr 2021 17:46:00 +0530
From:   Shreya Ajith <shreya.ajithchb@gmail.com>
To:     davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        davem@davemloft.net
Subject: [PATCH v2]sbus: char: bbc_i2c: Replaced header file asm/io.h with
 linux/io.h
Message-ID: <20210424121600.GA2036@shreya-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Replaced header file asm/io.h with linux/io.h

Signed-off-by:Shreya Ajith <shreya.ajithchb@gmail.com
---
v1->v2:
Fixed missing spaces in the subject

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

