Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4511130AD14;
	Tue, 26 Aug 2025 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224215; cv=none; b=UI7fPIxAStJyj5kFwWHYhsHBNyifjo8QVyWk1wJl5flFJwvAPR1OOLooBvi4v6NV+GMzmS+jn88LnwQmkEl/dykFy05SS43KjcG235vXyLfgEPmO7wSZFR4W71sFQeH8pI96SGtnbEwta7+ITey9dS+PByPer6xf+60sdxPPh7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224215; c=relaxed/simple;
	bh=EKPBJd2+pjA3sGUftf53mFuAwfhWqrtU/pNTzZPTXv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvWvrid/FHoPnX5eSnhm9gpihc0JuEz2wnetbjEEsblwqbd3cEdKbBneXYawrCmtEYbF4oDu74/7qq+kx1zQahKOvSkNlCyBQSdBWFEDp1GMCVCtrPmRPRzmjxoyKG7WyewBiJUmYN4iAHzqRSQd5Du1q0y/+OvcLEZbuJ17giM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=FZBPKk1O; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="FZBPKk1O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=q9U+uS5D7BYowZdn8R7R4pjosfssGQgmqsZEUqlSmzA=; t=1756224211; x=1756829011; 
	b=FZBPKk1Ol4oBtVPwricXJOfwBh13NeW7r17UA4uGNCBYhiMNFpuZF4LGJucS7fL+7Q4JqME8PQA
	Wo8wT9C3iWoFrgwBE9gDI9i9luRPPJOJ6a5wKO/6ijNgZYohi2j2pLk5Tgp7GAUPhtBWpJu76S/Gc
	E8jaw6a81tsEMhQRmQVITcNaPcLeQ8vc8aqxCrE+iVhYWH2kDURdbpjAfB9F7rWFmSbhbqgpejpKH
	+qsDC7fP5Di51Mb0daFLoryAwjckRKxfWL0tAvLNGKK/f1nvwskK6VBm9O7Vw7aTW5V1+3h7Hl1mz
	LAP6wKjvZmsacEMZBWym4iAzQPdfMUT9SqyA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1uqw8p-00000000x5w-3Voi; Tue, 26 Aug 2025 18:03:23 +0200
Received: from [89.57.34.174] (helo=Geist14)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <kernel@mkarcher.dialup.fu-berlin.de>)
          id 1uqw8p-00000000c5y-2YNS; Tue, 26 Aug 2025 18:03:23 +0200
From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org,
	Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
	Andreas Larsson <andreas@gaisler.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [PATCH 2/4] sparc: fix accurate exception reporting in copy_{from_to}_user for UltraSPARC III
Date: Tue, 26 Aug 2025 18:03:04 +0200
Message-ID: <20250826160312.2070-3-kernel@mkarcher.dialup.fu-berlin.de>
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

Based on a finding by Anthony Yznaga that the UltraSPARC III copy_from_user
returns invalid values breaking other parts of the kernel in case of a
fault, while the generic implementation is correct.

Fixes: ee841d0aff64 ("sparc64: Convert U3copy_{from,to}_user to accurate exception reporting.")
Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
---
 arch/sparc/lib/U3memcpy.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/lib/U3memcpy.S b/arch/sparc/lib/U3memcpy.S
index 9248d59c734c..bace3a18f836 100644
--- a/arch/sparc/lib/U3memcpy.S
+++ b/arch/sparc/lib/U3memcpy.S
@@ -267,6 +267,7 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	faligndata	%f10, %f12, %f26
 	EX_LD_FP(LOAD(ldd, %o1 + 0x040, %f0), U3_retl_o2)
 
+	and		%o2, 0x3f, %o2
 	subcc		GLOBAL_SPARE, 0x80, GLOBAL_SPARE
 	add		%o1, 0x40, %o1
 	bgu,pt		%XCC, 1f
@@ -336,7 +337,6 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	 * Also notice how this code is careful not to perform a
 	 * load past the end of the src buffer.
 	 */
-	and		%o2, 0x3f, %o2
 	andcc		%o2, 0x38, %g2
 	be,pn		%XCC, 2f
 	 subcc		%g2, 0x8, %g2
-- 
2.50.1

