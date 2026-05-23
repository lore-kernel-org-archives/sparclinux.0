Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDA72FD1C2
	for <sparclinux@vger.kernel.org>; Sat, 23 May 2026 04:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779510337; cv=none; b=dgtfHjbxSlW91PkdQZR+iFO37beq9mQl9r32yt1DbhIyOrmZJCTSw+ETqjzeNBiahMBeNRl5+GITw8AXmN+oJSCVdDncIADZqQzP1EoztEs6zSrM3zrvtdj4P6cIUlD4k6alz+iqseRouL2yFXd5iF7BkcEdKvM6AFzlzyOoz0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779510337; c=relaxed/simple;
	bh=uYLe2WUORQihPdLpVglNoB02YF0Q3XQ/wUNwuifNRnc=;
	h=Date:To:From:Subject:Message-Id; b=Fh/J3uhSMnthcr9+45U5QDKatS1tILLEoPB9tF8Gybf0wlsRCTXsXDggGUDc3B0wsluTVK2kmyTAok96t9mRfk9fLZhePoUH0N7yZVGHuA52UXGU7VAAyRIrow1DPq2QW/kB6Fk35evw/9Uke+BbgoMMnR3wjPbaaN78ambTKuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tWlUD0Ic; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tWlUD0Ic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A6B1F000E9;
	Sat, 23 May 2026 04:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779510335;
	bh=00vYFZo4c0NacbXu8VtKku2cvGLqydiY3whlIusUwVg=;
	h=Date:To:From:Subject;
	b=tWlUD0IcfLuzP1W8jJhaU4KPUg4iz25Jf78I8qIRKwBA6SHsTz8290MutQNXPaBOo
	 vgWdQUOefLzciDrJWe2SIOXfMmy16js4Q1hdEsGOnpkJ+XcB96JMknlnT59rKTgO6+
	 qNSVTltgeXfpEtboc8WknySKecQh+Pj5YK/iPMNY=
Date: Fri, 22 May 2026 21:25:35 -0700
To: akpm@linux-foundation.org,sparclinux@vger.kernel.org,davem@davemloft.net,andreas@gaisler.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [patch 1/1] sparc: add _mcount() prototype
Message-Id: <20260523042535.C3A6B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

From: Andrew Morton <akpm@linux-foundation.org>
Subject: sparc: add _mcount() prototype
Date: Fri May 22 09:20:26 PM PDT 2026

sparc64 defconfig told me

WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation failed, symbol will not be versioned.
Is "_mcount" prototyped in <asm/asm-prototypes.h>?

so I added it.

BTW, altering arch/sparc/include/asm/asm-prototypes.h then running `make'
doesn't compile anything, so there's a missing dependency somewhere?

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/sparc/include/asm/asm-prototypes.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/sparc/include/asm/asm-prototypes.h~sparc-add-_mcount-prototype
+++ a/arch/sparc/include/asm/asm-prototypes.h
@@ -25,6 +25,7 @@ void *memcpy(void *dest, const void *src
 void *memset(void *s, int c, size_t n);
 typedef int TItype __attribute__((mode(TI)));
 TItype __multi3(TItype a, TItype b);
+void _mcount(void);
 
 s64 __ashldi3(s64, int);
 s64 __lshrdi3(s64, int);
_
