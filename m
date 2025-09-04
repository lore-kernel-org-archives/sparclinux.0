Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF302DCC01;
	Thu,  4 Sep 2025 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023431; cv=none; b=COg6Km0AsyEDtUy2S2aNiJWmcL4S089ZGAJO6LnNK+sjzPQn1LBfGYuxZ8OZyoA8mxNRSgKU4vgcsLCGH43h0kG5cl8XGgiynrZkpoh0zzG5vHnmrPG7PIiUPd1PYciBCaMc9t857dBTtMrlO7dKAoBBFVAu6yDei27/N4rNcFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023431; c=relaxed/simple;
	bh=QtVN/GMHSSb9w9VpTzrkw/gk9ca/xQOgBwqNNorvZ0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uD1xeVo4h2uxvFa/qtCplt/1BgjR37rkEv7yQojqwjWwXCrBZfFjKmcY70Hlc5w3PZC6ft2fFBCvGfrp08Swh9wx+ucx17wehNq7LU95WLAdZ1EJIdwMwRt2F/gvGwyYSA2Y5d7l1iNsd7En/hCoG2XMHUo4ZEfREqcdeKJOPK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=UrXcY0nq; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="UrXcY0nq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=IYiVxWwna+8Kvhv7FawMeNPbAEbRP/5KT0vIiVIVjnA=; t=1757023427;
	x=1757628227; b=UrXcY0nqu68UlGwE4/DJ4GlkE7eT7l/lPHfmIK74EWUCCEIkk9uAMiZpo/wZc
	dpPWZFUJq5SVY++YOR7oqj7AM0SrSv0rfRYfUZr4GyVTVmzZRbKme0Lr2M0gxsAZPc2pdgvWmvJ51
	KePXQGoqKe4wFPktvnMjI80LvzYScPdutjvuCFHIR6hHCIpcEaJeD+IotpUo+gSx71EMhuMLwAPV+
	sp4L3Kkt/Pel0jgNh8VeJSFA2mlOojc1/QFF1ZqCmPJDIZGXp/FLdAvB2/07FjagIBva1GosTJxj8
	ag74QU8nJZAdsjK0PrWxf0ZAyaCkh8dbg3lsFRNR3p+XIbvCdw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1uuI3V-00000000z7m-3B7t; Fri, 05 Sep 2025 00:03:45 +0200
Received: from 89-103-142-46.pool.kielnet.net ([46.142.103.89] helo=Geist14.)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <kernel@mkarcher.dialup.fu-berlin.de>)
          id 1uuI3V-00000002DJL-2WbV; Fri, 05 Sep 2025 00:03:45 +0200
From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Date: Fri, 05 Sep 2025 00:03:32 +0200
Subject: [PATCH v4 3/5] sparc: fix accurate exception reporting in
 copy_{from_to}_user for Niagara
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-memcpy_series-v4-3-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
References: <20250905-memcpy_series-v4-0-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
In-Reply-To: <20250905-memcpy_series-v4-0-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
To: Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Anthony Yznaga <anthony.yznaga@oracle.com>, 
 Magnus Lindholm <linmag7@gmail.com>
X-Mailer: b4 0.14.2
X-Original-Sender: kernel@mkarcher.dialup.fu-berlin.de
X-ZEDAT-Hint: PO

The referenced commit introduced exception handlers on user-space memory
references in copy_from_user and copy_to_user. These handlers return from
the respective function and calculate the remaining bytes left to copy
using the current register contents. This commit fixes a couple of bad
calculations and a broken epilogue in the exception handlers. This will
prevent crashes and ensure correct return values of copy_from_user and
copy_to_user in the faulting case. The behaviour of memcpy stays unchanged.

Fixes: 7ae3aaf53f16 ("sparc64: Convert NGcopy_{from,to}_user to accurate exception reporting.")
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> # on SPARC T4 with modified kernel to use Niagara 1 code
Tested-by: Magnus Lindholm <linmag7@gmail.com> # on Sun Fire T2000
Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
---
 arch/sparc/lib/NGmemcpy.S | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/lib/NGmemcpy.S b/arch/sparc/lib/NGmemcpy.S
index ee51c12306894eee4195887d2b28b2619f63c2b1..bbd3ea0a64822c7410278fcc3d101ce9cef96c89 100644
--- a/arch/sparc/lib/NGmemcpy.S
+++ b/arch/sparc/lib/NGmemcpy.S
@@ -79,8 +79,8 @@
 #ifndef EX_RETVAL
 #define EX_RETVAL(x)	x
 __restore_asi:
