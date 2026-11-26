Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685485;
	b=s1tgjXp3NNqyw/F7FKuIBHyrEZHm+n1MK8wKERGrMD0s6y/Bjzs41knH7XCS6+uI9q4v
	 WPwMmya+1gMwnbINPgSv9uFsa7J1aqV9+uevxhGKGQPetsQdJQ9RrFixx/f0li/FGnIJ8
	 r5tblwaKNsDmtU6lvtSx6+8tCM5qrPGEhc2UUJZ6ng9Pv+5xTLaPFqyRnHGyYXVOo74gE
	 +6XSB4TRHxHrqXQXrWJo6okmKEMsHonWOtdEfLN3/6xDaKEsozeVwroq5s5z+Ezffx3F0
	 is5oBpkY4UqmrRFGCmu5l7eFZ7oGDbnFnuOmSe/gP+V3mbxZB4bvSx8hB8Vx4Nc6MMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KxYz0Rx58uvG878VN3POGtPURCrxZ6nQaRpf1JD8omk=;
	b=ogSsVsw/pe2C8W9Ar2Yap1P5QSRrCy7lF0rYogLneezxs2HVkzAYayBpvIyuQ5g/ZAWt
	 oMlsQlPlSp0EdLixreBV8iIffubsLMMd94dmPXuVAhVBCAUbuTsehdHg0bR7uwdtbtYos
	 a85+9e9QfIOra+ZafSy2QrUVX6RuArES4Gq9NCbZkN9DU+AeGCdRLhtr7M4wJAWztpZ+a
	 E54NYEvM+vZwOD1FgNv3Dx2BVfr8NsC1QNt4cnId03jpBnDgsHsLVqTPnJvgrwdE6iFkx
	 ibJgEPeyE/5q3Qb8Gx2N5JnNPqLWyvrzbkXOwTaZ3cgg5hE2EITUFoynYF9Ty5bW3fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zbssfSJ7;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BAE606A33F
	for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 09:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4BAE606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zbssfSJ7
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4d28f75d62so1117276466b.0
        for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 01:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685483; x=1796290283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KxYz0Rx58uvG878VN3POGtPURCrxZ6nQaRpf1JD8omk=;
        b=zbssfSJ7kR1tm3zM3tuzkXG/552spqHTV5kKqqofoN+VyodkEEjs2vYFuLekFgrJIb
         lg+Gr4GD4PH7RlMBBqLVrCWQxnumnh/QK3PNcev68ONjmqLugeN3yFlicfc99TidF/0P
         Kock3PcxjXPRTfJuFyytLa0sTnMq4Ekzt8LYJj3E4HPRPTskjvysCpDQ4u+7IIMh01sH
         a0AMbrg+7pcSti83ZiTdQfqxtTqrXSMstgyipvUzXdhlS2Kar3GCujw3VW/asv9Qjo5Q
         w3e2YRT4yz32aCtj7Vwhs5OUux9t1jLonF30dbTWHpjvbprccujmyaPqcXzYmYKRqRQ5
         7w3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685483; x=1796290283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KxYz0Rx58uvG878VN3POGtPURCrxZ6nQaRpf1JD8omk=;
        b=AQH4+MJYXR4cra/33yGmQ59Ec5Zb2Y8mDrn1OJbRBzE8mo9btJAD+Euou5PKlyR3sy
         lVsimidryB93ZFYRbNhikkb94Va+wyNLJVU3cLHk0gx8hByY1o46WnHquo3Lb1oAMrn6
         TEMeSEeaoOXILn62TmE506QyX0HWcxF2mhUSv7kclF90Skfw8L4BNmjgqKlBZkCinL3U
         VLMlfieOhNP46D/u/fK4f3OXjnLMIYZvfpeNRc2oIRAzko4yKyAhQu96XduwIhq+2zd8
         GLSvPbkzhykB56nL62azcH1jUivzCgWt+EywjpMw5IC+aHwO6SPvyldKOcMEDqM7rvNX
         s3Mw==
X-Forwarded-Encrypted: i=1; AL+hErHxwR79ZLT7tzGWCbaY1opP22HVENpOroaZL5ylyJDUn0dhFDyzkZoYPB0uy6Ft8/oFxb9NCVwoWGeF@vger.kernel.org
X-Gm-Message-State: APuU4Z8BK+quvQzsJY2iwEwRjqztS2OhHxmZUSDmrAzqkek6PY2STM+P
	K26xyV9VonNbleRe5IzT7FC7Gl7+WC0q93hkWhVUEosNt6IOtfeEtY2B
