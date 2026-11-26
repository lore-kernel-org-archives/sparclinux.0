Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685485;
	b=ZXCLkS3K2mmzR4zEA75ELy69YhjfaO1R39iHt49QU6TY0P1OKlLeXWmoe1nacHrkbo0H
	 bvhAk5Qjetl8PyOapPN5eU+7HlcYSFgSAvkGyQIE1uVvx1fO249eFdwnO9TKQlUiP9+qx
	 zbDRhXksRv6hjJnaJORmPAIY2WFA/QxEXM+ZrRPEzZF61ADamvhkcTUXmhRkZk7L6pWk1
	 LksfUwwPcLRdOA+76PhFn3lUuUWG2VqE1k/l3GfH75R8nvZfwQ1Mve3nIgSoS+ZeeuQVC
	 KZinGw9m28vH1sdnWI/pe2D0ca6gFQgzI9aLHVHcqTxWPZ26TSS2LekQI4pNbExsiMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9TO3Aq7knsuXUdH7NBurIbnP0YvlZ2ZwCn4tGtf47GQ=;
	b=TGneCD5TtqBp04VjTLzWmPd6iw2C3KzFNFV/EIuuA7+klwkw+KT27S0jtQ3f6Wayhunl
	 vw+Ur4VvlOzY/vxYsqV6FUkzAh9fuBfqZ+E2AHs5XSyQj0aCfabvoofVDC+5/xGihCnAm
	 MEuDw/HdtSzNB6j99p1MKnh/xvtNCIDve39W+rEJWtY5hqkSyEHkYiDW+wsPuLDMckTJ2
	 S+rsLM5+ZjPHaY597di+G0ZdVLF1HRiFAMFEWHNkpK2tepGSDgXalmw3RYNj5g4zLsp29
	 6GiPpio+BQI0Tyui0Dfd/9+Bc51bGz4udVh9Z6au0/AtTPoWaSa9ylQgnfVEz9e5EUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E43HplFt;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7E0606A33B
	for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 09:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C7E0606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E43HplFt
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4395d31228so1158047766b.1
        for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 01:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685484; x=1796290284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9TO3Aq7knsuXUdH7NBurIbnP0YvlZ2ZwCn4tGtf47GQ=;
        b=E43HplFtGOMrWrrUbPSnQUTjl/zR46WD34Dkq/2vWpUQly/l9mnDTQHLg/dWDh1u1x
         2qbK/SOnbyTjm6uiGdvvVObvQn4oBHyPVhgIkQZGZ97ZzOlesguUCA7czvpyU78TmK/W
         95IhtxBLTni3M7IBH+xtB4rKRIxHemytv7X+nxj0aylc8DXOWmvcG9RM1sMuNLRWQPgP
         pmAvsIYM1s7LM1fStCycGyIG77JCVydr7HOrc+0EO8E/nyqMX5bcExiinMlyAYU3CKjs
         f8xBU8pS16aLKsVbJmb+tU18V7XgnxIRpPuEf6NfP5zLYOYcTuFTRQ4V7B9GNhXu6BQ/
         pn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685484; x=1796290284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9TO3Aq7knsuXUdH7NBurIbnP0YvlZ2ZwCn4tGtf47GQ=;
        b=0Oy77eXwckLgEYxzP6D8ZNSu05YCPoJORYHVCg/z7XDPCD6IEby+NqKrLYYMzkM90o
         6NoAQs2dzjuVBlOxGaY4j5mHPoFDQv8m3DFuVMccfi6hoRCAd9882KQfMivC7nMIy/hM
         2MVlmU1XucKP6UHskttuMla0vKgO30Non3K1h0A0U8R0vRa6Hu7mTB7kJzaKfJhfzxbh
         gnW+0L3X1UflIT56CI0h61LavxnCuPOOYAqq5BFAnScOn6ytlUxUoCdcmjljHExM4pOD
         84cYoD5/dhIOwd3Wi1EsnaVqQx/MVWBV2/7m2+kHi6cE+MVhFGSyEFt69rtQlhWCIiIV
         M0EQ==
