Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685495;
	b=2+K1r2xMtD27qbWB7vvKv4xNceq7AN/zuFyZZ/SH1WBly3e632Ko76SMeTibRLEbOxqe
	 nDev1vtwr5/JeazTNG24yU39tOsn6plVw23XWZNyer4bTuw1g9xByw6Rb15XB+aTIKDDv
	 cT0DNS61/4sPVORURTCriMMHtP99V/Jyut7js1mQu+lQUBke/EKiANzVTYCD7m5pZNAkS
	 6iwjYhTYghdL6oBashEfbIR2LCtz9GodhsGdGjNE4JKAv0FfbXBccPJC/z3oZrt3XezJW
	 70I1oSphbKpQidRdUfMxU8Wf2X45eGOz2lnYTTDtvg6RVhmo72zDRymr29NVlnxo7Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685495;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8lJsCQlmSYKnZqPo3KXfCYUm3hUgy3XldOvtmxhX/5U=;
	b=mboOkEKOFSHtVt3e0HC2YCNQV7F2kobW9u48ycuX9D1Mt7CSa5UTZyAbZ5DmN0KYVDjS
	 yCJJy241UfteqQU5PlYu0acgeIPunS8KI1GmZLTFt9X3w+2+jr3P7J93Knb54NR4hC50T
	 hDsp0TIMhZsTkETIj18E21ymIywn902xam4Qiwg/F9LoWaGRwlUDXu77+ceWgWJZAi5gs
	 txUkwjLyKMs89UvjSbYJpyflCM2A58In5njpYgL5NIY6O8Ds7D5ZFLul1kAYVzaB0MP3B
	 kVONPBNGYEPSzYTHizoyKvGoViLqL+2qykZk33tj5YSrIsvyTRKJfOPmUseh0GpcQag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VIfwSMC3;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0745260A262F
	for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 09:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0745260A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VIfwSMC3
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c5118deebcfso1008731866b.1
        for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 01:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685493; x=1796290293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8lJsCQlmSYKnZqPo3KXfCYUm3hUgy3XldOvtmxhX/5U=;
        b=VIfwSMC31iCD8cVk+5pe7vnxLPjwT7enoDD0DE3wz0BW9qa6ipqhROzFP8phVAEesY
         qSLUhJciKHtailWOGsez0xlJfJe2KC5YUxP3rBgDOSy5oZj+GUNYCoiFlIOQBTO0HzWe
         LjK68XZwjQRjJjB8fUte0EVj+nNgradCSuVnxgmRaJqL+FPvApL3/cqUQA78Vc8rvGOa
         idYaojdEVbgSPeMAyOR+da+T+lcT7cFEWqgpQqCyZL2F1CublEBnIzgZqYjElWu7IbV8
         fn1mH2Hst5PhMq22LF4s3gMQeUuo7SfpWsgr3e88OEIarA8762obyYCKvcNWQuC40RcU
         DX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685493; x=1796290293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8lJsCQlmSYKnZqPo3KXfCYUm3hUgy3XldOvtmxhX/5U=;
        b=sqrGkRkttwz1rnGi7agpDgXtUnhvPfh/6LgvKDeWs+gRVuU419Zv1/fm0KQ7fSm13D
         J0R1oddsmVEGMajMnsGP4Cu0iubgIVsiWU+ba2GzOkiv4m6GTyQQugpILxVytJBXqpN5
         ozgVyMKJuXJrb9m6xlCqYjnHV06tjwc7S0YfZ3C2tIqFkngwjBbR3LxHrnS/DVkallMM
         StkFuvoqp52FmmnFQ5ZAKexUMwSjkUGtzPcTb9TzMkWUs7VbkhKqgx3p9UiJHVX8l6RL
         nhXX/QegeXVsTtlBw9YLMDgOoY8ZwHGPRPvKlE+t06YhVcTbZ2naVrElAz6JZrFqmKPV
         B+LQ==
X-Forwarded-Encrypted: i=1; AL+hErFaZKe9TKs3s5acP5Apbt3UrBdXEufMhJD3LOoKhg3zAYIrSIBYcDI9AaO8FY88euf7wmS8fy7wDJrv@vger.kernel.org
X-Gm-Message-State: APuU4Z/4K/jCFbs/OYg32U/OcQS3DNuQoF0WznLumye6UuaZdkz6kcUv
	hC+ff/zkhiudjvP6BMOlTQGeqv/la5yVmgsnktzNkHPpchlzZ/+HQ8TS