X-Gm-Gg: AZFdTZcy2f9lqpiLFzUKb9G5Kxkz+oWjdo3C7br5HT0Kxp6Z7zH1QpSU7syCuqRV0uA
	mNReE7IS4pzuzm7YowBlYUPmY6/q+17fYE4tJkwCmzVDMBuov2rHgO95SCsY5dZFW6gWytKX0vE
	mxLlI55eLmKC6WgvC4YPGMua4ecxBMjjoxZ4Y0Ji8dwlctv+I6uGaBSrFJIctWEOJNZBHPvQpEb
	IfpLQExOss7CDSmP9r65HfAJHhStoiunyc9LGTWEzBZG7EY6HXwOxak9ZOm+SCYvBcrWhxsoTU5
	v84YhLRpuCjIctlnjrzkCl2u0shupikwclLXrzERzGt5CvT0uL/AbsNZ3YyVRFRTcUJzeL/FTUQ
	vBq2YMzK700OmfyYeiN2X2CbwShEZfAtJOVHRDTAtZvQDbodw8rFJpGRJOvGrmv8sp1xoIr6O+S
	TLsHwmlHdefkBEIHywP28kxh452oOoNsO8Thu9+NltBXitzZStYxICzlyoqt2kCTDObGC9q47vR
	zXTpYVmaPGnYLCY368GmuWQqqvGN8eEMT3Hjevyogs/2sZYLDg9W2e/FI5tOv33VXHxR7IB0MG3
	+XSew+GL/skRmcryGPvi+plnKcB12P4W1pygab+/JNRCA9VAJJvcG1UZ3PjZiv/6TTP+RzA=
X-Received: by 2002:a17:907:fd15:b0:c50:f1c5:f815 with SMTP id a640c23a62f3a-c513ab49777mr1628525566b.31.1795685482808;
        Thu, 26 Nov 2026 01:31:22 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdee82sm597090066b.66.2026.11.26.01.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:31:22 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH 03/18] sparc32,leon: publish instruction updates across CPUs
Date: Thu, 26 Nov 2026 10:30:08 +0100
Message-ID: <20261126093106.1345825-4-linmag7@gmail.com>
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

flush_icache_range() is a no-op on sparc32, so another LEON CPU can
execute old instructions after code is rewritten at an existing mapping.
The LEON4 data cache snoops bus writes (GRIP 104.3.8); publishing code
also requires invalidating the other CPU's instruction cache.

Flush locally and through a synchronous cross-call with preemption
disabled. Keep empty ranges and non-LEON systems as runtime no-ops;
generic SPARC32 kernels can detect LEON without CONFIG_SPARC_LEON.
This covers in-place code updates. The module loader already flushes
caches when creating mappings for module text.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/cacheflush_32.h |  2 +-
 arch/sparc/mm/srmmu.c                  | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/cacheflush_32.h b/arch/sparc/include/asm/cacheflush_32.h
index 9fee0ccfccb8..4249663efacc 100644
--- a/arch/sparc/include/asm/cacheflush_32.h
+++ b/arch/sparc/include/asm/cacheflush_32.h
@@ -15,7 +15,7 @@
 	sparc32_cachetlb_ops->cache_range(vma, start, end)
 #define flush_cache_page(vma,addr,pfn) \
 	sparc32_cachetlb_ops->cache_page(vma, addr)
-#define flush_icache_range(start, end)		do { } while (0)
+void flush_icache_range(unsigned long start, unsigned long end);
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
 	do {							\
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index fb95865d7ddd..d2963fab829c 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -1736,6 +1736,20 @@ static struct sparc32_cachetlb_ops smp_cachetlb_ops __ro_after_init = {
 };
 #endif
 
+void flush_icache_range(unsigned long start, unsigned long end)
+{
+	if (start >= end || sparc_cpu_model != sparc_leon)
+		return;
+
+	preempt_disable();
+	leon_flush_cache_all();
+#ifdef CONFIG_SMP
+	xc0(leon_flush_cache_all);
+#endif
+	preempt_enable();
+}
+EXPORT_SYMBOL(flush_icache_range);
+
 /* Load up routines and constants for sun4m and sun4d mmu */
 void __init load_mmu(void)
 {
-- 
2.43.0

