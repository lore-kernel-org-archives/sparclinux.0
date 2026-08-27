Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387B64A2E1F
	for <sparclinux@vger.kernel.org>; Thu, 27 Aug 2026 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855303; cv=none; b=dtcpFf6C6k4Fpe70xgBq+04ASgXQdY0Z1u3rv9xptEQBEzNHR/aE6MlASVfK7xVLWCnyLpNfp2tvMl3FnzSCFOH5Yr+d5tYKcUZGPv8yCSXzpRns3Ojf69DCiMdteTrVrIx8H+HzA6NKhIvfz71ocQ22AWg+nmSfgUgEn9LWgMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855303; c=relaxed/simple;
	bh=yXdX+zpbNBeKwxVhS2Y2GevIJ4y3vDujudQupvSz5CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tEs2bOY5Eu3VOjKwmUOsi6KumfPhRQEy6rDQrlducIYtKHFvxKomf8kZExlmqrse3IPbUgq71P2twoN8uqckPSMDVFK4wEyiF6ZdEqyaChRgAAKH/FwVFCTToAdJQdExEcLp8EGAz66UMllEzLFunJryaqe7D7CXjA9hhoyAu00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S45aFZdB; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S45aFZdB"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2533d83e3bso25291566b.2
        for <sparclinux@vger.kernel.org>; Thu, 27 Aug 2026 11:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787855300; x=1788460100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fGmwVcHszkXz2n4AUCcGnwYhm3WHQgOcXwRyS4LumNw=;
        b=S45aFZdBKOGJ0c1gLIVhA5I8YvpsJ1eeCokgu/3JSkPe0C6t4afnaX0kY0CQxBNLbL
         Qpc7n2353qjYyK/VhaZ8Geq/PaKf2QddkzR/8p8+SF63DUSfwLKDpe6xG+GeWtH6+73f
         8U41n3RQR5kXRDGpGyhlBNJ/gLd0QmYjjunO3WRHQTnuX+4gYoR7cVRQLnG00BlZ/QTg
         NLv9h7HG7OnTOWcawiHHgWOlQCJMBcRlq5Jnr4oWRgoMEMEefl3IpTPWIwKyfm7zghum
         O4H70RgDV5T7E+PVDYptpm/5OTh18cjSOPsaM3Yjnd7g1+I93CLK8Upk8xoMZ6uf9504
         lUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787855300; x=1788460100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fGmwVcHszkXz2n4AUCcGnwYhm3WHQgOcXwRyS4LumNw=;
        b=NcdmYW8spflgOzN7dTTnPHUmPxEYH0IFpe9WBQsknt6TCG8LwBX0fmnDw0u8r1gyHW
         m3wkpHIzntyfv9B/ipqpwznrd8Rjikn3R4Jk4Ae0sAanHv35VfB1GYSMLgi6d763mXDx
         vq8oAxomJ/Grz+QVs2p21nZwCQGXEgMzemvgCbFD04tue09x2v/TWODEE4CbCPjmqNSV
         RHr8DVc0eEqGzCND7lGuJqDi213HmbWcGhM0VbGcVyngdg8FONQzD8n+G1u+8puUFvHU
         kiJsXJ3RnTSFBy/25Xa7YffpOGk77u/sZJJreEoRofddSUPk1ewbNlqxpFS23b9i14XL
         5dug==
X-Gm-Message-State: AFuF++n/1YOK2SSZwPYmFB50opiU7cQ2qfUGfvvD6i/wntGy1yL09mD2
	tAX2wWGJdt72ht6WF567K9dC5Uj1WrLMAMQHyUi1QMSAmAC1m9dNmxmq2jHfSsqD
X-Gm-Gg: AR+sD13QzPCogZO4w8rRotMgzZEbWTZx3L3fQ5RVWOkn9OHiTrOPNYdnjmjwHYkd3uv
	BoBzow+2fXvJDpbDFzRkswzw0Sa63mBx6p7u0VuyGxIVE74GBAlzqSf8jzF28aE9AYkKbsuwqsK
	M2LOyNfJvz5P8w4DCbGCyNtAXD7xw1kLX7FUSfsyFqcOBYdhBaeLs+GITmfGh9NcuQSa7p/U+iD
	hfBWwE8Ot9d0u5jt7WaCstgRM7W6NLIjtdAyvDGn9ZW8Q2fp9KVyCpotfgL7mlolyU5o9fVd9J1
	/sYghUJD3mjhZWT4o7pMVqDcH+OlU80eFO6S8VMUevLiA1mBQXC/R1rxeNgWLkjbgXITOIBBhFt
	IpOHTcPCGRwpBybR7y3ICONtvdGj9JpBZTPOyE4V4MXdBJusJf8hh/IHMikD/s2M915B/3yjdof
	hiYPfF9+VU7m+rIhdN4VILHQnzpdlL3E+MO1ioWAhTYVin0qXYUl5K8NxCsfAaZlztkP+Y6VE/i
	nQuQij8SeLfF9FzuX3JbNurmozF7ZM=
X-Received: by 2002:a17:906:794d:b0:c20:2165:d74f with SMTP id a640c23a62f3a-c25571ef674mr45322366b.22.1787855300422;
        Thu, 27 Aug 2026 11:28:20 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c254e4e736dsm61288266b.11.2026.08.27.11.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:28:20 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org
Cc: davem@davemloft.net,
	andreas@gaisler.com,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH 2/5] sparc32: use memblock to find available system memory
Date: Thu, 27 Aug 2026 20:24:14 +0200
Message-ID: <20260827182757.6856-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827182757.6856-1-linmag7@gmail.com>
References: <20260827182757.6856-1-linmag7@gmail.com>
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

