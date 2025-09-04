Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE8E2DC344;
	Thu,  4 Sep 2025 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023430; cv=none; b=a4Ouv1A/vSvqLsdVMmzym7vEamphCc8OqsPMtqXRjYmpacI/e/9NAgG3ci+8e7lQNMryjBZqK/Wghvpa/N1Ndhg4vMzOqrDL3md0c0cgqWKas1t9uTVkj+CSCuwpI/aOIpzS2mbQF/wvSW2HSix+YwzGm+04Tq9k7MMYHee7dnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023430; c=relaxed/simple;
	bh=yckpfoj4npEN+YtfiZVyat6SWElVSjCHN+wFaEGmz3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q/mvxqeXsRQrAmDhSzGKELHIK9XE4qoYzm90aBJcevz9xwQ2eS0eMInk71YE0Dtrmmz68iI6xaWsV4UW2QCB6uL9PxB1XSjwgkeXxyBiDYL23XttUMGMuoNZUoD2uwrDdkXGDmoW3QMyC8pjLCNohdvdgTqoaAx8eGezClGgZmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=dBTUuHE7; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="dBTUuHE7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=ynhD031oOOhISCeOF4gi9TxV/Tn9AXmI3UK6Fm/q0Wg=; t=1757023428;
	x=1757628228; b=dBTUuHE7ucgrz1NpBct1ETYDrN10dA7n1CZR8zLl7TLRWdGKxOkPK3H8OOJ+E
	Z1I3kkq6jze3Lxr7xABc4sGWI303PJlBikPKYcd5JBj3ANHRGIZKBD50pn0j7ZS/gg0y5a4bfOfFF
	x1eQNPLHkUME3m0PPP62sRjcEnExkZDcNOUfH0/J8QwEF6elBhhycvT5A1yVzUjMHgpPukIq0Zhug
	vtnDnOUyrG/YbYCpS3iGYEd1qAMjaSzrD82xhz07IqICJYefIv4Mm4E7gbQgFH7ghQ1Zzkb5I+H2R
	4gPBXC5yDQG+aCph5bkIvH+kMWYHe6b5i43u+TsChuJWt2xexA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1uuI3W-00000000z8I-1nyk; Fri, 05 Sep 2025 00:03:46 +0200
Received: from 89-103-142-46.pool.kielnet.net ([46.142.103.89] helo=Geist14.)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <kernel@mkarcher.dialup.fu-berlin.de>)
          id 1uuI3W-00000002DJL-0tSn; Fri, 05 Sep 2025 00:03:46 +0200
From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Date: Fri, 05 Sep 2025 00:03:34 +0200
Subject: [PATCH v4 5/5] sparc: fix accurate exception reporting in
 copy_{from,to}_user for M7
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-memcpy_series-v4-5-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
References: <20250905-memcpy_series-v4-0-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
In-Reply-To: <20250905-memcpy_series-v4-0-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
To: Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Anthony Yznaga <anthony.yznaga@oracle.com>, 
 Tony Rodriguez <unixpro1970@gmail.com>
X-Mailer: b4 0.14.2
X-Original-Sender: kernel@mkarcher.dialup.fu-berlin.de
X-ZEDAT-Hint: PO

The referenced commit introduced exception handlers on user-space memory
references in copy_from_user and copy_to_user. These handlers return from
the respective function and calculate the remaining bytes left to copy
using the current register contents. This commit fixes a couple of bad
calculations. This will fix the return value of copy_from_user and
copy_to_user in the faulting case. The behaviour of memcpy stays unchanged.

Fixes: 34060b8fffa7 ("arch/sparc: Add accurate exception reporting in M7memcpy")
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> # on Oracle SPARC S7
Tested-by: Tony Rodriguez <unixpro1970@gmail.com> # S7, see https://lore.kernel.org/r/98564e2e68df2dda0e00c67a75c7f7dfedb33c7e.camel@physik.fu-berlin.de
Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
---
 arch/sparc/lib/M7memcpy.S     | 20 ++++++++++----------
 arch/sparc/lib/Memcpy_utils.S |  9 +++++++++
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/lib/M7memcpy.S b/arch/sparc/lib/M7memcpy.S
index cbd42ea7c3f7c25a369536eaf8d0b28a808ae5ba..99357bfa8e82ad7cf15dfd04117c89b905082f5b 100644
--- a/arch/sparc/lib/M7memcpy.S
+++ b/arch/sparc/lib/M7memcpy.S
@@ -696,16 +696,16 @@ FUNC_NAME:
 	EX_LD_FP(LOAD(ldd, %o4+40, %f26), memcpy_retl_o2_plus_o5_plus_40)
 	faligndata %f24, %f26, %f10
 	EX_ST_FP(STORE(std, %f6, %o0+24), memcpy_retl_o2_plus_o5_plus_40)
-	EX_LD_FP(LOAD(ldd, %o4+48, %f28), memcpy_retl_o2_plus_o5_plus_40)
+	EX_LD_FP(LOAD(ldd, %o4+48, %f28), memcpy_retl_o2_plus_o5_plus_32)
 	faligndata %f26, %f28, %f12
