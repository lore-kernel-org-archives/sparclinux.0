Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685483;
	b=P+TkSPEgbZ6K4IkgVbWt6/EplOoXP/+RIapM4Qpkx4B0sTTy0hXd436DAsFPvzoRqgKw
	 4/zvdMEGO46gtLiJj8OUIa9ykLa9tI07kFTRdQ5yDSjXusYM2jFzzTqPN4Mr5iZZy1RwN
	 DskGawe4WY3qjVfCNn5BZnO+yJ8wZhWvNRt/nukuwbZsbl0LuHcnQfN2ctU/BfkLGQ3du
	 TO0H6ScFrJt3k4ZUiYiixV3eKuRg11MoM8wFPKOcZiSZBPugiEStG1Ye7XIBXOi1fb/QV
	 wPfIdFUp9iQfX3i1o3KV0mDcgYFwMy3eNlwI5lqjmmvnhM1IDujtDAb8bLOiBWOSrfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nwfQ/uhT3WPczWnDNwIoPHc9UZao7lfTv4ZO8Ma8hAU=;
	b=PthUCNYr24GqkDAfmnjYFJuy2DZwCzuVyMGLuZ3UFmU+8781iB57FFixxgs3vM30urWr
	 TjwU0Dq43HmiGkXHWsmdx73Y+8RdnQqlxZwaMt/B3zB2byGVAkUrv8ZTUxjyAEiLnamKY
	 B7C6rRPa7mllf+Kz+2CczvfJp+CfFE1uzqLKdZd4B5kNSXWzHeb3ymJ5JDa/d0xhGtHIZ
	 A3MlijqLEujWyRbwzekiEcQG7VtEda/nSLFPUlITQbrNpGWe64RbE8LGvEpjoZ+uBNayi
	 yekWWZBaIlIIsDEgL/k8laA7PjwbC1Apx1v9H1R4QdJeYX5Mf1t9QvyswYnm2Tc9I9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w1CSvlZo;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D571606A327
	for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 09:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D571606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w1CSvlZo
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c516a1623d0so728873866b.2
        for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 01:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685481; x=1796290281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nwfQ/uhT3WPczWnDNwIoPHc9UZao7lfTv4ZO8Ma8hAU=;
        b=w1CSvlZop21uujTolx+tFq0YkK2DVk9f2VwdkVB6t5zvRszi63WyX/iLfgjT3CsqnN
         uFmosd3dS8/cUK1MbQNWCxMZDLZBGFupA+CcKA2cYzJIR9Y7Z3nxL//MlMXQ7M16RTQJ
         PZCgWEoswKwUkvYLmnroOZgzmFccl0AyKLRS+VhwbTk64LSVTZTi59oqscc3RkQ+ECgJ
         FaRTOTdu1Fmjmbarox2lFeKvYOkbt/dIRLttvwaaY2hzPMzi5NvpwnvXz85y/ZMT8DiF
         tqpNyWJM8kt6w+eUN8iAGbxD6F7jNmSvVFM2OG47K2g4VUqrFsGphZ1e/g2fznjR/niQ
         Zd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685481; x=1796290281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nwfQ/uhT3WPczWnDNwIoPHc9UZao7lfTv4ZO8Ma8hAU=;
        b=plDvPmUMqNx+8OsIgOnUx071Br6a+6MKlwTPC7nyy3C3ONzfdEqtdDOnBnzo38/snb
         Z5uFdSjZu5/Q17EDESDt9qNZ0MffasNM5gVbzpRBbBqX3Ahzsm6YDpyOx4CAh5NNtZd6
         iYpUapnkiAAIhFhgYpHM2QeOSNaJTX9Ya8hP1bEyRLqciVKglKl6OIT/lrUvYDFYzlnQ
         Bk8G2LhI1KQBK+iyfoPrc+/wbIvnYBUvYzJNNhFyFq3Jeo3Gy0W7+G8Ahh6qnGYnCozB
         CHuMIs21qF7UJvZJPyMSEGHe5tGxngk5QyApa9V+OqBy9nZJzkouivfiyN1sI5XTDbmq
         yzSQ==
X-Forwarded-Encrypted: i=1; AL+hErF8IEywNosrcEb/X3fZuCiCLcs9iqK3fOyH4Eay7fgyqf2kjzwJ3BsBKhgu/6kRyNnYhzWouWmRS/sN@vger.kernel.org
X-Gm-Message-State: APuU4Z8iF4Tvb1uMmOF8xNUf6HgWtvL4ixrSF0ulVbXiovo2t/Us3Gw0
	/5MtjwA1Gs4n/gX2K9PP5jrQ1IGzSEYI0Du1zNGFxXGTpanvirPVQpFx
