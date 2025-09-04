Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D0F22D4C8;
	Thu,  4 Sep 2025 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014233; cv=none; b=MxaV6tfszTkACyQTWEe9qxLqq105YbSdVZjpBZBGwG9WbmNYJat4O3RrSDSe8gt5KsdwFNC0XpH2yPtUY2GOKRbsU16j6DHKYzpDLTTSfyg1or9Cmq2N6HKumDfJPZ6XTd3kgB8ic0MHLlsrcmQF5N793WvtpzvKHxypExhp8xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014233; c=relaxed/simple;
	bh=rD4x0h/JSnsqB7FA7HTHUlXh8b5LT3tMJgE+s0fXksY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a5U0G+vq9XTIN44G/QD8yVe5j/7o7i9qFXij1IcHGz1nyQaVTpKpe4JlBuB3sUxnSSAmnKetnC8nCdUlEayBG+6PiNNbN2L/pzaf4kHbLjFrz56PaV/nNPPukWH4hl+pX4NiLMucuOAXR243Jb7/IomPDxDPDbndxXYxKzl+wF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=KRSVNj2P; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="KRSVNj2P"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=+a5Reh5uOF4/k5y2gbhtTkugxhhSb76hiC5ZGvwQraI=; t=1757014231;
	x=1757619031; b=KRSVNj2PgrTpin+5A0pm6ArfUQ2O2IOcyJsW/gK8u7tVgzf2Ss79noudsuvrF
	Hm2RwnTiGaUHsP7n5SpSMbXIdcm4X1nm2ICw7JBFfV+btDRoUDydSP2H3McW/Ld3/eBRVO+rcWgpl
	iKACVa/b4PH1J5RUAmKwBd5MYdcGzStEiQ74DRL4f6bs8atp8CawC6k7ySx2uCapChfbV225pwoKp
	htkGZoki0xgP87hkTGBAt9Gm+TipbrdZb5jJSIXA+JhFI72HmVu6UZFrasePbJ00h0s1gXWLEAEjF
	EDU3zGGWSRB4iKPamkjk2tgEotwjrOb3iMeHXvFyjv8GTzZ2Ug==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1uuFfB-00000000UC4-2CKb; Thu, 04 Sep 2025 21:30:29 +0200
Received: from 89-103-142-46.pool.kielnet.net ([46.142.103.89] helo=Geist14.)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <kernel@mkarcher.dialup.fu-berlin.de>)
          id 1uuFfB-00000001eLL-1JqZ; Thu, 04 Sep 2025 21:30:29 +0200
From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Date: Thu, 04 Sep 2025 21:29:56 +0200
Subject: [PATCH v3 4/5] sparc: fix accurate exception reporting in
 copy_to_user for Niagara 4
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-memcpy_series-v3-4-906655a5a7ad@mkarcher.dialup.fu-berlin.de>
References: <20250904-memcpy_series-v3-0-906655a5a7ad@mkarcher.dialup.fu-berlin.de>
In-Reply-To: <20250904-memcpy_series-v3-0-906655a5a7ad@mkarcher.dialup.fu-berlin.de>
To: Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Anthony Yznaga <anthony.yznaga@oracle.com>
X-Mailer: b4 0.14.2
X-Original-Sender: kernel@mkarcher.dialup.fu-berlin.de
X-ZEDAT-Hint: PO

The referenced commit introduced exception handlers on user-space memory
references in copy_from_user and copy_to_user. These handlers return from
the respective function and calculate the remaining bytes left to copy
using the current register contents. This commit fixes a bad calculation.
This will fix the return value of copy_to_user in a specific faulting case.
The behaviour of memcpy stays unchanged.

Fixes: 957077048009 ("sparc64: Convert NG4copy_{from,to}_user to accurate exception reporting.")
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> # on Oracle SPARC T4-1
Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
---
 arch/sparc/lib/NG4memcpy.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/lib/NG4memcpy.S b/arch/sparc/lib/NG4memcpy.S
index 7ad58ebe0d0096ffce4a9a333eb9cc7113c065fe..df0ec1bd194892974899e15dfc0248bb6ebdecf2 100644
--- a/arch/sparc/lib/NG4memcpy.S
+++ b/arch/sparc/lib/NG4memcpy.S
@@ -281,7 +281,7 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	subcc		%o5, 0x20, %o5
 	EX_ST(STORE(stx, %g1, %o0 + 0x00), memcpy_retl_o2_plus_o5_plus_32)
 	EX_ST(STORE(stx, %g2, %o0 + 0x08), memcpy_retl_o2_plus_o5_plus_24)
-	EX_ST(STORE(stx, GLOBAL_SPARE, %o0 + 0x10), memcpy_retl_o2_plus_o5_plus_24)
+	EX_ST(STORE(stx, GLOBAL_SPARE, %o0 + 0x10), memcpy_retl_o2_plus_o5_plus_16)
 	EX_ST(STORE(stx, %o4, %o0 + 0x18), memcpy_retl_o2_plus_o5_plus_8)
 	bne,pt		%icc, 1b
 	 add		%o0, 0x20, %o0

-- 
2.50.1

