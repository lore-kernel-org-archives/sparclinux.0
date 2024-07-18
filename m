Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F35A48CCC;
	Thu, 18 Jul 2024 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721288326; cv=none; b=DfnrkuSy0xQ5XDa9R5uuAmOpx5WmSmfjFC97Jshg7BRm5DQS0LKroXpmb7E2Cf7f4mfh7S4ck99IEtspBH7TVD0T8PeBNIkB02Dya6b/8I/wETssol+j9z27J2/Qie5gmYYOjXCgGwjGpujZ/qI2OsUjUM/RWYCsUo2uQEVTOIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721288326; c=relaxed/simple;
	bh=EGk0AfDcQmB7xSdL6MgH34gtIj0fe4d5RgyaQCrssxw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=u0l1B5oo7DUlFitzc7OzrOoyQXudkgrJ6C8xsG2pHDJrupHpVmwci68Fj7ecYDktik9gf6cS0uugqo7nGM+q4d7DVaSQB2IvpjN2OgaiMvfZZrJbtW8f0BpltPl8RWn414+J9ebO2EyeiiRr+tTtVwR45b5qaktkhUEzg2GtQqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=SFEywNcI; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="SFEywNcI"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4WPl6J5Kjfz1DPkZ;
	Thu, 18 Jul 2024 09:38:32 +0200 (CEST)
Received: from [10.10.15.10] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4WPl6J3RNGz1DPjy;
	Thu, 18 Jul 2024 09:38:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1721288312;
	bh=rMDFGDkxIXYDRvjPGcNB7g8EQVb01tHxKlmOZP2cpdk=;
	h=Date:To:Cc:From:Subject;
	b=SFEywNcIgjmnp5o+W0fUT+IpBzlw2KeyvBUKHgdBFlrje+0XSK17jAfqT/4OQwkU5
	 ALFgG+1miAIFUp5jzlixp5UdTQCap36Gug8v5TecFnQAl6sHl39BEXqyjDu9ZA00t4
	 fhB3q7OY2m+sjQdtE3liSIdVsYDSlRpiaKBXTRps=
Message-ID: <5bc02e66-dfa2-4d92-a4be-30746f2f1f76@gaisler.com>
Date: Thu, 18 Jul 2024 09:38:32 +0200
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
Subject: [GIT PULL] sparc updates for v6.11
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-6.11-tag1

for you to fetch changes up to a3da15389112a28633e4c340e4841faab29df3b7:

  sparc64: Fix prototype warnings in hibernate.c (2024-07-11 15:58:28 +0200)

----------------------------------------------------------------
This includes the following changes related to sparc for v6.11:

- Add MODULE_DESCRIPTION for a number of sbus drivers

- Fix linking error for large sparc32 kernels

- Fix incorrect functions signature and prototype warnings for sparc64

----------------------------------------------------------------
Andreas Larsson (5):
      sparc32: Fix truncated relocation errors when linking large kernels
      sparc64: Fix prototype warnings for floppy_64.h
      sparc64: Fix incorrect function signature and add prototype for prom_cif_init
      sparc64: Fix prototype warning for prom_get_mmu_ihandle
      sparc64: Fix prototype warnings in hibernate.c

Jeff Johnson (1):
      sbus: add missing MODULE_DESCRIPTION() macros

 arch/sparc/include/asm/floppy_64.h  |  5 +++--
 arch/sparc/include/asm/oplib_64.h   |  1 +
 arch/sparc/include/asm/uaccess_32.h |  6 ++++--
 arch/sparc/kernel/head_32.S         | 15 +++++++++++----
 arch/sparc/power/hibernate.c        |  1 +
 arch/sparc/prom/init_64.c           |  3 ---
 arch/sparc/prom/misc_64.c           |  2 +-
 arch/sparc/prom/p1275.c             |  2 +-
 drivers/sbus/char/bbc_i2c.c         |  1 +
 drivers/sbus/char/envctrl.c         |  1 +
 drivers/sbus/char/flash.c           |  1 +
 drivers/sbus/char/uctrl.c           |  1 +
 12 files changed, 26 insertions(+), 13 deletions(-)


Thanks,
Andreas
