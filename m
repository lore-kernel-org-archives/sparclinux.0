Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA8B2EBDD9;
	Thu,  4 Sep 2025 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023430; cv=none; b=RZ5yW8tlw2vPnlRiWKOAm4Q8dhU0AqAhTnBWToBlZeo7B+Ie07RYjGbbuKJqnDNQPvsr3rP/oa4umEdl5SIHiIOaD0xQQAX6n0yyo/j1w+YImoRUOpU4jjgTxq6m4AFTM/Q5yUO/b50+TKC7nk5180C9Bq6vU+seuj4XN4WfaE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023430; c=relaxed/simple;
	bh=jI2mWtV3yaeSMgzwztwArK6FrK7ypmUX8e5XQckB240=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=spbVofqLURMQaoReD3ztNBMocwvBP+M9iRlDTvCl4NPcE8jvv0kAlibrDhhjecdWb/jCQ6QNHx1FnbGaHvGcC1wOhQUKVkVYEQLs+03YZyyl/sjlPVCkx5h7tMc8wEMWePAD0IrFNwn9agxQOSGNpKzChKbzEFODN6NO56XSi5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=W1uobHGU; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="W1uobHGU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Cc:To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:From:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=6kA3N7C7f6y80cfri0depDfE/jvR3uHumGY5Mi6x39I=; t=1757023427; x=1757628227; 
	b=W1uobHGUFtvy4TfyIPM3w0tOLN4T3XVLfuV5C62kW4BZtf367fCnw+XoWUTNzOkE4ggUPO5mH5k
	tr1yRVX6tkPNyJxZxO+im8AOu8guZEdlgaV7gj+ZpoIiT26XdwthZ1eNJESKeuvxCksFjkaV5O1dN
	acHkbFKUWumNPYkS+UTgREtn6DLJGWb+IjJE4oLg87SyxR1QtUlnKoOGfbu27Wm5OO9THbD/RVU0W
	E+GWQ0/748wguoBZbcmFy0F6HaKy509eGhAYXlHlCg0ckZSGHak2uREvgoMhMZPLrgZGnh1gC2us2
	hUi3dBe2HFiMs6f7mvXch9EWmBGwxMt1O4yQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1uuI3U-00000000z7B-2Y5q; Fri, 05 Sep 2025 00:03:44 +0200
Received: from 89-103-142-46.pool.kielnet.net ([46.142.103.89] helo=Geist14.)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <kernel@mkarcher.dialup.fu-berlin.de>)
          id 1uuI3U-00000002DJL-1aPM; Fri, 05 Sep 2025 00:03:44 +0200
From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Subject: [PATCH v4 0/5] Fix accurate exception reporting in SPARC assembly
Date: Fri, 05 Sep 2025 00:03:29 +0200
Message-Id: <20250905-memcpy_series-v4-0-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALEMumgC/62P2wrCMBBEf0XybMpm2yTVJ/9DRNJmtcHeSLUop
 f9uL4IgoiA+zsAcznSsIe+oYetFxzy1rnFVOYRouWBpZsojcWeHzBBQwgqQF1Sk9W0/z3gSJtZ
 KGWFqNBs2taeDu0687W7ImWvOlb9N+BbHdibFqISCUGCAoIELfiJfUr4pTsanGfnAOpNf6uBw4
 Qn53JWBpZH/0IheNFrkwFcxKGuFjiPSn0GjWSv+ZPPTeDIInwZvLoXjJVBKSiONNvYLsO/7Oyb
 A7SPNAQAA
X-Change-ID: 20250902-memcpy_series-b3bdd5542ca7
To: Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Anthony Yznaga <anthony.yznaga@oracle.com>, 
 =?utf-8?q?Ren=C3=A9_Rebe?= <rene@exactcode.com>, 
 Jonathan 'theJPster' Pallant <kernel@thejpster.org.uk>, 
 Magnus Lindholm <linmag7@gmail.com>, Tony Rodriguez <unixpro1970@gmail.com>
X-Mailer: b4 0.14.2
X-Original-Sender: kernel@mkarcher.dialup.fu-berlin.de
X-ZEDAT-Hint: PO

In 2018, David Miller implemented accurate exception reporting in
copy_from_user and copy_to_user by handling exceptions on each load
or store instruction that accesses userspace memory and calculating
the remaining bytes from the processor context. As issues with
transparent huge page support and folio support in ext4 were due
to a bogus return value from copy_from_user, I wrote a comprehensive
testsuite for the generic variant, and the machine-specific variants
for UltraSPARC I/II, UltraSPARC III, Niagara, Niagara 2/3,
Niagara 4 and M7, see

https://github.com/karcherm/sparc-cfu-bug-reproducer

despite the name of the project, it does not only test copy_from_user,
but also copy_to_user, and it also contains fixes to a very small amount
of exception handler references that were calculating the result in
a wrong way.

For UltraSPARC III, I chose to adjust the memcpy code itself instead of
adding complexity to multiple exception handlers. That fix has already
been tested to fix stability issues observed by Adrian Glaubitz which
kicked off the investigation. On all other architectures, the changes
are just to the exception handlers.

Kind regards,
  Michael Karcher

Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
---
Changes in v4:
- Add further credit for running tests on machines with this patch applied
- Link to v3: https://lore.kernel.org/r/20250904-memcpy_series-v3-0-906655a5a7ad@mkarcher.dialup.fu-berlin.de

Changes in v3:
- Fix bad formatting in commit messages (missing line wrap,
  extra empty line after Fixes:)
- Consistently add hardware to Tested-By lines
- Link to v2: https://lore.kernel.org/r/20250904-memcpy_series-v2-0-9806dd1784e7@mkarcher.dialup.fu-berlin.de

Changes in v2:
- More verbose description on how these issues were found
- Add M7 change, previously separate in
  https://lore.kernel.org/r/20250828121844.2250-1-kernel@mkarcher.dialup.fu-berlin.de
- Link to v1: https://lore.kernel.org/r/20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de

---
Michael Karcher (5):
      sparc: fix accurate exception reporting in copy_{from_to}_user for UltraSPARC
      sparc: fix accurate exception reporting in copy_{from_to}_user for UltraSPARC III
      sparc: fix accurate exception reporting in copy_{from_to}_user for Niagara
      sparc: fix accurate exception reporting in copy_to_user for Niagara 4
      sparc: fix accurate exception reporting in copy_{from,to}_user for M7

 arch/sparc/lib/M7memcpy.S     | 20 ++++++++++----------
 arch/sparc/lib/Memcpy_utils.S |  9 +++++++++
 arch/sparc/lib/NG4memcpy.S    |  2 +-
 arch/sparc/lib/NGmemcpy.S     | 29 ++++++++++++++++++-----------
 arch/sparc/lib/U1memcpy.S     | 19 ++++++++++---------
 arch/sparc/lib/U3memcpy.S     |  2 +-
 6 files changed, 49 insertions(+), 32 deletions(-)
---
base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
change-id: 20250902-memcpy_series-b3bdd5542ca7

Best regards,
-- 
Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>

