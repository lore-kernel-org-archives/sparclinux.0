Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685499;
	b=UztFrL9W0SspV5U0WTvVtN/9i/4T68MKjeLsXrftBJVYrAg9ST543kDFk1wfi8Eow+dd
	 tcA1SMgd00EgtMZG4W1HZEBFO0MlyBTmUf3euQ6bLLDK5zgXsMM8BP7egbnNJdAC50j0Y
	 YVCrHV+ZFBfM/7hV8df588mRjWf9DsE2TvLfhKzprnNxlHjDbtt5oXJ2wOLayiVPFNrZF
	 D4zOv2u+9Zm1ZSrN4tHzp9XQOSxVXvS/5ANAubBRR5E1X4q4g/mi5uicB/a1G+gUU4+9E
	 +uyrbwkqycZyn6Jf462V18QZ2lEf7e3ahbnpn7Tt81Cp2w4UDs8H8K4gwqfo1ancuTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=F3ixIBgx9rfehOEgpBv2CsrhUoWjHeLEcEcFRQMVILI=;
	b=K4a6AIUIgdSSmBRfuXqqHZG8Gt8b3QFIk2g+FH03zvg75SU757rZ7NM5g7U7QNsaqntv
	 aFlwxn0tbde4vSUE6F5Wdg+bnEnm5vG6nMmR/x3I4IGokUP9gj0hHLzVaQlwcRFSN/6Js
	 Xt+3MJjHuViLIn6mnZ9bLBMVhtHDCBFFWivKhvEmqaxehyB1cps4qjuMLn4vztVazn3TJ
	 BVb0/DFptouCvdZVwSFve0TRhX+IQf4PDdhOEKHqm2Yuzmk6yWZBovOd3MrcaYRTK8U7q
	 EPz9TaHoZx6it0TnH0QKDDRVmy7zxWoDmxObbD7WzF62DO5GQKpQPA4tvJLMFBgNUhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B98SFmwO;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E700160A262A
	for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 09:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E700160A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B98SFmwO
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so1133584466b.3
        for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 01:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685497; x=1796290297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F3ixIBgx9rfehOEgpBv2CsrhUoWjHeLEcEcFRQMVILI=;
        b=B98SFmwOIyA4BOS4ZRIEXdzWqEHyXDOKNvGSbDbsoQq3izuTk+qgeAru/okUSiTO09
         q+IVKUdmwC6xuEnEY2FlW0zF1NrCCttQvBqXOnrw1NS8w2IdACsuyAEOawWxfIkYl/fj
         0Bmumb8i1pu9ujJe2J2o5pKItyIHn7rWj8tcdvE02qyaHmLaDT7lloNXvANs1xTwuzY5
         5fSRrpk6yC/SXLZnwRYY2/6fbhKMv1Q+oafucmXEyCuCo73fCRzNNdoaDvpNf664xfwh
         lNvO3AIVFU/NREGuB2E4Cz9/sYjFBIUvkowu1ur4qDNMjUwWj/VKVru6UcW0A1yvfjVL
         sttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685497; x=1796290297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F3ixIBgx9rfehOEgpBv2CsrhUoWjHeLEcEcFRQMVILI=;
        b=ZvID4eshF0GAdRIOMLHHgcCTuBHm0pq+3tgU0J7SnZuEhexkn2fZlFOFwhv3HyqsKO
         qsZ8fYkgGQMud9+iSJZTyRwTT/extbU23RXojK8vqn8OAifdIBc051JsGHxsP3JbfB6N
         odOgRCzhmgY+zHhK5rAmaaGvWFIEo+39MfBgYDU9DgjHcwS137bUkEOm4OYCFKwfafE6
         z3HAMgrP10RjSxZ5SGV3aMksqB4u51GTWwjyO/adFi6judg+y/+H/dutXTq6wsgodmLn
         JFBxGg0NpsX+0YZ2bg9VQpWVPcXAJnFKQ1+peCCxqpss/o3BX/i+J92eVKVZqk/1CbE5
         qSTA==
X-Forwarded-Encrypted: i=1; AL+hErGozMvX8dHR+gmgZfgjsTETFeZQwBqeIDEvmbN6HX8GYzar3OO1z1PER8PJS0l6LzBPpPuU2RrSeiHO@vger.kernel.org
X-Gm-Message-State: APuU4Z9n4ye+knqaBoCaSQnAE7ND0b/7ki6VY9tGn5FE5cyIekLb4eny
	cCve4RP2ZTsLtHvOKJKyV7E+mF1POpCCdbAtY2gmjdiUXlAX4tEbnATa
