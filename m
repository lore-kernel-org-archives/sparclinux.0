Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685493;
	b=yoCnEIBAv0GzohStOCKgfN+CBZX5t2hjLqvg3PZKFSFbpjrmrnXcSHELNtjuevz8j0MQ
	 uAp6VJPnPMm1Pa+3l9DmzYnvVAxmJQyLUEsi+dfnlh60Er/f5JvKIat8YO6Lvm29VOsLa
	 VAUClb5IJH8KkkSfjMvzT3fYF59YI1r5hq6P72Rn+RTtwjMUMlcVyklk76pzPP29ufNGZ
	 Lck1JC2R+F375cG8kK/fENhAO70llIkTmSwZS5zZ+R9PVTR1qY7ANmIA7wOj5NzgTOzx2
	 7taOpxxf56CYL2vP0Vbx2T8OLXdeQuujkjPGwEZe0k9grhJizanwtg5cquY7P/Mlc9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lp89Z2vbQqpmCvnOyVvMZ8E+x8ZLxSlWg8zPGPjYRG0=;
	b=wSbbJLiQmUEbTkL458wOkqOVHhKKHyzwPC4W0V4Ogho8bJNcidEnY+gQUDVhk/qIV89g
	 mcODafkfR5w9cwhK9hNVoufZBti0UQavCCfb3ZTfNZs/I7wG7iJjYbVry8S29JZt6Kff7
	 n7yqB8ma3+UQ6clpD0NvKM900P73sfZiIJvozpLc3UsWtvezZcOgAZurx+KU2ZYdEtISP
	 cTNkeCeBwjY87QxH2S1e34YFdG88iwcwTXOm84RpjXthG/8r5EJGKMhMHvW1Pn6zLGprO
	 Dds577UkIXDe5W7xQhDL4/4B1CPJHUunA9OrLCDXPKste6Gp+Vs4gCqwmpI+QGy26rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JVutTiHb;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B60606A6A8
	for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 09:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0B60606A6A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JVutTiHb
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c50d3ac6b51so1384973166b.1
        for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 01:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685491; x=1796290291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lp89Z2vbQqpmCvnOyVvMZ8E+x8ZLxSlWg8zPGPjYRG0=;
        b=JVutTiHbNuoLxsHio8HUw628/7LEpJ4ZPHcYYSWeKqStTw4lEfAgVQGSjp7LlNR+Nc
         dptCZRvR+2EVvHMOu+lmhI/lwbNYGzSFnLGw5k5wGWaGTI/yCmYMF6o59WsJvcJGd3A/
         wlKSn2kLi0wc3z8gxqepfea4cAXtZcMd2nRr6LRS5Hj/CyGw2F+Gg/uvzswfgEDB2ra4
         kb00HkgsdB9bBXwm0rfERJY5tYcPGqnl3OkRLGzULTbp529oWnb9wBJhfCCmf6dYIcNv
         ruywwk31pkUkM8AdQUEu2VfeveFghc8Lio/VDriKQXnqvh5HNIoClXatLauuYAUMDNXt
         Zcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685491; x=1796290291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lp89Z2vbQqpmCvnOyVvMZ8E+x8ZLxSlWg8zPGPjYRG0=;
        b=ly/8BJ1yOQAxqWdYLXeyFsHjQy/ua83NFcHOCXBk16RqQ6DLMVmtT9eKvN9thvpSFo
         pnQOxid1B56y+Xkg95oS28nqZUI00hORE7hmtGgbhgRGkIaMNoO3kgx+OPPeAp9SoXeP
         KvGogVuwGrWooeCC1b9QbD5A1I4NnCJ1zkauKZrmv5TlCmMoE9kHXuws40j+7Bg45YpV
         tF8wDRug2igmLsZahWqk78ybg+TdAoLwBECJl079vRE5kHmcolO+asGCYUmDvo/9FmHV
         zME641bMPnRbYoGRTqKRLdeMw4WRUPWN4uP3T1w8LmBpuc8/kvg/5Y9WS8vRDFXa1PEH
         8sJg==
X-Forwarded-Encrypted: i=1; AL+hErGBl6mbxip+XlJShlmloc48lR7B+lCiRnBGIetCFwGmlcsnjB5vMkGaeiW32C6fAQvExTWvLCVUKTqj@vger.kernel.org
X-Gm-Message-State: APuU4Z/3/hKm+CxzVqz/4joLdr731nD7ZpnNVHZ7eLjeS4eXZnIKum7K
	2n9J0S46f8J4teOr5hRNGQzxXI8eZR7EwH0S+Np+JrpBPU59RGb5Ghrzp70eOBSm
