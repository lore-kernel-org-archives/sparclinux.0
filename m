Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685484;
	b=VZzf9/Gla0+gSDZ1cXNsk4619HJTUAZBlot4rb6TmoGwLKD0rn+uGK8+8mD5oK27p2xH
	 RfrrOA3rPVR+WFfE0v7VtV/Ng4ZvtopgB526VwSrVNWGWXUcSB36P471CxksR96cb5ss2
	 0sGbjWS78XOldC/rT/dRg1F0p4Kw3E4/0rrSS2MJVlSESeHlb8gZmkS9kCFdgesn55GWs
	 BfrihUpgi0s1x/1TuGRUnymXLDKWYs7Q2OBwzJvm9ChNuA60S1D7XPp24UN+E8CvXOdC9
	 NYCxYpq2qG+GkLJYN0zt9oCXXiTNj+2chrlNBrBS1evpuahuAJxE+OpeC1woDklZhNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=E/ftTHBn544yXnq15epikqQ+4mq3bhKo9jH8irlYVGU=;
	b=FHbcFbahvYhJMKnYFgwjZNncOWbQAskbiTeV/Y41z/IRVWQoOWgeQMTNjUU3l5b70bXs
	 gJ7vAo9Au6kxAcZMxTRNOsoUHOPklYTApjTOgsfSVCok16E1ltrYmZ5XJtgUgPUHq8pf5
	 pGTHcFvp37Ub5gh1VRKhfnW0qxq17VWnnjgRxbZZaotfLZ+Wi+IZ3tbfMeVC/kfIWxY+F
	 pgGYBU0/DC/udy+ySvn3/YTS+u4KUDB+CGRxN+jCo5osrIJV/UMY5HuQaXMcfETBC2QTh
	 OosU+JwrOpuJvRsLdLaPIymZbPidAWg5w1bFMciN91yCPGRv2XdBwKz1UHFRmiH3h0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IIwECtid;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93336606A337
	for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 09:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93336606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IIwECtid
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b87a240de3so8540015a12.1
        for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 01:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685482; x=1796290282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E/ftTHBn544yXnq15epikqQ+4mq3bhKo9jH8irlYVGU=;
        b=IIwECtidaIQK6vrOzQTObRsTceSkyoFgrZwJA8eGaN9/pI/BplL9rjyx9rSxxS95Xn
         Qc72IRVxBsbsa64bCeB1IU7O4AaGcBYEBjHODI47GXVTJF/EkMzToJfJYmYlylqPdtAo
         1RCYrX1N95gAeQ1SkC/29ibtj2MfGsEkCbaQrp8bnjDavLIt7ENrfwARo7l7HYITyyqD
         i6gbTKmSatgMNBgJxlF95WcjBG7335FuQu3nVi7Ywj+o9FMWNq/DIXiPFLWGxGK1uPD9
         v3WFtyBK+vsAQRcJVQvBKwaTokYmoBHrqwVqD35r2+02TDHFDIlrgdGrWKc18yred/FV
         SeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685482; x=1796290282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E/ftTHBn544yXnq15epikqQ+4mq3bhKo9jH8irlYVGU=;
        b=cZJwZZLCC4IuZlTQs9J30Xm5sTcb//F+cmNQ5R7XfgN1J6wwKK9/Z5m9U8hZt3B/3Y
         +B7nDC3L0ZFTWtgYKuN0cOk9oHXWUimDZaNKX7BcznRq4q6C006UlLGHHx71e7ufdbAh
         2PSiv6OKMiScyyBECX+XJJvcGT3vVkq+pQ2C3E5x1sIc+jdGmtZ43V9kWUYbnrxf2an+
         K0IbJ3G0VURQdVbdhHfAiNIOhIx1BP1t7Nf6gD2na37fp0Fpd0UttIzgs0XzThP9Xkqu
         wPky9WicIpuenEDrOnDJyqTMK4CJgUhk3FOyhIMzQVfZSKCjPiuGRTxEyG/amFBENC2R
         4+JQ==
X-Forwarded-Encrypted: i=1; AL+hErGir+k6d423/Bu4P/w6RHROx1xua0zv9qiNBKdQ70gFTulUNyTYuOVUSmXlXjzFemNar+hvcTs2zIZ9@vger.kernel.org
X-Gm-Message-State: APuU4Z9yN3ROsFJVCj4wO9WOzmbhXvP8QbhqMOWJ6/ol14YNl/Jm1gzQ
	DQhjZLUJKNC/puNVxLaksCIUmXB41Jkn0AA2caE05aTRq2wCFNnWYS4PNiQSydgY
