Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685489;
	b=MQN3AKe9GCZr+r2kjtsh+6/tz3aEdRdzP8K3T6+64I0sYs1q5h0BlXvGGK7K2NVV4zxz
	 kQhihJsqwk+zSZ4C1hNKGCGW6RxDsyWynrkU/+4dwyG3tKHdN3ljRZsGVoOdakXtD6pIM
	 MorrbbmscW1C2WJUcB/bn4IFi9Q3qF8Uk1R55WLr10cI2HfQdFtL6X0wmVE0kmHFm82kK
	 MsI4obvSnmPpSKhhqls7ZVooWuwCkNLcsxt5lwHz2wY6zWmiJaVs5g5p8p9aBnjxXIt7P
	 TH2mEva9ummAwbUGApPUQwjH59Wqt8azxOEhskjryfgwiFE8hOiA8aiN19BYPK0oCDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685489;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=62zsAbNpyYh2P0IvXqu0uU90/iZYUWvyU/7P+mIdw/Q=;
	b=muJanbWvfuRPI69FimjfPOcjpA5MCGgKvecKVSpAvgh+Huq7wN5bEFzKAPymHNYukydV
	 W1fLvR4VUJNolesfBguap6EKFi7kiABsmXs9HB75E+3nfouuEoStSG5+pxvM/0uUagfUL
	 W+/CUBePZnyCam81iumk7GDvWnGU9AkrWF5H8BYp8ewnw/R7t2+Za33wt+NpwBywqglvL
	 LigVfv4kly8V1QjAbYEDH2xovjjAI05rxDpRtpm/DKpWjUa7FioIdlnQ1Asg/jbKcNnR/
	 jceqM5rg/Ca5LOlLYMceNg5Fkw/C07uEj5cQX1puiBzJL/NCd9EZ4bmrV6aaRvIv0kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sHScJeds;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F15F606A327
	for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 09:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F15F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sHScJeds
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c51373ae637so213945266b.3
        for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 01:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685487; x=1796290287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=62zsAbNpyYh2P0IvXqu0uU90/iZYUWvyU/7P+mIdw/Q=;
        b=sHScJedsWWAuHzomP/yISjEYjyOFfOgoS7OoN+mMu38gyHwCyBAyv07VGirbjLz3s3
         OYMssdDrcV4tCOJOxVcW1wcp9Q2KbtPVR+z46mZUeQ/dqjvralNbv8umYoKAq8ZR7TvL
         aszdQUaGiPGzOpcVj7xHTfVpg4pRYbezmV+iYYhN5XL3T7URMfPwL2tbkPLZiOxtIrgv
         sn6dhuXdGQUanMWYdIkhYZlHeQ83zWWcNhCXVFr/hrag1o1c0QX178Hapsb4zpW8vDx/
         HXNllJXzGcywo1k0tsIcV58BBCNzJW8WQ43VRjdKXeBF6DMh1hLeRpFoulazq+twjKvU
         ZTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685487; x=1796290287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=62zsAbNpyYh2P0IvXqu0uU90/iZYUWvyU/7P+mIdw/Q=;
        b=WsT6iYUxsBb2QMIUHUNevn7zxQ8PwdtCoGlyMP2acNXWCJvxX8nEk8KT9reccr2UOV
         s1Iwbuxa/H44Uc3gDJH2cgyaFHvZLGRVkUnonUmsemSW0gcfty1rczLgTfVsBRmSPHGT
         Bzf4XmQY4pIOEnH9v3CrfIn9EMf22bj0BAWuvuS042ogPX3JIjfaol4UcPeh4fxZMdIg
         V0Lry8H8S+Uy1vgWuXr8I49p6Q2DoR0tq1LbQYOPiQAFxsSY52JV3rE99eiHCh1NtlJs
         DdZtFeLwIocj90lmtlFppWpHNSgCw69i7536lS0GC3c4Ql4O0X1gFQF4oHSZdJIHDwil
         P70w==
X-Forwarded-Encrypted: i=1; AL+hErGvBHRM5GSBRKneTpBRk7Rh9IblCBZEukvzVPwi6vwYkfv5vz/WYkpB89Qju7QUn1en2FcWV9YtT1YW@vger.kernel.org
X-Gm-Message-State: APuU4Z81XAKVYNeeC2qWRxr+sEEz+6s/KIDv5p8hvWeKzuPJKD7bgUKO
	jh768J57Rqk0a3eqP8p9gCzyXf8CmjCrQn8j7bQTDQf9Bjn07nA234y6
