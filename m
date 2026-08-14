Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A4C3DA7C3
	for <sparclinux@vger.kernel.org>; Fri, 14 Aug 2026 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786705491; cv=none; b=e3z+N3Y5Wie4lcEtPekhhF9rbxw2GlXXevmEsE3xjvdsOBWpGXUcNwFY2uNCcJNILtyrCT9qbtvHT74xtAz86rCa3woUph3/vQrgXZcZla8+TXMcAW0mmRGz++mVBER/eoYc/kLI2OcHT4PBGo1FA+oN04R9XkfmhSAA2iNaqx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786705491; c=relaxed/simple;
	bh=ZcvHgI3U1UUIH3Y/QsAcb3zSzGUk/Kqj3EmUTTtZ0WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/jv4Bw+9YCg9llC36hUvz9pvEAdUCXrsVPC9mTHmEOt1kPkQMmQAFwcbA8X2dkv/Vh0fTzTpCvsqRGRMUpkc5Bo0g72V4eDAVGNLq8TGxbPPNFNI+r8KjBBO6WEcLv75HCXlbs0BFvxL9Mju3K/arorDSB85iHp/5lMupK+nD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qesa6303; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qesa6303"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1c52d920b8so120708866b.2
        for <sparclinux@vger.kernel.org>; Fri, 14 Aug 2026 04:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786705482; x=1787310282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=48xmVgdSxn1ziJVhznRmfvGtQ8ErzBcg/MTqWjfxPSc=;
        b=qesa6303n6Vk0DtRBjSG1MbH6FGmpFpWAATulNaY0nhZFTl06CQwRlgOi4pZ0P49f0
         euBqSfpO8l5kkRg0lCZnUA323nI7XveJLMQkXgCCvSw2Q0d1iJACVOlcgZoIKOK/+b82
         ourMgCqDbfa3iz/KC+n2HhcUoMlvLVwSFY22MocKf9vkBOR673l7EQg7W32ZVZ3na9cw
         3YE7/HYcI9OkwCWmg2aaVmUA2r533tIE5y+aQLQ14/I5BC61Fe0fYWaKPh0XWbE9SX/8
         f8o0EWjkbrS6N0VwrzGsaJ4io4KM7ZjpE8pIpmq8zBjScVlRUOe8L1lpuYV5yi9fMX2S
         BEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786705482; x=1787310282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=48xmVgdSxn1ziJVhznRmfvGtQ8ErzBcg/MTqWjfxPSc=;
        b=rydzorJDVEDXt7IV6kSHGE3lZutyBi3wa90VgyAMlLAHYgmuEikHPnbQLJX/U2/Qv1
         a+I2cAUYQvoFR6CbJRnUYg8Oe9v0iDoSaOxpAEeVjdkasbObWJ9myr0BpxeVtdttbZzs
         C6EvARW7YfAtooRSv9j4ir9DOa5AShx3zmOwVoBWgeTe0AwerdB0260Ijvya+O3kSlmA
         DZGEGbinu1ruMoM27UBXU072zENAjTA6JuC8gYQ2tRlUNDta40rCdBaQXeRRxJlaDmie
         qXPODT5K4l0dwP6kAgnx8Ttl/FpGjIq5h5slSZGGSYmFrgMTu5CD2yu2euKK++HcQyY+
         7yew==
X-Gm-Message-State: AOJu0YxjKKfRK/19EJiNXXNsUW9kkwTC+J0M0/iT9G5fZXp1kd5Xn7Jg
	pn605JhaG54W5IEU5LwE6s8gHYw6p2eBcrA7eeg0kmnCT9FZlcnnTb1P
X-Gm-Gg: AR+sD13b7aS5TiISldVk0/8sOvbwFpaAN773oTWEEbMK/qqgJAZwMsgYcnc7OKDameN
	T24uOo27eaGLewMUMfpQrW+37KG+2K+RO60MObu1IVZgPLVKTsN9iPj3jWo/CT1lXsvpAmMY5y3
	u1DByCkWhTDnlwtayu+05ybc0I7YKp4PW5bIcyj9lvtw1guxBoMQIscGYx7sJTnu3ArCTLvHQra
	ClYwOAB3wjrYN86BIJ65PV3REsWDMAKbcpo6hx+yzsHOZkFCXJkW2sxvYXJPmVhQaWhpdYo68yI
	VlvpE3b6iCd7361Dj7yEG54Lg1GuJ6LI0NEw1GJjTBw01ZJQTgti64uScp5/JoZl9q8H/rPhZsE
	Erfd4m52eUqNfTrxG4ZWawjbwUHBzgE8fL/fJhG24OAvIp3o4g3o+N53+nLobTwXd88hRVvrP7t
	ZDfSFmGSWB4Jv+FG5t6qdSMZeUWzhBhW6/BXMd0/3Jy/nsBiMpe9rl3rF4/9iI6aIhCqzB2nTwu
	Hjl+zY4gZQu0ytb76WijMwf5VA4vFI=
X-Received: by 2002:a05:6938:a094:10b0:c16:67d8:7a0f with SMTP id a640c23a62f3a-c212a3425e0mr145770866b.28.1786705482320;
        Fri, 14 Aug 2026 04:04:42 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c21233a12e6sm92028366b.12.2026.08.14.04.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 04:04:41 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH 3/3] sparc32: advertise relocatable kernel with HdrS 0x0300
Date: Fri, 14 Aug 2026 12:52:34 +0200
Message-ID: <20260814105723.3454511-4-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814105723.3454511-1-linmag7@gmail.com>
References: <20260814105723.3454511-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HdrS version 0x0300 tells the boot loader that the kernel supports being
located somewhere other than physical 0x4000, which is where SILO places
the image on the traditional path. Anything older is copied back down
there, and refused outright when it no longer fits.

sparc32 could not make that claim before, because setup_arch() took
phys_base from the lowest memory bank rather than from what PAGE_OFFSET
maps to. It can now, so say so.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/head_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 8c320fa25a67..11a1746829a4 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -69,7 +69,7 @@ sun4e_notsup:
  */
 	.ascii	"HdrS"
 	.word	LINUX_VERSION_CODE
-	.half	0x0203		/* HdrS version */
+	.half	0x0300		/* HdrS version */
 root_flags:
 	.half	1
 root_dev:
-- 
2.43.0

