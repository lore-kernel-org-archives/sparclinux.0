Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD073DAABD
	for <sparclinux@vger.kernel.org>; Wed,  7 Oct 2026 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394908; cv=none; b=da0070UFhmNPCbVapEzZFZcNnv9Syt/x8sk4VbeKtlklR7FZXzSr0VnXFDmSDrcjCRZ+aKIA/1OYy2a9MTrX1ACZCO1iEobzNFOX2f8KsMAE6IZG5ro7klUq2j1pJDyvi5sNwX33hYKQ/TW6VN1D97qIJaZ7BW+TyQ72FaFNRwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394908; c=relaxed/simple;
	bh=+7B04P3KtWGS5Yj2YGU8kpSoOlbeBAUVoQM7IwEIbXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGEn6iySw2H7URYWqRYM7hr2fM0SL5lFPFnM+vFnB5RZfh59vbxb0KNaFTB7Bzn4idebAk1fBbPnXF1Oc+vnui/1eCX7KcC20zcooP85KFFCnQbvsf8FixNsAGEs3LfJOfEuA0yQHiDDSqImkB/zu+jn7KL7opLJK4WFDXL7gRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ac3mjvbO; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ac3mjvbO"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6afe8d3980aso2426170a12.1
        for <sparclinux@vger.kernel.org>; Wed, 07 Oct 2026 10:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791394904; x=1791999704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hF4GBMeX+jM3tIEPITZKNJjLTuPGbNXnyD85O+h6i7I=;
        b=Ac3mjvbOQ8P2c0IDCgBSqj2OymmfQTrrt5CAicBYosSQJIAnWTL97Pn07R9d0jjYCL
         Jc39wPaTvxtkDhm4FTWPVv9l+5sDekpkE6fEO4tHPUbbEFUAYOFjfVSzC38IbVL8of31
         bZxfQT2+YIzdFOR+5rpVoh5yofjDzhA0nkj7AcXj2hQSrfzx0u+bCmMIVMfQ1Zmseqqe
         rzHKLueSTU1Kh4fxe71YSdvrPPu6kQJca6sT+oBK9h+UIQWb4gU77Ta2GN7B87d8qlyp
         AymQooDXA1VswtLNO/mPU82qpVqQ4pBSZxiAOBBroAb3qyHqCJhYoQXXZrlMVP5SF17b
         C7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791394904; x=1791999704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hF4GBMeX+jM3tIEPITZKNJjLTuPGbNXnyD85O+h6i7I=;
        b=mp8MTgAn9rs9g/LTQOxwJtJCyRGInM4bDyRBmDEtw0iZQb7eaUEmEXibXOeE6HXMiv
         ozd0yQH3CVnDgnkRiUZ7F8uqzn0Uo0spaOUntRUmnjYP8XKuJAA4G7dxprAKd2w+FUQz
         MPbP44UQpMPDFQXVwoPglb4dXXvrkqu4OKvgXCXG525lDBgCUtBO7ZbOYY4i6zPeajVW
         joF57QEkiv9ee8UAPjH/ZpfwxrPENg5Fnpi42xAdt10FX/D4wWho4k6TvFP/Y40Pbady
         lsefKjZSV3RbRkLl0AF9xYF+VdmcL0KB1zX3JAk/Mivi07gjds2kzYfsebvjfqfUdvWF
         xi3g==
X-Forwarded-Encrypted: i=1; AKwUvBydnPZ2x0kAr6gL3O7s2KVr87MIdTPqckG0b6kUfh9m1Oz9qFRVaTx06UuNeay43dxFUZa4NgXAnKRA@vger.kernel.org
X-Gm-Message-State: AFq9FYIgpDPHPGaQx1bF9e/7zj62GAl1+uRtnumckUPNmZmoNXkdAO2x
	L31xh4gzEeBqITbYfo6D1KcS7oQtSe/8amybApMQOSMvyYSQLAJ+GkSL
X-Gm-Gg: AYBFou2Zl1gTqrUhGwOBDqQp/8md0kvhXCiWS+1n61nb0k5ya2fAmlFPj49PMxlhx+n
	rlFyFQde7Kdcy0rJgvmO0O4LZDUAEWtbaXUrWTJu1ysDzLNSNUU7J2AyJa28yVvhQeN675T9ped
	w3qWahaM4AUzGHljc7V3p3P3pyPSASzNP81IiTy+8iTmNIXKdDNpdNMAMeAMJZNpyrB8a58Vscy
	6kIqMPPbkCFtCWwC1eHmk0zwF3jShDRrSRndQul7VCwkt7nmHRZ/CiBxSHb6vj5Tv3M1qQ1Xb1C
	FjU0vXGTIZlZxznrq3NoqJoWo17zrTmXVaXgzPWtmBJeFXf81Ev64nzA3TtApq9tqNBeIplffuw
	m/gjAnz3vWmgfssLqTPGfS2Ihg0RW6vT/sNH/uoKOkvwf+T04GAaxRkqBvxoGDIqDHFro1XBwZi
	w5QkglaXclUSu3tF3dAV3qnQKtv10XsAmFuxECHcAlKGyMhFHBmksUlwOA8OAaKp9tSE/uEE5oH
	nB8E/1WAkuR0I++HHtDFDQsekvND/lbxiKUXqgC
X-Received: by 2002:a05:6402:3204:b0:6aa:f630:f846 with SMTP id 4fb4d7f45d1cf-6aff453200fmr3164810a12.31.1791394904161;
        Wed, 07 Oct 2026 10:41:44 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b009e80cd8sm356802a12.8.2026.10.07.10.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:41:43 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH v5 2/6] sparc32: use memblock to find available system memory
Date: Wed,  7 Oct 2026 19:41:11 +0200
Message-ID: <20261007174128.959307-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007174128.959307-1-linmag7@gmail.com>
References: <20261007174128.959307-1-linmag7@gmail.com>
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
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/mm/srmmu.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 110e2f248c60..7b57a10c961f 100644
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

