Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979A94A2A4A
	for <sparclinux@vger.kernel.org>; Sun, 18 Oct 2026 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331388; cv=none; b=Tmm91b4t2G25O392KvQwuoWT+wnkmZUTJz1pwuBTAtNhPzN950pSWszmrvls6RvEFzEXts9zG2uq1tLmQpKuJHSFpUMuFCdLptU9HHjqZIgZe16BepITUG8YpGIT/LJgUZ1uQ2RCbPa/NC/oyZiglJR/B1e3K2YMw49LMrqx8dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331388; c=relaxed/simple;
	bh=MI5rNeMwhZ43wprmCG+DEgAxLuM2IMPTCnPCyH9xbeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqgMatEo4NKf0sNJzzAeWw8j8d33gPltsNh7LZ57dfKpdlWOkd6R3qyOCWBounomEfLnaICE8Wyhv0bd87zqlg8Lu1H/jt5fq/rGhy3UZUBCQLijH3RXhgCkGAJBu95SNB/sK/Cu8ilIUwN5NRAkYU32gCyf9pazeJn7BW93JpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqzmN5Zg; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqzmN5Zg"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c40447e25e6so141808066b.1
        for <sparclinux@vger.kernel.org>; Sun, 18 Oct 2026 06:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331383; x=1792936183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j0iP+m3EX5ucikvDp402dsq76Smx73BsFN2IxwK6/bU=;
        b=EqzmN5ZguXXrxRgfMiQuvwrgNp3aYl+s7JPYNRhp2TEmQvuz6/5VSkk5ZRmeRO3gFw
         ErsDvtsdDTrunOsyotzqPXmQSJRiFqbUIS+vHISuVi0DUQlNvx0SkEbdqlmuptYGU9K1
         LOY+8wRkHo9x0g0azzBrWqOyaJvHRkz58vGvihPYW8ne8cTmGmDclJQYmGBbXJS32MmR
         mubntJ+S6eIsd7EID55y8+1j2XLedAbYmbzbpG2Gc0lGcLXQ4R71f0l/6yiUBpc6HUCC
         Y+2YgsDKxAbTnJbhjvlaZMaaPInTn7g82H6OjosOV1Kf9tSSgfDtS48FIzsyKKRlXUfZ
         wu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331383; x=1792936183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j0iP+m3EX5ucikvDp402dsq76Smx73BsFN2IxwK6/bU=;
        b=f7cX2hdPNd44Sh5rIrhRmNTiQZ6jE4VIoW/Ktmd9oSDuwSsgAXh9EogIJx9VFJxBHt
         uyajanyCV1qJSU2j5j11gEfOAhEMqEE/xCJtCwdbNtXfgU02by7jGy4eAnoVvD+msppW
         9WukQN5Ga9QIxNRz/YizBQRL9VRBoq2mmYLjPZL5mOyNPZpqZQEo01jN4KQU+EmoQMs7
         RVDx4yw/A4avDGY9BlKggxrQmNxSUcJSm/o+oyZ1OZ5sbsCahKg1hUMp5SNSSjp3ah5U
         N5qytBwEvgB8ABofTHnZJNAPNkJtkkBX5MnEf0AaQbEpmiITcjS7bJ7FKhpeMRROnV9x
         AfeA==
X-Forwarded-Encrypted: i=1; AKwUvBxMKjkHWH49andNj7f/EyJWksq5Yb4eqnGX0MqSCuExcoI+2uq1BTK6XCfgXjYDDsEgsLdrm67/RJIV@vger.kernel.org
X-Gm-Message-State: AFq9FYKHDemdF5wb0KxJWhhFp12faBGOBkAwcXYHSqdZo/ErlmEnWBk+
	CXYGnpAoH5EZRPILdbPeoi/ZqRgGbw+FdeuTzQcRw4YtT9Fs6wlKtP0m
X-Gm-Gg: AYBFou3ckLklJbEQ1g09Iqww5x0h3czoG6MqVXWsgQWGk9AexoLTvGsqGYz70L+qcN3
	J57voCscgcCZw3QS9Lpl3U2wDOzPyQHEa2Dqn9q2Y/bd0sgPGWE0fDRGc7fCw6fJK5YXHm4Bg+A
	yjyDOgVIy49b21KRHOMA3A0Y5W9PYZZ0l02k/HctJQWthWTQSd0bnQlspMqX0qpEm3IzjikQNpB
	PmY17QGH2TjLNsFQ8w7AHmglN5+wYsV4QrH6I7qCR2YsxTV07/RrxGzuFFSkhJrqyXEuTi30dmV
	U0Z3efSAXtuxctArOqOI2q0m2CVXeV26YOyQJv8YMg+O0C0DnxMSE+kKUktEoA773qXffWKnijI
	5ly3jCbkfHdcTHikQFFzizmfousOfGFw5HzsIifGgZoLkiGfmbdTM5nf7i1yD3VjHAPGKdhLB0g
	hmS5QdQlOxOwyWBYkDRPlWPyrgZpH9oE1OfcFtEos+T1bxV+eXoGcSDaYZFt+Xrh3iGjYtzj+QM
	/1fO3TNQ6jF3bM60IGY+OpN59pvTGT341uyuEca
X-Received: by 2002:a17:907:c22:b0:c41:1e13:8891 with SMTP id a640c23a62f3a-c419df3e64emr310042766b.9.1792331382777;
        Sun, 18 Oct 2026 06:49:42 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:41 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com
Subject: [PATCH v4 07/10] sparc64: zero newly allocated IOMMU page tables
Date: Sun, 18 Oct 2026 15:45:09 +0200
Message-ID: <20261018134738.1016106-8-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018134738.1016106-1-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iopte_make_dummy() replaces only the physical page field, preserving
all attributes. Applying it to an uninitialized table leaves validity,
permissions, context and reserved bits dependent on prior page contents.

Zero the table allocation before installing dummy page addresses. Keep
iopte_make_dummy() unchanged for unmap callers that preserve attributes.

This initialization pattern is already present in the initial Git
import; the Fixes tag identifies its earliest recorded version.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index a23105b64fb9..66aaafbf1621 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -130,7 +130,7 @@ int iommu_table_init(struct iommu *iommu, int tsbsize,
 
 	/* Now allocate and setup the IOMMU page table itself.  */
 	order = get_order(tsbsize);
-	page = alloc_pages_node(numa_node, GFP_KERNEL, order);
+	page = alloc_pages_node(numa_node, GFP_KERNEL | __GFP_ZERO, order);
 	if (!page) {
 		printk(KERN_ERR "IOMMU: Error, gfp(tsb) failed.\n");
 		goto out_free_dummy_page;
-- 
2.43.0

