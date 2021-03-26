Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1488BC433DB
	for <sparclinux@archiver.kernel.org>; Fri, 26 Mar 2021 01:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D471B61A3A
	for <sparclinux@archiver.kernel.org>; Fri, 26 Mar 2021 01:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhCZBmZ (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 25 Mar 2021 21:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhCZBl4 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 25 Mar 2021 21:41:56 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E21C06174A;
        Thu, 25 Mar 2021 18:41:55 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id o19so2255837qvu.0;
        Thu, 25 Mar 2021 18:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=92hpsBw5fZe/a/OuoM2jEXQ3NJ9whjvCFIdXAjkbMRI=;
        b=guly8TdTGgHpEDCugy3FsLfVVNmJWt+YQgIhN18Euh5WmZ4gUJc50G43PKZxnLqsW1
         U5R1Evd/LtvibyozGOtJBb9kuCEgv9QIs+5ZzA4Ry5cmQUE2I9CI1tYHsohLDHhXzMfl
         k9GkSne6BVSCDxUSEBiGE51hz121a2sSHrYfIoI7Wv9Hm3phccwAArk6Ui1VBfNT96cJ
         2VKfQuQJHcUE/yzAtb/bXskxX1tHrj+cwrlYeEyEUANaNXPS0Z98hVkW75dgTv29vUrC
         3jygWtc+i4wfxCEGffjZwxrTCni6aZ1RtMBkeaN3+j+uLvtftFMdv6ZnmKi5OPjWgxrY
         15HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=92hpsBw5fZe/a/OuoM2jEXQ3NJ9whjvCFIdXAjkbMRI=;
        b=EzLXFddQdYm0V8qqJJFTh3Qk/O4jjNkvS6MVX9juRqjXcQTjokvDBoG7t0BkMTtbEB
         SiTxdZ2Meew3C7bLHyl3QNtucf8uXX+hO7OJW25z7MjYKBHxfF3+na7NhsZgcpWu6OkV
         Jbhnt26H2b8KIz8VV2KUXYg9XqepRq8KI/wkJGl5Gc67O36ir4fquJNlqJQnak5PrlRI
         4w6R2F45TRcfhGGkx4kf9KrsDF5c0FLSOMVZYbeX4rwKjpyHjH39AxFGxkwM+7C3QgnJ
         VPKgQ3CdRH/I4VsI5urdcXvRMwSoUtdJ40FXWLhbYEtvgZLwYnw3M1KJVBNGRsHSQ5ie
         Bvtw==
X-Gm-Message-State: AOAM532Oev9lGTGOoBx/Rv7ALlmsMMZWMdI17dLFIbHVfEmaLgCKwt3B
        7B5bSt4WB3Zv/9hca31KW+Q=
X-Google-Smtp-Source: ABdhPJz3bnTqvaE3+zyK+ye25gf+ip7HPOWdPO6FcPD9/G26Qn6PBkHVySFYAV9cjlEVJ0/73xK8pA==
X-Received: by 2002:a0c:f805:: with SMTP id r5mr11055926qvn.45.1616722915201;
        Thu, 25 Mar 2021 18:41:55 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.107])
        by smtp.gmail.com with ESMTPSA id o7sm5681072qkb.104.2021.03.25.18.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 18:41:54 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     davem@davemloft.net, will@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, tglx@linutronix.de,
        unixbhaskar@gmail.com, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] sparc/mm/srmmu.c: A typo fix
Date:   Fri, 26 Mar 2021 07:09:41 +0530
Message-Id: <20210326013941.8883-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

s/guarentees/guarantees/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/sparc/mm/srmmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index a9aa6a92c7fe..8a3804231d44 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -1480,7 +1480,7 @@ static struct sparc32_cachetlb_ops viking_ops __ro_after_init = {
  * flush resulting in corruption.
  *
  * Our workaround is to take a global spinlock around the TLB flushes,
- * which guarentees we won't ever have too many pending.  It's a big
+ * which guarantees we won't ever have too many pending.  It's a big
  * hammer, but a semaphore like system to make sure we only have N TLB
  * flushes going at once will require SMP locking anyways so there's
  * no real value in trying any harder than this.
--
2.26.2