X-Gm-Gg: AZFdTZdDESdDY5tg8JbPw0+ZKmVIBkdLsSq92g87Rzg8gH1d9WwbiTnqn0uwUuvRFsw
	fVi/94GDjuIG/RMe+HZHDMqiDOiVMoUPlPaLnAnG6FxK+jz9sfLMgCGyT4oYir1TM5UyQ2iKA3d
	PXbi0BbX1Je2fpsMbTp9TZ8NP2ub6tIMUEqoS+5bsXpEEC6tT5yK4LyaTKFgH9tu+5iN4WO6RYT
	ZOPVHG227717OIOIEEV15mkNKzi4EyiSqpIJVTMe6bXn+SB/Vx60ANK5KNxc1HlGVibB79IyTNB
	dpjv3x0ONhcNOUjVPRWw+4LkntT5E7oKcK0izGHWK8qhmDrHD0D34HtdXsDU+cSWHzMO8p6WsdH
	mpM/f5sjTeCwL7zMlSfUtY7TLfAtxZfQAqT0ks75AMDQvyixghd/tosmtCEbIs1n54Ac3Hac82a
	JeqOL+ivIi16SBgXKpavJQpsVi1cu480WkmnMInC8ObUBqctTQ3vgK2DHzSFzsfj3Q3dIt0r4NP
	z/GovnyLy3WnN5yAh+wrD3PWLPjq9yHwftiRNP6gXrMhc00cf08HKAvwrfx8eH27/lXBpifkvZR
	+UftKW4cDb2itYwTdj1AKGHCXFnfA7a2cI1fVEamRNBuvZAx165ICWSKvSmBeBALiHW4i4I=
X-Received: by 2002:a17:906:115a:b0:c1f:983f:d8a with SMTP id a640c23a62f3a-c513a89ec1emr1276642366b.24.1795685487565;
        Thu, 26 Nov 2026 01:31:27 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdee82sm597090066b.66.2026.11.26.01.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:31:26 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH 08/18] sparc32,leon: identify LEON before the firmware model lookup
Date: Thu, 26 Nov 2026 10:30:13 +0100
Message-ID: <20261126093106.1345825-9-linmag7@gmail.com>
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

The legacy firmware lacks the compatible property expected by startup,
so LEON is misidentified as sun4m. With LEON support enabled, identify
PSR implementation 0xf before the firmware lookup and enter leon_init.

Fixes: 1ddb22e13dea ("sparc32,leon: fix leon bootup")
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/head_32.S | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 11a1746829a4..97000e9dffd6 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -27,6 +27,13 @@
 #include <asm/errno.h>
 #include <asm/pgtable.h>	/* PGDIR_SHIFT */
 
+	.macro leon_psr_compare reg
+	rd	%psr, \reg
+	srl	\reg, PSR_IMPL_SHIFT, \reg
+	and	\reg, PSR_IMPL_SHIFTED_MASK, \reg
+	cmp	\reg, PSR_IMPL_LEON
+	.endm
+
 	.data
 /* The following are used with the prom_vector node-ops to figure out
  * the cpu-type
@@ -205,10 +212,7 @@ not_a_sun4:
 		 */
 
 		/* Check if this is a LEON CPU */
-		rd	%psr, %g3
-		srl	%g3, PSR_IMPL_SHIFT, %g3
-		and	%g3, PSR_IMPL_SHIFTED_MASK, %g3
-		cmp	%g3, PSR_IMPL_LEON
+		leon_psr_compare %g3
 		be	leon_remap		/* It is a LEON - jump */
 		 nop
 
@@ -366,6 +370,23 @@ execute_in_high_mem:
 		sethi	%hi(linux_dbvec), %g1
 		st	%o1, [%g1 + %lo(linux_dbvec)]
 
+#ifdef CONFIG_SPARC_LEON
+		/* Old LEON U-Boot uses "compatability", not "compatible".
+		 * Identify the CPU before choosing platform initialization,
+		 * and publish the same model for sparc32_start_kernel().
+		 */
+		leon_psr_compare %g3
+		bne	.Lprom_machine_type
+		 nop
+		set	cputypval, %o2
+		set	0x6c656f6e, %g3		! "leon"
+		st	%g3, [%o2]
+		stb	%g0, [%o2 + 4]
+		ba	leon_init
+		 nop
+.Lprom_machine_type:
+#endif /* CONFIG_SPARC_LEON */
+
 		/* Get the machine type via the romvec
 		 * getprops node operation
 		 */
-- 
2.43.0

