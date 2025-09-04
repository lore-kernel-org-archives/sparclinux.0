Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA4125A2C9;
	Thu,  4 Sep 2025 18:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012060; cv=none; b=nrnlp1rygGFTqBJcYZh70QiQEL2N2f+vQf01x+GUJkdDNXELVX1HC0gPz2uLFOS5W4N1kkQEbqzUW1U90BhjoULNcB/l0XYR90cZtV/Ct6AuLl5CAdpWEJhgz/rbZ//fsdNgFjOa6B1S61a24d5/Rkq15Uw+S8L0w6CoMRqLqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012060; c=relaxed/simple;
	bh=pvDsEz2grS3ltRmzXPOdKAdpUxQnOswrjzJkaGHrLkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ujxFxgoWyNTXZCQMiEXfrGtPtPFkKrPRAy2Xo4fv/EXEJY9ZNrphJi95qgmc/4bJRO2m635p7ykGgNwU5IpiEsOcfGmNvg60PdbzaowRcIcLP6JexJd86ODRllCq5BzcUwbknewmhsMG9M2i22exj6yDtinbWBRbEYhC1k5EteA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=ag7a/+JC; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="ag7a/+JC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Lcjxx9E6TZo4ykQ21yVSp/K169td2MI0XA5ZX3ldnys=; t=1757012057;
	x=1757616857; b=ag7a/+JCJYVtdqDGIXXaI9FbmCD3bQMy1PG0FKdcZV1GIY2p/0bRJHyl27nlN
	sf1WzEvWcqYQe6eUjaOivnSgbgcdRwNp5DbUQ6HtGcvV3J3rns6vyBbdHAfnPwbHcKMKhVUelz0pM
	n3FyxAOIkvanxJmUTSniA8kZ+DYNLngNBM8cAx5T9ODrqG6J5qaCrM+vuBGoevYZtpD+f26gyELWQ
	9zOQH26iuaXKrc+7sctS5FKqWndQnDxrEcy93Ld+wzd6uVO1ZfmKeEdoTtslvqSrjr7sCgY9LyfiR
	/0rq0EPzsGGT1F54WVDe+whsI/U37DmYsFM7z0aSXBwrOenVoA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1uuF67-00000000Lyb-3RfY; Thu, 04 Sep 2025 20:54:15 +0200
Received: from 89-103-142-46.pool.kielnet.net ([46.142.103.89] helo=Geist14.)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <kernel@mkarcher.dialup.fu-berlin.de>)
          id 1uuF67-00000001W6v-2XqM; Thu, 04 Sep 2025 20:54:15 +0200
From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Date: Thu, 04 Sep 2025 20:53:54 +0200
Subject: [PATCH v2 4/5] sparc: fix accurate exception reporting in
 copy_to_user for Niagara 4
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-memcpy_series-v2-4-9806dd1784e7@mkarcher.dialup.fu-berlin.de>
References: <20250904-memcpy_series-v2-0-9806dd1784e7@mkarcher.dialup.fu-berlin.de>
In-Reply-To: <20250904-memcpy_series-v2-0-9806dd1784e7@mkarcher.dialup.fu-berlin.de>
To: Andreas Larsson <andreas@gaisler.com>, 
 Babu Moger <babu.moger@oracle.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Anthony Yznaga <anthony.yznaga@oracle.com>
X-Mailer: b4 0.14.2
X-Original-Sender: kernel@mkarcher.dialup.fu-berlin.de
X-ZEDAT-Hint: PO

The referenced commit introduced exception handlers on user-space memory
references in copy_from_user and copy_to_user. These handlers return from                                               the respective function and calculate the remaining bytes left to copy
using the current register contents. This commit fixes a bad calculation.
This will fix the return value of copy_to_user in a specific faulting case.
The behaviour of memcpy stays unchanged.

Fixes: 957077048009 ("sparc64: Convert NG4copy_{from,to}_user to accurate exception reporting.")
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
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

