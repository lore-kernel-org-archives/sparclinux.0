Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685492;
	b=v/CRWn4BhKrPKmzqRvWEsvkWT9EqAJqxxeCUKpEG9NaAF5vhuBJUxqmIWVjf8bXH8fhI
	 DFY6jjs1s2a6tZr9SdADQVOwHuh1v1m8BMHOFygkncYcUs70UjXlqhUjCwNErzOY8kbwC
	 CCt37qKeAk6/RCYdcwjlrqc1pSeXFWiEcrqM2uPLJMYetk1ZvW3HQMJDnlCuo07ULsesj
	 wn8vH2V76qB4VsTWst4BVkasuIIqg7Joy4Ad2CIuhgIizSFqHeVaUksmTCQ88gbjZs8e/
	 6j9LFtUxZp+10knZDPqDjpWgcqhKF6tmFOw0204kJtsshcnQ0QcazY7RSEhIkQ4NMLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1Hsp/nKJQfa6z9fxFEd4d4zCQ7inN3vyv8oVcbS42Bc=;
	b=UxZ8uh9c1V6pylXftDOeAKz1/uSOXh7vgsa/rHylXZgPf8NTXvefq7xDE4N2uxjLFq+h
	 HRqo5naW/b8plN5bxUvG4gKZx3sOcqgAlJQT6yfVl0lsUYzIRxQsJ2UqsbipMdD/mcO+7
	 fMKpFt9oYemEsH37E07WOzruqILAv3vFFdyugpLFKn4w/kgqCVOoWooXC2vr1V92/5MFr
	 IP3ikilEFcEYJuY4riIdKrFZC3OEUhM93g7hDJYSFZSqfy+BrxfzkMiS/1CePlROItaQq
	 2iWeuFUtlhlX+Nj8FlcLXTNu+LLxnGVBf3Wr2TIaUgddX1vRFG4WWL+s5pTviYydSOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UWiADtOA;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C22F606A33E
	for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 09:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C22F606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UWiADtOA
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6bab10844b5so7494226a12.1
        for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 01:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685490; x=1796290290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Hsp/nKJQfa6z9fxFEd4d4zCQ7inN3vyv8oVcbS42Bc=;
        b=UWiADtOAPdIfy2Td76h/yXsK6/bP/5BR4o3HCPmj7HIw8jdapX3wPGP7EE4mS5YqJj
         Iv2ezBrsDwiYaM99rULbCEKIRMFI5VtUV4K2hacDbTJZIjPGQp4uyOJJjg4X+1sMPuG9
         le+gVTEjQT1sxHEuCCudB9vXXtimZWXAyqfV3ZsSVWXZTcy4Zv/hmy5M1AKmNEW7MOfc
         BgSxdMfxxPDcAIgyka7+PT9TSnwa6h3nms4SlvDGGULBvqVrz6/Fei6CksVpN+VMLGQJ
         Yce1vDvmTkbGvncZrsDzdbSGj808/nn26X7W3IekJN1MYx4O7O0FHapg1VWWjx3EZ6UU
         tw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685490; x=1796290290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Hsp/nKJQfa6z9fxFEd4d4zCQ7inN3vyv8oVcbS42Bc=;
        b=XyvcpuaLsku0axe93xLCCgeo9lNEDYiU1UJbVtV8nN7fqjgrJUjemCn81k0boDaOos
         /rhRQ7/mseAWmbsww2cBzlBi9J/HX0bHLg1WXmoZAmCGWwFYb9fHs9W96F/Sr03C3hnO
         E+dTtPb+bpd/T0ca2oE/tIxmMURHb49/PUrfRKtNXbdynHWrS7+7q8XtnzcvCQpc4WpL
         r02NIxa3eRUb1qU8QmsD4D2S4F+JW3Hx3tqJTKbg7RULDyRxIklSVgqcPHEftOjHA4Pk
         A38Ge7e6g71HHwwmrRWG5RTfLCklh8mX/QiVMBLYS+zwgUDZpx7K+WjCMCfhdH/FC983
         61PA==
