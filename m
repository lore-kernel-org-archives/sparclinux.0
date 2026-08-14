Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFD31A2545
	for <sparclinux@vger.kernel.org>; Fri, 14 Aug 2026 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786705488; cv=none; b=IpnaI+F73GtbkmiHsfj7YrXg/cKybfqJIC3u8lzCMLGib6SKbWHu66H2DgZbsuE7TGi55HShttZ/iz3ciVhmloaiBL6EAVvKMFDbOaEqaeTolp/fnBNIBknUeFuV6KyjUUYOP9YATW1ILMxN9pSfHHS+3728+BFtCtN7obPg6ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786705488; c=relaxed/simple;
	bh=7ZS9XfQBg3/J/2JclDC1KmYn/5ZetW387cKqolJQXzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSUxV8CsRLxI/15Z6dzFqTYunIi8ApBuRzVc+JDuUzJynb4Zkfdq/MzKSEh2tKZ2ugFbwtBtbtDyAp4lzgHmqEHwVl43o9i+WVcKqLzm0aNurkZJGrmUzDiTocBVq94m/2epfub1gRYpwG5j0K+8ojZvJb3YY0Rt8RWt5EddQtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jX+oQS5q; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jX+oQS5q"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a28cbdso1404529a12.3
        for <sparclinux@vger.kernel.org>; Fri, 14 Aug 2026 04:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786705481; x=1787310281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xFVxe3t9mWeVpbsGrII+FmHHHZF4AA0TdlMjQEfc1jM=;
        b=jX+oQS5qIzGP/LxnmwCzXfcxruK7ZApgHgCCvA5h7eAu7LZ3+8hNhrgs2Fh7rViuf1
         o3u2OABhIVt6CwE+eowQJiNSO3StQmPGGFQ4O4+YckwPLDbxxOYA2xRAVqspBC58dC3N
         HoZcE5Z06v8G2oxpg+OyjMsaQu67GXWjKApLVtESRrUEYXgRWvfru0KjlDeIProGJmTb
         eZn1+hX8Il2m5CJt1knL56w+E+XPfR6yVTgdbNfMuLfW2O8vclzs6PH+UzU2kLJ4IKh3
         VQWwWgQq+HSi36Wpfnf3NwgZltkYGH5nqo6LZYDbI8sIllU+cZaCRZbN9LQ9HaW+nFkE
         xvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786705481; x=1787310281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xFVxe3t9mWeVpbsGrII+FmHHHZF4AA0TdlMjQEfc1jM=;
        b=Ee3x/a0TCL/3jK26Vwja3IFUy78rbOcuSplMDH9pnZPppdaIphNBb+ge8pGtkgpJX1
         LfHaivccZliu6kZ4zv/gIQk1U7H4i3rsoBkml4rBCClYqezTu+GJhbL1ElBNfXxp5ypJ
         YBL+fiEncLLJOSH29L7iVbJ3Vl+4Vnvf490G1wUj9Sp9t7gIG8dVXvj/WYCL637KtwkN
         HxY0hv9BKr4sM2B7ndDiClbZoRJAdLwNd5WDjV1GFAV7ml6IdV4QNHb0TF7KUd4eqsSg
         FOW0+nCREWnr4S0vp0v6nc6f7/TtF9KYiRdLWvTYFpT72s+jQKe3mKGhcWnSMIlz3hZm
         LPPg==
X-Gm-Message-State: AOJu0YyEAWUZPnCagG/ere7KJ+DzviAHgQJV4sE/gwiEt67nxIF/yKSc
	V+bskiisq5Hh8LBKyurKzEiQ+5GVuwGI6la6PGAvIJeSNVjrcBKYxNX0
