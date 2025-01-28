Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1D6A59;
	Tue, 28 Jan 2025 07:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738050174; cv=none; b=I4nrugNw5tpJwU+fnYGKjtzmUtoCP34KjWRHmYdHhgTdHYoJ/XC4zJ1Xh+MYVhn/ZUOWsSgy3vkyGvQHa5lMFcnELR4LPp0LibjzfcYpDsfiP8rbHtp54E+o6xf/Axo4bQrBdCBg9LYrtGp1kadj0pDYUAypD25xz9wlG2Loyb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738050174; c=relaxed/simple;
	bh=0MaeTcc6NMtCtJe71eNX5ci1a/YXKxtP8+oU63JT8CQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QD3P1R8zDuHsuKT3raTr44uRClScNDULiS7mTe9Iv7zR9xO7ZIUW89FrqnA3z227BlRjwtCOl9j+SeRLJlSqWfQlbIVoqm4faLCgF5FI1Py6OiEgM4rbyE/JsCGLkB0HBYzHnjWNxuQZP7kDex+D9CvaKZShyqPU8KlRQAwg61I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=O9wwxth6; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="O9wwxth6"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4YhxqQ6RmHz1DHcP;
	Tue, 28 Jan 2025 08:33:54 +0100 (CET)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4YhxqQ3jLYz1DHVZ;
	Tue, 28 Jan 2025 08:33:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1738049634;
	bh=L55dgoj/0sTt7H4fzTRDoM3s9MOeZy5B+ZD/YRcp0DM=;
	h=Date:To:Cc:From:Subject;
	b=O9wwxth66o7CGjUCBCZOAowFw0Fp71TVjcjpRkPWugfogwYBnfVvp8OqeX4QjXKat
	 bWzhAjFNIqGAq3vdGGd5zKBWOca/vqzqScmRBtpy4h2WhCiDAeoZAk2DgpeNbIuWQ6
	 5Du++fZSJcrolvQ/TM7xDHsu+mq533QrB4QwXVcc=
Message-ID: <35a42f8f-fb15-429e-9b90-11033f17fbeb@gaisler.com>
Date: Tue, 28 Jan 2025 08:33:54 +0100
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
Subject: [GIT PULL] sparc updates for v6.14
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-6.14-tag1

for you to fetch changes up to 2cec2c4dc90cbf5194c1acef08c1e74f0437af95:

  sparc/irq: Remove unneeded if check in sun4v_cookie_only_virqs() (2025-01-17 16:33:48 +0100)

----------------------------------------------------------------
This includes the following changes related to sparc for v6.14:

- Improve performance for reading /proc/interrupts

- Simplify irq code for sun4v

- Replace zero-length array with flexible array in struct for pci for sparc64

----------------------------------------------------------------
David Wang (1):
      sparc/irq: use seq_put_decimal_ull_width() for decimal values

Thorsten Blum (2):
      sparc/irq: Use str_enabled_disabled() helper function
      sparc/irq: Remove unneeded if check in sun4v_cookie_only_virqs()

Zhang Kunbo (1):
      sparc: replace zero-length array with flexible-array member

 arch/sparc/kernel/irq_32.c | 12 ++++++------
 arch/sparc/kernel/irq_64.c | 11 +++++------
 arch/sparc/kernel/pci.c    |  2 +-
 3 files changed, 12 insertions(+), 13 deletions(-)

Thanks,
Andreas