-	EX_ST_FP(STORE(std, %f8, %o0+32), memcpy_retl_o2_plus_o5_plus_40)
+	EX_ST_FP(STORE(std, %f8, %o0+32), memcpy_retl_o2_plus_o5_plus_32)
 	add	%o4, 64, %o4
-	EX_LD_FP(LOAD(ldd, %o4-8, %f30), memcpy_retl_o2_plus_o5_plus_40)
+	EX_LD_FP(LOAD(ldd, %o4-8, %f30), memcpy_retl_o2_plus_o5_plus_24)
 	faligndata %f28, %f30, %f14
-	EX_ST_FP(STORE(std, %f10, %o0+40), memcpy_retl_o2_plus_o5_plus_40)
-	EX_ST_FP(STORE(std, %f12, %o0+48), memcpy_retl_o2_plus_o5_plus_40)
+	EX_ST_FP(STORE(std, %f10, %o0+40), memcpy_retl_o2_plus_o5_plus_24)
+	EX_ST_FP(STORE(std, %f12, %o0+48), memcpy_retl_o2_plus_o5_plus_16)
 	add	%o0, 64, %o0
-	EX_ST_FP(STORE(std, %f14, %o0-8), memcpy_retl_o2_plus_o5_plus_40)
+	EX_ST_FP(STORE(std, %f14, %o0-8), memcpy_retl_o2_plus_o5_plus_8)
 	fsrc2	%f30, %f14
 	bgu,pt	%xcc, .Lunalign_sloop
 	 prefetch [%o4 + (8 * BLOCK_SIZE)], 20
@@ -728,7 +728,7 @@ FUNC_NAME:
 	add	%o4, 8, %o4
 	faligndata %f0, %f2, %f16
 	subcc	%o5, 8, %o5
-	EX_ST_FP(STORE(std, %f16, %o0), memcpy_retl_o2_plus_o5)
+	EX_ST_FP(STORE(std, %f16, %o0), memcpy_retl_o2_plus_o5_plus_8)
 	fsrc2	%f2, %f0
 	bgu,pt	%xcc, .Lunalign_by8
 	 add	%o0, 8, %o0
@@ -772,7 +772,7 @@ FUNC_NAME:
 	subcc	%o5, 0x20, %o5
 	EX_ST(STORE(stx, %o3, %o0 + 0x00), memcpy_retl_o2_plus_o5_plus_32)
 	EX_ST(STORE(stx, %g2, %o0 + 0x08), memcpy_retl_o2_plus_o5_plus_24)
-	EX_ST(STORE(stx, %g7, %o0 + 0x10), memcpy_retl_o2_plus_o5_plus_24)
+	EX_ST(STORE(stx, %g7, %o0 + 0x10), memcpy_retl_o2_plus_o5_plus_16)
 	EX_ST(STORE(stx, %o4, %o0 + 0x18), memcpy_retl_o2_plus_o5_plus_8)
 	bne,pt	%xcc, 1b
 	 add	%o0, 0x20, %o0
@@ -804,12 +804,12 @@ FUNC_NAME:
 	brz,pt	%o3, 2f
 	 sub	%o2, %o3, %o2
 
-1:	EX_LD(LOAD(ldub, %o1 + 0x00, %g2), memcpy_retl_o2_plus_g1)
+1:	EX_LD(LOAD(ldub, %o1 + 0x00, %g2), memcpy_retl_o2_plus_o3)
 	add	%o1, 1, %o1
 	subcc	%o3, 1, %o3
 	add	%o0, 1, %o0
 	bne,pt	%xcc, 1b
-	 EX_ST(STORE(stb, %g2, %o0 - 0x01), memcpy_retl_o2_plus_g1_plus_1)
+	 EX_ST(STORE(stb, %g2, %o0 - 0x01), memcpy_retl_o2_plus_o3_plus_1)
 2:
 	and	%o1, 0x7, %o3
 	brz,pn	%o3, .Lmedium_noprefetch_cp
diff --git a/arch/sparc/lib/Memcpy_utils.S b/arch/sparc/lib/Memcpy_utils.S
index 64fbac28b3db18864b0d067acaee0d7898feec7a..207343367bb2daa41a70398e20ef271116423b38 100644
--- a/arch/sparc/lib/Memcpy_utils.S
+++ b/arch/sparc/lib/Memcpy_utils.S
@@ -137,6 +137,15 @@ ENTRY(memcpy_retl_o2_plus_63_8)
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, 8, %o0
 ENDPROC(memcpy_retl_o2_plus_63_8)
+ENTRY(memcpy_retl_o2_plus_o3)
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %o3, %o0
+ENDPROC(memcpy_retl_o2_plus_o3)
+ENTRY(memcpy_retl_o2_plus_o3_plus_1)
+	add	%o3, 1, %o3
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %o3, %o0
+ENDPROC(memcpy_retl_o2_plus_o3_plus_1)
 ENTRY(memcpy_retl_o2_plus_o5)
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %o5, %o0

-- 
2.50.1

