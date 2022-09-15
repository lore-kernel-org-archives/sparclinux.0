Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15927ECAAA1
	for <sparclinux@archiver.kernel.org>; Thu, 15 Sep 2022 15:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiIOPBK (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 15 Sep 2022 11:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIOPBJ (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 15 Sep 2022 11:01:09 -0400
Received: from m15114.mail.126.com (m15114.mail.126.com [220.181.15.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 298A852E50
        for <sparclinux@vger.kernel.org>; Thu, 15 Sep 2022 08:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=k1pB8
        EOkeK4dtio5llLZt3Jh+yAnefYiNu+DUp4HyuA=; b=H8mbbdTISmrQn7Z9yIbp4
        +AEL2hiHcHF4YRYFUQCEXjKxW3Q3NaGnuHBlLbgLk7HWzJKazdRhlyPQHDaV+08h
        ekHB5BryQodwbsPY6AqFmd99miETLetyT5Un/U5JqqgkwH/dKy62+SEv8eJwDjpm
        kR5MRNVrcR9DbEmO4IAyog=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp7 (Coremail) with SMTP id DsmowADn7VUhPiNjX9lbBg--.52542S2;
        Thu, 15 Sep 2022 23:00:50 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     davem@davemloft.net, sparclinux@vger.kernel.org
Cc:     windhl@126.com
Subject: [PATCH] sparc: leon: Fix refcounting bugs
Date:   Thu, 15 Sep 2022 23:00:49 +0800
Message-Id: <20220915150049.4079224-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsmowADn7VUhPiNjX9lbBg--.52542S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArW8Aw1UXF4DKF1DKFW8Crg_yoW5GFyDpF
        Z2kr4avr47uws2vw1xZ34DZFyay3ZYy3y7J3Z3KFnxZFnrWr15J3W5XryUKFZxtFyxuay3
        Ka1v9F1fKa40k37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR2ii3UUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3AN9F1pEEQuNTwAAsz
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

In leon_init_timers(), we should carefully handle several refcounting
bugs:

(1) we should use of_get_child_by_name() instead of of_find_node_by_name()
as the of_find_xxx API will automatically decrease the refcount of its
'from' argument.
(2) we should carefully call of_node_put() for the references returned by
OF APIs.

Fixes: 53aea7caf2e2 ("SPARC/LEON: find IRQCTRL and Timer via OF-Tree, instead of hardcoded.")
Signed-off-by: Liang He <windhl@126.com>
---
 arch/sparc/kernel/leon_kernel.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 39229940d725..917b45b2ceaf 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -305,7 +305,7 @@ static irqreturn_t leon_percpu_timer_ce_interrupt(int irq, void *unused)
 void __init leon_init_timers(void)
 {
 	int irq, eirq;
-	struct device_node *rootnp, *np, *nnp;
+	struct device_node *rootnp = NULL, *np = NULL, *nnp = NULL;
 	struct property *pp;
 	int len;
 	int icsel;
@@ -337,26 +337,35 @@ void __init leon_init_timers(void)
 		amba_system_id = *(unsigned long *)pp->value;
 
 	/* Find IRQMP IRQ Controller Registers base adr otherwise bail out */
-	np = of_find_node_by_name(rootnp, "GAISLER_IRQMP");
+	np = of_get_child_by_name(rootnp, "GAISLER_IRQMP");
 	if (!np) {
-		np = of_find_node_by_name(rootnp, "01_00d");
-		if (!np)
+		np = of_get_child_by_name(rootnp, "01_00d");
+		if (!np) {
+			of_node_put(rootnp);
 			goto bad;
+		}
 	}
 	pp = of_find_property(np, "reg", &len);
-	if (!pp)
+	of_node_put(np);
+	if (!pp) {
+		of_node_put(rootnp);
 		goto bad;
+	}
 	leon3_irqctrl_regs = *(struct leon3_irqctrl_regs_map **)pp->value;
 
 	/* Find GPTIMER Timer Registers base address otherwise bail out. */
 	nnp = rootnp;
 
+
+
 retry:
-	np = of_find_node_by_name(nnp, "GAISLER_GPTIMER");
+	np = of_get_child_by_name(nnp, "GAISLER_GPTIMER");
 	if (!np) {
-		np = of_find_node_by_name(nnp, "01_011");
-		if (!np)
+		np = of_get_child_by_name(nnp, "01_011");
+		if (!np) {
+			of_node_put(nnp);
 			goto bad;
+		}
 	}
 
 	ampopts = 0;
@@ -366,6 +375,7 @@ void __init leon_init_timers(void)
 		if (ampopts == 0) {
 			/* Skip this instance, resource already
 			 * allocated by other OS */
+			of_node_put(nnp);
 			nnp = np;
 			goto retry;
 		}
@@ -382,6 +392,9 @@ void __init leon_init_timers(void)
 	if (pp)
 		leon3_gptimer_irq = *(unsigned int *)pp->value;
 
+	of_node_put(nnp);
+	of_node_put(np);
+
 	if (!(leon3_gptimer_regs && leon3_irqctrl_regs && leon3_gptimer_irq))
 		goto bad;
 
-- 
2.25.1

