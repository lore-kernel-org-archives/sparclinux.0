Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638AB13B7A3;
	Thu, 23 May 2024 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469611; cv=none; b=iZaR6kWFNBjkLdOvDFhUzu7vr/SIaFFfzj4J1P6Z7hQCwjSrDRb5gRnq79K5oyBvPsqALsnRkhmGmjo4Q0kdtX0iiODosLShuZ3Ddz5+762DKsYgRuTkBNQ/h3zahKj28oNZGbUv/fdJcL3WRz3vpSMsHn1ZLP+HxjlPaHmrB/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469611; c=relaxed/simple;
	bh=kswXzuirsNRtNf+Xr5hNHJ3T/IAZOwuRlS1VozUlXz8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=EEqlLRlF4Q93CGmsi48vfxLtG7ULDxzrCw+JTOJXq1QYbgzx4WsZzHgAmZwnj88tDJ9Ty7+boWULuHvLHkbZ+JYtrSTqg/0dyIYEObKzEj7/bwyAeNNbs72Pf+yA0RAS16sVny9M5QGgArLZiLOaEXbJoW8/7pWYnPsyFmm2eOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=j8J6Oj+p; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="j8J6Oj+p"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4VlSsh1ZY8z683H;
	Thu, 23 May 2024 14:58:48 +0200 (CEST)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4VlSsg66Tgz6808;
	Thu, 23 May 2024 14:58:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1716469127;
	bh=25qeUHlhp9AzNRH6OxC2fB+5NR3IUEhWt6Hs1OKWWBk=;
	h=Date:To:Cc:From:Subject;
	b=j8J6Oj+p62MHmeDS/udeSw+5DFq6D65r3kTh9B8YFkh4dZXzxHs40lP0u9jWp+nup
	 Ygg5klzGA/FovuQqVjPgC7BurvnLDwNc+7Ff6Dns5BSCxIScGL0qJudZZy4n4NAjWL
	 TnggXV5Td7eE7T4IYUlSsOsvVhvFV+jKUG2Tw/9A=
Message-ID: <413928e9-8e8e-429e-bca1-5d55ed3314fb@gaisler.com>
Date: Thu, 23 May 2024 14:58:46 +0200
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
Subject: [GIT PULL] sparc updates for v6.10
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-6.10-tag1

for you to fetch changes up to 1c9e709cde80fb612e07d9503ad04457e8a58da2:

  sparc/leon: Remove on-stack cpumask var (2024-05-08 19:42:16 +0200)

----------------------------------------------------------------
This includes the following changes related to sparc for v6.10:

- Avoid on-stack cpumask variables in a number of places.
- Move struct termio to asm/termios.h, matching other architectures and
  allowing certain user space applications to build also for sparc.
- Fix missing prototype warnings for sparc64.
- Fix version generation warnings for sparc32.
- Fix bug where non-consecutive CPU IDs lead to some CPUs not starting.
- Simplification using swap and cleanup using NULL for pointer.
- Convert sparc parport and chmc drivers to use remove callbacks
  returning void.

----------------------------------------------------------------
Dawei Li (5):
      sparc/srmmu: Remove on-stack cpumask var
      sparc/irq: Remove on-stack cpumask var
      sparc/of: Remove on-stack cpumask var
      sparc/pci_msi: Remove on-stack cpumask var
      sparc/leon: Remove on-stack cpumask var

Mike Gilbert (1):
      sparc: move struct termio to asm/termios.h

Sam Ravnborg (10):
      sparc64: Fix prototype warning for init_vdso_image
      sparc64: Fix prototype warnings in traps_64.c
      sparc64: Fix prototype warning for vmemmap_free
      sparc64: Fix prototype warning for alloc_irqstack_bootmem
      sparc64: Fix prototype warning for uprobe_trap
      sparc64: Fix prototype warning for dma_4v_iotsb_bind
      sparc64: Fix prototype warnings in adi_64.c
      sparc64: Fix prototype warning for sched_clock
      sparc64: Fix number of online CPUs
      sparc32: Fix version generation failed warnings

Thorsten Blum (2):
      sparc: Use swap() to fix Coccinelle warning
      sparc: Compare pointers to NULL instead of 0

Uwe Kleine-König (2):
      sparc: parport: Convert to platform remove callback returning void
      sparc: chmc: Convert to platform remove callback returning void

 arch/sparc/include/asm/asm-prototypes.h | 17 +++++++++-----
 arch/sparc/include/asm/floppy_64.h      |  4 +---
 arch/sparc/include/asm/parport_64.h     |  6 ++---
 arch/sparc/include/asm/smp_64.h         |  2 --
 arch/sparc/include/uapi/asm/termbits.h  | 10 ---------
 arch/sparc/include/uapi/asm/termios.h   |  9 ++++++++
 arch/sparc/kernel/adi_64.c              | 14 ++++++------
 arch/sparc/kernel/chmc.c                |  5 ++---
 arch/sparc/kernel/irq_64.c              | 10 +++------
 arch/sparc/kernel/kernel.h              |  4 ++++
 arch/sparc/kernel/leon_kernel.c         |  7 +++---
 arch/sparc/kernel/of_device_64.c        |  5 +----
 arch/sparc/kernel/pci_msi.c             |  5 +----
 arch/sparc/kernel/pci_sun4v.c           |  6 ++---
 arch/sparc/kernel/prom_64.c             |  4 +++-
 arch/sparc/kernel/setup_64.c            |  3 +--
 arch/sparc/kernel/smp_64.c              | 14 ------------
 arch/sparc/kernel/time_64.c             |  1 +
 arch/sparc/kernel/traps_64.c            | 10 ++++-----
 arch/sparc/kernel/uprobes.c             |  2 ++
 arch/sparc/mm/init_64.c                 |  5 -----
 arch/sparc/mm/srmmu.c                   | 40 ++++++++++-----------------------
 arch/sparc/prom/tree_64.c               |  2 +-
 arch/sparc/vdso/vma.c                   |  5 +++--
 24 files changed, 76 insertions(+), 114 deletions(-)

Thanks,
Andreas

