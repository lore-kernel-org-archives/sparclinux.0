Received: from mailrelay3-1.pub.mailoutpod3-cph3.one.com (mailrelay3-1.pub.mailoutpod3-cph3.one.com [46.30.211.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE5E14A83
	for <sparclinux@vger.kernel.org>; Sun, 24 Mar 2024 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711263458; cv=none; b=E6wAyjySeCj5Ok90d7xyJ5DFEck6HVaXJBdmsehejBMpWFWDfppCuHsgUqMQsMjAl14IHrz6s8ebNGKGt63HC72hobTqv+BRteqBB+cc60Pz84EqbgJab4njTXNIJthyb0AL24pCJSEiwZrJhzHjnMPrSHwgH/7UwaWitA1TIAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711263458; c=relaxed/simple;
	bh=hNhX/E+5OJiG1jMNdsPIR78kDhvi6G6lVvJsWnl66ns=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J9i8F+s/DPAN883NDA/Vvj5Tm1mGkxzkgOVH0OxEMP5j2HN8iMMntBw6N79JYdwpWEbat/LRl6lVR8qKg4JH2CXHnB9mCb1JXqQEITPE1FjtZHVo+33tBThV68ekm6ng9GsjMSPi5LiPU0DHJlHK0L4SlDIkqQvkif6/hbuWDIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=BvnuuTWU; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=2ud3PQ2J; arc=none smtp.client-ip=46.30.211.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="BvnuuTWU";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="2ud3PQ2J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=content-type:mime-version:message-id:subject:to:from:date:from;
	bh=JA1PtlfbrGpGTl3IvxV8e+rHMTkk61JpqpH1uq2fTqg=;
	b=BvnuuTWUTnJ9Nwu5Ly3h99GyLglq/cybWXB+sFF6rZ/4tWoIgdL+24jIBi2bAg+OwZTOt6jSETOj+
	 lHKdiwowxDkG1z1y+ktz2GO7L+xvlTdxCM4hFV1+3JHr3b/45D10U+Tr2yE6xVwki9bACT9tiIImP5
	 65MU/ew1Ofa+NLxtURCaiQBInBq6Ib6id16BnsFg/lXGPhzHNXiEsxOAItmNC5Bg61HPbnv9VaZMid
	 AxI2s5TLwx0V0q3DVmerPgI/OYqTYzhfeiCfHg9mkwm7bYGrEgTrPDh//boXVyWzlRu51En6i8gqAx
	 OoBZoOheBTXtdnDchbty3ji+PR+kIKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=content-type:mime-version:message-id:subject:to:from:date:from;
	bh=JA1PtlfbrGpGTl3IvxV8e+rHMTkk61JpqpH1uq2fTqg=;
	b=2ud3PQ2J8g8lcw27zSvoSALsCJcATJkOjeZkQKTkWfW5ng8ZQ3/aY38lD89fxG0QZSd/E5xFK07IC
	 ihQZSMNAQ==
X-HalOne-ID: 9fa617e7-e9ab-11ee-8086-ff813d2dbafc
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay3.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 9fa617e7-e9ab-11ee-8086-ff813d2dbafc;
	Sun, 24 Mar 2024 06:56:23 +0000 (UTC)
Date: Sun, 24 Mar 2024 07:56:22 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH] sparc32: Fix version generation failed warnings
Message-ID: <20240324065622.GA1032122@ravnborg.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

An allmodconfig build of sparc32 resulted in several warnings:

WARNING: modpost: EXPORT symbol "empty_zero_page" [vmlinux] version generation failed, symbol will not be versioned.
Is "empty_zero_page" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "__udelay" [vmlinux] version generation failed, symbol will not be versioned.
Is "__udelay" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "__ndelay" [vmlinux] version generation failed, symbol will not be versioned.
Is "__ndelay" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "__ashldi3" [vmlinux] version generation failed, symbol will not be versioned.
Is "__ashldi3" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "__ashrdi3" [vmlinux] version generation failed, symbol will not be versioned.
Is "__ashrdi3" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "__lshrdi3" [vmlinux] version generation failed, symbol will not be versioned.
Is "__lshrdi3" prototyped in <asm/asm-prototypes.h>?

And later a lot of warnings like this:
WARNING: modpost: "__udelay" [kernel/locking/locktorture.ko] has no CRC!
WARNING: modpost: "__udelay" [kernel/rcu/rcutorture.ko] has no CRC!
WARNING: modpost: "__udelay" [kernel/rcu/rcuscale.ko] has no CRC!
WARNING: modpost: "__udelay" [kernel/rcu/refscale.ko] has no CRC!
WARNING: modpost: "__ndelay" [kernel/rcu/refscale.ko] has no CRC!
WARNING: modpost: "__udelay" [kernel/time/test_udelay.ko] has no CRC!
WARNING: modpost: "__udelay" [kernel/scftorture.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [fs/quota/quota_tree.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/ext4/ext4.ko] has no CRC!

The fix was, as hinted, to add missing prototypes to asm-prototypes.h.

For the __*di3 functions add the prototypes direct to the
asm-prototypes.h file.
Some of the symbols were already declared, so pulled in the relevant
headers (delay.h, pgtable.h).
The include files was alphabetically sorted to make the list somehow
readable.

The .S files exporting the symbols do not include asm-prototypes.h,
so they need to be explicit rebuild to generate symbol versioning.
One or more of the generic headers pulled in by asm-prototypes.h
did not support being used from .S files, so adding asm-prototypes.h
as an include file was not an option.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>
---

 arch/sparc/include/asm/asm-prototypes.h | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/include/asm/asm-prototypes.h b/arch/sparc/include/asm/asm-prototypes.h
index 4987c735ff56..08810808ca6d 100644
--- a/arch/sparc/include/asm/asm-prototypes.h
+++ b/arch/sparc/include/asm/asm-prototypes.h
@@ -3,15 +3,18 @@
  * Copyright (c) 2017 Oracle and/or its affiliates. All rights reserved.
  */
 
-#include <asm/xor.h>
-#include <asm/checksum.h>
-#include <asm/trap_block.h>
+#include <linux/atomic.h>
 #include <linux/uaccess.h>
+
 #include <asm/atomic.h>
-#include <asm/ftrace.h>
 #include <asm/cacheflush.h>
+#include <asm/checksum.h>
+#include <asm/delay.h>
+#include <asm/ftrace.h>
 #include <asm/oplib.h>
-#include <linux/atomic.h>
+#include <asm/pgtable.h>
+#include <asm/trap_block.h>
+#include <asm/xor.h>
 
 void *__memscan_zero(void *, size_t);
 void *__memscan_generic(void *, int, size_t);
@@ -23,3 +26,7 @@ void *memcpy(void *dest, const void *src, size_t n);
 void *memset(void *s, int c, size_t n);
 typedef int TItype __attribute__((mode(TI)));
 TItype __multi3(TItype a, TItype b);
+
+s64 __ashldi3(s64, int);
+s64 __lshrdi3(s64, int);
+s64 __ashrdi3(s64, int);
-- 
2.34.1

