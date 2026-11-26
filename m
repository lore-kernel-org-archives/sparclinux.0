Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685497;
	b=wSG1b7JuZi/miTBRtoXCaQxG3m19Ih9GS2PKpJ0gNyN1uMwn2Dl1En7GVE1L1ovqfL8L
	 LvIJm/WIyJ6ayVfW4RhplSf4i1/nZQdaYvv90mxq8l0mtAQ3KTXMpOYQW0BwGk2O2/OOu
	 g9sNWLYoWSJcUUxzEykwn4QIIel7oAbVkPY+DBspEMgtWF0lEVlFsZwOk5QtHULMNpiLN
	 DNW8+Ck0ZmFQ1CXhr2tp6+yEZqc8Xq4pWtCSXBefZQuKExd809JdRGcdjubxht1Jtk/ub
	 zPHDuoqQar/AzUPJ5it8fluyVfK2WwS35BjHH/0pIh/LH08N+klHiVQBUHxGaTODUDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rYtDI3t00yBsJ7/8bDa0K/Ek0vbIf+lbsMzxOdG7umk=;
	b=RTae8UB2aOYRed0NB33cLXNC1cuxGPfQAiWABF0iv5zEdntKeHlyq4RvbFg1VAzQABYi
	 2oQstlTzc3y+Hse/gcz6x2KomCvPA6VuXAguziR2pME5xc6i86u30HgtX0qnl9i0qNukl
	 tjaw9PaSq/ZugYIb/DYGm5lI6AmRvdrhN1SnWJAZjl1b45/QzgiRLhEi1Vnw/V02sILY2
	 PSyEFEAyhLk8EY+RpNcm97q9lGeebC01aPPy8pftQemVwZJe1Fc8TsYBpGLTUY54rBdaq
	 YaTLoPMazEl/B/kcc07+CkdJuwilAVM+10EXn4MtU4r+3C8hYbxNFV02k76phGS6QQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jsja5psw;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765BD60A262D
	for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 09:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 765BD60A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jsja5psw
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c51bf011392so132778866b.3
        for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 01:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685496; x=1796290296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rYtDI3t00yBsJ7/8bDa0K/Ek0vbIf+lbsMzxOdG7umk=;
        b=Jsja5pswQ+lFRlkYENUKRUttHAb9XEX+lfj9k90hF0veUq8vITYp5KB1CAzSlz2SQf
         vBqkMgwBf6BShA+nh+twiJhVukFOjNHrmMvrA9MOP0gBwxSdkukVvUXW6fImprqYnWgL
         H+uFGsD1bT+dZukyFYp0wbcbqxvUg37T4MyubI/B4SSUomD58xdD4v7jjUSS7GWlHLkN
         WEHq9bL4H2rQS/a+/SEv2Q4lPulx/DZErg/KAQq5KgChL3ZMyPS4//SnkI3yoB3QDnXV
         A+uQlbtjrRwLWoihk5t+jumL2kFVe8dMO/miErdO25JO9oDjNDzQfvZ0vpy2qM5txxTD
         rr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685496; x=1796290296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rYtDI3t00yBsJ7/8bDa0K/Ek0vbIf+lbsMzxOdG7umk=;
        b=CSKbRbhMhZIoxW70VeLp4Shv3Cp8XAR5y1whYyoWCaer4HH0KTjqLKBZ1LOIpBad8K
         CFE87cCRAqMt9lNuO5PRQ/zOatlkOYky4piYXMiJKEIBUL6hXPBwdpIU/rPX+KDxPT3N
         fS6A94yzzomYf7ja/pO4/A3tRDjQu7FAhuWZ4GjZWOPPxCry+F0AQKrHjjX5MH+sJa0d
         y3//Ec81w4o4fplUoxE1/HP14/oi5O/MBlROhdQMXKCWw1eN5Yl2zllA3OW+n8SlYjff
         v3M/VeiCpaPqZh70qJoJzcYsuMVNoJUJIvYW+/cwhz4YH29wpYyr4oqKEoDxNFqMtth0
         BscA==
X-Forwarded-Encrypted: i=1; AL+hErFPJzEtWbsogJZkK8/UKO1FBTe+7MQrNb8Wi9OicU5fYyOS+hX5n5siWGRCxD/mfVFm6xcrXeKnh7Fj@vger.kernel.org
X-Gm-Message-State: APuU4Z8XV+EF8Z5c1JcJ0mB5Jxr9J9u1ohA68fb+8fBV17wAavNHnK/5
	G0o8lMwFNpHtj2dSiuh8JoEvbKrYAzSi3CiQM8DZuf8xNMW4qtGZ61Ry
