Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685486;
	b=j+ssurNVbS1b8+4yVVxjOBIzYPb20+ox38zKo4EYkdqUasf2CjJlRgUmR0PCtm4g7lyh
	 2MW9netdbgDvFeD9M7YP5N/1bljYYIq0lHzaXEKeu1ZsYdhXIYHRUwRJZGHgNWFkrPtEv
	 9A3YGypLxNmpPKmCS6+G6TNViC6N4kajAVXU3spOZ4y9lmcSEe2kEuBo1sa98wgByo/Nc
	 m7V94e/QFxFCLAUNNah2iz1hW+bylx2LNso0CYcZaihtCnbv9CbO7IELfkCGud96/HHAi
	 /lZMcjK1wx6ouxQtDi1uhdzKP8WaehsLExEbyyvoB5qA0VAFCuclGtoryG4zmgUV+1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tCB15JnYkDvfVGEXUZ81H+2smLFpK44pjfBFb6tfg1Y=;
	b=v7DHdLwKlJxigSosgrIZDE3E/5LARrJ7J12IAi3uHWrp8Su/KiCPnYarsW693eFrQQvJ
	 QxtwVlr4e/F4VRnXaOnbvqwPXk/sN07bJCUQQVPh3ODJgQUBsp9/KxGF9kFlaf1K4qnv2
	 t2FfzQCUpxIn/GfU71AdOC8OjB8OKZ1wdPI1jf4ZCH4LKEoxe6Hobl5uvhXmR5W4MhqdW
	 WD+dQCUWL1Z4bzZWhVmIMjhaSK6ks91920c9OrNGmS5AYsQ4CWaK8Iu6hVRtmJQbqXe8C
	 vHyjfFn74SykGhAsSUrZGSvL1yVB8CgXO9ompDb1zzZEskWxVSZNdzidSDWtp+MB/LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VJqwi00S;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935AC606A334
	for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 09:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 935AC606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VJqwi00S
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c511c0e2826so779513766b.0
        for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 01:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685485; x=1796290285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tCB15JnYkDvfVGEXUZ81H+2smLFpK44pjfBFb6tfg1Y=;
        b=VJqwi00S5Wbo8E/cR2Lcr2fOeC5pr51NXyVjERokSV/kXNOsPUKew2a9XEf9JFgoMk
         c3+SV+T/13UTVvesYqXWkVTEpcDvm8S0we6zORSJTpJHVWmy+eQNXitRvmAYFDwZz/jp
         LP5xYQ5dEOLQmQtMEKTRhEb0Ba/3NGuSJY0Q4MrsKSlVTMo50lENu6l/3JSEyoVsSqC9
         klEeLq7R0FPtOPSLjHDYg7mvBMwKafcc6yqTCLc6eEhSW+LubgJTVR2Ynv2nNiA6Cbo+
         WTjJfs+LwyXTTgxE7oyG8J7xnPeuBrEppFHtQXhZXcel/Y2Cy92F1RGlr/Ff+RJvt3kp
         oKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685485; x=1796290285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tCB15JnYkDvfVGEXUZ81H+2smLFpK44pjfBFb6tfg1Y=;
        b=glfG4NuC7Nb5scUsKTCornov0HPj6x22F213yQRG0Eu0iiR/eMJiAygnsxr6/MRfQC
         E+vzxvkt/W9GF1EpjLXbr8UYV/UaP4x2NW5sArwiJ0PUaihg2rcL3ZJdfGeB3Kd+5ID/
         1mjnAjbz0AFGqxqgyJjFv9/WChzCt4uVlsVCkiXMYrCiP9iwuikoAc4idEDCfEMkhLuH
         TQlk2vmeEgW6Lazvufa/vQed0/eoUgzOWoTKJ9uttMJYQ09R7Q4k1xVBlArj50qfkl8k
         EZNtDEdqOXlGneX6uFNgEtjjoc7EDyIOJCduA1NPufis2poOggJUt0Fc77iNch2+4x13
         2J3g==
X-Forwarded-Encrypted: i=1; AL+hErF31rW8VpN0oTkmLhd1Go9OdneUh3T3GnXkoDfiX/BM2zTVC6FkwmYDjDISIsQ1vRK3WcTfDvYbMSdq@vger.kernel.org
X-Gm-Message-State: APuU4Z8WaZyOBbiy3h6GF5LoBUDyrgyB87wcnSaKgqp6fNUhSqWitFWV
	DUHf3ZzY7PKASWBN65wvcE0Yp56zLnq2m+R2Epw9YaZYkaBiTVJ48OAV
X-Gm-Gg: AZFdTZfIiO1LLC1KhNRvpcs4/oAjVpgdbG33aAuontmwaqLIy6PajBuavydru7lLdBi
	770iQikG3++Ur/GGzAIdi5aOmzB4kfhf3/41g+SMs+QjXx3fj5t1tAtZmdgc7/MX80BO75VwFwp
	MMwgh3t2u7If1R6XaRPIdZPeOsXu7skddc1TH0HE/JkYpm1deZZUjSgJGSCiS15xakcmBS3L/lk
	z7L+WKFxVfqGu/mxbIwqjGIXTFute9bOqsinizPnhGZZ5BAGoM58GZxVaR5x7yV7S3vOiN4FhTP
	k8SL7E703xpnefWNeACWqaYVqT26qHxlkFxwOx4Rj1kalvXgplJd5ayXULCzSVOmAxmMrDJHkJT
	fKXTZtU3oq6ebXUq0wFl4wcx/R7lo4H4t8dXPoFE/gZ1WpgJXgBuoZIvdeXF7OMRK66lGecSOij
	nueKwKo7cEZr6VX+3hAIhJyiJwPsb65jhGEZqB2XpUXIhBlgIBHBtE8MPlRUv7aKc/dn8bJwUld
	3Xn3wFezz4SVPbE4fPN9f4a1Jb5xo2eE9kS+KzP4kMgeWVdu0LR6I9oUxmJGNkEzV9olCekVAsJ
	IWyC8OeNzbgSjaUJhodpCN4h0TbiWEIlD53KC5SntAMgq2OarbTHZr4Qd0tComCzSJqA33M=
