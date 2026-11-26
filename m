Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685499;
	b=1NVrLcDsdK5+6klSztQCXRHgTy6erj2nkcPP0fwtvXWZ9w5/3rbNeXlUKenNOEbuDK03
	 ahufcy9w3oIwkwEMmfDeyFTE0MuTPwMz2RR+s1fkYGaJTEXTmYB67Z22NCXJYpF1LuHmj
	 /0RQfG43bhOpDwbyfMBIjZ5ICvFHwM9FrzxagHYc+4JncFl88ovk4LkE2edy/ctMCJuXs
	 rgun5S9pBu3WpyC5bBOg+ND0RfJZDyj7sUtle08PfMaD4FzOWy6N3adM9P4YKlHiPuKoH
	 f8q5KilTmwI02DRNWo3/2CWzVTS+u7dG1yn7jeu9qCE6JmMLOuEGfH2y9ZvhGdZJeIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GflLAzzonWaKk8Eu9eDMJ575mKa3vJ+vJVZwmNjRoYE=;
	b=s2jABpNc9mIp2U3m4AzBjFukLBMqqqsT+MZ/E9TZFOAPKai/IQmazmYYxWrqHtgi6IuW
	 pQBrXZxEpgdx6iCiaQENxBLgiLJcAUU8mAigb7wVtp9Mbam2lTnYKy0HOaAa+DGJwOLGI
	 VU6IL5mG6Gh5y7PZ0vj5isXqdivE9AtbT++R6oBqgKMdgpw6MjWGb+HhzdsuTSC+bHCD3
	 QqsIfDavqZWOe3k/ueKdhFQtSTqOqDCI88+Kl1LCisj7HzIGlHrqPbaYt4ymSkoyJ+6Xn
	 HY9T24uERFkHmvnivxXgUJm/C/pcwWmfEQ5HKsZTuhuJd7440kOC3BvmViwjzn21yEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r71SEXIU;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9D060A3807
	for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 09:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F9D060A3807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r71SEXIU
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4d427836e9so904963866b.1
        for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 01:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685496; x=1796290296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GflLAzzonWaKk8Eu9eDMJ575mKa3vJ+vJVZwmNjRoYE=;
        b=r71SEXIUludP4qQMXALYT0TJ2ZYKMwTrhT3xh4StS0KJNVvpMYKQ7iujRBmq/Z8zGp
         eqo6hBjqULLmK3FalJxrl5AnT3/HcFztzjyVPoV/f3KMI3FYXDWMOq165kKBNKEvZXaU
         Gb2ex9T3hxs+Kg5t2FYWDhgSTESaM+gsc6a3azHMq/txwVOftSG8tJvqCQoW1L/wkS9j
         yxaYoi/BkBuu3wLrVAqpklZffN6MuWWpAdTciQT62KuEzHO0zg/Ri2MY5azdhQjbzg/8
         crA8s+R6bkE/IRrh55ub+Wn2ICNzOZ/DP58Ms5OJTImIEBeBolS5EgeGQ9UqPHDGUzHA
         upXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685496; x=1796290296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GflLAzzonWaKk8Eu9eDMJ575mKa3vJ+vJVZwmNjRoYE=;
        b=e8sJIAxnzLDVlHGjiWuEb3UpuBY5dmf25vCNlEbXTWyn6BFZ5D74UggNk3WuUhR6vs
         EFD1FceyadtnOvSQqGHDX8+ivl3+IdvbnjR0jqrIwLXqNP7rQOFPiwjhhAgnlOHB8ZJz
         pLKrbOTQTJNn9TDm5Vnf0a4PLk3wkwM5au5qfpcQcpeINBDuBfYLIep+yA/UK76M9b7t
         e1UK4S6BQ+IDXs+InjgXCZZcHul8MRoGTZkiUtT9RAUk5lD2zMO9PQ27M1WLfXCyO8N5
         C8uVyrSnR2URW/fyKO9DDTC+p3T5V834g8Iku5TlP+ONeA10+v4UqnWyl+uF3EPh9HFm
         4gAw==
