Received: from mail-ej2-f27.google.com (mail-ej2-f27.google.com [74.125.228.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCBE4EFFAB
	for <sparclinux@vger.kernel.org>; Fri,  2 Oct 2026 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790957789; cv=none; b=VnizJg1rFOk64y0CySw1lEdMc9N2ouyNibfpa7I8K6dEols3z0ZsQVzqKQzBKm62wo9IlbDQ/UVQlBwuv2Ox4LXh+lH1E1C8VOOeb6Vv1PJjJSQvnAj41XUHfQSwK1t/1hfWXL2kmlGUdAdK+cW2QrikKmNbybCaYoWQ84FZFIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790957789; c=relaxed/simple;
	bh=9F9PqYLol8RYefMryvIE9X8WcFhHN+25KlDi07fHopY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xuafx/isC6TepGsYQIbXVTC30TECkZEtyyI3bhAAYbRR+tzfJl9CEVfb73+kZ1UXPbnpRIF3ZC89ib3guR8De3l8BuS/ta8XmGyHzxRjuub43DIbs4c+qWjGlH1QK/NP3IJUFVrYdO1PdQ7X0VAstJD1QWYdsYdiZZjAhXrL9UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSvlT0Jq; arc=none smtp.client-ip=74.125.228.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSvlT0Jq"
Received: by mail-ej2-f27.google.com with SMTP id a640c23a62f3a-c2e201b7189so13733066b.0
        for <sparclinux@vger.kernel.org>; Fri, 02 Oct 2026 09:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790957786; x=1791562586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ey4LJMK8RV+MV7vSZrPUmikamurNbFQxbI2le0bK+bM=;
        b=DSvlT0Jq08crkzAseZCIfwxExC4fHktx3wkMEscgVtz49+TXFD4Q03kJ7UoAVSYxck
         5YC5wZu4llfsRlGmsgbdgKqta7LIYFMEeH7vt1LPLWIPWDUM5qqfjUuurvl4aTczy5Kz
         m9Hu/GbS3ebEewEDbhtvOELj1QrlBi800Kj7+c9XuMZEWrr6x0N3P+VcgEMjmuE3oCk8
         /75FCLEUO2B7gDQJcF699X8S4qRTZk9DgSKK2W6Du2oduK+/VwsVpbNhT1mJP6w3Grbi
         6lMRXlK1VV8wTu8qJmzU+2H6Sck8g3lfQ28jyVlNC6i+1P19RJ+/pMlWUjbW1XCD4o4r
         vBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790957786; x=1791562586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ey4LJMK8RV+MV7vSZrPUmikamurNbFQxbI2le0bK+bM=;
        b=yoEMeKNtnNv50OvC5mj0+cxPDn00I4adu5ooXAxrz41Qcoh0pgjjxbs8wjW8FpPb8O
         1uW5tdJuaJc6X6vnZ01D8SFAHqvn59I057ulG6JoYoe6xAWtYCkpfGdeafTIr/09t4h6
         eB4YgEf2BHWUxHsDBAikNdx1zuModG/NxFKp0DDwAx8aeXZkdrXiEaAFu7Fu2+Rrp9RO
         CWF5p8k1UGwJsEleO/VMIqkyMPYgjpqkdHtx4QkBdxyv/gxwoLP4Ja/yil3ML1UDAZQ5
         BmCZ5jY/v92baLt/p9BEeUbmGcnlahg+BdyZ7i0M/02vfCz7LDQaXm5wu2WzS4JskFCT
         6axQ==
X-Gm-Message-State: AFuF++n4dPMYkeSFOCWbQ5g4JbTsxIHiCcXnX3g8RbULwYfGf1Gt66ln
	fIPwFrEi2OSJXnJ2WwhHd9JsKTPco1uQd8F1fWo8p9ICkXhnied4ucw8MbTRl8iH
X-Gm-Gg: AYBFou2g0rMKMtuQIe3zFkONlLwbQ0L0vKF76wPC6/v6SOl3t1uBVVZZs8GKboX9wuK
	Gx2Wv02PdQTzKhKB+vJ7W9C9oByzlKHJ/BOyB8BCwpiBStX/as5AS1E1zae2d0mQO61dO2R6v1k
	nyxoGXpOo+o/wMFJVIu/kQfX3AJzyojbpjREgMBrsVYFab8y5XVwo+oSapOszT8lVc0GXg820SO
	4BSPbMJtv0S29j5m2IMAUrmzBh8V4WYrInRd1tbostpGyVCQYl4ZatU9e9DY3QjR0fkh02jSEd9
	rrQTh5UVG6UUOtFXYRSFpmnIDkA4Fj6aIc47uCcdJxysIEh9qsgymB6DuE6R0c0gwgcnSJGL/Nl
	QaGG8RBF2sidj6u2p5//OAP6EIqK4vGzTWzhBS3vM8UDMYnUNSDFuh9UXC/ouckvByupE1dyYn8
	1GnRdL7CHb+kADgu9+WjxNPI0R+GiEaK2Wt7y1RF3jrL7sJKJEgpyzftoIwklt8sygOrMKIDNmK
	DRHwMy9fncJzhp7llKWjInF10XfxUI8H57tilR1
X-Received: by 2002:a17:907:7282:b0:c2d:fc0b:551c with SMTP id a640c23a62f3a-c2e4ad7caa6mr250891266b.16.1790957786532;
        Fri, 02 Oct 2026 09:16:26 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cf5f4e4sm106437166b.42.2026.10.02.09.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 09:16:25 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>,
	stable@vger.kernel.org,
	Bob Picco <bob.picco@oracle.com>
Subject: [PATCH 3/7] sparc64: avoid huge kernel PUD mappings on sun4u
Date: Fri,  2 Oct 2026 18:14:25 +0200
Message-ID: <20261002161515.932316-4-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002161515.932316-1-linmag7@gmail.com>
References: <20261002161515.932316-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel PUD refill path merges virtual address bits 32:28 into a
TTE, requiring a hardware page size of at least 256MB. On sun4u,
kern_linear_pte_xor[2] and [3] instead select the 4MB fallback TTE.
Consequently address bits 27:22 are lost when refilling a huge PUD.

Keep the kernel linear mapping at PMD granularity on sun4u. Its refill
path preserves bit 22, as required by the 4MB TTE. Leave the sun4v
mapping selection unchanged.

Fixes: 0dd5b7b09e13 ("sparc64: Fix physical memory management regressions with large max_phys_bits.")
Cc: stable@vger.kernel.org

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/mm/init_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 103db4683b16..0ae97e616435 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1696,6 +1696,14 @@ static unsigned long __ref kernel_map_hugepud(unsigned long vstart,
 static bool kernel_can_map_hugepud(unsigned long vstart, unsigned long vend,
 				   bool guard)
 {
+	/*
+	 * The PUD miss path propagates VA bits 32:28, assuming at least
+	 * 256MB hardware pages. Sun4u uses 4MB pages here: retain PMD
+	 * mappings so bits 27:22 are not lost during TLB refill.
+	 */
+	if (tlb_type != hypervisor)
+		return false;
+
 	if (guard && !(vstart & ~PUD_MASK) && (vend - vstart) >= PUD_SIZE)
 		return true;
 
-- 
2.43.0