X-Gm-Gg: AZFdTZe0KjyTnl+ZJcp3sbIT+TJmSuobYYOaYbJlOcFspR/oxBlUEpnMb8iWF6kBfM9
	0d5o05FC6ELisndXHEuKBcnEDYWHTUgqvCrjC/TdjLpyOmduH1RPoL16OOhtADs/D15br4Sd2ES
	NRwbweBNr06j6L7OIQYCCB6fB1PGUXLyxYEbukVX5qbBr7bJHgMzoa4q7p2+F4mJKuGzoD5E7Fp
	46YDpDFqsKoqPS+st8QVM7alFlmX2hCUzS0IYzkR0rtha/1UWyMfQ/skkS6f4q8VUuIGDCfeAKa
	E+3fX9d7Uxp8H1+ffHnFzoqZ7RCHmDE3Vj+qfdOVYH2ls0wLC+3b9tjgOjqc0wpO9JUbkSC0DqQ
	wSV4Vf5T4gk91oLUpYXpMPskzwhtyoWY0hwXJseO17bf0SJ/6524rVJNENPFAEctexDlYl8kYlE
	ikmQVqe6TDo4MsGAegHdlrYWTL40w++xrZBUv/Ya/vM67Ollp3+Hu6sLw9enz6/h7KSRJzYqqFp
	79FUxMOAJR8O6MTHlrM/aldmi8PD+ADhdCwp76KxKf/iEDKppvRvjWXJ0ukRTfSBIUb6k3++KSX
	WOy4CfTMo/KHkBGzGsbBr2OCp0J/nDemhKLvrkf1NkNDvyOi9JpNLtjV9qxQENWG9bFr4og=
X-Received: by 2002:a17:907:6089:b0:c4d:f63:642 with SMTP id a640c23a62f3a-c513a99e69bmr1991282966b.33.1795685480823;
        Thu, 26 Nov 2026 01:31:20 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdee82sm597090066b.66.2026.11.26.01.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:31:20 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH 01/18] sparc32,leon: give the cross-call IRQ highest priority
Date: Thu, 26 Nov 2026 10:30:06 +0100
Message-ID: <20261126093106.1345825-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126093106.1345825-1-linmag7@gmail.com>
References: <20261126093106.1345825-1-linmag7@gmail.com>
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

A CPU can spin on cross_call_lock at PIL 15 while the lock holder
waits for it to acknowledge IRQ15. If firmware gives a lower-numbered
interrupt higher priority in IRQMP, that interrupt can keep IRQ15 from
reaching the waiting CPU.

Put IRQ15 in IRQMP's high-priority group before enabling cross-calls.
IRQ15 wins within that group. Preserve the priorities of the other
interrupts.

Fixes: 8401707ff645 ("sparc,leon: Sparc-Leon SMP support")
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/leon_smp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 1ee393abc463..649f219e2b69 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -159,6 +159,7 @@ void __init leon_boot_cpus(void)
 {
 	int nrcpu = leon_smp_nrcpus();
 	int me = smp_processor_id();
+	u32 level;
 
 	/* Setup IPI */
 	leon_ipi_init();
@@ -167,6 +168,14 @@ void __init leon_boot_cpus(void)
 	       (unsigned int)nrcpu, (unsigned int)NR_CPUS,
 	       (unsigned int)&(leon3_irqctrl_regs->mpstatus));
 
+	/*
+	 * Cross-calls must reach a CPU even while it spins with PIL 15.
+	 * A lower-numbered IRQ in IRQMP's high priority group can otherwise
+	 * keep IRQ15 from reaching the CPU until that IRQ is serviced.
+	 */
+	level = LEON3_BYPASS_LOAD_PA(&leon3_irqctrl_regs->ilevel);
+	LEON3_BYPASS_STORE_PA(&leon3_irqctrl_regs->ilevel,
+			      level | BIT(LEON3_IRQ_CROSS_CALL));
 	leon_enable_irq_cpu(LEON3_IRQ_CROSS_CALL, me);
 	leon_enable_irq_cpu(LEON3_IRQ_TICKER, me);
 	leon_enable_irq_cpu(leon_ipi_irq, me);
-- 
2.43.0

