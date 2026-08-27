Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D6743E06B
	for <sparclinux@vger.kernel.org>; Thu, 27 Aug 2026 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787842503; cv=none; b=uU1NAD5w2qeIUGmNGSmIZwuPDCIsgZuR+1AwN9UBadw2QP1ej5BnQS6t9/HrBYlTNK26UsS9pNpBMdrIymENVVWTzY+eMhlstdI6/ZFl3Ry56TfPaItX6q/oo5pCHPrRyNBpXis8MMJtITrcUa7onWPE9EjlkgwlcEWTPTytMMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787842503; c=relaxed/simple;
	bh=PrK+ZTBPp9oMQZepAYrrwk/bXLxCzFuwkXY7dxFh4D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOmgs/hh7p3l8UvDybSEwMup3dqhV6Ok/xrTGCzrMDOnwmlVX2B+RN9jPLv998SdhMyqYpIggWoO1uxZ3LslJiXUspQ4KaXDA2cTj9Fd9H8eeSp2R79g/oCzGJMRIW5+f5PHQlnTH/nawI2cDG+CmWacav9qgBGTDBKyOy0HfqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GY/UmWFr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GY/UmWFr"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d58efc7356so26417575ad.1
        for <sparclinux@vger.kernel.org>; Thu, 27 Aug 2026 07:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787842494; x=1788447294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z0BquGYPn2o69A57j1S92QvXaMtH50+KXNysShZUBXQ=;
        b=GY/UmWFr6bLIAXt98w9MRX63UrdBafAR/7f0ceRG5uMHGwbB3Xeru4DBEvEEixWyMs
         P9EoW7x0lQOkO7PxqoA108Hno1jaIohBHQfyRfOxp7QeSBfXDDQLrO+xMU2trwVxTH7z
         J4sU9jFs90Ce6IAJBgUSXiUpCe0qLMxr8xqjGCaIss2+2UIRnZjpJ3F1vyvS74oK4djd
         Mx098sbJIZULFYf/w17BGT78Mlig7Va7zvrsq1JpaZD3oDvImcbxnsc/rErKP4uLMuPD
         FYM430C1rHQfZj4qAZlf0Xfm3wg9X77ULVgMklcrHqbZjE/Kmqdt4Zp2t8KfMFWIeg/9
         tj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787842494; x=1788447294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z0BquGYPn2o69A57j1S92QvXaMtH50+KXNysShZUBXQ=;
        b=FoPiwl7l6rfn5MhSgd6b+W0043OWUwsqZRiQ/6AbCDyemQhpY5to3aLV0rWh5HrrkE
         9hEw5/PY478hmFCqxRaMVqH2mmdMecoVjhEHa/ffX8iYKYEP1v3nRj5/xgOG7o8702aR
         c48lFJt96fFhJOtoHnB4GWcvk6IgsyyAzLAGPI24t1nmykeFlqm3cLBvM5jfyDD5aTQG
         T0I9jeVuzQx9AEtTiCSyMa49UZYP+UHKKytQWq4T28rav7ERLTxH8lvXpsNbbmFWvIZt
         hMULol+XTtknmbIo2KRfgGd3HEcOe6D/U1oIUDkWPWyFPOUcM9ilJpY9z4dtFcEw4EzY
         LktQ==
X-Forwarded-Encrypted: i=1; AHgh+RodEj8vhD5gNP05+yVPsiLvaUqpV/Z52yE7xa9xLs22tNNyk6lND0hpHd3+71eXePz8inR+ebtkEu5M@vger.kernel.org
X-Gm-Message-State: AFuF++kXN/Vnmw13tsfTBmMncpaKsz5NeOcTL/Z1Oxz+HVEb3SasdNjG
	X43oAUryxy4vLLIOXlUMzmqvgiQK2VYq+ZCN8E1Hh8AtcQiMTreJ6SSqmEnAFg==
X-Gm-Gg: AR+sD11KgDUjS4Gk7raxFpW2PorAP9yvf52WmrDl+d5M2eIsVUkeTRa8cyPltN960On
	rizlkwmouTDlvY7FoaKwV9S4s3GuMNEaEEdIMn3FevzmwAPksQTe9bCp2vBHRBmerghEtyUKmDG
	3digBnre2btlJmN65aXpp7G3NA8V2yfA2rgMU+HG+E585l81RGar/gTnLtLtHc2B/bRmjx9KNKZ
	iooN48bAzXPiX0a/mHW1Rx8BvTB8jKBREMaFsRKTbJ4r9UY8ODazlQ2tOnBUfwOPm4tvEMEVqQt
	pLEN0YHlLsRNvA/PkszyGlV1YdDJk+zKCE1Yl1jH1cDFX5X0X5MMoTR4rYC7+2Dej8YHxVPA6QE
	1iSXc/rn9KKDAXO9dZyltK7OGI+ivrOtxNPSs8MwF7sb1Db3fyWkAmd6LuLeu7tVF5fr8Wloe/V
	D49SSIKIdNOT1FfNGTL2w8vgqL6p0CPVF/IB6bFL9zp8JEsMFu497JWsI=
X-Received: by 2002:a17:903:1ae8:b0:2d6:f3f0:3e7a with SMTP id d9443c01a7336-2d707957143mr289849535ad.3.1787842494167;
        Thu, 27 Aug 2026 07:54:54 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d704b9f555sm18725405ad.40.2026.08.27.07.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 07:54:52 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH 2/2] sparc32: remove redundant memset in srmmu_nocache_init()
Date: Thu, 27 Aug 2026 23:54:34 +0900
Message-ID: <20260827145437.490605-3-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827145437.490605-1-ekffu200098@gmail.com>
References: <20260827145437.490605-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memblock_alloc_or_panic() returns zeroed memory, so the memset after
the allocation is redundant.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 arch/sparc/mm/srmmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 9a74902ad181..f9a92a07a255 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -279,7 +279,6 @@ static void __init srmmu_nocache_init(void)
 
 	srmmu_nocache_pool = memblock_alloc_or_panic(srmmu_nocache_size,
 					    SRMMU_NOCACHE_ALIGN_MAX);
-	memset(srmmu_nocache_pool, 0, srmmu_nocache_size);
 
 	srmmu_nocache_bitmap =
 		memblock_alloc_or_panic(BITS_TO_LONGS(bitmap_bits) * sizeof(long),
-- 
2.43.0

