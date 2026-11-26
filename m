Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685487;
	b=JmMIQ11PIHej/7EikjIDPTuCvs5Q+GogIQtV4SMNqvjKo101EUkWauIT0zKcpS8l3e2w
	 0G1B+clzP7Ej467RzbZ3PJx1ipG9Uwgzaf0vsXLZ5iYClz8a7A4cvv9+0aBNNsJmZ7Ln7
	 iF0ClppUz+QbRw00C2X+d8bNvnjVOX/RAyeFi0w+AOHsvlIYauWNuedb+T3XygT2Wgty3
	 XBhvoKJ93wpQypjtf6eLXpUZ4jhjzSOF1VcCtmK8tlUS5UB1fGlQSVzcsSlzfakylE3Su
	 S66BSavETPm8f3c+cO/Seo7UwbpkvLJdx8DaCbTLlsg/me6Mmv0Eqpgu3fj6TGxCpsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JI0g72Qz4jcoRZ1TWDvybKstNSgg9xw32wUy5VYIBiU=;
	b=lac4jdrMYL2dpHDwKH+AyWxUWM1SxSbYggZpJoVCEgMRwvuBBjc3FSuRE95PU9EcMWZg
	 YQSyPWxGu1EE1aHK1d9aW2rE2InF6hZnvn5hSyP7jtvlqPWVtv/um37Q2nar70hR4ONxS
	 XdAUqsYYfAviaJB24jzwlK06Hs9U0waLqb9XHnjOhsTxM2O/hJrtPJuPg42B7XIk1amGw
	 YtEUVLGUrgZE02gUZ3chuZ/GO0oTsNsAfvN43RsHYu9ZXgd+Elmz+tbLwX6vkg/x2DyGM
	 marEZ0Q1B9wq3n32KmTtLFSPlAIslOPuYoDcniU2LJf6jQnIoxjV8BHDQklKd1hxXpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NLIEXoAC;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53295606A31C
	for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 09:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53295606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NLIEXoAC
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4cac7a7d3cso1011121266b.3
        for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 01:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685486; x=1796290286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JI0g72Qz4jcoRZ1TWDvybKstNSgg9xw32wUy5VYIBiU=;
        b=NLIEXoACBrLd1qXDnGnO+WaIvVmTHfswa0Z3T5gwTfjTJtLfjaQau8vJ+X3repNeH5
         eq31x0IaKS/4Kiq6gACXje2COML7Gfes4N7TmYeLwoLsVyrVQhVW2W6G+gU8sPM/W+5Z
         iLMCy2eAul21eKsG1gTWpqLEUAg0J7wQjAr0oSBPG9gdN1jxMSA77Rol4//Zc8pj+G5L
         i4K2Z46fkzb9J+fq+sTHMjyDAwj7w/VSVmL+CMIWA40wB/OJxG1Q1sEnshUZ0q6xKHD9
         twCECEI4Y7d+VvaX00eDHqjEZn4i9SH5mGFGNbPdIHtrUjA4I/pEycvJ5WTsKDXWHc/d
         /ipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685486; x=1796290286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JI0g72Qz4jcoRZ1TWDvybKstNSgg9xw32wUy5VYIBiU=;
        b=IpYmY1Xl4DFU+da0Bb7h+AULKpWKVm1w8gqu3DZ21r/CUTRixwl7dtzqrT10BD1yM1
         RQFCGqeEUhL1nFpUk+lLyVdZs7UOjM4akyG8V5t7hHUbq2ljMHVuoydbq2tUQqbDxq2F
         chOH83gGG4e8A8h49XMnJYE7SJFbAFgoji3Vq7OAL9u+DRivipxP6xBgCgrTsLfcDzWh
         yq+Wt0MxNE9RiZREH/xDB6zo+lRl4rcq8OvwrQzNYSXAP1nYkaT9QzRN7xnoM2LKl11A
         2opiBiVaKeP9p1TULUVKui7k1V8+l7yMVDszrYJmQdj/DuXok4chj8+MJGUBV0XKlhnB
         T0mw==
