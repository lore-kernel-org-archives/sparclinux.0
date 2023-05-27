Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5342FC7EE32
	for <sparclinux@archiver.kernel.org>; Sat, 27 May 2023 01:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243908AbjE0Bm7 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 26 May 2023 21:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbjE0Bmw (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 26 May 2023 21:42:52 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB28E50
        for <sparclinux@vger.kernel.org>; Fri, 26 May 2023 18:42:32 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d2e8a842cso1214092b3a.3
        for <sparclinux@vger.kernel.org>; Fri, 26 May 2023 18:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685151752; x=1687743752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CpMXuml+REzVPCV5YpF8KcdPL/FMQZnR1a5DDg0o94=;
        b=lWWP/2wciP5Lcnvzvjsar/98gic2UMLjL7shy/u4jcBVbG5MnQbC3jVJH8wV32l4xR
         /nrvT+VbnmoHL7WUx9Zoh+UT6oazi8OyVzo4oafQGAwcJbnMk2/Hi1w+wVB/DP/r1xpp
         TGm6jAwztGOFKItK9wAegBPuXnpdHRPuC12Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685151752; x=1687743752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CpMXuml+REzVPCV5YpF8KcdPL/FMQZnR1a5DDg0o94=;
        b=f4zHd6yJoeKvpMqpdG5X3hDi87FK1YjkzzFwWWW3e3K8KjWj+8bzdOw9HgGvzoiGXf
         NOQRua2VFOFUBTVePuHJ7dph5Dx5pHL0Pmkci9HclVrTY1tPfOtmXCytD1CbcJ8x+U9X
         cC1EGNPfEZhiyEYO7FZDmBu1DgDdGMfpbUwKVFf9a2UQysepT3ELvi9/+rgvGhDyOoB/
         13XOkU/pskzbkAe8Uy6cEwt26mmIIAghpJbEeJnAO/lb0g9JhuXzXAGK20rr9BxDnyyl
         7oBxoTQ0k3wdlMhrzlomcKryG6C2mSPLLD8z9NKzfja/ZlwX5TPvv7zJhckbimQJkIe0
         Olpw==
X-Gm-Message-State: AC+VfDyB974KU+u8hszUNVeu1segvaXC8HYfooc+yndKyalZiltFm/N3
        nuSyTqN8k8j1Ut8alVGoR33G4g==
X-Google-Smtp-Source: ACHHUZ6DB7hFCO3S8IN2pb5iImgPKyxBk6jrI7pr6oeNwgGoZm+rSryxNvvUZrHJqd9sGrPZ5NEogQ==
X-Received: by 2002:a05:6a20:2d2a:b0:10c:7c72:bdd6 with SMTP id g42-20020a056a202d2a00b0010c7c72bdd6mr1357189pzl.59.1685151752164;
        Fri, 26 May 2023 18:42:32 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4015:7255:c79a:26d7])
        by smtp.gmail.com with ESMTPSA id x25-20020aa79199000000b0063b8ddf77f7sm3202440pfa.211.2023.05.26.18.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 18:42:31 -0700 (PDT)
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
Subject: [PATCH 09/10] watchdog/hardlockup: Move SMP barriers from common code to buddy code
Date:   Fri, 26 May 2023 18:41:39 -0700
Message-ID: <20230526184139.9.I5ab0a0eeb0bd52fb23f901d298c72fa5c396e22b@changeid>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To: <20230527014153.2793931-1-dianders@chromium.org>
References: <20230527014153.2793931-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

It's been suggested that since the SMP barriers are only potentially
useful for the buddy hardlockup detector, not the perf hardlockup
detector, that the barriers belong in the buddy code. Let's move them
and add clearer comments about why they're needed.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/watchdog.c       |  6 ------
 kernel/watchdog_buddy.c | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 6cc46b8e3d07..a351ab0c35eb 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -109,9 +109,6 @@ EXPORT_SYMBOL(arch_touch_nmi_watchdog);
 void watchdog_hardlockup_touch_cpu(unsigned int cpu)
 {
 	per_cpu(watchdog_hardlockup_touched, cpu) = true;
-
-	/* Match with smp_rmb() in watchdog_hardlockup_check() */
-	smp_wmb();
 }
 
 static bool is_hardlockup(unsigned int cpu)
@@ -141,9 +138,6 @@ static void watchdog_hardlockup_kick(void)
 
 void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 {
-	/* Match with smp_wmb() in watchdog_hardlockup_touch_cpu() */
-	smp_rmb();
-
 	if (per_cpu(watchdog_hardlockup_touched, cpu)) {
 		per_cpu(watchdog_hardlockup_touched, cpu) = false;
 		return;
diff --git a/kernel/watchdog_buddy.c b/kernel/watchdog_buddy.c
index 2ef88722c5e7..34dbfe091f4b 100644
--- a/kernel/watchdog_buddy.c
+++ b/kernel/watchdog_buddy.c
@@ -51,6 +51,13 @@ void watchdog_hardlockup_enable(unsigned int cpu)
 	if (next_cpu < nr_cpu_ids)
 		watchdog_hardlockup_touch_cpu(next_cpu);
 
+	/*
+	 * Makes sure that watchdog is touched on this CPU before
+	 * other CPUs could see it in watchdog_cpus. The counter
+	 * part is in watchdog_buddy_check_hardlockup().
+	 */
+	smp_wmb();
+
 	cpumask_set_cpu(cpu, &watchdog_cpus);
 }
 
@@ -68,6 +75,13 @@ void watchdog_hardlockup_disable(unsigned int cpu)
 	if (next_cpu < nr_cpu_ids)
 		watchdog_hardlockup_touch_cpu(next_cpu);
 
+	/*
+	 * Makes sure that watchdog is touched on the next CPU before
+	 * this CPU disappear in watchdog_cpus. The counter part is in
+	 * watchdog_buddy_check_hardlockup().
+	 */
+	smp_wmb();
+
 	cpumask_clear_cpu(cpu, &watchdog_cpus);
 }
 
@@ -88,5 +102,12 @@ void watchdog_buddy_check_hardlockup(int hrtimer_interrupts)
 	if (next_cpu >= nr_cpu_ids)
 		return;
 
+	/*
+	 * Make sure that the watchdog was touched on next CPU when
+	 * watchdog_next_cpu() returned another one because of
+	 * a change in watchdog_hardlockup_enable()/disable().
+	 */
+	smp_rmb();
+
 	watchdog_hardlockup_check(next_cpu, NULL);
 }
-- 
2.41.0.rc0.172.g3f132b7071-goog

