Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC4BC7EE31
	for <sparclinux@archiver.kernel.org>; Sat, 27 May 2023 01:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243628AbjE0Bm5 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 26 May 2023 21:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243811AbjE0Bmt (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 26 May 2023 21:42:49 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A7C1B6
        for <sparclinux@vger.kernel.org>; Fri, 26 May 2023 18:42:29 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d57cd373fso1972062b3a.1
        for <sparclinux@vger.kernel.org>; Fri, 26 May 2023 18:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685151748; x=1687743748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAUIzM0ipEZnJ+DKEACmhXTzJMTqgJKwduhWCKwpQIQ=;
        b=Q025PITc8JDv9dJTfN7tctFHTJNnpaJy29WWhsH2ZPNUoOboOZYviwhQysV0Gmhli6
         56fngg0HA+HuSP7ILjSstqS+Mhqo+R8NkGbp1+jpakojtJHDkgDTve7zASH3nWRB6R5B
         bOOBqThle1HJJLIUfe8O4ba5IMukCJE/7Qfis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685151748; x=1687743748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAUIzM0ipEZnJ+DKEACmhXTzJMTqgJKwduhWCKwpQIQ=;
        b=f+KFkyKihiKY/m2U6/m3sDJzs29YvWNrh3rhevhCi1hlE5ZZn+3y5+Yd3HmXR/lzp9
         bzwpg7d6PS7tYvUi6RkZ3OVEAtasVZd1sJIFqgg9SNhmLdgnIQmtEgwfTA8/IQvt4EhW
         F4gZTHqv55Xmbx8cktPCNbAfba7kQg7JJ5Hqfe5yOyV312lR2qKljsZT4pxMJ8yWjl9j
         D7VyL2GQA3lZgxcKMMk0962AT/RRDHwCJPPJ8WCTp78MV8KFL8LnK0Gzaa3idocT4PhI
         7q0wYuc/2dP6GE3ZAkHilyRyphS4PkKviNfN1d7a2awNRItRs4NBj1UoTVomAhF5kG3h
         hAAQ==
X-Gm-Message-State: AC+VfDyyJOXWErkuaPuFtscvTZw+t3yMqQDyYlO+yHE0QXdE2K//dDEU
        pNaqAuhZVdv84D5VMDnQkawpFA==
X-Google-Smtp-Source: ACHHUZ7CuB7PPQInlPEZH0k1cEJvxZtnt0cbbm9xAfq9bZv1LojzgB0/25WLra3jsMmghAsHAYATEg==
X-Received: by 2002:a05:6a20:7351:b0:105:3e47:7504 with SMTP id v17-20020a056a20735100b001053e477504mr902971pzc.11.1685151748589;
        Fri, 26 May 2023 18:42:28 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4015:7255:c79a:26d7])
        by smtp.gmail.com with ESMTPSA id x25-20020aa79199000000b0063b8ddf77f7sm3202440pfa.211.2023.05.26.18.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 18:42:28 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 07/10] watchdog/buddy: Don't copy the cpumask in watchdog_next_cpu()
Date:   Fri, 26 May 2023 18:41:37 -0700
Message-ID: <20230526184139.7.If466f9a2b50884cbf6a1d8ad05525a2c17069407@changeid>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To: <20230527014153.2793931-1-dianders@chromium.org>
References: <20230527014153.2793931-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

There's no reason to make a copy of the "watchdog_cpus" locally in
watchdog_next_cpu(). Making a copy wouldn't make things any more race
free and we're just reading the value so there's no need for a copy.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/watchdog_buddy.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/watchdog_buddy.c b/kernel/watchdog_buddy.c
index 3ffc5f2ede5a..2ef88722c5e7 100644
--- a/kernel/watchdog_buddy.c
+++ b/kernel/watchdog_buddy.c
@@ -10,12 +10,11 @@ static cpumask_t __read_mostly watchdog_cpus;
 
 static unsigned int watchdog_next_cpu(unsigned int cpu)
 {
-	cpumask_t cpus = watchdog_cpus;
 	unsigned int next_cpu;
 
-	next_cpu = cpumask_next(cpu, &cpus);
+	next_cpu = cpumask_next(cpu, &watchdog_cpus);
 	if (next_cpu >= nr_cpu_ids)
-		next_cpu = cpumask_first(&cpus);
+		next_cpu = cpumask_first(&watchdog_cpus);
 
 	if (next_cpu == cpu)
 		return nr_cpu_ids;
-- 
2.41.0.rc0.172.g3f132b7071-goog

