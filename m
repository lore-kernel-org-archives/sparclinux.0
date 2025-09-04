Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B387F350831;
	Thu,  4 Sep 2025 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023430; cv=none; b=qnwBbWumyH36Z1Y6pKc2WAahn/XBqz/hF7kflXJL1r0aIfcIIR1CK9s3UFM1VGGyS9kpjuMtHZMUvh2IB7pTyrXiWBvi+u3Ehn93sBS0zaRWrN9qR5AbaXhvoDTpI6B3DNHJdyKdV/Xjvlz6PmUPL4HOrMRp//7EwipJotquLyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023430; c=relaxed/simple;
	bh=rD4x0h/JSnsqB7FA7HTHUlXh8b5LT3tMJgE+s0fXksY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GUsFx6ouVLUNZ3NUh+6/u7NSB9Q5t3ZJWYe9Dl/v9RbWm0iogSEWgvJp9AewCvSXcHC/ivdQmLhsyDUQFKwpmRStI+a5CeyF7D2JeMz4OMyMdGg6uexV8Zr5BlXrTf6lmhdi4BG5oDSUedCqHjxMR7mGnKdJFqLBQS7Sd7EeuEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=UKTIawHu; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="UKTIawHu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=+a5Reh5uOF4/k5y2gbhtTkugxhhSb76hiC5ZGvwQraI=; t=1757023427;
	x=1757628227; b=UKTIawHuYmvDFxUtsHhXmPsNu332lue1UaB/6AHgICUnFHjV5x63FJcexWp0+
	/ccLJw1/A4DQAoOhY8x9yZSsX6Jy0/otBtTIgpqyEaSnqX0iv5ReZL2B2OfQm8P9zTEQ6BEEE7st0
	LPhBoZsz0XePAvD7FSv7KOMwrPuN9gG5Xsuzd3jYnKcT83GWuFzSvboha16qmGzRSPmUJrOJ+bpe9
	qUv3sxhcttL+VOX+5T5AIqIZqTOrgBfrWz5GNUGC5XmcY+uzxciVpmwQBj/IhI/hENiAcQ18FKJrz
	pSq1jEGoNUay/pjQEYQTW1weQGR7bq/QB+WM579Lr9FOpbZVKg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1uuI3W-00000000z85-09Vj; Fri, 05 Sep 2025 00:03:46 +0200
Received: from 89-103-142-46.pool.kielnet.net ([46.142.103.89] helo=Geist14.)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <kernel@mkarcher.dialup.fu-berlin.de>)
          id 1uuI3V-00000002DJL-3WUK; Fri, 05 Sep 2025 00:03:45 +0200
From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Date: Fri, 05 Sep 2025 00:03:33 +0200
Subject: [PATCH v4 4/5] sparc: fix accurate exception reporting in
 copy_to_user for Niagara 4
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-memcpy_series-v4-4-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
References: <20250905-memcpy_series-v4-0-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
In-Reply-To: <20250905-memcpy_series-v4-0-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
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

