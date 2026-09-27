Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D239C3C1D79;
	Sun, 27 Sep 2026 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790544566; cv=none; b=F/Nz77rfPe04+53h8Kl1R0CNFJOoFr6EqQ2nE4jmdzFdyEyWABtDYWE4UL0VwaK3zNAitAbLzy5C/pjr8+Aup2Qhq7P2OuaUP+G8Iq1A2iMQYBmm4vzWYVgh/9Ji1Lc3mRpycJO3ncpvzT+1e9wFLlk/NMxBW0MQzhkTMxwgb+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790544566; c=relaxed/simple;
	bh=bBKmg9pfb9+mY+zGrrcQx1bEdEyz6obAHAVPXKZ1bYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/x6+JF2vu8gE9/L3+lRIpHxjL9NqRC5JZR4T64ody3VJg1rJMnDxhWpw5N8lYmpx2i3odxGBEWLOpNi9LKfEOCKm4WDxTEMGPCEI/rbMb3h0lJsQAYcdFckzWVY55pmhbRL42fHrEttc5SW9jYTvv7+THmfy7rb3/G+3E1M2eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=mYKLOotG; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="mYKLOotG"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790544556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48HM4bSYyLxI5mQ/j1bJS2K0qEiIi3K5cN3OT/yJ0AA=;
	b=mYKLOotG91oDjmjKbbI3m6qjn40AHrLh3CFuTuebw/p49etBsJvknYMNw9GaYiQPSGAtdl
	F7FGAgRvUhMuCQcth4Ymu3JM0dj5xEIGW9rpLbtcqk1NjNivaYeqvSj5ZsWln7p5wPQ8gQ
	WK02V9NLpFphJ5NFJ/x1Fp2BQnl1LKY=
To: andreas@gaisler.com,
	davem@davemloft.net,
	sparclinux@vger.kernel.org
Cc: Stian Halseth <stian@itx.no>,
	linux-kernel@vger.kernel.org,
	david.laight.linux@gmail.com,
	glaubitz@physik.fu-berlin.de,
	thuth@redhat.com,
	regressions@lists.linux.dev,
	nroach44@nroach44.id.au,
	kaloz@kernel.org,
	unixpro1970@gmail.com
Subject: [PATCH v3 2/2] sparc64: remove dead THREAD_SIZE branches for non-8K pages
Date: Sun, 27 Sep 2026 23:29:01 +0200
Message-ID: <20260927212913.3237082-2-stian@itx.no>
In-Reply-To: <20260927212913.3237082-1-stian@itx.no>
References: <20260927204912.3667-1-kaloz@kernel.org>
 <20260927212913.3237082-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 15b9350a177b ("sparc64: Only support 4MB huge pages and 8KB
base pages.") made 8K the only base page size, so PAGE_SHIFT is
always 13 here and the else branches have been dead since. Remove
them.

Fixes: 15b9350a177b ("sparc64: Only support 4MB huge pages and 8KB base pages.")
Suggested-by: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Stian Halseth <stian@itx.no>
---
 arch/sparc/include/asm/thread_info_64.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
--- a/arch/sparc/include/asm/thread_info_64.h
+++ b/arch/sparc/include/asm/thread_info_64.h
@@ -99,13 +99,8 @@
 #define FAULT_CODE_BLKCOMMIT	0x10	/* Use blk-commit ASI in copy_page */
 #define	FAULT_CODE_BAD_RA	0x20	/* Bad RA for sun4v		   */
 
-#if PAGE_SHIFT == 13
 #define THREAD_SIZE (4*PAGE_SIZE)
 #define THREAD_SHIFT (PAGE_SHIFT + 2)
-#else /* PAGE_SHIFT == 13 */
-#define THREAD_SIZE PAGE_SIZE
-#define THREAD_SHIFT PAGE_SHIFT
-#endif /* PAGE_SHIFT == 13 */
 
 /*
  * macros/functions for gaining access to the thread information structure
@@ -128,11 +123,7 @@
 #endif
 
 /* thread information allocation */
-#if PAGE_SHIFT == 13
 #define THREAD_SIZE_ORDER	2
-#else /* PAGE_SHIFT == 13 */
-#define THREAD_SIZE_ORDER	0
-#endif /* PAGE_SHIFT == 13 */
 
 #define __thread_flag_byte_ptr(ti)	\
 	((unsigned char *)(&((ti)->flags)))
--
2.53.0
