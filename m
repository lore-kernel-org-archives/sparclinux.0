Received: from mailrelay2-1.pub.mailoutpod2-cph3.one.com (mailrelay2-1.pub.mailoutpod2-cph3.one.com [46.30.211.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEBB13FE1
	for <sparclinux@vger.kernel.org>; Fri, 29 Dec 2023 20:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="DkuEGVps";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="3NYGE2Qr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=content-type:mime-version:message-id:subject:cc:to:from:date:from;
	bh=pkcfHoIvOVMjb6wC0QUurbUExgvIMqM69mplL5NKdgY=;
	b=DkuEGVpsJ0PA0maJ7z/JNX+UwlQKxJT8JuYyFUJOlK79HQi2yQBmDkROFKaEx3eT9efRwWhkgTqvI
	 ZPHdse0DS2Ko/mc93xWY4NztroPEoVgL1x7H+u+T7RZWg2LxKXW+anoZtMvXuGYFKUXHansoanhl7d
	 i9eQ8b37OMo0IUUN/9MrzZcp2osHEbrqiIRsNvVcejnktviOZChWh99wm7Qfkmu+H5wPhFSoMfeTNC
	 bGdWiu2IquCha58M64jhvhVpvP7OLZAMIVg9aRXYkVMRfFh/KJaEobEjBkt6ZGpmIHy82KFmC7+0LN
	 zefJGTU/jLyEKIOFG6sD+Opzn9bJaiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=content-type:mime-version:message-id:subject:cc:to:from:date:from;
	bh=pkcfHoIvOVMjb6wC0QUurbUExgvIMqM69mplL5NKdgY=;
	b=3NYGE2Qr+dkkLFxqzamsXtDCLIQV/6BPpRc210Gno3ufKgW7nwwH4WDbPA+8kfaF+d+u/mpW3o1ix
	 MPjdbboAw==
X-HalOne-ID: b1e19022-a685-11ee-8a6e-a34c9b1f9040
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay2 (Halon) with ESMTPSA
	id b1e19022-a685-11ee-8a6e-a34c9b1f9040;
	Fri, 29 Dec 2023 20:06:05 +0000 (UTC)
Date: Fri, 29 Dec 2023 21:06:04 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "David S. Miller" <davem@davemloft.net>,
	Arnd Bergmann <arnd@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 0/4] sparc32: Use CAS for atomic support
Message-ID: <20231229200604.GA4033529@ravnborg.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With sparc limited to leon3 the next step was to address the atomic
support which this patch set does.

Gaisler already had an implementation in their kernel patch stack, that
co-existed with sparc v8 without CAS support.

As the sparc v8 without CAS is no longer supported this patch set takes
a different approach. Using the current best practices the atomic support
is implemented in three steps.

The cmpxchg is updated to use casa/swap.
The atomic bitops are implemented in their own file and uses a minimal of
inline assembly.
The atomic operations are implemented based on the template found in
asm-generic.

Some notes:
- The code uses __always_inlin almost everywhere, where inline could be
  enough. Not sure what is best here.
- The new (and replaced) files uses the SPDX tag: GPL-2.0
  No sure if this is best practice today, I am happy to change the
  license.
- Build tested and booted using qemu.

The patches are on top of the sun4m and sun4d sunset patches.

Review feedback appreciated!

	Sam

---
Sam Ravnborg (4):
      sparc32: Add support for specifying -mcpu
      sparc32: Add cmpxchg support using CAS
      sparc32: Add atomic bitops support using CAS
      sparc32: Add atomic support using CAS
 
 arch/sparc/Kconfig                        |  24 +++++++++++
 arch/sparc/Makefile                       |  13 +++---
 arch/sparc/include/asm/atomic_32.h        | 151 ++++++++++++++++++++++++++++++++++++++++++++-----------------------
 arch/sparc/include/asm/bitops/atomic_32.h | 124 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/sparc/include/asm/bitops_32.h        |  71 +-------------------------------
 arch/sparc/include/asm/cmpxchg_32.h       |  72 ++++++++++++++++++--------------
 arch/sparc/lib/Makefile                   |   2 +-
 arch/sparc/lib/atomic32.c                 | 202 ------------------------------------------------------------------------------------------
 8 files changed, 296 insertions(+), 363 deletions(-)


