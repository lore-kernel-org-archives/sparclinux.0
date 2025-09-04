Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3AE1C6FE8;
	Thu,  4 Sep 2025 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014234; cv=none; b=pibhJogScHlw3bymdOcpNYVXxi5hTQuLEoITI1IFLcdVQTHiXHqbE/GdxPuB/DzmVWdSeJT3nQR1EXaSpRHLm8IfbBb4n6FA8xCIj9270cUb86w9WU1DRyVW7BfjG3PJl2tTv5M0cm0HcgKIB5zw4AhXvzq8EztUHr6lIZwHyxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014234; c=relaxed/simple;
	bh=WqcDo6tdhzDxNEaRlGwvJ/3NEtjIz7qn2K6+WOAmmH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VTWatyDI1/HRvaD4tL6/OlFzleVYBbXAbUGrBBOq/8nw/0cQn2gYeHEIKUBRoQu43QSKLgM7WKER4NnsaUH1kK0uNP3owZmzMSqv+WxvVDKg/yMyhtv0urEbQUCp4T/ACyobw4kK8UdaslvH6ilzYsuglGH7IxaexZULrgOUyCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=XhNizlvc; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="XhNizlvc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=c/smPJ5cqqeUFArcOKPQwnin0Vhj5pge1Y5vI9zqoBA=; t=1757014230;
	x=1757619030; b=XhNizlvcr10XZttS0mhW/UYghgX+CfITpJ4UPIQEZRLBAFl22A1b+ZDP+fKsI
	IoTfP4Ys/AaIFKBuTadlXINr9h8TVvNGLcTYFcy2Eltb8H8jnwou/INteBxse8u8oiPg7/37U4OzF
	tqdB4SNPJRsDcv+WzC+twe28kXKaU31r0Kn2mt2rekCwVwxsPa3tHbqNQOkUlPem0cKf9RKGS/3kQ
	vK6g0Dwz2NoNUozG1zEo8ZRQxtUcpFDwglL3wFjGQphmuSKNpXfdMzVh3we2cwMSaujKu0k5bAFTn
	yZd11v6vvavk85RcrjiqGu6HSWv+PPDbs0/67e15gRiTgrLuHQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1uuFfA-00000000UBF-2HCr; Thu, 04 Sep 2025 21:30:28 +0200
Received: from 89-103-142-46.pool.kielnet.net ([46.142.103.89] helo=Geist14.)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <kernel@mkarcher.dialup.fu-berlin.de>)
          id 1uuFfA-00000001eLL-1OBO; Thu, 04 Sep 2025 21:30:28 +0200
From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Date: Thu, 04 Sep 2025 21:29:53 +0200
Subject: [PATCH v3 1/5] sparc: fix accurate exception reporting in
 copy_{from_to}_user for UltraSPARC
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250904-memcpy_series-v3-1-906655a5a7ad@mkarcher.dialup.fu-berlin.de>
References: <20250904-memcpy_series-v3-0-906655a5a7ad@mkarcher.dialup.fu-berlin.de>
In-Reply-To: <20250904-memcpy_series-v3-0-906655a5a7ad@mkarcher.dialup.fu-berlin.de>
To: Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Anthony Yznaga <anthony.yznaga@oracle.com>, 
 =?utf-8?q?Ren=C3=A9_Rebe?= <rene@exactcode.com>, 
 Jonathan 'theJPster' Pallant <kernel@thejpster.org.uk>
X-Mailer: b4 0.14.2
X-Original-Sender: kernel@mkarcher.dialup.fu-berlin.de
X-ZEDAT-Hint: PO

The referenced commit introduced exception handlers on user-space memory
references in copy_from_user and copy_to_user. These handlers return from
the respective function and calculate the remaining bytes left to copy
using the current register contents. This commit fixes a couple of bad
calculations. This will fix the return value of copy_from_user and
copy_to_user in the faulting case. The behaviour of memcpy stays unchanged.

Fixes: cb736fdbb208 ("sparc64: Convert U1copy_{from,to}_user to accurate exception reporting.")
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> # on QEMU 10.0.3
Tested-by: René Rebe <rene@exactcode.com> # on Ultra 5 UltraSparc IIi
Tested-by: Jonathan 'theJPster' Pallant <kernel@thejpster.org.uk> # on Sun Netra T1
Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
---
 arch/sparc/lib/U1memcpy.S | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/lib/U1memcpy.S b/arch/sparc/lib/U1memcpy.S
index 635398ec7540ee3d344151ddc4c6f07ad41e11f9..154fbd35400ca8fe547c222d26aec18f46fcb1d2 100644
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

