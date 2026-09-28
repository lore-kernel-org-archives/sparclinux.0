Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E5C4F5DF4
	for <sparclinux@vger.kernel.org>; Mon, 28 Sep 2026 20:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790626128; cv=none; b=agEE81HCACLcGVM118m4+Lcj1u9Ict27DP5MKYTwxr16KH0BZVtcTpZhSfDg2jmHGmrXwNXy+lGS49ZpSTpCgsAL6kX72MEhOq9fjaP/oYWAkC5iYyd5ewJ/CK6wjx/O34wBtWN++GbyFNWsLXw5QuuJKHk15N9QjSOjNaynBxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790626128; c=relaxed/simple;
	bh=KbFTqf0Stipa6Z0Bf79nWzA2T/N8nR0vSGeB4CqZjYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uc4b8PSvsn0yksN0nhKEj0CTK1+GbUu7K067iRumCYyUN/I/2IiHHVJccTcZfTuHaenyOExT3fSIJAiFTSf8QEE3WcQmnxsxW4r6U+dXeFo0JeXyprDyATJ9q0hkHMa5a119psjDwLIkDex28V5BvpsVeFinItwNzy1tYQxaTvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPlDZWmN; arc=none smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPlDZWmN"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2df698f77cso3902766b.1
        for <sparclinux@vger.kernel.org>; Mon, 28 Sep 2026 13:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790626125; x=1791230925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CtakEnWLArPo5Q59HM8M0ssZyLg6kVbX40sG8XoXT0s=;
        b=dPlDZWmN54mISqwprU6ivV+m6IM8HfS0HaAHfJQ1JIWc9NeZ11rsjQ6/3rd9PuJMRN
         l8jXha1T7I2OhDifAF/w/BA5kXDCsLX8merYYtgroLpB7TzRTrDPAtyLqR8KGLVnxZZ0
         H3VBDxzUmLYghMxQxQ9thd10pTWiV2upPL7qNqG18qt7nUSkG4WcSG8BuoPWK6JUcFnh
         Kbgrq8HMtB1o7klkC1uHCojzQoRCBprJhThCyMOuPCKbaDCHz8IYv1x/sWWlxQ9eVf+E
         E0QDAAU6oo6gKyYWrNsixGWxJeYyj5m+RRz5rHudzaYl47EMckcdgcQKRtLq+3RoRNT1
         UDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790626125; x=1791230925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CtakEnWLArPo5Q59HM8M0ssZyLg6kVbX40sG8XoXT0s=;
        b=ok4O0ph+8HhvAOPAsPiA2ib8Bj+palyMbEC+CMwmHdtzrYBlDOgj2jMLScMzPBDjxX
         BrhA/ymj0IVxHVC0/TLkUqSVWJoTZ+dG/Zg+7Kjh4WBejl5wuaFHGWK46qficvGOeBQB
         /yKCO97T+x5H4IsFBxqr5blIaQjwDc+3NVLZhN/ZqRbPJG7swKdSEINL8fJwXEy+uqqX
         LaqOjsNHfEQRm1VdWDU0/DvUJMiXudFN2LWpDyxYQkkPx5EtJzJe9e9eJk4ecDKRet/B
         bIE9ef7Nso37/n0GAymcqGEBDkdFpbfn/ipWCvnLOmRgUcJe3fncPJKerHZ7f8s1tkUc
         52XA==
X-Forwarded-Encrypted: i=1; AKwUvBwI8WCxt77PUTkMri7FoanjlfyTEElu3sDeQj6hegNaDasZBYXIy0V7HiIrw234irNaKLUYsZoeJCpI@vger.kernel.org
X-Gm-Message-State: AFuF++nYR3FfaxFfDqupx7lHNgZJLRuCj6tcEahLGIz5vo+q6tVauGcW
	zx92meajIS4UMEy7WQM92PPpFawi79b9LBYOn0Lk+FU9PYECam5E6vlw
X-Gm-Gg: AYBFou0LUHiMWaHYnpjN6wVaJgj92NAXaDEcgW3zjSYFHLd1E7nizU6xkqr7xsgX5sf
	6uEECE/o6cvUZKvma+LP6j8lMCHcu4Taa2bdunJV0Dn+w/7bJall6tF8GV7Nsk9QWkTl2RSnLyb
	wJSSvNfv9yXXMQ1sKB7UgR1nDHaq8dsmcp0XBw9GE6OsNCUG4TIHPtpTugquwNkK0B6bDUHoYfh
	7FYQ8Rt6RowQnuBa69M1A5mIyswdRvps0EWZn1l0BQeHcvJXbVoe4jhEzHpYPMqA8EYmoUy0cz2
	l0+9t4EOTg0uGqJRxti3ARSOAMCXXVj882gGe5mpJfMNK8BRmpc/MfjF/VzD+j6dsxiIyMvtals
	FRE/Bg0/2fcFR4jFjO9KB9HREEyxZt1lMA43j1w7TSaY+SkqJPCU5/gqz04vccodc1VY/l8QB87
	ywkVcjr/2IGUzcBns9pKGft/2xPoVkqVV6+PkZMb9eNHSM5EytrvLyKfGfmTKSxbgHkZSp4zUtp
	uaNkk4orHQJeCMmX69ReHYGaiSatyPpqR+PSfvM
X-Received: by 2002:a17:907:7ba5:b0:c25:8c05:902f with SMTP id a640c23a62f3a-c2ac230affbmr1172846066b.13.1790626125092;
        Mon, 28 Sep 2026 13:08:45 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae76abc3asm509778166b.37.2026.09.28.13.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:08:44 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: linmag7@gmail.com,
	sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] sparc32: honour phys_base in the viking cache flush routines
Date: Mon, 28 Sep 2026 22:06:22 +0200
Message-ID: <55357ed4f6270c81595a018af2fbe391d8b912ab.1790548064.git.linmag7@gmail.com>
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

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Message-ID: <20260928002035.1-2-linmag7@gmail.com>
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

