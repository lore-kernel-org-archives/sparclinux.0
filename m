Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80D73D649C
	for <sparclinux@vger.kernel.org>; Mon, 28 Sep 2026 20:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790626130; cv=none; b=FbJrj4So8FHiGa8a2QqEnS8b4RGiSpbqcPVf7UYA6L7wq3Rc5FO7F8UfBgK2WVqS5z1e4+9KLWcWyEFVOD5juj3643gY4CTxy93jaosUxcuzcfHLL+yoCRdCfHCWZolaSL8RQKANCDLeGoX2CDRRKH9pgCSKH571WN1xPjc+HEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790626130; c=relaxed/simple;
	bh=AzdGodhxKE7DykxVHyS0xooKhsrpCAjLMp0Dm5wVvZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJkk/amIv34mgD5PQ3IxbMdepR/dQt8WuYM5nGbkbafL4pMgflTJii5QXlULI9eDmZ+fJI39QOpSzbrLbTKVQUy/KwnLb6NYNQ1oI/9YMGz2GIvpxivJovQtTZzhXLV3nl6F6jzTJm/kRaDpOFo20fm1uoLELNEtLRw3gwAoi6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqoUdbVo; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqoUdbVo"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2af3a4f193so373251466b.3
        for <sparclinux@vger.kernel.org>; Mon, 28 Sep 2026 13:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790626127; x=1791230927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CE3tEgZ4a44KtqLZ+CTK+zzBvwh13usPnMe5fmHTEY0=;
        b=RqoUdbVo0WMwpRDmK1sdxvJydGhZJijtpBo/xOFGBn2FJj8VoPxhcVYHZ0H5e0QRJS
         z5Vv4V9czbSK52bApuVIfJhd3w5JGkE97qH9TKgptHRJQHJ09Gja+XKRCCgRcNDAfsnJ
         lfY7jEBY1yZtopfhlcb+aexUzPjFHn4GJ6t/TsHI5KnYvGdaZd2U/6dBc65Jd/B52ReF
         qcAOMOPsQLM9y76c4aVuYnTz4DA/DbOUPXjshVXGkHAVayLrRxyKYJwWU01I0K8/+KfX
         2iybwoOtYE3i+jRKmqji6uUDQclchT6kN02DCGkctTAwnwe4G2Kuacsi2nzyK+lcTdfj
         Jm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790626127; x=1791230927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CE3tEgZ4a44KtqLZ+CTK+zzBvwh13usPnMe5fmHTEY0=;
        b=0uAeDwLaKrDPCNTxbCQOoqpTBVNzjffsuRl44eM5ssPNXOIcStJVZH0RIecBO88xXt
         VI00grgc4kZzuZL/ugGtd+TYyGFRnycMGkf5Re1w8PaRBY6JI6hp8CTvWa8HtKyb2L2m
         0Qo0ZxHoK+dEapRx5Jdi57lBtT5elDUXI0oTul8vyzW09pvDXBPpw/72N2FxhkfJlxQb
         kMsP12a/WoqSOnACcgA8oQ3EZyFCid/0xsxAIbewXVDbP/9inj1SdKSwrBkfvqu4qdP1
         HMOoaW10+d0zOhVHfADPt5XOkfHa4nMJ7VKh/c91iJvc2xRJWfNCKx2sXqo0BZ3uUcla
         418Q==
X-Forwarded-Encrypted: i=1; AKwUvBwZKanuyvO64oDrRDPUKDfCOv3+yRZhogHfU5I/FXqbX5ij9zU4PjZhzYgDk2HdAf/Uf4ICkMk836Mw@vger.kernel.org
X-Gm-Message-State: AFuF++nsLlCu9srhNZLvX2IzPNzoXKDC5eCiCF8hW4XL7Npo/n0lczY8
	AM8QcWcjlZCoknZomcDbXXl24aJPUnkomls+WKpe2rdc58FqsZSNivLy
X-Gm-Gg: AYBFou0bqSq9TZiZcENtBEWPsRExlZ6gpHojOtsla1ft7Zw3XYztKrJa71VFeSTCzvl
	BxQQ/bwWsaBS5XU5GRsBalN4Du+zO8Hw85phmrhvXCfBUbUdTUptxG4sdcFeGesCQjg0m/YHYFm
	nNsdE5yZRD3xwHSzWu4zrc1oxlg0ER9BQNXDIVgFOZRMmiWCHCB23NjBdB0V3FGPkfFI+LVyB3A
	awg6q0Pbvg05XYfCmfI0BybkkcacRLT2Pq4R+qerZ89w+2tWdV+vyk2Fz4xKqaksTmqb+Tpy79A
	oMskh55wWR7DkMyd0sR4vnkOiAdAHc7DGYtgkQbtdAY8C365dslv1FjLDwHxt+0jTpLYJvVLy3b
	2tdlc7l3QbVvj7enTFX3Oc3zoYAvndx9MeoTNEsNLzZXyPZkiyuWL7eLiuSYx779ZgCihza+1Q2
	NhyMvUDQ/ZRJLtm5yOlf30Ebo0TZtSa4NithzeuXxaGgJX7nZ/BCHc6jdjfRTbcyEG/YDMCoRDn
	tuaQsTbe+IRlcBH7likRRcxNyjYD+LqFloAOgavk9rqwDDHMqwN
X-Received: by 2002:a17:907:1888:b0:c29:286e:2e3e with SMTP id a640c23a62f3a-c2ac25ef36fmr1148656566b.38.1790626126915;
        Mon, 28 Sep 2026 13:08:46 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae76abc3asm509778166b.37.2026.09.28.13.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:08:46 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: linmag7@gmail.com,
	sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] sparc32: advertise relocatable kernel with HdrS 0x0300
Date: Mon, 28 Sep 2026 22:06:24 +0200
Message-ID: <2ed67cfac2dd3847de19eeba566254593a661e93.1790548064.git.linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790548064.git.linmag7@gmail.com>
References: <cover.1790548064.git.linmag7@gmail.com>
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

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Message-ID: <20260928002035.1-4-linmag7@gmail.com>
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

