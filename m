Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1653F2459EA;
	Mon,  9 Feb 2026 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770639712; cv=none; b=stDkdUgXZSUDWFHG+1apK09svXvZV5ObqRM3SUZq1Rl0f04bMxwowch9iN5FRLfU6/lBWn/6V6H3RVdB9f4dJzl4ScU9vWZzm+1I1Uo4LFrDLbKXOgTnEcy8qT5YV/hJHTgf2jV46GpT/7Sr+l4SozLgqHWjQ988muV02Ahr1Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770639712; c=relaxed/simple;
	bh=hyl0K/7LsnGv+e8ziO3GQpyZsgBnOiWZP7RLpu+hI50=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=UEKkcPOL/YOgMRBTC4FcOUwWWHsteRFPR9a8DbG9qcOqMzJTUi0vtvk2MwOXwzx99zmj7bKAM5Vc0v5CWEx1vFUi2H4NoEFFD2SD9DPeZOXsxcE4htjSuVwQ2naVlHhpvW4jzAH4W+pZNjpurBHYDIATVo542fv1PtvlhkMGRRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=i9aMrw/z reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="i9aMrw/z"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f8kMd5HxPz1DR2Z;
	Mon,  9 Feb 2026 13:21:49 +0100 (CET)
Received: from [10.10.15.18] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4f8kMd3Kp6z1FDXT;
	Mon,  9 Feb 2026 13:21:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1770639709;
	bh=Y6hQaPBkiNg0SXtGmllyDcVnytfY8lXRUfemZWLc1I8=;
	h=Date:To:Cc:From:Subject;
	b=i9aMrw/zOG8ta4QrOM01XpLlmzE2scljuqhUmWFTEWgdrjpAZGNg6/L0Iwi4KTHEI
	 /PFGKZI/PVuLmSAFdBf5ZxdG7dkn0ClzmcDJajveq5IuGSx49IhALT/JGuzchSyWk1
	 bIkhgOGCEQmi+zhBO0YlzpOgmdCpRaza7iMd3OciStVuL5XXLltiA64L0Q2HO7PTb9
	 DUA1PkEJ8LKYZh0TD3foGgeIJecoF75BJtMkFNao0HL7mM1gu/t+DWI/2I8ODFgHcn
	 zZLLzVUqIYe5IKFfsfXHRD0EmLRQv0uNP3h7ku+ZyMnz/4InJqu2afnq8NRbBM+fHL
	 vKtqgJFwdJC1g==
Message-ID: <4908fe5d-4d42-45e0-9dba-e78e8a5b084f@gaisler.com>
Date: Mon, 9 Feb 2026 13:21:49 +0100
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
Subject: [GIT PULL] sparc updates for v7.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-7.0-tag1

for you to fetch changes up to d844152d85cfcc7d2ef9430a25882604c12da279:

  sparc: remove unused variable strtab (2026-02-06 15:16:22 +0100)

----------------------------------------------------------------
This includes the following changes related to sparc for v7.0:

- Hardcode uapi ioctls.h TC* constants to not rely upon struct termio
  that has been dropped by glibc

- Fix bug for fork/clone and add support for clone3

- Add ARCH_HAS_CC_CAN_LINK

- API choice improvements and cleanup of unused variables

----------------------------------------------------------------
Alex Shi (2):
      sparc64: fix unused variable warning
      sparc: remove unused variable strtab

Andreas Larsson (1):
      sparc: Synchronize user stack on fork and clone

Ludwig Rydberg (1):
      sparc: Add architecture support for clone3

Sam James (1):
      sparc: don't reference obsolete termio struct for TC* constants

Thomas Weißschuh (1):
      sparc: Implement ARCH_HAS_CC_CAN_LINK

Thorsten Blum (1):
      sparc: vio: Replace snprintf with strscpy in vio_create_one

 arch/sparc/Kconfig                     | 11 +++++++
 arch/sparc/include/asm/syscalls.h      |  1 +
 arch/sparc/include/asm/unistd.h        |  2 --
 arch/sparc/include/uapi/asm/ioctls.h   |  8 +++---
 arch/sparc/kernel/entry.S              | 15 ++++++++++
 arch/sparc/kernel/kernel.h             |  1 +
 arch/sparc/kernel/module.c             |  2 --
 arch/sparc/kernel/process.c            | 52 +++++++++++++++++++++++++---------
 arch/sparc/kernel/process_32.c         | 23 +++++++++++----
 arch/sparc/kernel/process_64.c         | 27 ++++++++++++++----
 arch/sparc/kernel/syscalls.S           |  8 ++++++
 arch/sparc/kernel/syscalls/syscall.tbl |  2 +-
 arch/sparc/kernel/vio.c                |  4 +--
 arch/sparc/mm/init_64.c                |  6 ----
 14 files changed, 119 insertions(+), 43 deletions(-)

Thanks,
Andreas