X-Received: by 2002:a17:906:ad1:b0:c2d:d408:5d9c with SMTP id a640c23a62f3a-c513ac9c0d9mr1173205266b.48.1795685484803;
        Thu, 26 Nov 2026 01:31:24 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdee82sm597090066b.66.2026.11.26.01.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:31:24 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 05/18] sparc32: preserve both LEON PROM character-output conventions
Date: Thu, 26 Nov 2026 10:30:10 +0100
Message-ID: <20261126093106.1345825-6-linmag7@gmail.com>
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

Factory GR-LEON4-ITX U-Boot returns zero after character output, while
modern MKLINUXIMG returns zero when busy and one after transmission.
Recognize the legacy PROM before printing and adapt only its zero-success
callback. Match the exact legacy properties and accept its getprop()
success value of one; preserve other firmware conventions.

Fixes: 154337688bfa ("sparc: prom: Sanitize return value from prom_nbputchar()")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/oplib_32.h |  2 ++
 arch/sparc/prom/console_32.c      |  5 +++--
 arch/sparc/prom/init_32.c         | 23 +++++++++++++++++++++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/oplib_32.h b/arch/sparc/include/asm/oplib_32.h
index d1cf3a27a40d..5f009615cecf 100644
--- a/arch/sparc/include/asm/oplib_32.h
+++ b/arch/sparc/include/asm/oplib_32.h
@@ -25,6 +25,8 @@ enum prom_major_version {
 };
 
 extern enum prom_major_version prom_vers;
+/* Old LEON U-Boot uses a blocking, zero-success V0 putchar. */
+extern bool prom_leon_legacy;
 /* Revision, and firmware revision. */
 extern unsigned int prom_rev, prom_prev;
 
diff --git a/arch/sparc/prom/console_32.c b/arch/sparc/prom/console_32.c
index 6404e5bbb7e6..8615005ca67f 100644
--- a/arch/sparc/prom/console_32.c
+++ b/arch/sparc/prom/console_32.c
@@ -22,12 +22,13 @@ extern void restore_current(void);
 static int prom_nbputchar(const char *buf)
 {
 	unsigned long flags;
-	int i = -1;
+	int i = -1, ret;
 
 	spin_lock_irqsave(&prom_lock, flags);
 	switch(prom_vers) {
 	case PROM_V0:
-		if ((*(romvec->pv_nbputchar))(*buf))
+		ret = romvec->pv_nbputchar(*buf);
+		if (prom_leon_legacy ? ret == 0 : ret)
 			i = 1;
 		break;
 	case PROM_V2:
diff --git a/arch/sparc/prom/init_32.c b/arch/sparc/prom/init_32.c
index d20470166cb1..d36fa4e7207a 100644
--- a/arch/sparc/prom/init_32.c
+++ b/arch/sparc/prom/init_32.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/string.h>
 
 #include <asm/openprom.h>
 #include <asm/oplib.h>
@@ -19,6 +20,7 @@ EXPORT_SYMBOL(romvec);
 
 enum prom_major_version prom_vers;
 unsigned int prom_rev, prom_prev;
+bool prom_leon_legacy __ro_after_init;
 
 /* The root node of the prom device tree. */
 phandle prom_root_node;
@@ -27,6 +29,25 @@ EXPORT_SYMBOL(prom_root_node);
 /* Pointer to the device tree operations structure. */
 struct linux_nodeops *prom_nodeops;
 
+/* Identify the old U-Boot PROM before any library routine can print. */
+static void __init prom_check_legacy_leon(void)
+{
+	char compat[5] = { };
+
+	if (!IS_ENABLED(CONFIG_SPARC_LEON) || prom_vers != PROM_V0 ||
+	    romvec->pv_stdin || romvec->pv_stdout)
+		return;
+	if (prom_getproplen(prom_root_node, "compatible") >= 0)
+		return;
+	/* Old U-Boot's getprop returns one on success, not the byte count. */
+	if (prom_getproplen(prom_root_node, "compatability") != sizeof(compat))
+		return;
+	if (prom_getproperty(prom_root_node, "compatability", compat,
+			     sizeof(compat)) > 0 &&
+	    !memcmp(compat, "leon2", sizeof(compat)))
+		prom_leon_legacy = true;
+}
+
 /* You must call prom_init() before you attempt to use any of the
  * routines in the prom library.
  * It gets passed the pointer to the PROM vector.
@@ -65,6 +86,8 @@ void __init prom_init(struct linux_romvec *rp)
 	   (((unsigned long) prom_nodeops) == -1))
 		prom_halt();
 
+	prom_check_legacy_leon();
+
 	prom_meminit();
 
 	prom_ranges_init();
-- 
2.43.0