X-Gm-Gg: AZFdTZcFowYQSsSdZUYCkrgllX9/d3BeYeBXUBu8uSLbN5EUiHo968Ro1Z/Wemuo0QA
	YZq2SOE1btMeXoasX5cGN6EhRrPTrPoa7mFGbzhEdkjtDGKgwBUeawotYEwoKSwCK6S16tLapmM
	Y4oBXKD2+5VbAGOy0/MOzCYpCUBzP4IqQafRG/p7dWsn3EADnT1H5t852UKe0E2bvoXV+/Wzait
	VehuS9GlDL7BGiyBiKX2Y5TwmMXKeg97X3H+6N853MwcsIjfcHZsASbkG0I3HyDZt68nHbZue5Q
	Wos9mUcPpxGpBtE8lLbjH7ixLp2Gc9hF72RzQSaRMSlqSa932hRC32UVNXr5Sis2Vyhois4RCST
	BeVnqWlvpLAZOKsUsgG/gIcJAWGyXFO4qFRXVjHOdCLw6HSqmxEg8etD9rqiM0I1zkqkmGsKl/Y
	jgyBXZxPT9rXHcwLaIlVp8goz3B71ELnJTGgmSg3N4Fhrk/LrBtJ8J8TemYiQ7ReLtgOKmgOciW
	2WCz3gqTj8V72Y04CF7Mo2Ll0hLhrnOSJhqTSuJC5bmSlW7KIbPjH2ySurSLP+dDfxYgvtjBV0o
	s6rMOyeTbYlZynhvvqNbm7zNsfd9NNy/3GP82uH8JMfvxV+T+RShmHizAJJNO08RwPGJtng=
X-Received: by 2002:a17:906:d317:b0:c42:102f:15df with SMTP id a640c23a62f3a-c513a99abd8mr1309198866b.8.1795685494372;
        Thu, 26 Nov 2026 01:31:34 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdee82sm597090066b.66.2026.11.26.01.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:31:33 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH 15/18] sparc32,leon: skip the GR-LEON4-ITX PROM mapping import
Date: Thu, 26 Nov 2026 10:30:20 +0100
Message-ID: <20261126093106.1345825-16-linmag7@gmail.com>
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

The factory U-Boot maps SDRAM with 16 MiB leaves. Linux reaches the
PROM through the linear mapping. Until now leon_swprobe() rejected its
context table at 0x4bffe000 because it lay at max_pfn. Adding the upper
RAM raises max_pfn and makes the importer copy these leaves into the I/O
and vmalloc areas. The first vmap() then faults in
__vmap_pages_range_noflush().

Skip the import on this board, including the high virtual addresses
whose leaves alias RAM that Linux will allocate.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/leon.h   | 1 +
 arch/sparc/kernel/leon_legacy.c | 5 +++++
 arch/sparc/mm/srmmu.c           | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 67f2822d5fc6..9e51f1fb70fd 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -226,6 +226,7 @@ void leon_update_virq_handling(unsigned int virq,
 			       const char *name, int do_ack);
 extern bool leon_gr_leon4_itx;
 void leon_init_timers(void);
+bool leon_legacy_is_itx(void);
 void leon_node_init(struct device_node *dp, struct device_node ***nextp);
 void init_leon(void);
 void poke_leonsparc(void);
diff --git a/arch/sparc/kernel/leon_legacy.c b/arch/sparc/kernel/leon_legacy.c
index fa978620f4a6..d6c9efe59f42 100644
--- a/arch/sparc/kernel/leon_legacy.c
+++ b/arch/sparc/kernel/leon_legacy.c
@@ -39,6 +39,11 @@ static u32 __init legacy_read(u32 address)
 	return LEON3_BYPASS_LOAD_PA(address);
 }
 
+bool __init leon_legacy_is_itx(void)
+{
+	return prom_leon_legacy && leon_gr_leon4_itx;
+}
+
 static bool __init legacy_is(u32 id, unsigned int device)
 {
 	return (id >> 24) == VENDOR_GAISLER &&
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index d2963fab829c..2ecc42f6c935 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -767,6 +767,10 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 	pte_t *ptep;
 	int what; /* 0 = normal-pte, 1 = pmd-level pte, 2 = pgd-level pte */
 
+	/* The ITX U-Boot maps only SDRAM here. Its PROM is in the linear map. */
+	if (IS_ENABLED(CONFIG_SPARC_LEON) && leon_legacy_is_itx())
+		return;
+
 	while (start <= end) {
 		if (start == 0)
 			break; /* probably wrap around */
-- 
2.43.0