-	ret
 	wr	%g0, ASI_AIUS, %asi
+	ret
 	 restore
 ENTRY(NG_ret_i2_plus_i4_plus_1)
 	ba,pt	%xcc, __restore_asi
@@ -125,15 +125,16 @@ ENTRY(NG_ret_i2_plus_g1_minus_56)
 	ba,pt	%xcc, __restore_asi
 	 add	%i2, %g1, %i0
 ENDPROC(NG_ret_i2_plus_g1_minus_56)
-ENTRY(NG_ret_i2_plus_i4)
+ENTRY(NG_ret_i2_plus_i4_plus_16)
+        add     %i4, 16, %i4
 	ba,pt	%xcc, __restore_asi
 	 add	%i2, %i4, %i0
-ENDPROC(NG_ret_i2_plus_i4)
-ENTRY(NG_ret_i2_plus_i4_minus_8)
-	sub	%i4, 8, %i4
+ENDPROC(NG_ret_i2_plus_i4_plus_16)
+ENTRY(NG_ret_i2_plus_i4_plus_8)
+	add	%i4, 8, %i4
 	ba,pt	%xcc, __restore_asi
 	 add	%i2, %i4, %i0
-ENDPROC(NG_ret_i2_plus_i4_minus_8)
+ENDPROC(NG_ret_i2_plus_i4_plus_8)
 ENTRY(NG_ret_i2_plus_8)
 	ba,pt	%xcc, __restore_asi
 	 add	%i2, 8, %i0
@@ -160,6 +161,12 @@ ENTRY(NG_ret_i2_and_7_plus_i4)
 	ba,pt	%xcc, __restore_asi
 	 add	%i2, %i4, %i0
 ENDPROC(NG_ret_i2_and_7_plus_i4)
+ENTRY(NG_ret_i2_and_7_plus_i4_plus_8)
+	and	%i2, 7, %i2
+	add	%i4, 8, %i4
+	ba,pt	%xcc, __restore_asi
+	 add	%i2, %i4, %i0
+ENDPROC(NG_ret_i2_and_7_plus_i4)
 #endif
 
 	.align		64
@@ -405,13 +412,13 @@ FUNC_NAME:	/* %i0=dst, %i1=src, %i2=len */
 	andn		%i2, 0xf, %i4
 	and		%i2, 0xf, %i2
 1:	subcc		%i4, 0x10, %i4
-	EX_LD(LOAD(ldx, %i1, %o4), NG_ret_i2_plus_i4)
+	EX_LD(LOAD(ldx, %i1, %o4), NG_ret_i2_plus_i4_plus_16)
 	add		%i1, 0x08, %i1
-	EX_LD(LOAD(ldx, %i1, %g1), NG_ret_i2_plus_i4)
+	EX_LD(LOAD(ldx, %i1, %g1), NG_ret_i2_plus_i4_plus_16)
 	sub		%i1, 0x08, %i1
-	EX_ST(STORE(stx, %o4, %i1 + %i3), NG_ret_i2_plus_i4)
+	EX_ST(STORE(stx, %o4, %i1 + %i3), NG_ret_i2_plus_i4_plus_16)
 	add		%i1, 0x8, %i1
-	EX_ST(STORE(stx, %g1, %i1 + %i3), NG_ret_i2_plus_i4_minus_8)
+	EX_ST(STORE(stx, %g1, %i1 + %i3), NG_ret_i2_plus_i4_plus_8)
 	bgu,pt		%XCC, 1b
 	 add		%i1, 0x8, %i1
 73:	andcc		%i2, 0x8, %g0
@@ -468,7 +475,7 @@ FUNC_NAME:	/* %i0=dst, %i1=src, %i2=len */
 	subcc		%i4, 0x8, %i4
 	srlx		%g3, %i3, %i5
 	or		%i5, %g2, %i5
-	EX_ST(STORE(stx, %i5, %o0), NG_ret_i2_and_7_plus_i4)
+	EX_ST(STORE(stx, %i5, %o0), NG_ret_i2_and_7_plus_i4_plus_8)
 	add		%o0, 0x8, %o0
 	bgu,pt		%icc, 1b
 	 sllx		%g3, %g1, %g2

-- 
2.50.1

