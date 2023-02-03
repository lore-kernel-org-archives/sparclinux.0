Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D90C05027
	for <sparclinux@archiver.kernel.org>; Fri,  3 Feb 2023 22:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbjBCWJI (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 3 Feb 2023 17:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjBCWIQ (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 3 Feb 2023 17:08:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA32AF0FA;
        Fri,  3 Feb 2023 14:06:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1361062038;
        Fri,  3 Feb 2023 22:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C566CC433EF;
        Fri,  3 Feb 2023 22:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675461982;
        bh=nXrabXpKFkbXCMFjc3rmCrrnT82/WMJleHEGw691mcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o8eHohITAVmxjRXNbpfeL/cd8yNdoWWWFTWag8bI9FPvrbMJMbn7FDeWO6jeb5YOD
         09wPFTEb38+tMtIgPe9CHEcvDL5qejhmyy++aNANFxprUQblrITcsG2eqHUbL8gmjP
         4gSQVCoZOcsy77T+LMkCLBQL3ugwMFw9fYlynnFYPAuVOyx0fjaF1UNV9fyR8q62PB
         h633UkAqPNNQmIqlOFdeaLl3kp8E9fQrbTqg4QDEu+JRFrn1I6ApIrNEekrHOTvbXp
         jHiZ0SPsYXyBzSGzOGZrRgHnyMS++i5x/iAEJAM5eK7R7f/TB4A4nPAJaqn+bn24YL
         BOf5EfzEJfk4Q==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, richard.henderson@linaro.org,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, guoren@kernel.org, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, loongarch@lists.linux.dev, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, jiaxun.yang@flygoat.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, ysato@users.sourceforge.jp,
        dalias@libc.org, linux-sh@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        linux-xtensa@linux-xtensa.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org
Subject: [PATCH 22/22] sched/idle: Mark arch_cpu_idle_dead() __noreturn
Date:   Fri,  3 Feb 2023 14:05:31 -0800
Message-Id: <2eeb4425572785d1f05d8761dba1cf88c2105304.1675461757.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1675461757.git.jpoimboe@kernel.org>
References: <cover.1675461757.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Before commit 076cbf5d2163 ("x86/xen: don't let xen_pv_play_dead()
return"), in Xen, when a previously offlined CPU was brought back
online, it unexpectedly resumed execution where it left off in the
middle of the idle loop.

There were some hacks to make that work, but the behavior was surprising
as do_idle() doesn't expect an offlined CPU to return from the dead (in
arch_cpu_idle_dead()).

Now that Xen has been fixed, and the arch-specific implementations of
arch_cpu_idle_dead() also don't return, give it a __noreturn attribute.

This will cause the compiler to complain if an arch-specific
implementation might return.  It also improves code generation for both
caller and callee.

Also fixes the following warning:

  vmlinux.o: warning: objtool: do_idle+0x25f: unreachable instruction

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/cpu.h   | 2 +-
 tools/objtool/check.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index f83e4519c5f0..8582a7142623 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -182,7 +182,7 @@ void arch_cpu_idle(void);
 void arch_cpu_idle_prepare(void);
 void arch_cpu_idle_enter(void);
 void arch_cpu_idle_exit(void);
-void arch_cpu_idle_dead(void);
+void __noreturn arch_cpu_idle_dead(void);
 
 int cpu_report_state(int cpu);
 int cpu_check_up_prepare(int cpu);
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0f67c6a8bc98..e3fa2279d612 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -167,6 +167,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"__reiserfs_panic",
 		"__stack_chk_fail",
 		"__ubsan_handle_builtin_unreachable",
+		"arch_cpu_idle_dead",
 		"cpu_bringup_and_idle",
 		"cpu_startup_entry",
 		"do_exit",
-- 
2.39.0

