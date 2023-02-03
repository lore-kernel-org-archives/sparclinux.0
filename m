Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4261BC05027
	for <sparclinux@archiver.kernel.org>; Fri,  3 Feb 2023 22:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbjBCWIT (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 3 Feb 2023 17:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbjBCWHd (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 3 Feb 2023 17:07:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9943AF69A;
        Fri,  3 Feb 2023 14:06:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C71246202D;
        Fri,  3 Feb 2023 22:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E24C433D2;
        Fri,  3 Feb 2023 22:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675461971;
        bh=NrR4P0DY0KkRcvJJpvaBPY8nrqhj1/4WEFbiWkgx25U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IbvLI9SGR0mrEEcDvsTWGmRFY+xC5m55RleQxz9+JQteyCjIJS4oyATHgaLDKg8iT
         Mrcrj1tUqkDKFgDxhiACotXzzd+Ubb/npyitm47+khhnGTg6xyDpHKD0vy1jIB9u/5
         Kl5ByQZatrNlKTDjf0rI7hwfhuNbRiRVWk5imgdvp/hM5rNayYJmTUSlZKkk4SlpVs
         hNm1EBHVifr87GODpz8fpV5UZtd7OqZtrW9RwJeMKf5neI0Evpzkv/91pLQ3MbT6JX
         YQvfjazaZO7Yyom9jcaMJyey9HktA0dUciIGj3r15+QMSD68NRS+h08TN3KaJVaVuz
         sRz7u8p3VLZNw==
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
Subject: [PATCH 16/22] sparc/cpu: Mark cpu_play_dead() __noreturn
Date:   Fri,  3 Feb 2023 14:05:25 -0800
Message-Id: <eccdec6e86daed65bedd77f9c3e540503e1ed648.1675461757.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1675461757.git.jpoimboe@kernel.org>
References: <cover.1675461757.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

cpu_play_dead() doesn't return.  Annotate it as such.  By extension this
also makes arch_cpu_idle_dead() noreturn.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/sparc/include/asm/smp_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/smp_64.h b/arch/sparc/include/asm/smp_64.h
index e75783b6abc4..505b6700805d 100644
--- a/arch/sparc/include/asm/smp_64.h
+++ b/arch/sparc/include/asm/smp_64.h
@@ -49,7 +49,7 @@ int hard_smp_processor_id(void);
 
 void smp_fill_in_cpu_possible_map(void);
 void smp_fill_in_sib_core_maps(void);
-void cpu_play_dead(void);
+void __noreturn cpu_play_dead(void);
 
 void smp_fetch_global_regs(void);
 void smp_fetch_global_pmu(void);
-- 
2.39.0

