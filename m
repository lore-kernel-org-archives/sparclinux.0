Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16292EB874
	for <sparclinux@vger.kernel.org>; Sun, 30 Aug 2026 12:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788091683; cv=none; b=C22vd8QKADv5/kM1m+p22rneH4sRIHtxpHFEgaEUKIHIP0aIZ1H/EWyhgpUNjJlu856eSbAMFKOboQ0hzmoy7xnTaPnuPFKEMvTz+z8Ez7h/zqrrjCZuJ+xCAnqKmkaCFurNu7Vg78J4FLksIOYx19Bc7Wwc74idcMYUiYJ/vmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788091683; c=relaxed/simple;
	bh=kBYbgY9C1IVSMpDCAy1CI3kRgaJc78wxHYafgcraeKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJwxoDkWDae0Uw/TVqcWrhfs1xHOwZpKAVYkLmzbS0yHz5Hi7sEf3mBTktyetKZHpfYPfb6AXvuzpMtqHCazGs4DXSeNtENaQEfBPiJlJmtsl+uKpRU5GOv0LMopj5ZKinhdiM/MiyhUFYHuJDxTUjgBYFS4oZVJ2LaB3BOExlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZMKFqJt; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZMKFqJt"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2074710751so337020466b.1
        for <sparclinux@vger.kernel.org>; Sun, 30 Aug 2026 05:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788091680; x=1788696480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7o67oyyTyEc09pnUJGRRIXfdxc355uJN1B7XMFhIUSM=;
        b=EZMKFqJtQmOB8gT4GU5ZCwQFZUrkm/BDpyWV3b3WTfleh2sj+Yile9pGGXq2LF8ebo
         F1zlMGUfiP+08hv1dmaGR28BQHFbkPAogwtlNrN1KykSFx6n/zO6rTTfTDbRunTh4cWK
         Hij2eweYEnB0PVLVppoy9cbhukOYGOQNyIr3UBxWn2vBCZz3cCAOEl/0W/SO+/R9V2JS
         6cjiGE6oDq8J1dSWy9h8IGSfRhfoP3bGCiMP/B2ZbCtIZUlIJpOCvC5C329mkiSzN4dj
         RUti3J0btPhsTO10EK7Oi+yr8XJ9QBUDf0mFxGpn91fPmsXyUz/pQcWCEWQBdrH2If14
         pYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788091680; x=1788696480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7o67oyyTyEc09pnUJGRRIXfdxc355uJN1B7XMFhIUSM=;
        b=NE/uhMWe8v11jM7rYm+I8/FLvUXDzUdEZojwylmH/TWGgB6vsmY4MwIqzsgX/PE183
         /D+/kxYuifaWtHwFnfEN+i6NdV3Xu9odppuRw+ai2ofIL914PXhiAJaOTKTYKGotGbWB
         7jwsSpdqqg2L5VySPphbhLJ9YALnBsgBgVSKPltbZkKAZePqhbMMU3SP8n5MjAi0C1Ia
         seke50/u9PUvl2dgmYE+vlkaEN44lkMxMGHO38pbbgJ998a4UiCsna1SikMKBjr77BX8
         GeBRmfftlRcxitSSZFfBAQKv4lkjnNGc//qexw+5GATNGmodYpEI7Ah1K42uYddJqFPL
         pJMg==
X-Gm-Message-State: AFuF++mtnSr4TN2DFR7eanKQtkFawBM7kFB9AKqiqo1bsL8sxLPW5yI7
	zZkCZQJvIMHuQzJYUXB8UvmEkrRaXLZRPx+pV9H8ZHNv9slktvpWWuKdZAwDzVaU
X-Gm-Gg: AR+sD10FiFtH7OUrnxOf4bAqTwZYAsp5ahoilqowAw9cONyuDtyPVrpCTA/+NbXznma
	iMqnLkAsil14SWykXoEa8jknt1A5zo4bWMqoOH5IrI2l1vVyCE/Qfk/bGA4sMDLypw2kW8e4wv3
	Rp18ul7q13GXQve6I406ozxaVfc3LwWmobyK1nmAheOj2sjQEoLnpzeecQttAYls2joL/iS9fOv
	qbdij7zJVMydPfmH4DKmyEmzYBW8JbqCwIe1CPBeJuMSvp5hg1Tpbgf6FAIVdkYuimp/9azH9EH
	TnQ/5EfPCkkMv8Wi0+DBAMtav4KH95wckKP9FblMmfjuNlQApfoQ3Z+I7rahRUzWcOUVyjhHVv3
	BuAG6bGuS2bmybbb2IM1QFaVU3zQSnyRzqxjNBmZnyKuAYt0c/nbFQNA9RA7EFPfYHHlyZuVuRP
	8x6CJqbr65Q1CySbTgt3SXiww6w0wtLroUSKJqXDXIah4bsnqdYK07gbsfkvO3IBJ2SjvhT4cyq
	6uiG1Q+dL71axeL/IV1Pwmm3KnQnqSxFZyCqWCnmQ==
X-Received: by 2002:a17:907:c01c:b0:c21:382e:9a38 with SMTP id a640c23a62f3a-c2556c18e20mr1323915266b.2.1788091679662;
        Sun, 30 Aug 2026 05:07:59 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee09eb6sm304287966b.10.2026.08.30.05.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 05:07:59 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org
Cc: davem@davemloft.net,
	andreas@gaisler.com,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	glaubitz@physik.fu-berlin.de,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH v2 2/6] sparc32: use memblock to find available system memory
Date: Sun, 30 Aug 2026 14:06:41 +0200
Message-ID: <20260830120742.20950-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830120742.20950-1-linmag7@gmail.com>
References: <20260830120742.20950-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SRMMU nocache pool is sized after memblock has been populated. Use
memblock_phys_mem_size() instead of summing the private sp_banks array.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/mm/srmmu.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 483235458d69..3029527a5a9f 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -226,25 +226,13 @@ void srmmu_free_nocache(void *addr, int size)
 static void srmmu_early_allocate_ptable_skeleton(unsigned long start,
 						 unsigned long end);
 
-/* Return how much physical memory we have.  */
-static unsigned long __init probe_memory(void)
-{
-	unsigned long total = 0;
-	int i;
-
-	for (i = 0; sp_banks[i].num_bytes; i++)
-		total += sp_banks[i].num_bytes;
-
-	return total;
-}
-
 /*
  * Reserve nocache dynamically proportionally to the amount of
  * system RAM. -- Tomas Szepe <szepe@pinerecords.com>, June 2002
  */
 static void __init srmmu_nocache_calcsize(void)
 {
-	unsigned long sysmemavail = probe_memory() / 1024;
+	unsigned long sysmemavail = memblock_phys_mem_size() / 1024;
 	int srmmu_nocache_npages;
 
 	srmmu_nocache_npages =
-- 
2.43.0