X-Forwarded-Encrypted: i=1; AL+hErElVXbP8VmaLWFDbGK9717SOir1/WB+XHmbQ6bD1wfDmYRdWI0FzLtUob2iFm5xVrBF/BN7BTd3hA2s@vger.kernel.org
X-Gm-Message-State: APuU4Z+PXenfUJ7ZHK6x90yDGycwTWCuuCFwZWeDb7eudHjlqb4LELlf
	KIk+NLDeVmNyW7aLWcWusIFRY4gYEUC0/KUfDdB4JeiY0TgiL2ibs+AK
X-Gm-Gg: AZFdTZfWXvWdcG8TYKl5n5CvGSeXYObVic8vlP1VzdpvNK5cFA9lpUO15VlPSU/HQ2j
	2GI3z5WyZbhSjiGxh1eRH68POvpD80rKsm7sF9t8fT9xQqz5psHGu8CzcOr76BqrtCuQIeUcxFX
	vFGq2IfQPlCf+P5hKyKEc9spupI4kRDwNXKZXUYwA/22drCzYQDyWVjTDQEUy56uKXvkcBv8u9Y
	ONtYNrDEoDdw+ce7vxjer++zKYp5qgvarQlNSWVY3AoRNPGqUDQh+raLZofsy9HLXu8B5/WefUP
	98GuDgyc2DoKiREnsxoyTQxtl9QGKLIc2nplIMO78AEq6y1mZ2g4EYH1llQNtnnKB77dDCPP1eS
	+crXmoUOQDn+kP9gWqVcqzGuBymHMV06DnardrbmaYnutpDQ89iwdCoTHtRYhoCRuujqbmr/URR
	O3cDgxu70402Z6On6kpbMIdOnefABb4dH3RNB+EEMMU/f7UYx8mAa7p1m50cXGayFevFd7riT9q
	dzHLB1DB1g1LGMFK/CdTJ3QG6zc2YNf22xqVzZOQkuHzvNEBIC7vXtVx3iIktIV+vMkHBPSOxMi
	OL0HeVZJYV+PL+OoKxmX+wIQiSAxb/1LmjUj8KkqJPlCSNSwu2khsakfvgFHDKSvC/K3IsXBP+q
	cNtUAwHtv/8i7HdNNoQ==
X-Received: by 2002:a17:906:c14b:b0:c35:babe:ab44 with SMTP id a640c23a62f3a-c513a1e0076mr2020213366b.0.1795685483801;
        Thu, 26 Nov 2026 01:31:23 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdee82sm597090066b.66.2026.11.26.01.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:31:23 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 04/18] sparc32,leon: avoid nested IRQ accounting in the timer handler
Date: Thu, 26 Nov 2026 10:30:09 +0100
Message-ID: <20261126093106.1345825-5-linmag7@gmail.com>
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

handler_irq() enters hardirq context before genirq dispatches the LEON
per-CPU timer. Entering it a second time around the clockevent makes
account_process_tick() charge idle, system and softirq ticks to hardirq
time. As a result, htop shows idle CPUs as busy.

Remove the inner irq_enter()/irq_exit() pair. Commit 2cf9530420e4
("sparc32,leon: per-cpu ticker use genirq per-cpu handler") removed
it when LEON switched to genirq. The clockevent conversion restored
it. The sun4m and sun4d tickers enter through dedicated traps and
still need their own pair.

Fixes: 62f082830d63 ("sparc32: generic clockevent support")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/leon_kernel.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index a43cf794bb1e..e560f0237165 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -289,10 +289,8 @@ static irqreturn_t leon_percpu_timer_ce_interrupt(int irq, void *unused)
 
 	ce = &per_cpu(sparc32_clockevent, cpu);
 
-	irq_enter();
 	if (ce->event_handler)
 		ce->event_handler(ce);
-	irq_exit();
 
 	return IRQ_HANDLED;
 }
-- 
2.43.0