X-Forwarded-Encrypted: i=1; AL+hErGsAAWJzpq5v8Ez4c++oPBpo6ynJpTo+eKLvKh1o0yTeXIQ5e+BwtmZA3hI1gcTCllgN70RUXHrbsp4@vger.kernel.org
X-Gm-Message-State: APuU4Z8I1pQhvuLUyMUvE4J+tsWchY93947jTQ5vqc7rLENqbijtk9YF
	IkBJ96pKjoEvQN80TVpLpvfIkPOwbIkbNP5m925xqtcltHeq2vxyOZvVjBNc8WfC
X-Gm-Gg: AZFdTZcoeEcWAMPQdOrfs36FZPi/BrtcL/txy8Xh1+2oYJiHInBmckv8kcFJtvW25zx
	+LVmT2OjPEt3gCPhqALPKhA296S5af8EVmUVXMlde5Gt+0IqXhPeX/EJ/jqorpePADJwEsctGYK
	m85bvvFcszCeoCmVtjMXhCSuMqQgkKcP5oZPWHRJRgmp8l4yVAYaZppqyMFwQ2c4unXlQZTYoO0
	9KArB9QfJMmb06Yi9n1XNjbIq/WAAceN6m5vSzz3B8ZjO+K3xiFAafdVUpoNaSULZuXv4lU0c4w
	+uWaLTinLgpHthYDkuR1cmyC4WLQ4iEGIauvWjt4mVcX/piefe6qeNQS4CshFDnq7rjCeg5uSUC
	YUV30YVTljOwyOgFHXsFbV37pn+ue3NaAhNK0uW8AhTNT6HVQtGzCwvL8cjPSW7cmxtdDutCwHq
	tVAEGhauBIyZtVX0P70cLGSsSxturvjvltE5j6u90KsbR42uRIeuMhJ7EOh4px0BG0G0G/zjMuz
	9V24CPSSNZCVlCDeqbDKfqmOiRXsXTu0mMVR82+8Ra9pXkdPe+jrd2cRRDOv3JQ/HwNlyh9/oUi
	ppQlR8r7Td0SwV1cud+0FXRingSkdy4vKCOoG5KxqyL3/AzZ2CovRuv6GZH5Nhuib16GKRg=
X-Received: by 2002:a17:907:ec09:b0:c2d:c6e7:9e9a with SMTP id a640c23a62f3a-c513a816ce5mr1651611766b.11.1795685490519;
        Thu, 26 Nov 2026 01:31:30 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdee82sm597090066b.66.2026.11.26.01.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:31:30 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH 11/18] sparc32,leon: restore the kernel header offsets used by U-Boot
Date: Thu, 26 Nov 2026 10:30:16 +0100
Message-ID: <20261126093106.1345825-12-linmag7@gmail.com>
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

Factory GR-LEON4-ITX U-Boot checks for HdrS at 0x9000, then at 0xc000.
Reserve eight pages before HdrS in LEON-enabled kernels to restore the
UP and SMP offsets. This costs 32 KiB in the loaded image.

SILO, TILO and the kernel's piggyback tool can locate HdrS relative to
the branch to gokernel. The ELF entry point and header ABI stay the same.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/head_32.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 6547717aac20..d36839ca1f03 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -64,6 +64,14 @@ sun4e_notsup:
 
 	.align PAGE_SIZE
 
+#ifdef CONFIG_SPARC_LEON
+/*
+ * Factory GR-LEON4-ITX U-Boot checks for HdrS at 0x9000 (UP), then at
+ * 0xc000 (SMP). Older kernels had eight pages before the header.
+ */
+	.skip 8 * PAGE_SIZE
+#endif
+
 	.global root_flags
 	.global ram_flags
 	.global root_dev
-- 
2.43.0

