Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79273B0AD4
	for <sparclinux@vger.kernel.org>; Mon, 12 Oct 2026 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830932; cv=none; b=jIeM1/hmwp99jgWzxJS95RuJnFvmlliIMaCKSAN+Tw4JRoYk449Tfr7GK0Fu0+XJxrNOwmgo2gC5rEeHUJnnA3649Zfqq3fnTyU63HALaIo7uXQ57b+qhvnMCSTKGO0CyBr1eSAHSK99lR8u1ZVW63+PNcBoVrc5r6JMH+1Xloc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830932; c=relaxed/simple;
	bh=lHqcE6L/05Y5Gh1t1RuDhITcXofphAcppq5EmdQFuLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAx9iTQSa36fKCpzx+YcXyPufIwptxVYR4qgXZu9Bnkp3cJzEt3q2EY8LFPZWuRBcr0kW8ilP2+JpO+nsWnqvnHiXI5Gy/YfDXlkOCg4arz7DIQ4D3RLsZLrzO9PEVfj3KlV+IZbDKSkVlZofUH7zW5nGCykldZ0dE5us2aUsQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvuY6mhq; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvuY6mhq"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c315a445752so341103666b.3
        for <sparclinux@vger.kernel.org>; Mon, 12 Oct 2026 11:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791830929; x=1792435729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9gLypezyadrnh0M08opMU0Y8wfZpigwqaTEA/o05oR4=;
        b=EvuY6mhqmnypJ0n2Q2Fp++Ax9En4JybsvGIqnkiTt8bUda9JnoUgoEunpGUnUWIyQm
         7uhsxchtkzG2euYZly+A0xSeDs31XF6WBW2z8TaXC8IyS6bqcbvYdYoqQkLjnG2llp0M
         NmHazujB73v6dFUUFMZB8ebT1p9uQPe3D1oQ2efn0dE8cnHytpKz8IMhH6XjfBg+yUjT
         c99Ccu+hHpeMoK/LXmR/4NTIcrToEjNqnFa5e33Jhd9EyEN+/2VX+3gmwCD73XWF99bW
         VLEc6dv8UBfziVMiLqjed/UM3sSD38GghhQxxQM3vdd7gZB2o/FECwgM/vVbIEf5FQEB
         af5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791830929; x=1792435729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9gLypezyadrnh0M08opMU0Y8wfZpigwqaTEA/o05oR4=;
        b=BFENwRGEWczU+c/LnI3jv3L6u5bOi1UeD8ZxSsnlPI3km27UJztwcloHKhr1+06rsa
         TcUR3n4p44y6zttPEAWC6sNqhasHh0uXCt+m1+2aPWBsu6u+YOD1AYuBUZ3oHGphvrIy
         0bM3LXdqvFrCxYZuAuh6JbPn8roM2Zb4W6aKvBumRGNiM8CQbMeq9iUT6nrf2YRcx2Wd
         9D3v/FUb7Usbwn1KThOm/AxcNJcnWFTNdbn1BJgnFf3MBci1k48o22o3jUdIqIZmQzi+
         l4WZ+eKk3TEeMuGT1aV2ajMoOB9nXM6Mj8EGB+bxVzknEbDGFV0cVgNou4cGJQed0Y2M
         XTYg==
X-Forwarded-Encrypted: i=1; AKwUvBys+ul8eulvJCTFX62696AeP83lES2iBrTKG4J7SR8vk2y0/XPolRRy15nHjIFaL6Rbv9XzxgBa43oX@vger.kernel.org
X-Gm-Message-State: AFq9FYKxY67+WhVq9cmaCKC9StXQiHykNuL+QqbnDMxDhBiQXR5iFhXn
	y4r2ihZo89oLWXNRfakR6mFqQAFQ4vcXVHckuZOYu9aJBWDTGAos9GpN
X-Gm-Gg: AYBFou1kq9rWu8+OAwaaNMeQHTR4uQdyEvWxUX6GgTEoQ0u+KCM1NudiivuE6P4xmRe
	sWWj7zym3fyavNJfP/qjiEw5YM0Q32MqNxRpqF1Coh+S7B6fVyVVJv1pvYj92APBYK4eiBk3DQN
	Vja91BtSSQaqD1ADlfhB8vvhmDjk5H74mNE7iWo3Q30IcmAozywuLA3eNSKtuQoD20M90OJfA+7
	wJbavWG14UKGtL8TdfWZlQQR8EG22piPWRkHhHyJM6c06fhbDa8A5gSYeQancaHyUhfCMHJ3fXb
	veBBgMV5PdTUcrVegI6ByL6pnghCnaWQwLnUCXEsiD8yZjbr2brApg8bZv3K++n5IViRigXbso+
	pvGWhwjSzfSeocLD2vGWh4tq3BTjTULliMss2j+o+oaAXzPSpzdlsDcKAf4VZO2a0MF33uYShXc
	SVgtYudJmpK1M4bU66/bcWCnoKi3YOSmBbWZNlcvJZHWP7CMf+5QBEwFIb+RvsuhRU383sgxt0d
	ZPZFbZfHHuIwzjooclvWg8wljS4ZKKSil6xN0/B52nMXS/j1eW6
X-Received: by 2002:a17:907:3e0d:b0:c2e:80b0:deb3 with SMTP id a640c23a62f3a-c31a9a10e74mr1102093566b.7.1791830928881;
        Mon, 12 Oct 2026 11:48:48 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa5aa7sm488517666b.55.2026.10.12.11.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:48:48 -0700 (PDT)
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
Subject: [PATCH v3 3/8] sparc64: avoid huge kernel PUD mappings on sun4u
Date: Mon, 12 Oct 2026 20:48:04 +0200
Message-ID: <20261012184826.986050-4-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012184826.986050-1-linmag7@gmail.com>
References: <20261012184826.986050-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel PUD refill path merges virtual address bits 32:28 into a
TTE, requiring a hardware page size of at least 256MB. On sun4u,
kern_linear_pte_xor[2] and [3] instead select the 4MB fallback TTE.
Consequently address bits 27:22 are lost when refilling a huge PUD.

Keep the kernel linear mapping at PMD granularity on sun4u. Its refill
path preserves bit 22, as required by the 4MB TTE. Leave the sun4v
mapping selection unchanged.

Fixes: 0dd5b7b09e13 ("sparc64: Fix physical memory management regressions with large max_phys_bits.")
Cc: stable@vger.kernel.org

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/mm/init_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 103db4683b16..0ae97e616435 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1696,6 +1696,14 @@ static unsigned long __ref kernel_map_hugepud(unsigned long vstart,
 static bool kernel_can_map_hugepud(unsigned long vstart, unsigned long vend,
 				   bool guard)
 {
+	/*
+	 * The PUD miss path propagates VA bits 32:28, assuming at least
+	 * 256MB hardware pages. Sun4u uses 4MB pages here: retain PMD
+	 * mappings so bits 27:22 are not lost during TLB refill.
+	 */
+	if (tlb_type != hypervisor)
+		return false;
+
 	if (guard && !(vstart & ~PUD_MASK) && (vend - vstart) >= PUD_SIZE)
 		return true;
 