X-Gm-Gg: AZFdTZdEyLtYKWfXyALP5P5I7oQ7feDgYzOpIDLF8iWTu4dZtthvRfh2/WAxUvYpfk+
	KKQCPuok9LWIQe8KNvBCyOWCdoQpCC4QV4DypvyU1sVhftPulYpXgvAPUx+1ngRXQP1Gsyqd8Dh
	A8RDDZOHz6SPu2XrssL9Txj6cJYj2V/4ashxlKgLvmvfpBZIljDBRf8VpT5tGvRaxSIw7czxd0l
	25lR4G0Swhpzz+gByKjH6uy7sxf60RTFExsIU2HK0JeESnKzj6lcmlhl4/rNgTNRhrzBmgEY/Zi
	BRcp36iy1z/0QGpnoNBmAoddtlJMmtnfhX3SzS69ly8TJyNDpEg4E3CPwgEuTF5zHI5zcBl6EdZ
	QUh2p7b/DYYNmzV2LDeXzw/kDaJmP6nmiSbV77hzGnYXL7dJEMS3QqRDzV/E+OQzw5oKOMTBWTi
	CgvxFvqhC0wS622vSOSs5V0WDaefs087OWTdYDJOOruyQec5ZNpZThS7+5bKXmWOZ7BJdx3ackz
	meRxmn49aOSyhJ+hGhkY9Jez4qqzVl3gu5TAU24AWYCpCekVyeXbx+MUQOfrqJ6TFjzsyxyLoZh
	XJkU0YRxBg9uUa0RLazUbDEaSzu92LA4TzHF+jWXO4TGFp81t6TQIvESBTo73zLTa4l/bXQ=
X-Received: by 2002:a17:906:9c03:b0:c46:2987:2169 with SMTP id a640c23a62f3a-c513a84c864mr1341631066b.24.1795685497216;
        Thu, 26 Nov 2026 01:31:37 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdee82sm597090066b.66.2026.11.26.01.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:31:36 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH 18/18] sparc32,leon: describe the DS1672 on the GR-LEON4-ITX
Date: Thu, 26 Nov 2026 10:30:23 +0100
Message-ID: <20261126093106.1345825-19-linmag7@gmail.com>
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

The factory PROM omits the RTC on I2CM0. Add an rtc@68 child to the
controller at 0xc0000700 when the legacy ITX check matches, so the
DS1672 driver can register the hardware clock at boot.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/leon_legacy.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/leon_legacy.c b/arch/sparc/kernel/leon_legacy.c
index d4b3c48a4a10..f9fb35c3bb06 100644
--- a/arch/sparc/kernel/leon_legacy.c
+++ b/arch/sparc/kernel/leon_legacy.c
@@ -32,6 +32,7 @@
 #define ITX_DDR_END		0x50000000
 #define ITX_DDR2CFG1		0xffe00100
 #define ITX_GRVGA		0xc0800000
+#define ITX_I2CM0		0xc0000700
 
 struct legacy_bus {
 	u32 area;
@@ -262,8 +263,10 @@ static bool __init legacy_clocks(int cpu_bus)
 	return true;
 }
 
-static void __init legacy_i2c(struct device_node *np, u32 freq)
+static void __init legacy_i2c(struct device_node *np, u32 freq, u32 addr)
 {
+	struct device_node *rtc;
+
 	legacy_property(np, "compatible", "aeroflexgaisler,i2cmst",
 			sizeof("aeroflexgaisler,i2cmst"));
 	legacy_u32(np, "reg-shift", 2);
@@ -272,6 +275,14 @@ static void __init legacy_i2c(struct device_node *np, u32 freq)
 	legacy_u32(np, "clock-frequency", 100000);
 	legacy_u32(np, "#address-cells", 1);
 	legacy_u32(np, "#size-cells", 0);
+
+	/* The GR-LEON4-ITX wires its DS1672 to I2CM0 (board manual, 2.14). */
+	if (leon_legacy_is_itx() && addr == ITX_I2CM0) {
+		rtc = legacy_node(np, "rtc", "rtc@68");
+		legacy_property(rtc, "compatible", "dallas,ds1672",
+				sizeof("dallas,ds1672"));
+		legacy_u32(rtc, "reg", 0x68);
+	}
 }
 
 static void __init legacy_device(struct device_node *bus, u32 id, u32 freq,
@@ -309,7 +320,7 @@ static void __init legacy_device(struct device_node *bus, u32 id, u32 freq,
 	if (irq)
 		legacy_u32(np, "interrupts", irq);
 	if (legacy_is(id, GAISLER_I2CMST))
-		legacy_i2c(np, freq);
+		legacy_i2c(np, freq, addr);
 	pr_info("LEON PnP: %s at %08x irq %u clock %u\n", name,
 		be32_to_cpu(regs[0]), irq, freq);
 }
-- 
2.43.0