X-Forwarded-Encrypted: i=1; AL+hErHpCAPutIbxsWmwDmKhj0OThvNsx3JSAzgVErL9Af3wuoH3M2xaN9VGFnsYIqxRgfhG4klhV2hE6bjB@vger.kernel.org
X-Gm-Message-State: APuU4Z9S9lbsbnEO7kh6MXn+XdvZje7GhIyaRdfAhTDXWBqIqtgPim4h
	Xh1hW0xV+HUv3iCmFkQB5hcAr19+MZHSFiKPmYYsKVV/d6wfVkQG/bvx
X-Gm-Gg: AZFdTZfJmopGNJY3a9w3RX2JSpMcbd/qwCGBWoq8pXE40ypnjatAyLNTejr/+VqZUX2
	CF6OzBfM5EBe3jnSjcEiKUvXmBryKLJBOqMkPaPh3ahi8j7XRsOQcRBAfp2qhSmMNYpCX4ejUHs
	FtDL4ZGT1d/hB84sJ8q3LWuQl5kBRZZKvBXJxGdlIwo067Dy41odoNDx4c7xA5AasbRMXq+MH70
	gX3P8Lx6qYd/Wwsn23FqvbN0uxc82fd1ANyWAMVbhy2YWSPMtn7yN4WvpWA1f1y7rcvZipV3DKV
	JFnJKi996//AXBVZQnwHXjA+TJvTEzdRNC6bQoe6J3wbycVG1CRfUkhbGIK+UfzNBSLjUnAbYoH
	Y/8kwAsZRF8/03ItlIHBtGKG/Ad59VodDx4jVUOsKbDLHRMqiLX9L4rr1+FektmaHd7d7TgRhvG
	zBxdabr2siy7Cw7M9Zf3BFI7/obXG8NpelH8LKSvijZkO25q2EJRf0VFasXXwOwiozIwn2FH3FC
	lbzSMzlJvkdoNKhK8NswuM1MOZ9eWtWSgh0fr0v0rYPdq8V59nj9WRfKExAKX7Gl/yVSVz4v2Al
	DSTmatSwkeF2u6ZuZETsAedPFPphhtR2PsJ/m4UTm0Ds/kAhlsdielb86IALekXRGUm9vPI=
X-Received: by 2002:a17:906:81da:b0:c51:1d9a:323c with SMTP id a640c23a62f3a-c513a88b0d1mr1322592666b.15.1795685485641;
        Thu, 26 Nov 2026 01:31:25 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdee82sm597090066b.66.2026.11.26.01.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:31:25 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH 06/18] sparc32: tolerate firmware nodes without a name property
Date: Thu, 26 Nov 2026 10:30:11 +0100
Message-ID: <20261126093106.1345825-7-linmag7@gmail.com>
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

Factory LEON U-Boot omits device-tree name properties, causing
build_path_component() to dereference NULL. Use an empty root component
and phandle-based child names when the property is absent.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/prom_32.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index cd94f1e8d644..804ca0b2a5b5 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -189,11 +189,21 @@ char * __init build_path_component(struct device_node *dp)
 	char tmp_buf[64], *n;
 	size_t n_sz;
 
+	/* Old LEON firmware omits the root name; handle unnamed children too. */
+	if (!name) {
+		if (dp->parent)
+			snprintf(tmp_buf, sizeof(tmp_buf), "node@%x", dp->phandle);
+		else
+			tmp_buf[0] = '\0';
+		goto alloc_name;
+	}
+
 	tmp_buf[0] = '\0';
 	__build_path_component(dp, tmp_buf);
 	if (tmp_buf[0] == '\0')
 		strscpy(tmp_buf, name);
 
+alloc_name:
 	n_sz = strlen(tmp_buf) + 1;
 	n = prom_early_alloc(n_sz);
 	strscpy(n, tmp_buf, n_sz);
-- 
2.43.0

