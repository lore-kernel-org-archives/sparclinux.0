Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565BF39769B
	for <sparclinux@vger.kernel.org>; Tue,  1 Sep 2026 21:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299201; cv=none; b=fGUmeZhzueeyPA8f7L7G//ed6dp24JDdJvtvOtICgx1lpe1C7NBAKFH/47nh3ktk9K9FdBPKI0uhwm4MSB93+NuvXN1Mnx/bGKWwKmNW6o/QfH+ZIkUVcN5DItT8RuKrXz+YEooN3CjTk5jE1h5vilHaoK/HXkKt0+ix1ZO8bU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299201; c=relaxed/simple;
	bh=zE1KksifcHbHAHvPFyNIwbkqyuCe7h4Fiw2QNazvKy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPKtqmy7REm7+ffezq8xBEFAA1O+hVsDxeCjNu3aZwzmqN4fHkYmgQae5sTIxqaSvXOG2PPKcDrR/QiATmSd5n+NHdR23ZR5R/ZUuH9gz14QxClX9LIAhiODF5ZqFSOakkaGUaTUbOXtZJLYvSUWRpAafR+KNLNKxKrZ8QaX5P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2oH4aPu; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2oH4aPu"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2055573c8cso36116366b.3
        for <sparclinux@vger.kernel.org>; Tue, 01 Sep 2026 14:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788299199; x=1788903999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5xhEm2040oiMbVomt7wZPED9xDDq0R7WfA01fbUVQBQ=;
        b=U2oH4aPucRRE0MDxBGJ5Vebc7fF+soCvK03sfyIZSBe2Q1XOJl7TYmFan2xUONxt5n
         vzOJn5asgjUn/24RVnFfDCjy6EUcAJpBvsZTWlLNzhC7/fXGBhZklnWnFbbnrhtzYxDV
         10cKmhIM/ICMxqeZO0hwlX14kzXIitSwn4UI2GIakTZvIWVdncod6Zwaw5Fv1sn5MjCa
         CnB6/yDY6g7G2xVNp6qhO3uRDAGSG8aaFJtr6odnNpOTnbtwOa7SXuvsOeLmvwjkDbZ9
         N57tJn+RmdeB/YqhNJUH9LyeDNyrR5+JtFrlrDu0l6TSUeUiFlZUcfwa4TbyLbdKcGX2
         3Ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788299199; x=1788903999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5xhEm2040oiMbVomt7wZPED9xDDq0R7WfA01fbUVQBQ=;
        b=aDI3sP3+Y0BifZVGCWJEVU6Ra+LJMnE0U1AVizNlqW9rSG7r0up8wptV1gHDS6ntqF
         SZh/Ffk8NswvuumfXYIt9P7+5T1UPPqpcVSOGROLIfZkcxHMZl1TLJqfOhBI/2bSyYlC
         Hf+sOp7q+yyICy1R54rSnLjza3ckRAoMZlSsnZI7rZFKhxtMN1ywQmAnty2zUFMrcwQs
         UqW+HUhiqOnlaBDSt85IhQFNeU2jYdzpV0Q/dL5Dn2x+xbXDo9ft++VmrIBCYDPN3oGk
         +p002dr0lzhDc48gRbh6IX39mTnFprkNxLxEh7aQNCOZeNROa5SOs9EXVfx2hvssn9yE
         lpOg==
X-Gm-Message-State: AFuF++lSRQd8JCJuR7FBzJGJOi9cSq9ApL9LooAF0bpD2g2jm3gF77Yk
	G1Q6y/MpjOlE5xLppBWxQmI33wMJC5wSc2ThtDVXiUoW7fotB06akGiuqEUlTg==
X-Gm-Gg: AR+sD11MvmZWkX7wtMoyDylX5SRDUu3nIakbvUs9gmVTIxZwuvT1PPLxfpX4ynoAfXp
	hg7XJ+MhH+z6jIFUTWMxyL8rmrt7Q22exWXvcs8ziIk/JEFXuuPFhIqtcoc0gRY4jkUG6JKHf02
	idu350NfnstvvW1vuga9bqi+N/MvtY5A9Jo88bj/061PyUT5omkBGxFJSBN1ASrAtXStzQxECh/
	fufmYYaucRr7vSlNn2O9KcQk5Uvvt36GYYjWbXlMt3h35Ph0T3piPf0be5jHDphRi5s9FEtbti9
	pymxvaburSlN5eLK610AhZozLuCXFyrhomfIMkQDViy9yjw29WyMV46zt4BkEIjFFhSIEx32P+U
	wz7qOsv3y4+/JopXonV3Utq1idnFDjWFglux5+LApoM5tji3SRN88Q4AMost555WATto/e+6YWB
	FshMuVwH1PjTKrSWUZfUmE4uG0fcgVdLMvFMBfVHmHACSkRCm185yJAkGDYYh+CUco+jZaxp4ox
	N8yrPO9sDcY5Ci/Ken5gGq7LQFwo2c=
X-Received: by 2002:a17:907:980a:b0:c25:34c7:44d1 with SMTP id a640c23a62f3a-c25d4c89963mr22663566b.0.1788299198592;
        Tue, 01 Sep 2026 14:46:38 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25cffc70fdsm27500866b.4.2026.09.01.14.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:46:38 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org
Cc: davem@davemloft.net,
	andreas@gaisler.com,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	glaubitz@physik.fu-berlin.de,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH v3 2/6] sparc32: use memblock to find available system memory
Date: Tue,  1 Sep 2026 23:45:46 +0200
Message-ID: <20260901214611.60560-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901214611.60560-1-linmag7@gmail.com>
References: <20260901214611.60560-1-linmag7@gmail.com>
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
index 23a6383feb15..f094f6c105a2 100644
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

