Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2667CC61DA4
	for <sparclinux@archiver.kernel.org>; Fri,  3 Feb 2023 22:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjBCWHB (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 3 Feb 2023 17:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjBCWGa (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 3 Feb 2023 17:06:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2CFAF69E;
        Fri,  3 Feb 2023 14:06:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92CAC6202C;
        Fri,  3 Feb 2023 22:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5039DC433AA;
        Fri,  3 Feb 2023 22:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675461960;
        bh=7d++Hui9U2QmrKVsgoxi792ojGAxFKsPKUzhCpj0Vz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aUxqaJ3ww87KOGdisOk/HBl19AfmCI5IwgU45YTMMCbIOEAKmYokeRwWgk458aBdz
         KAB2IA5A6KZwBO7KL27vUbssmzJh7ENV38QqtoqOcvWzHLrWYU0SayIkMkcSRT9MFV
         rTXdxTX48v4hwkeYdjTBdMWiSWGW97wTHOHIHCoTCLhuLDOSQ6E13CVInzoI5HdmNi
         3mbcM1YB9zlDGO+z4veQYZkCQn+awXjDQLZSURiYJducHsArb8fWxtgCDFxv5s177E
         FUekw0iJc/v9Ta+STjHGBIEOmOzc69H99WWgT7FCYTGb4FUxkC0cXDeNCacXAzXnoD
         6xgtVXdRGS0sg==
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
Subject: [PATCH 10/22] mips/cpu: Make sure play_dead() doesn't return
Date:   Fri,  3 Feb 2023 14:05:19 -0800
Message-Id: <b131d3e00967034d86692b894a66c6a656e7de3f.1675461757.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1675461757.git.jpoimboe@kernel.org>
References: <cover.1675461757.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

play_dead() doesn't return.  Make that more explicit with a BUG().

BUG() is preferable to unreachable() because BUG() is a more explicit
failure mode and avoids undefined behavior like falling off the edge of
the function into whatever code happens to be next.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/mips/kernel/smp-bmips.c | 2 ++
 arch/mips/loongson64/smp.c   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index df9158e8329d..be85fa075830 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -414,6 +414,8 @@ void __ref play_dead(void)
 	"	wait\n"
 	"	j	bmips_secondary_reentry\n"
 	: : : "memory");
+
+	BUG();
 }
 
 #endif /* CONFIG_HOTPLUG_CPU */
diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
index 660e1de4412a..c81c2bd07c62 100644
--- a/arch/mips/loongson64/smp.c
+++ b/arch/mips/loongson64/smp.c
@@ -822,6 +822,7 @@ void play_dead(void)
 	state_addr = &per_cpu(cpu_state, cpu);
 	mb();
 	play_dead_at_ckseg1(state_addr);
+	BUG();
 }
 
 static int loongson3_disable_clock(unsigned int cpu)
-- 
2.39.0