X-Gm-Gg: AR+sD11nF1/iFa2mehWNF2HBfhsKDTjcr73MtIfI6o1vF1QfK9xWvpdjNU6CL7NTpzr
	HB4PQtw2FrQUKn+g6RzrNnwGZvAdsDTXSwhaHKM4o8YxJUpCq4Yh0gFpvgn8vCPtXte1aF8E4NZ
	I69hD594Ez5q71QThBrYkTp3rh0l+B/NicHKPmosnbmD/mtQfdNMXYNEgJntkZiB9FwBmXoEcGR
	4lKC4XKpcVlgX6PKBCAuJRe1br51buhERRTjFCvnoC/VjWJ/pcwEhZOmavBZGPI/DRV4NPHTix2
	QoINzez96tFZNVrwdp58e9OdUoImyM1uYT4n4ihF7tkhaxHh8hovX1YMaTA9i/JaPKJ5lO8gehB
	q/7VB7o/dRs8WxjDi7KH60zLK0JKDX6IhD47wFxMdtkY1tHlgLbhTD5R9N8MVLsV6ymYtVy/l0E
	Sos42GEDlWhrgzCZVT8kD61F3rOcJLDPLKy4WT9l3q4XR9Pch+3YBK1QMQM8a47VTq9hN/69EmR
	80FAdDI17M406kDHo6EX/2Zge5bqGGG/5NrpR/J3ls=
X-Received: by 2002:a17:907:94cc:b0:c20:7897:bc69 with SMTP id a640c23a62f3a-c212a8d86a9mr208542866b.30.1786705480333;
        Fri, 14 Aug 2026 04:04:40 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c21233a12e6sm92028366b.12.2026.08.14.04.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 04:04:39 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH 1/3] sparc32: honour phys_base in the viking cache flush routines
Date: Fri, 14 Aug 2026 12:52:32 +0200
Message-ID: <20260814105723.3454511-2-linmag7@gmail.com>
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

viking_flush_page() and viking_mxcc_flush_page() derive the physical
address of the page they are asked to flush by subtracting PAGE_OFFSET
from the kernel virtual address:

	sethi	%hi(PAGE_OFFSET), %g2
	sub	%o0, %g2, %g3

That is only the physical address when phys_base is zero. The C side spells
the same conversion __pa(), which adds phys_base, and every caller passes a
kernel virtual address expecting exactly that.

With a kernel loaded away from the start of RAM the two disagree by
phys_base. viking_flush_page() then compares cache tags against the wrong
page and flushes nothing, and viking_mxcc_flush_page() streams a page that
is phys_base lower than the one it was given, so the intended lines stay
dirty in the cache while unrelated ones are pushed out.

The visible effect is that anything relying on a flush to make memory
visible to another bus master silently keeps working from stale data. On a
SPARCstation 20 this shows up as every SCSI transfer failing with a DMA
error: iommu_flush_iotlb() cannot get the IOPTEs out to RAM, so the IOMMU
walks stale entries and the ESP DMA faults.

Add phys_base, so these agree with __pa() again. No change when phys_base
is zero, which is why this went unnoticed.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/mm/viking.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sparc/mm/viking.S b/arch/sparc/mm/viking.S
index 48f062de7a7f..8b4e251bbba2 100644
--- a/arch/sparc/mm/viking.S
+++ b/arch/sparc/mm/viking.S
@@ -38,6 +38,9 @@ sun4dsmp_flush_tlb_spin:
 viking_flush_page:
 	sethi	%hi(PAGE_OFFSET), %g2
 	sub	%o0, %g2, %g3
+	sethi	%hi(phys_base), %g2
+	ld	[%g2 + %lo(phys_base)], %g2
+	add	%g3, %g2, %g3		! + phys_base = physical address
 	srl	%g3, 12, %g1		! ppage >> 12
 
 	clr	%o1			! set counter, 0 - 127
@@ -91,6 +94,9 @@ viking_flush_page:
 viking_mxcc_flush_page:
 	sethi	%hi(PAGE_OFFSET), %g2
 	sub	%o0, %g2, %g3
+	sethi	%hi(phys_base), %g2
+	ld	[%g2 + %lo(phys_base)], %g2
+	add	%g3, %g2, %g3			! + phys_base = physical address
 	sub	%g3, -PAGE_SIZE, %g3		! ppage + PAGE_SIZE
 	sethi	%hi(MXCC_SRCSTREAM), %o3	! assume %hi(MXCC_SRCSTREAM) == %hi(MXCC_DESTSTREAM)
 	mov	0x10, %g2			! set cacheable bit
-- 
2.43.0

