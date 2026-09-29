Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F57452CCE4;
	Tue, 29 Sep 2026 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689449; cv=none; b=BCjyRVIziEtgA4WBVSMEE+vW0QQFNOoIpWHE2dghaIkXkyrhhxOHIacs4H/jz3qXztBhfTGO3ntaX4OyXuWGhsZORGgGleR/hsT4GnIlf/MnYKf9nTXavo0/Ld5z6gS7QzHHGCP7MOIdswlqceNCBviAdSTq0NtiglWhflr4jrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689449; c=relaxed/simple;
	bh=hIfRpnCqDW1vxGSO3OJHWVeR0uPAJLGj9eqpEYk0C8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccXrJSnM7E3yXzYnntJ5nTqzHy2R8rRcXqiQ6YjQpRnrnjTQbcEiQgXdpi5nOsEPWEtoAHb3IOcy+6w7WYVI/buS8avRjAYyZVsBg6MD2PLG0yKLMN6XWclQgeBWvNMfaF/ej+ljlDfcOacEEGPMPBSenPKv9VAcXwuwgYRk6vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=ncy7Xar9; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="ncy7Xar9"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790689442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FmB7mYo730DHrgC/G0GPm86kcoZLRNt+jml80pgZmts=;
	b=ncy7Xar9G+UlwE6tqNYq8JKm4Dw+PeI5p4yZgkQH4+4tcXfZUqm0oJAah8y+xV/9DPWsz2
	7sdNZvu5ub++J+csOTd6VWYaVHI38tvBuv9ol7V6UMdEL/QDCk/ivzHcsSqve0zONAfJc3
	OiTPFo/gZxEsb6IALRCbIlBRCHRxNF4=
To: "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH 5/5] sparc64: Match the machine description's combined crypto names
Date: Tue, 29 Sep 2026 15:43:53 +0200
Message-ID: <20260929134353.3879030-6-stian@itx.no>
In-Reply-To: <20260929134353.3879030-1-stian@itx.no>
References: <20260929134353.3879030-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

crypto_hwcaps[] is indexed by CFR bit, and mdesc_cpu_hwcap_list() reuses
it to match hwcap-list strings. Those are two different namespaces. CFR
has a bit each for the Montgomery multiply and square, while the machine
description names the pair with one string, so "mont" and "xmont" match
nothing.

Nothing breaks today: any recognised crypto name sets HWCAP_SPARC_CRYPTO,
and a chip offering the Montgomery operations offers "aes" too. It is
still wrong, since a machine description listing only the Montgomery
names would leave HWCAP_SPARC_CRYPTO clear.

Match them from a list of their own rather than adding them to
crypto_hwcaps[], where they would claim a CFR bit that means something
else.

Signed-off-by: Stian Halseth <stian@itx.no>
---
 arch/sparc/kernel/setup_64.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 6f3b1d56a8c79..a53fe2d1eabba 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -396,6 +396,14 @@ static const char *crypto_hwcaps[] = {
 	"xmpmul", "xmontmul", "xmontsqr",
 };
 
+/* crypto_hwcaps[] is indexed by CFR bit.  The machine description names
+ * the Montgomery operations with one string each where CFR splits them
+ * into a multiply and a square, so those names need a list of their own.
+ */
+static const char * const crypto_mdesc_hwcaps[] __initconst = {
+	"mont", "xmont",
+};
+
 void cpucap_info(struct seq_file *m)
 {
 	unsigned long caps = sparc64_elf_hwcap;
@@ -506,6 +514,12 @@ static unsigned long __init mdesc_cpu_hwcap_list(void)
 				known = true;
 			}
 		}
+		for (i = 0; i < ARRAY_SIZE(crypto_mdesc_hwcaps); i++) {
+			if (!strcmp(prop, crypto_mdesc_hwcaps[i])) {
+				caps |= HWCAP_SPARC_CRYPTO;
+				known = true;
+			}
+		}
 
 		if (!known)
 			pr_info("CPU CAPS: unknown hwcap-list entry '%s'\n",
-- 
2.43.0

