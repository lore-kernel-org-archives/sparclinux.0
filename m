Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F38A313E0B;
	Tue, 26 Aug 2025 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224213; cv=none; b=Q0LfE+/2Vk7jGnMLpuYGjOAH5iHaOR4lkQrqZtHw3wbC5ZIKM1a5w+I+qb2sOKRVQCTjky2vuNgZmXkj15ITCaM3hOE7qVAZBsQ5UKyPtARedfmE8jh2PChkDK2KgckCUkkg9uOyFmKT7kLwpGb6G35Vht9Pbk/caendmv92eHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224213; c=relaxed/simple;
	bh=uQmHDK9q2+1h/qYfAzwPyk/3mAwAb0UodjIUz+gh0VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PuKt63cjvm5c2EBG4Z3lAxIKWlXCJ17vuOBxfQBkkTU0cLF3OIkue8hR36lXX170FP32BT2zv42XXRd/maDEhpyiWREKQqn0SByomILmm6U7aVjld/rNfWJiRdVULzQrQ5yPmHIw4s++pJq1Q8GYKs+qCCe7ob/pX4EnT/dth5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=UimqA6JQ; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="UimqA6JQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=pIjPE6K57qHddsjmMtmeekZnymnbiQUtKQ/iu32UBbs=; t=1756224210; x=1756829010; 
	b=UimqA6JQC3YuQTSetu7o94uZJHCgTa6RWasm4vTDNF4sL1LOaKLTE0euBh0AnT9Ts9BHMN2glc7
	mJqJIOo9/sf+bDHRkuSooFf7UUfo5QgLegNcYoFlv8kTpC/gnLSESk876zHoLxRcoZzlK3d0SPI1A
	1RlSAr0qzptFtPz3otmp16u9vE2qb5AAJ1At8eL3/PAneKo5fpvezhGpluLjzQD6WyYGZIG3GDSJ+
	tyuh7mVVIESXCIZdPqjDjqdapSUq03C/BJIuqkg6sCgROElH9RMh/alExZCYHM1A1gnvN9Z1Hluim
	ww8PJJgOrBzJVadtJcLFZGwl+1QeO62QMuvg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1uqw8p-00000000x5E-1xsu; Tue, 26 Aug 2025 18:03:23 +0200
Received: from [89.57.34.174] (helo=Geist14)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <kernel@mkarcher.dialup.fu-berlin.de>)
          id 1uqw8p-00000000c5y-10E4; Tue, 26 Aug 2025 18:03:23 +0200
From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org,
	Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
	Andreas Larsson <andreas@gaisler.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [PATCH 1/4] sparc: fix accurate exception reporting in copy_{from_to}_user for UltraSPARC
Date: Tue, 26 Aug 2025 18:03:03 +0200
Message-ID: <20250826160312.2070-2-kernel@mkarcher.dialup.fu-berlin.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: kernel@mkarcher.dialup.fu-berlin.de
X-ZEDAT-Hint: PO

Fixes: cb736fdbb208 ("sparc64: Convert U1copy_{from,to}_user to accurate exception reporting.")
Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
---
 arch/sparc/lib/U1memcpy.S | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/lib/U1memcpy.S b/arch/sparc/lib/U1memcpy.S
index 635398ec7540..154fbd35400c 100644
--- a/arch/sparc/lib/U1memcpy.S
+++ b/arch/sparc/lib/U1memcpy.S
@@ -164,17 +164,18 @@ ENTRY(U1_gs_40_fp)
 	retl
 	 add		%o0, %o2, %o0
 ENDPROC(U1_gs_40_fp)
-ENTRY(U1_g3_0_fp)
-	VISExitHalf
-	retl
-	 add		%g3, %o2, %o0
-ENDPROC(U1_g3_0_fp)
 ENTRY(U1_g3_8_fp)
 	VISExitHalf
 	add		%g3, 8, %g3
 	retl
 	 add		%g3, %o2, %o0
 ENDPROC(U1_g3_8_fp)
+ENTRY(U1_g3_16_fp)
+	VISExitHalf
+	add		%g3, 16, %g3
+	retl
+	 add		%g3, %o2, %o0
+ENDPROC(U1_g3_16_fp)
 ENTRY(U1_o2_0_fp)
 	VISExitHalf
 	retl
@@ -547,18 +548,18 @@ FUNC_NAME:		/* %o0=dst, %o1=src, %o2=len */
 62:	FINISH_VISCHUNK(o0, f44, f46)
 63:	UNEVEN_VISCHUNK_LAST(o0, f46, f0)
 
-93:	EX_LD_FP(LOAD(ldd, %o1, %f2), U1_g3_0_fp)
+93:	EX_LD_FP(LOAD(ldd, %o1, %f2), U1_g3_8_fp)
 	add		%o1, 8, %o1
 	subcc		%g3, 8, %g3
 	faligndata	%f0, %f2, %f8
-	EX_ST_FP(STORE(std, %f8, %o0), U1_g3_8_fp)
+	EX_ST_FP(STORE(std, %f8, %o0), U1_g3_16_fp)
 	bl,pn		%xcc, 95f
 	 add		%o0, 8, %o0
-	EX_LD_FP(LOAD(ldd, %o1, %f0), U1_g3_0_fp)
+	EX_LD_FP(LOAD(ldd, %o1, %f0), U1_g3_8_fp)
 	add		%o1, 8, %o1
 	subcc		%g3, 8, %g3
 	faligndata	%f2, %f0, %f8
-	EX_ST_FP(STORE(std, %f8, %o0), U1_g3_8_fp)
+	EX_ST_FP(STORE(std, %f8, %o0), U1_g3_16_fp)
 	bge,pt		%xcc, 93b
 	 add		%o0, 8, %o0
 
-- 
2.50.1