X-Gm-Gg: AZFdTZejmF76TwAYacv2wbBqLzRFeDyy1wqEwJ6HaNYrLAOwSpetVdu2DK7UwvLOTv3
	wEyZqxFB2PIQdZ1g7uH+G6YheW2Mq1h8O/yu0DnbSR2qSw2cPgvkWgff8gWO9rESzkafdAgrgru
	uWUcmPgSQeCg5it6m201dqSMG7hLqGjvjQv25EThN4IYoRB/2rjhkqkxUuud5R0TtVqfRYt+CGv
	B3/47YCIW96HlV/bqlzVjoS7/mZFr3Te2G4ip96Zuf7Cs36yIrGyCjGn7g/x9y8GOnO1v1StaU9
	TZPze8v77ECWFWKkxVF6f5w90/Q6zdNU1PN87daas8pYqoV7vDS5GWZ8gxsRjLt94ZDjchqZlVs
	dnNeP/iQP+yg0ZPAL4N1BpoJvl5ZCH6H9pf7F42BBdNihcCEjXdLyOEE450XkJcdc0xRHh5LtRF
	uztQ7v6Y6XTm9msPw1jtWuKR7rDfwSqtaoKtcR9gH8oCNCooh8gBEvYox9jmBuWVsk7WNPIbRqA
	u7bxwRSNPzi76d3JEYeU+0VD9pKIQ2T38BdgWPalIyflyx/FcW3CRY0NCdEKPw9TI07rUHJDmkb
	pZu055L9zY8LkS3dK6j2btGxnOfMTAfkBNZiZyRAaWys674CQwnZHhFOF4nY5QPmt4+KL0s=
X-Received: by 2002:a17:907:960f:b0:c31:e9b7:f10b with SMTP id a640c23a62f3a-c513ab4fb53mr1665093166b.42.1795685493247;
        Thu, 26 Nov 2026 01:31:33 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdee82sm597090066b.66.2026.11.26.01.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:31:32 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH 14/18] sparc32,leon: describe legacy AMBA I2C controllers
Date: Thu, 26 Nov 2026 10:30:19 +0100
Message-ID: <20261126093106.1345825-15-linmag7@gmail.com>
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

Describe I2CMST controllers discovered from legacy GRLIB plug-and-play
with the compatible string, register spacing and input clock required
by i2c-ocores. Do not infer attached peripherals from the ASIC system ID;
RTC instantiation needs reliable board-specific information.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/leon_legacy.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/sparc/kernel/leon_legacy.c b/arch/sparc/kernel/leon_legacy.c
index a9364708e231..fa978620f4a6 100644
--- a/arch/sparc/kernel/leon_legacy.c
+++ b/arch/sparc/kernel/leon_legacy.c
@@ -201,6 +201,18 @@ static bool __init legacy_clocks(int cpu_bus)
 	return true;
 }
 
+static void __init legacy_i2c(struct device_node *np, u32 freq)
+{
+	legacy_property(np, "compatible", "aeroflexgaisler,i2cmst",
+			sizeof("aeroflexgaisler,i2cmst"));
+	legacy_u32(np, "reg-shift", 2);
+	legacy_u32(np, "reg-io-width", 4);
+	legacy_u32(np, "opencores,ip-clock-frequency", freq);
+	legacy_u32(np, "clock-frequency", 100000);
+	legacy_u32(np, "#address-cells", 1);
+	legacy_u32(np, "#size-cells", 0);
+}
+
 static void __init legacy_device(struct device_node *bus, u32 id, u32 freq,
 				 __be32 *regs, unsigned int count)
 {
@@ -235,6 +247,8 @@ static void __init legacy_device(struct device_node *bus, u32 id, u32 freq,
 	legacy_u32(np, "version", (id >> 5) & 0x1f);
 	if (irq)
 		legacy_u32(np, "interrupts", irq);
+	if (legacy_is(id, GAISLER_I2CMST))
+		legacy_i2c(np, freq);
 	pr_info("LEON PnP: %s at %08x irq %u clock %u\n", name,
 		be32_to_cpu(regs[0]), irq, freq);
 }
-- 
2.43.0

