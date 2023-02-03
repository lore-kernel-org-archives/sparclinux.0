Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926BAC64EC4
	for <sparclinux@archiver.kernel.org>; Fri,  3 Feb 2023 22:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjBCWGA (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 3 Feb 2023 17:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbjBCWFy (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 3 Feb 2023 17:05:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47833AB5DE;
        Fri,  3 Feb 2023 14:05:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF6F5B82C32;
        Fri,  3 Feb 2023 22:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FD4C4339C;
        Fri,  3 Feb 2023 22:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675461950;
        bh=bmnsttKFT2vt8nGO3aA3GL09+qkDKrC1WcjQyEBFYe0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YE3hiGiiwH26Qr/K5PJOS+hNPeo3XuuCzqosW8oIqc0E3EJH0XGyBuNtXvJJ+SDrq
         JWmWDQWlcs+rYmML0rmuGU0SgDAh8zsWcPGWR/IeV9EOploqiQQdVC6qQ3Mjd98Kkp
         qRir1VJnOqGiyahlKVWc3Q3eeabaKpe08lyVFr75tS/LESPPL1b4z/fZbqVUOKw35u
         FmxMJjAAFN4EIAdXWaTf/CNUOG+n3QxS4Ayq9xfsJ63ylTjRXx8FH6ZqSSf9B9zOjo
         Do4XcGJmVDfvZbC1YhgBETGpx9fbFkRBfVkORFUvu04PjtpY5bUIjcbGas4InxOYCL
         W7lQoYSaYIxBA==
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
Subject: [PATCH 05/22] csky/cpu: Make sure arch_cpu_idle_dead() doesn't return
Date:   Fri,  3 Feb 2023 14:05:14 -0800
Message-Id: <f860f3a1c1a53c437a99abc53e8f1a798aef6881.1675461757.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1675461757.git.jpoimboe@kernel.org>
References: <cover.1675461757.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

arch_cpu_idle_dead() doesn't return.  Make that more explicit with a
BUG().

BUG() is preferable to unreachable() because BUG() is a more explicit
failure mode and avoids undefined behavior like falling off the edge of
the function into whatever code happens to be next.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/csky/kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index b45d1073307f..0ec20efaf5fd 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -317,5 +317,7 @@ void arch_cpu_idle_dead(void)
 		"jmpi	csky_start_secondary"
 		:
 		: "r" (secondary_stack));
+
+	BUG();
 }
 #endif
-- 
2.39.0