X-Forwarded-Encrypted: i=1; AL+hErHZTGqx7sKGLqFKlF5eNaKVcOHsNBmr7g2X9eDZeMULWcHyu7X7Wnvbq8/dT9oYGskTQbr9OiuaX/W8@vger.kernel.org
X-Gm-Message-State: APuU4Z9Y/8R6JhEyfYg5smkjhoKWvO1bFxJ0QlMnri5AdE6Jix6l0OhC
	PheeeR2syTuz4jhlDVUPXKCqbi6tTcdPpPFoaNannWJ+Ryaoz+L0mRaH
X-Gm-Gg: AZFdTZc1vy0qANpg2lTlagBSV3qQMaH2Vyk36ngQYo11US2Ww3P+94aPHXg0232Nsny
	grsC8s9GyFom3M6wcPinqlDj2drrBKnKgq4epVRTKLsZtqow0UHYZQgaIQ1mGKZatwgYfaHKxWO
	OO1QhofFVOME4iHQbhpHL+qiUrVZcKe9RuJZphmeRlAJmgDk/RwzcgtYtRVefuem2GP6WQKkViw
	k47SnrvZ5yrLLz5XJ4PusLADU9tzDKqz4uPc5lmAenKK4j2j7BcyUmAyP8ECa61HQh64l86Xmmy
	MTMu/5T2a/Mwc9yVjiTu6pCgeGSJ5hlA3Qoxlgh/Q2BeOgQI4+U7mKNbfMABOqUKoEUEZ1gk7cR
	Da06c4exC7h5av5DNwdKvnVhFc0iK5Nbc3i3Rm0VeHr95iREv30zXSnlcwLtf1w8jD2X8Al7/AI
	TjECCi5cxl3t+opBIUnESnH1GWRdQa7C4DqoT/2SiXczIJs9Ja609e73NY6mf9G19gCRKpLsXrJ
	1oDH+agKA6l6fxTG5JWpQp3OsYSdJ3p8X/ZoZImi/UWyZim+BlGiTRWL+cUf63kYVp6t0k+yFwk
	AouYZUqPU6ywiQ3rZ2dR4NaginGBNzcljpqUjhPWYYu+sYnheGnz7WBdY+fmzNkSRW7MuWw=
X-Received: by 2002:a17:907:6d15:b0:c51:5589:2ff2 with SMTP id a640c23a62f3a-c5155898309mr1382987366b.9.1795685496308;
        Thu, 26 Nov 2026 01:31:36 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdee82sm597090066b.66.2026.11.26.01.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:31:35 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH 17/18] sparc32,leon: combine legacy GRPCI1 plug-and-play resources
Date: Thu, 26 Nov 2026 10:30:22 +0100
Message-ID: <20261126093106.1345825-18-linmag7@gmail.com>
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

The GRPCI1 host driver expects one node with APB control registers, an
AHB memory window and an AHB I/O window. Legacy discovery creates two
nodes, leaving neither with enough resources for the host to probe.

Pair the APB and AHB entries on each AHB bus and take the interrupt
from the APB entry. Omit incomplete or ambiguous pairs.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/leon_legacy.c | 62 +++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/leon_legacy.c b/arch/sparc/kernel/leon_legacy.c
index 03d3120797f0..d4b3c48a4a10 100644
--- a/arch/sparc/kernel/leon_legacy.c
+++ b/arch/sparc/kernel/leon_legacy.c
@@ -314,7 +314,48 @@ static void __init legacy_device(struct device_node *bus, u32 id, u32 freq,
 		be32_to_cpu(regs[0]), irq, freq);
 }
 
