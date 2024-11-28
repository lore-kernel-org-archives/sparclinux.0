Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6995E19CD1E;
	Thu, 28 Nov 2024 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732797192; cv=none; b=pW8E3xVpMYvj6ee1cL6O9MJaCgIGkWsdoLhODxKDknR5x7JJEodVJgrEIue57xw6bgDjp7HvvWcBqon1T3fZU2PfLimFxpd+nqUhbKJIHkTuuSrf/qRiNSUDTA/chd57aFWoRddkQriHJ3sokHbxUA3c3+5dshCMr2xpEmW/vMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732797192; c=relaxed/simple;
	bh=4kN4p8GQ+2QmKeA/bnUvaeh9MyJCO4sslOgNjFrCxfA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=KCyB1E6v4CBVFxygsWBK15AbT8A5QbB7SngAJwHjQEuRXMLwc0QTClD17hxU87IYsPXv4WSdeh8XKEvFTobL0qZZq1ix0m5Iz61d1ajhwZOPkdT4Ful3iesFDSmGPLEU0s78Kv1Oq6hz3vnQMAMhGI26si2796DHDdxUWCMg/yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=bC94NoxQ; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="bC94NoxQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4XzbLm3Jvzz1DHVZ;
	Thu, 28 Nov 2024 13:33:04 +0100 (CET)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4XzbLm1z61z1DHY1;
	Thu, 28 Nov 2024 13:33:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1732797184;
	bh=AMfTwH0iXzHF6t67vGYAsjXiFxhVy2J7CG3nlbvkp3U=;
	h=Date:To:Cc:From:Subject;
	b=bC94NoxQf1RSr3QiC+zGBU6QfCth0JI95JXGCsqTm9jR68sRB98myvCZ4W7C/IVKU
	 0XGSAfjgy6oinEIZUyqZEnW2tXsqR8rW/Mh1RMfeipx/sAbEhYm5MQa/1xS5ZNi1dO
	 //3tmTxwKv5FpntFlKUaaOjFhquN8xcJFFTANLr8=
Message-ID: <a124b567-d9a1-48f5-beec-de1bacac2140@gaisler.com>
Date: Thu, 28 Nov 2024 13:33:03 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Andreas Larsson <andreas@gaisler.com>
Subject: [GIT PULL] sparc updates for v6.13
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-6.13-tag1

for you to fetch changes up to b6370b338e71cf24c61e33880b8f1a0dd5ad0a44:

  sparc/vdso: Add helper function for 64-bit right shift on 32-bit target (2024-11-18 09:59:20 +0100)

----------------------------------------------------------------
This includes the following changes related to sparc64 for v6.13:

- Make sparc64 compilable with clang

- Replace one-element array with flexible array member

----------------------------------------------------------------
Koakuma (3):
      sparc/build: Put usage of -fcall-used* flags behind cc-option
      sparc/build: Add SPARC target flags for compiling with clang
      sparc/vdso: Add helper function for 64-bit right shift on 32-bit target

Thorsten Blum (1):
      sparc: Replace one-element array with flexible array member

 Documentation/kbuild/llvm.rst    |  3 +++
 arch/sparc/Makefile              |  4 ++--
 arch/sparc/include/asm/hvtramp.h |  2 +-
 arch/sparc/kernel/smp_64.c       |  4 +---
 arch/sparc/vdso/Makefile         |  2 +-
 arch/sparc/vdso/vclock_gettime.c | 28 ++++++++++++++++++++++++----
 scripts/Makefile.clang           |  1 +
 7 files changed, 33 insertions(+), 11 deletions(-)

Thanks,
Andreas
