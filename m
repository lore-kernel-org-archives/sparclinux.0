Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792625697;
	b=hOEnij91zPsqTyxDLBtsw1zAcdJSlTyhPbaWGCopgHAhqrp3jtABBaZbLE0kJwW/UpVG
	 gYIbSHQD/Bj41Qy2GJkbFxTf7XQbHJ2ZLtHAz0B0s61TGUqAornIAGDKRwM75aXLROwrK
	 fK0Lx/HNdB471xwcLsIludefMKwuM3jNDscjO+s0YrSGTKLQlfe0gsQ4dEeb2pN2E4dKA
	 cpTnODZ99QMTK/lgt6xUF2+g23R/XRnaQqK44sUO+g0fylflFr/N4sojSuE2zRNQmFG6t
	 3KPdQxYyJ27VfV0YJVAXPnRaB1ojaoV66ctMwX79nOXKCOyDrrJtGLPTk9aoJ5cFJQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625697;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=b+mC8VYd4OIdAs5s1Sr2HQYuGE+BUuD12RZl8Figbho=;
	b=oclR0mQpkLHADm+0NQaYKEqum5NUyOnBFN4hjtSUIJluswPzk8BmGut98XRj/beIjNxG
	 1oauuMBFq8grEgAKxcIm5yUPtwyDHYzbgFDXVlxoW0hjSQ1QUe5/QtW67RiW+GDoq7qJP
	 OrIf5uxHyt2EZx7pNmtSf23UYg+UGvTG6Cfanz1f97NFW00oAFfwTt/YYAcw5KhXL9ydJ
	 CLr98GbHN+Fn/OF2JsADLQevkCQNN/C4Uwsd+GpnAmMQKdEx+Slv0x84jl1c/pAtrPzv4
	 9IeCnJ6dUhrEeTTJPYp/TwioSy8uwZiLnWKKZU1nmdRzyT6HCUl2ORRVfm0k3cCWbag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M5sHW2cn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D05606A31F;
	Wed, 21 Oct 2026 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M5sHW2cn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772431F000C2;
	Wed, 21 Oct 2026 23:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792625697;
	bh=b+mC8VYd4OIdAs5s1Sr2HQYuGE+BUuD12RZl8Figbho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M5sHW2cnzWwkaf3Qjkf0OZTU7gUHdmKDYHdaTqfMhbjdkZjbnRg84RuEDsypeG6lp
	 bOp3H6s/TgsDqqE+JOQA59IpEbc+6OWNPbTQj6AMOLah9E9ht6OLOXdDCHBctcYMH3
	 hTtZmgQSBd3PJgLG5CoLHsRTA9AwVHa01J2AilkqIMHJui8LrU8MPgvTFVvxmJihoA
	 lAFSKomWZsB5yTPqBmcWm0vf6bczeXn5eOyk9SZV1Mnn8jqluU+Mn33sGq90m6NFic
	 CbALjsYjmcaM5tQBzI0Na6qKNsVvwT1QZOgS5g1qOhjQOfjFRqBNyhQ2ro7V8/agdk
	 xDuHDfWUC221A==
From: Imre Kaloz <kaloz@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 1/4] sparc64: skip the trap block in xcall_deliver() when there is no target
Date: Thu, 22 Oct 2026 01:33:37 +0200
Message-ID: <3bf5d270153bf6b8efb1673a9500df826ec28678.1792609488.git.kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1792609488.git.kaloz@kernel.org>
References: <cover.1792609488.git.kaloz@kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xcall_deliver() writes the mondo data and the target CPU list through
the trap block's physical addresses before it knows whether any CPU is
targeted. These addresses stay zero until init_IRQ() sets them up, so a
cross call made earlier, while only the boot CPU is online, would write
starting at physical address 0.

Return before touching the trap block when no other online CPU is in
the mask.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 arch/sparc/kernel/smp_64.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 371460e34484..4240c129c5fe 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -801,6 +801,15 @@ static void xcall_deliver(u64 data0, u64 data1, u64 data2, const cpumask_t *mask
 	local_irq_save(flags);
 
 	this_cpu = smp_processor_id();
+
+	/* The mondo block and cpu list are not set up until init_IRQ(),
+	 * so do not touch them unless there is a cpu to send to.
+	 */
+	if (cpumask_any_and_but(mask, cpu_online_mask, this_cpu) >= nr_cpu_ids) {
+		local_irq_restore(flags);
+		return;
+	}
+
 	tb = &trap_block[this_cpu];
 
 	mondo = __va(tb->cpu_mondo_block_pa);
-- 
2.47.3