-static void __init legacy_apb(struct device_node *bus, u32 base, u32 freq)
+/* A GRPCI1 exposes the control registers on APB and two windows on AHB. */
+struct legacy_grpci1 {
+	u32 apb_id;
+	u32 ahb_pnp;
+	unsigned int apb_count;
+	unsigned int ahb_count;
+	__be32 regs[6];
+};
+
+static void __init legacy_add_grpci1(struct device_node *bus, u32 area,
+				     u32 freq, struct legacy_grpci1 *pci)
+{
+	u32 mem, io, addr, size;
+
+	if (!pci->apb_count && !pci->ahb_count)
+		return;
+	/* The PnP ID alone cannot pair multiple cores on the same AHB bus. */
+	if (pci->apb_count != 1 || pci->ahb_count != 1 ||
+	    !(pci->apb_id & 0x1f))
+		goto invalid;
+
+	mem = legacy_read(pci->ahb_pnp + 16);
+	io = legacy_read(pci->ahb_pnp + 20);
+	if ((mem & 0xf) != 2 || !legacy_bar(area, mem, &addr, &size))
+		goto invalid;
+	pci->regs[2] = cpu_to_be32(addr);
+	pci->regs[3] = cpu_to_be32(size);
+	/* The driver uses 64 KiB each for I/O and configuration space. */
+	if ((io & 0xf) != 3 || !legacy_bar(area, io, &addr, &size) ||
+	    size < 0x20000)
+		goto invalid;
+	pci->regs[4] = cpu_to_be32(addr);
+	pci->regs[5] = cpu_to_be32(size);
+	legacy_device(bus, pci->apb_id, freq, pci->regs, 3);
+	return;
+
+invalid:
+	pr_warn("LEON: incomplete or ambiguous GRPCI1 on AHB bus %08x\n", area);
+}
+
+static void __init legacy_apb(struct device_node *bus, u32 base, u32 freq,
+			      struct legacy_grpci1 *pci)
 {
 	unsigned int slot;
 
@@ -325,6 +366,10 @@ static void __init legacy_apb(struct device_node *bus, u32 base, u32 freq)
 
 		if (!(id >> 24) || !((id >> 12) & 0xfff))
 			continue;
+		if (legacy_is(id, GAISLER_PCIFBRG)) {
+			pci->apb_count++;
+			legacy_irqs |= BIT(id & 0x1f);
+		}
 		bar = legacy_read(pnp + 4);
 		if ((bar & 0xf) != 1)
 			continue;
@@ -337,6 +382,11 @@ static void __init legacy_apb(struct device_node *bus, u32 base, u32 freq)
 		}
 		regs[0] = cpu_to_be32(addr);
 		regs[1] = cpu_to_be32(size);
+		if (legacy_is(id, GAISLER_PCIFBRG)) {
+			pci->apb_id = id;
+			memcpy(pci->regs, regs, sizeof(regs));
+			continue;
+		}
 		legacy_device(bus, id, freq, regs, 1);
 	}
 }
@@ -374,6 +424,7 @@ void __init leon_legacy_amba_init(void)
 	pr_info("LEON PnP: system ID %08x\n", systemid);
 
 	for (b = 0; b < legacy_bus_count; b++) {
+		struct legacy_grpci1 pci = {};
 		u32 area = legacy_buses[b].area;
 		u32 freq = legacy_buses[b].freq;
 		u32 table = area | LEON3_CONF_AREA;
@@ -388,6 +439,12 @@ void __init leon_legacy_amba_init(void)
 			if (!(id >> 24) || !((id >> 12) & 0xfff) ||
 			    legacy_is(id, GAISLER_AHB2AHB))
 				continue;
+			if (legacy_is(id, GAISLER_PCIFBRG)) {
+				pci.ahb_count++;
+				pci.ahb_pnp = pnp;
+				legacy_irqs |= BIT(id & 0x1f);
+				continue;
+			}
 			for (bar = 0; bar < 4; bar++) {
 				if (!legacy_bar(area, legacy_read(pnp + 16 + bar * 4),
 						&addr, &size))
@@ -399,11 +456,12 @@ void __init leon_legacy_amba_init(void)
 			if (!count)
 				continue;
 			if (legacy_is(id, GAISLER_APBMST)) {
-				legacy_apb(bus, be32_to_cpu(regs[0]), freq);
+				legacy_apb(bus, be32_to_cpu(regs[0]), freq, &pci);
 				continue;
 			}
 			legacy_device(bus, id, freq, regs, count);
 		}
+		legacy_add_grpci1(bus, area, freq, &pci);
 	}
 	if (!IS_ENABLED(CONFIG_SMP))
 		return;
-- 
2.43.0