X-Gm-Gg: AZFdTZdtgSdEhk13dXbq0Vz/3WhuTMsclRl3blM23qIgCXQyu26KofFS8ryf2jMDB5I
	1qGlrhPPPpxklc7Bckv+Sfr0gFjAe6hGKLTWz++B01nBXoHD6oPO/yNIjXSQq8IDeAhSLV+sYYn
	M1ttDWAZkurBOShd/8xrGtBnI0/DgMmQc6ItTcY8qql2M5MWp5gFUWBIAebvbKcsx4Iq9x/RU3h
	SFbC/FtcFjr4uRXPnrRQs/595RsJvvhkkYV2bhgVviC4rcnu/eEEDTkrURe4Yx90Fv7H2Vic7Nj
	KQLM56szBqf+UZOTNOmlQECXjixDTTphNfvO64YI5RSjtTZjmBiijmIpjVFeOQvPVHFepN/7w1k
	MJiBmuhXnk6Ia6N6qD9BJe14g5X761Z0N2SBaUs0VRhQQQE/0WKQt2lFnhEVu6T88W90oUrlGWe
	lWpNt2jY/IGvBT0VWkVFnakmKesMyJWRGcw4GoMmL3pzCP9BXLGymQbD/BS2GYRpscAOEd+owtx
	ahgbfwP2BLAgO29x0RRbBGyfHbgVz2keRLd0ZoLS7q0hyigUTF1JxUgy25lZ91CU4BZgYpZ1hYX
	2fSd05Z8VY+GHi4AzIcF0rikDT5Ctap3SIT6SBLA1vw8pLx1DpZM51DPK1vneAZSnPM14R/6aUt
	9TfabR/a6jlnOfEAJ
X-Received: by 2002:a17:907:e106:b0:c51:3382:8ff0 with SMTP id a640c23a62f3a-c5133829107mr1257620766b.12.1795685491348;
        Thu, 26 Nov 2026 01:31:31 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdee82sm597090066b.66.2026.11.26.01.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:31:31 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH 12/18] sparc32: recognize the legacy LEON firmware machine ID
Date: Thu, 26 Nov 2026 10:30:17 +0100
Message-ID: <20261126093106.1345825-13-linmag7@gmail.com>
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

Factory GR-LEON4-ITX firmware reports IDPROM type 0x31. Recognize that
legacy LEON identifier in the machine-name table. This only corrects
the diagnostic; CPU identification and IDPROM contents are unchanged.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/machines.h | 1 +
 arch/sparc/kernel/idprom.c        | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/sparc/include/asm/machines.h b/arch/sparc/include/asm/machines.h
index 9f78f70c6f11..ee79cc8e929c 100644
--- a/arch/sparc/include/asm/machines.h
+++ b/arch/sparc/include/asm/machines.h
@@ -32,6 +32,7 @@ struct Sun_Machine_Models {
 #define SM_TYP_MASK   0x0f
 
 /* Leon machines */
+#define M_LEON2_SOC   0x01    /* Legacy LEON firmware ID */
 #define M_LEON3_SOC   0x02    /* Leon3 SoC */
 
 /* Sun4m machines, these predate the OpenBoot.  These values only mean
diff --git a/arch/sparc/kernel/idprom.c b/arch/sparc/kernel/idprom.c
index d6c46d512220..8aba9b4d4498 100644
--- a/arch/sparc/kernel/idprom.c
+++ b/arch/sparc/kernel/idprom.c
@@ -29,6 +29,8 @@ static struct idprom idprom_buffer;
  */
 static struct Sun_Machine_Models Sun_Machines[] = {
 /* First, Leon */
+{ .name = "LEON system (legacy firmware ID)",
+	.id_machtype = (M_LEON | M_LEON2_SOC) },
 { .name = "Leon3 System-on-a-Chip",  .id_machtype = (M_LEON | M_LEON3_SOC) },
 /* Finally, early Sun4m's */
 { .name = "Sun4m SparcSystem600",    .id_machtype = (SM_SUN4M | SM_4M_SS60) },
-- 
2.43.0

