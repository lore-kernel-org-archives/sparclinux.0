Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE13E258EF3;
	Thu,  4 Sep 2025 18:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012060; cv=none; b=Y7IGOGx0ZS/SDUkz1piT5emcbuAHL/rnt1KncpMN1a2eqvH6vhQ77LLvGAzEtyGgT196pqfsvDLQa4V89zCgC761DXV363Vl5qOhWiKJQAxiZbRglZ6Ah77tCkLPqdAOxBbG3+fT3dzVtZ1uMLFJAZCUKpkrOpuzdpT7FQzjPY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012060; c=relaxed/simple;
	bh=dCuFnzhXyxIXfXF9vCjVibuGDRmhGN1bu7A34k5qAUA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OGOoB86wpCNwPy5Ku0hTaz3WWY6JDA/LGiJKXJU6pcHNmbZuQaELlMOkAqrNFCUJbQhZ9IJq3+a62h7VBfBjwsNbMe+WCxTKnjoIy5JUd6r04/cItL1O6fnh9hkaDgTit+TKqiw4HzOmndHNoxCYQSC0jMBA12fMcpcS0fWaXQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=MJonE9Vd; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="MJonE9Vd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Cc:To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:From:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=xaMvad4T5nGumMFK/aiZp33v6glqwYWXIyi8YhtP2jU=; t=1757012057; x=1757616857; 
	b=MJonE9Vd+Eg5ytzU6g6ox/G9e8OehvHMSvsrrqKz8kVfK006e628uMJznCCFnUU2xxcS/AA2CwS
	8qItEOqBhyjmccgkSzCW/FhdFfRR4M9l9ZBVqgZlSygjovnE1cWb5W52us0Rel9EyfA0eRucqH2vq
	PQYkRPQPlU4EYqabWvb9LKvY4C+x0HLJjSCFocfo2LulWj7R9EwrhqNju5jyL9sImJJ02mv0SIduo
	PO6syYFLS850cQ5YcGLUM1BAKx858jgTY9GwxssIHNhJW5IuX5azxDp/a4IrHsISX2jBVmxptgr1X
	bZpCKGkc+Xb41zV7/XeJctYIYQmfLe2K5X/A==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1uuF66-00000000LxY-24uz; Thu, 04 Sep 2025 20:54:14 +0200
Received: from 89-103-142-46.pool.kielnet.net ([46.142.103.89] helo=Geist14.)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <kernel@mkarcher.dialup.fu-berlin.de>)
          id 1uuF66-00000001W6v-18Qy; Thu, 04 Sep 2025 20:54:14 +0200
From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Subject: [PATCH v2 0/5] Fix accurate exception reporting in SPARC assembly
Date: Thu, 04 Sep 2025 20:53:50 +0200
Message-Id: <20250904-memcpy_series-v2-0-9806dd1784e7@mkarcher.dialup.fu-berlin.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD7guWgC/6XOQQqDMBCF4atI1ibEsWrbVe9RSonJWAc1SlKlI
 t69UY/g8h94H7Mwj47Qs3u0MIcTeeptCIgjpmtlP8jJhGYgIZM3CbzDTg/z+5jxMi2NybILaFW
 wsBkcVvTbvecrdE3+27t55yfYrod0hTzJZZqAAFlInvAGncX20TXK6RqdMKTacRDVyEt0LVlhk
 G3glJxE4ujMB+u6/gFgFDWxMwEAAA==
X-Change-ID: 20250902-memcpy_series-b3bdd5542ca7
To: Andreas Larsson <andreas@gaisler.com>, 
 Babu Moger <babu.moger@oracle.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Anthony Yznaga <anthony.yznaga@oracle.com>, 
 =?utf-8?q?Ren=C3=A9_Rebe?= <rene@exactcode.com>, 
 Jonathan 'theJPster' Pallant <kernel@thejpster.org.uk>, 
 Magnus Lindholm <linmag7@gmail.com>
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

