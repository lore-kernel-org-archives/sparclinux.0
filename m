Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB5C381EB9
	for <sparclinux@vger.kernel.org>; Sun, 16 Aug 2026 07:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786866809; cv=none; b=aDiqmPSdTyGUB1ZKKJHmJibR2t5c1RsnfwNieEOH8awb4WmLAhhCsLlWb+TXrOxeqGeDo/PeEKHED967rHDe+v5O/CKi423ZwkuXmQ/ls6p/aDpoIE6YqEbNC6fEYN79yetxnuABFK1Xtlihj4oDQ49ZgxwM/hfIwJahR07uegs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786866809; c=relaxed/simple;
	bh=qeTfM1VkMk0+4bmCCogGKKwXhXDMIKGOfZW8zAb4pmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhstOr1QdMc9MRgGJzrO5+kxVy2LXTKYfN5xk/68VX64R1mFcqxxhbdQw5ADHrNimEcIvfxvEDuXcNpDQdpLO0kKK8+9uaqEj+6JRRh5DgdIUlDzxzIElPdfxY0xM1nTrQKSVLkKahPbneLXntFzQsrLRBCqOPFYG9gD1zHigOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFO6jydn; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFO6jydn"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c9bb9d2fbso18442801fa.2
        for <sparclinux@vger.kernel.org>; Sun, 16 Aug 2026 00:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786866806; x=1787471606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rgiclpiITCoA8RFUuKs2akILXvflZWj5Tf2R9RMw6kg=;
        b=IFO6jydnJMkaXbP7dWfMZNEg0fudx7/gXJaKdpSuLK5Hof1p1PcnFFkT4CyX7zOEFv
         Zrob8xrw69WBmpRGwH4PaaBx0/yryHdd5bYueWsngMse2Eb9b7BWUZg8Y4C/kdgfTh2l
         q67/tVrV1juyl9eYKRgLvpHnQJgjrujDSAA7PI2Lhk7cC34d2C3f6zXFtt9CdqHB0BkA
         seHhL4NLjQ4+vtv0aSVIaS1fQfy77ynbnoI2BMdVTuktexQvC7yVPeEE+ov2HvVziAqk
         o52C/gpeG61R1LqP+7RJFFMCGPbV4pWlhJhLL27h4KuXrtRukg8hBZjtmVcXXce55EeU
         Olww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786866806; x=1787471606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rgiclpiITCoA8RFUuKs2akILXvflZWj5Tf2R9RMw6kg=;
        b=HJIaezExvu7NxPECOM97XXgJ5INyM1Xpq5YwHL7N8JMAtQrEGH1h907lxRvnQL/GbM
         Eowmgfi+UDwRCovwaPY/ekq8flJcmNLpnp6RJZYBXLLdh3OeF71DXJ4dF9oy4QyUXRnL
         pTuNq80KWCWZpMB5+wAtlWE5UilFoVMvFMMjCJ4kSVBJ+i9CmBYo1MvFXn9SHxIXZVeV
         NyK5cRpcNZMC3e5bLI1jn4z19dSDJ9a9aH6Y4B0P30NA5pWIgBy7c9iUxsNxr61CMQWr
         FNiFDEsA5F7WFmO9pUce0a/nnyp2eFgtvV2mzitxaoxCPbVuHXhyVVfn7mFid5KVr/PN
         ahQA==
X-Gm-Message-State: AOJu0YxzP1jXm6b5LL6i5ERIZoLEZB2v1P6Iw/uC4M9szKVIU1lrBz3K
	5lGfle04yMaI0B2jKqEXUUBzraEFHFyw0wNq++2hIq4FicSfw/RskEqFj5Fzog==
X-Gm-Gg: AR+sD11tewNhxMKNewvbqeOK4qBHz+zfI2uBKJCAr6lL1Md8OM9A3e7CIvYZBUOL4Fn
	pNsa6mHdgBhmZVpJCl6A0lrRp5l9kJZ1s2xQ2NCr6+0t69hXzIA1sVUJTJrOHt2vvvMjvSkTAFb
	8k4OZfuwNf8Ufo33t8pdSmsGvI8Z2moFxTsBJu3ul3qlOPrOQuCOJzoPJOWLaEpL7bSfR5FF7or
	wSZ7dV3zGVtBSu/6OAnWF/vjH3f0HuBQROyiU8M9Lh/McvOXb6jSsEzPaUrOIuG9Fjy7L6BRE2t
	8dWYaQfbQjOo50cp/tQauY9GrLYHuizUEeIlTYilMuu/XnOMeOY9M4+VTZxnruuoNO3eHbnoXSE
	EfHNK3xshWMFNmPnsmbcgZSOHIvfQ0MvOEG5gy4mcpEw8cUl3AgoSqEEOGwVwBpW5S8H6lSbM0i
	3zbv05GRqFwev2fbvctCu8fodpg6du+R8DFSYbVIf7TLBxFemBuACcxTow7Tvk3oKEOf2SzRN8U
	Kts8SmQR6GjD9qbfcZ3oQuYT9vfJPqrIrdoakMKVA==
X-Received: by 2002:a05:6512:ac4:b0:5b0:1ae2:8b7a with SMTP id 2adb3069b0e04-5b45918c5c5mr2824941e87.45.1786866805942;
        Sun, 16 Aug 2026 00:53:25 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b458b9a8d4sm1631136e87.15.2026.08.16.00.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 00:53:25 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2 1/3] sparc32: honour phys_base in the viking cache flush routines
Date: Sun, 16 Aug 2026 09:50:15 +0200
Message-ID: <20260816075141.3489194-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816075141.3489194-1-linmag7@gmail.com>
References: <20260816075141.3489194-1-linmag7@gmail.com>
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
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
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

