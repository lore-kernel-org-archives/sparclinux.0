Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405C94BF953
	for <sparclinux@vger.kernel.org>; Sun, 18 Oct 2026 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331377; cv=none; b=Y5QrCBqTu5NIEUkSCkZBOlpAcSTN2IJgwONYujD2VAR+sZsjTLqwnI5GhPEL31o9iqlRqsG8pWqhWMOkipyl5Yyqbn0Hm8kqj7XcTqec/BAhXvMCK461t28yuDlrZL0COdWIjwPjmJB/sCFw3Ttr7s9uJ7sbj+AXEfy0zdMqqS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331377; c=relaxed/simple;
	bh=vjNze9pFwuYamoQe8DimXqpx4yhAb8nyRLguv8W/FP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOwWhJQ8F46o+vePu1m4Ow0cxQXjDG0wStBcyyOTqSoNGVDcvxnbxzogfFaiHT+1aWA6UjXhRk3mQX3LQKrQwHTQthATHxNckECi3jaUlOcvEX3cnVv+00wSK+roICzibtflxSSG1Q59TIxLZomSI6FCEG7Rvjrw2lKlXA+UgTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIekOHqz; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIekOHqz"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c37b612635bso141421666b.3
        for <sparclinux@vger.kernel.org>; Sun, 18 Oct 2026 06:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331374; x=1792936174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JW5bZpm7GPoO7pVkcm3aweioHrkQpRkv3vtqxcRc/ZU=;
        b=VIekOHqzIRhKs/C4R/JDeFuMMl2BBAk/QJPyrEUuub4wIKK6DCAJ0ysmbpXvRfOHUX
         W/0hPAKkRR34mTC2yl0iZIzfjMVV6CAsCWH9dbirEeCWY9zbNBIKvRRtA37n5AwC0xlM
         2tbdXenbcIIXBkLwI/kNQNk9bqXplpcPxJ/JAidmboPipC8F42GTCZM4xAyTjkXViIEp
         ER82YaRMy3SJ/DWp0/yp2OfNW/CbqpAgZFaFLKxwY5b99MNNJ34VVfxvkLP0xFgMThEc
         ydP4crIoEYS35t56+SR1rmlLkf/0b0Y666S9O+zMRX4PO4oEOq2SXAhxzgVoFbOnkiM6
         6Aug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331374; x=1792936174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JW5bZpm7GPoO7pVkcm3aweioHrkQpRkv3vtqxcRc/ZU=;
        b=DqaduIHQHQwJ/1jnGKGSrwmVpMRwx2oBAuNNoii2Bm05OTEEdqZsFed3PNNmOpGYpd
         qJdndRPrI9Lb62TtN6Pi67DuASdw85FEHAjWW7dVRSEdW+eQo5o4SQRNFWvQbeMOsoes
         eWwqJ0VtbJcW49tLUWG9ZelQzmFsbe0zrrtXvZ6FhYKaxpk8wxvFa1t2LvESeGG2AIgB
         mLFIKmBuL7egGCj9GMBTJ1/9x1H95H8Ge3HE7caKhQj6xhfR7tf9nO+UuaPcgBeUydL7
         MStaHp3y0BvMMndRVfajQEG/ICQV5d6DSb00MIMPABJXU9supPD0cK6BiKXiz7dlQ6tl
         eLBw==
X-Forwarded-Encrypted: i=1; AKwUvBzLYl8mO49vjmsyhQVnXjoOVWfwIGdlXYRfBQlJBOkw+PzCx5bKcDBsqwW0zsGmMXspmCKggLkxmRA5@vger.kernel.org
X-Gm-Message-State: AFq9FYJsdoz/umrokxITVssjpibrZ5TKciWU0NS0tnR3ma8G4HU+UY7w
	2hXmx/II1NUeWyDjSa+o/RtF38SRpmvsSW5wVmSclI8vOu9aKgA0w4iG
X-Gm-Gg: AYBFou0IcNox2uIX6aw3A6Ml2XJTGH/QV2h6whL4NOBpwMNLE9S4++XYltOxNEY2IcH
	ZMq0T4Lj2az0mZhXEpp28yTSnpFvGc9GZTHZnlFYjUsnRu+G42goSS0exAegahqKI0cDqDVsGez
	9jF2Am4099FAxKz69IQWMCWTioubtoutmfAXG7nKj8JT9X7eUYVofEzIY9qMVcN5keptLRI3og5
	X0f9oqySuXUdP4T0D1pFinoDc8C0Z6cyJeLAF41s0wthII4ThXf7bUnBrh4Ko5UusDzVZ9VQIpG
	GkVSKrEvk9rhnD0wODj/UY6CrtjKChesZE1G1vZNPh9wojnRPRD/gCK1ZdwVrd0xDe9FA0yV3eX
	LjPtwutlZZEdA/ijWzMOiW4/JKwpm4ZL9Jh29PZh1LgSQCk0v5JP5PzlZjYIYa7Kb453Rc6SRjp
	hgTnXfDsxj7RkiA9+4suWwaoeSKWbCTb3RGrFURHoB8BfhFCIcToId2QNlNyHQKrRt4BwtQNjD2
	XLJCW4DQpogjkBK0HUXiE70nEu9V1WEv+M6Mwoq
X-Received: by 2002:a17:907:d2a:b0:c41:21ef:26ef with SMTP id a640c23a62f3a-c419ef2407fmr317025966b.20.1792331374388;
        Sun, 18 Oct 2026 06:49:34 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:33 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v4 03/10] sparc64: avoid huge kernel PUD mappings with small hardware pages
Date: Sun, 18 Oct 2026 15:45:05 +0200
Message-ID: <20261018134738.1016106-4-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018134738.1016106-1-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel PUD refill path merges virtual address bits 32:28 into a
TTE, requiring hardware pages of at least 256MB. Sun4u instead selects
4MB pages, losing bits 27:22 when refilling a huge PUD. Sun4v also falls
back to 4MB pages when neither 256MB nor 2GB pages are selected.

Keep PMD mappings when the selected PUD encoding matches the small-page
entry. The PMD refill path preserves the bits needed by the 4MB TTE;
sun4v selections of 256MB or larger remain eligible for huge PUDs.

Fixes: 0dd5b7b09e13 ("sparc64: Fix physical memory management regressions with large max_phys_bits.")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/mm/init_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 103db4683b16..f3f7eba08469 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1696,6 +1696,14 @@ static unsigned long __ref kernel_map_hugepud(unsigned long vstart,
 static bool kernel_can_map_hugepud(unsigned long vstart, unsigned long vend,
 				   bool guard)
 {
+	/*
+	 * The PUD miss path propagates VA bits 32:28, assuming at least
+	 * 256MB hardware pages. Retain PMD mappings when the selected PUD
+	 * encoding falls back to the small-page entry.
+	 */
+	if (kern_linear_pte_xor[2] == kern_linear_pte_xor[0])
+		return false;
+
 	if (guard && !(vstart & ~PUD_MASK) && (vend - vstart) >= PUD_SIZE)
 		return true;
 
-- 
2.43.0