X-Gm-Gg: AZFdTZedhcEohePOdKJgrk7yFLe7CEzcXxA+tMVjInnYQ/BdZi18DHc7/ppSVbYkA6s
	sBnvGkbjdDdbfTlycCzlFfV9QL04fMYCj1jIKinnjchD6/Phk5RmJhnL5Xrl7JbOytX9Bwx/ro0
	kkjghAMNvcfpG52d5kNxlwpHkWbvr/oHH6uPRXVsYwln6cBjsSBJ0OX/jVwgUnPFcQY1pfoJ7zr
	L+E5o206jSrvvuvV9BA0OW7rv/v+xI5ncjD1qQsMqLrucPdaF05JrDBtLXIcS6vuHEp7++SUWvA
	n4j15bf39zoKOaRIlo/xTrVEL2JL8N/V8n90LQiKA5QCD2ktlxI+lcZYilttOpd7b2rc/j9wUX6
	eJyXWVDZQALG9942h15Y2wD5rI8sJZZY0yPiOXEJL0VC8nhwJkuWJKDdigxspalbRiZjeguQCRT
	aWMd6C2GP8u3ZN1/lbbtahbzZ6PnYuZMQn7ZJdNu5G4SEObm4CGUlY95K9aCKMwJzxZtEKw/pOB
	jonnNzAfHj3yJogmCtUYO4WlRgV5MKeGWJaYdoinrwUnIp2MjrsHyu2LlHog/0K+IrlRM4H/cAv
	LhrEwT4OFk3cxFVE4DJLaZFTw2jw9Kbu0gAQxqY9vzW6gkPpiarB8BgMbVuFPYDz8KhvUUc=
X-Received: by 2002:a17:906:a11a:b0:c4c:d96e:80de with SMTP id a640c23a62f3a-c513a5dabbdmr1290596466b.8.1795685481732;
        Thu, 26 Nov 2026 01:31:21 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdee82sm597090066b.66.2026.11.26.01.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:31:21 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH 02/18] sparc32,leon: retain SMP TLB shootdowns
Date: Thu, 26 Nov 2026 10:30:07 +0100
Message-ID: <20261126093106.1345825-3-linmag7@gmail.com>
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

LEON replaces the synchronous SMP TLB wrappers with local operations,
leaving remote translations stale after a mapping change. Keep the SMP
wrappers for LEON. On GR-LEON4-ITX, all 512 remapping reads were stale
without this change and all 512 were fresh with it.

leon_switch_mm() passed NULL to flush_tlb_mm(), which the SMP wrapper
would dereference. A context switch only needs a local flush, so call
leon_flush_tlb_all() directly.

This is based on "sparc32: retain mm_cpumask across TLB shootdowns" and
"sparc32: enroll and order CPUs before switching address spaces".

Fixes: 8401707ff645 ("sparc,leon: Sparc-Leon SMP support")
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/mm/leon_mm.c | 3 ++-
 arch/sparc/mm/srmmu.c   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/mm/leon_mm.c b/arch/sparc/mm/leon_mm.c
index a43c5ffbbbe5..c19eb23b62e2 100644
--- a/arch/sparc/mm/leon_mm.c
+++ b/arch/sparc/mm/leon_mm.c
@@ -264,7 +264,8 @@ int __init leon_flush_needed(void)
 
 void leon_switch_mm(void)
 {
-	flush_tlb_mm((void *)0);
+	/* Context switches are local; mapping changes use the SMP wrappers. */
+	leon_flush_tlb_all();
 	if (leon_flush_during_switch)
 		leon_flush_cache_all();
 }
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 145a63a5fda9..fb95865d7ddd 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -1746,7 +1746,8 @@ void __init load_mmu(void)
 	/* El switcheroo... */
 	local_ops = sparc32_cachetlb_ops;
 
-	if (sparc_cpu_model == sun4d || sparc_cpu_model == sparc_leon) {
+	/* sun4d supplies its own SMP TLB operations. */
+	if (sparc_cpu_model == sun4d) {
 		smp_cachetlb_ops.tlb_all = local_ops->tlb_all;
 		smp_cachetlb_ops.tlb_mm = local_ops->tlb_mm;
 		smp_cachetlb_ops.tlb_range = local_ops->tlb_range;
-- 
2.43.0

