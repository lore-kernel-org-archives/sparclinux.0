Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DA61F8ACA;
	Fri,  3 Oct 2025 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500195; cv=none; b=AuQA2s7/uChwBFXvHID9x6dq6TRxnogwDfRcmLPwFX7fJCosLDXkv3FZB4+ZRQ9syeGkujdon9jo1adY4lZn1QqoRVbL8+3SRt7J+EFub3okDA8P5DtfJOIiFmv5EDXy8qqzylhyqtcQHDjZiMwWo7gtyYjhpAPwTAK6nOWpYNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500195; c=relaxed/simple;
	bh=zxGtDrrScMfp8eoAumbrdn2qE7q+mhfvAqBgp60/kUY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=qaNdLBr02BgfTcnN7BIFPAf56TMMqO4lCNsOrOSLN5t2Ihx0p0UnHWt4JniNm3N3Dm0YCdKzbmzlYqkwZMlmtvGre5PMFSwdXbcdjGG3tPF5MBTmaaVK7yMIp75ec/HB9sHiWMDToXINFaTx5XeJ03boqO9y4qmaY0arEIWkhcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Str79VsD reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Str79VsD"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cdVjy010Jz1FZPw;
	Fri,  3 Oct 2025 16:03:02 +0200 (CEST)
Received: from [10.10.15.15] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cdVjx5H6qz1FZPS;
	Fri,  3 Oct 2025 16:03:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1759500181;
	bh=lDzruDbgMefzIZKlD2uVhCYwI1hpYf0rZ6qKYmidsGA=;
	h=Date:To:Cc:From:Subject;
	b=Str79VsDv32V3dbI/d9nvQYXVuip2VYXXoz9KDpkbWQdEwWAcO+bS7CxUQcNydPrS
	 HYi+csurfkYcOGdgEKJxj3CyHBsqkJWjeUvCF9qfOukMB/Dv+tWe0RlJWeEpIqMwgH
	 hdgI/uQ8mQCq88BtfgP+pMtI+MZbTcb50pyr4/2O40szIJIKyVEBHnRrkIS5hTVMc6
	 gZ74ANg31xNc4ChC9s5wYmsFAELiRXRG3FpuvPBvXoh1tF7OsFgFQpQaK0J8OTQLyJ
	 4hu2+k9oFhCFVZe69+lQSxvO3qyYtP9txoa5UqaGH37aUnjvJtvO8HXhEEk/okg7Ub
	 jVxY4qTDejU/A==
Message-ID: <165c7a48-a7b5-4a79-98d6-4ffd520a3772@gaisler.com>
Date: Fri, 3 Oct 2025 16:03:01 +0200
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
Subject: [GIT PULL] sparc updates for v6.18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-6.18-tag1

for you to fetch changes up to fe0126702a40b2f3d315bc943ef10dc2f707e29d:

  sparc: Replace deprecated strcpy() with strscpy() in handle_nextprop_quirks() (2025-09-26 17:27:35 +0200)

----------------------------------------------------------------
This includes the following changes related to sparc for v6.18:

- Add relocation handling for R_SPARC_UA64 for sparc64 that is generated
  by llvm and clarify printout on missing relocation handler

- Fix missing hugetlb tte initialization for sun4u

- Code cleanup for redundant use of __GPF_NOWARN for sparc64

- Fix prototypes of reads[bwl]() for sparc64 by adding missing const and
  volatile pointer qualifiers

- Fix bugs in accurate exception reporting in multiple machine specific
  sparc64 variants of copy_{from,to}_user() for sparc64

- Fix memory leak in error handling for sparc32

- Drop -ansi from asflags and replace __ASSEMBLY__ with __ASSEMBLER__ in
  headers for all arch/sparc

- Replace strcpy() with strscpy() for all arch/sparc

----------------------------------------------------------------
Al Viro (1):
      sparc64: fix prototypes of reads[bwl]()

Anthony Yznaga (1):
      sparc64: fix hugetlb for sun4u

Koakuma (2):
      sparc/module: Add R_SPARC_UA64 relocation handling
      sparc/module: Make it clear that relocation numbers are shown in hex

Ma Ke (1):
      sparc: fix error handling in scan_one_device()

Michael Karcher (5):
      sparc: fix accurate exception reporting in copy_{from_to}_user for UltraSPARC
      sparc: fix accurate exception reporting in copy_{from_to}_user for UltraSPARC III
      sparc: fix accurate exception reporting in copy_{from_to}_user for Niagara
      sparc: fix accurate exception reporting in copy_to_user for Niagara 4
      sparc: fix accurate exception reporting in copy_{from,to}_user for M7

Qianfeng Rong (1):
      sparc64: Remove redundant __GFP_NOWARN

Thomas Huth (3):
      sparc: Drop the "-ansi" from the asflags
      sparc: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
      sparc: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers

Thorsten Blum (8):
      sparc: PCI: Replace deprecated strcpy() with strscpy()
      sparc: parport: Replace deprecated strcpy() with strscpy() in ecpp_probe()
      sparc: floppy: Replace deprecated strcpy() with strscpy() in sun_floppy_init()
      sparc64: Replace deprecated strcpy() with strscpy() in prom_nextprop()
      sparc: Replace deprecated strcpy() with strscpy() in domain services driver
      sparc: Replace deprecated strcpy() with strscpy() in prom_32.c
      sparc64: Replace deprecated strcpy() with strscpy() in build_path_component()
      sparc: Replace deprecated strcpy() with strscpy() in handle_nextprop_quirks()

 arch/sparc/include/asm/adi_64.h         |  4 +-
 arch/sparc/include/asm/auxio.h          |  4 +-
 arch/sparc/include/asm/auxio_32.h       |  4 +-
 arch/sparc/include/asm/auxio_64.h       |  4 +-
 arch/sparc/include/asm/cacheflush_64.h  |  4 +-
 arch/sparc/include/asm/cpudata.h        |  4 +-
 arch/sparc/include/asm/cpudata_64.h     |  4 +-
 arch/sparc/include/asm/delay_64.h       |  4 +-
 arch/sparc/include/asm/elf_64.h         |  1 +
 arch/sparc/include/asm/floppy_64.h      |  3 +-
 arch/sparc/include/asm/ftrace.h         |  2 +-
 arch/sparc/include/asm/hvtramp.h        |  2 +-
 arch/sparc/include/asm/hypervisor.h     | 92 ++++++++++++++++-----------------
 arch/sparc/include/asm/io_64.h          |  6 +--
 arch/sparc/include/asm/irqflags_32.h    |  4 +-
 arch/sparc/include/asm/irqflags_64.h    |  4 +-
 arch/sparc/include/asm/jump_label.h     |  4 +-
 arch/sparc/include/asm/kdebug_32.h      |  4 +-
 arch/sparc/include/asm/leon.h           |  8 +--
 arch/sparc/include/asm/leon_amba.h      |  6 +--
 arch/sparc/include/asm/mman.h           |  4 +-
 arch/sparc/include/asm/mmu_64.h         |  4 +-
 arch/sparc/include/asm/mmu_context_32.h |  4 +-
 arch/sparc/include/asm/mmu_context_64.h |  4 +-
 arch/sparc/include/asm/mxcc.h           |  4 +-
 arch/sparc/include/asm/obio.h           |  4 +-
 arch/sparc/include/asm/openprom.h       |  4 +-
 arch/sparc/include/asm/page_32.h        |  8 +--
 arch/sparc/include/asm/page_64.h        |  8 +--
 arch/sparc/include/asm/parport_64.h     |  3 +-
 arch/sparc/include/asm/pcic.h           |  2 +-
 arch/sparc/include/asm/pgtable_32.h     |  4 +-
 arch/sparc/include/asm/pgtable_64.h     |  8 +--
 arch/sparc/include/asm/pgtsrmmu.h       |  6 +--
 arch/sparc/include/asm/processor_64.h   | 10 ++--
 arch/sparc/include/asm/psr.h            |  4 +-
 arch/sparc/include/asm/ptrace.h         | 12 ++---
 arch/sparc/include/asm/ross.h           |  4 +-
 arch/sparc/include/asm/sbi.h            |  4 +-
 arch/sparc/include/asm/sigcontext.h     |  4 +-
 arch/sparc/include/asm/signal.h         |  6 +--
 arch/sparc/include/asm/smp_32.h         |  8 +--
 arch/sparc/include/asm/smp_64.h         |  8 +--
 arch/sparc/include/asm/spinlock_32.h    |  4 +-
 arch/sparc/include/asm/spinlock_64.h    |  4 +-
 arch/sparc/include/asm/spitfire.h       |  4 +-
 arch/sparc/include/asm/starfire.h       |  2 +-
 arch/sparc/include/asm/thread_info_32.h |  4 +-
 arch/sparc/include/asm/thread_info_64.h | 12 ++---
 arch/sparc/include/asm/trap_block.h     |  4 +-
 arch/sparc/include/asm/traps.h          |  4 +-
 arch/sparc/include/asm/tsb.h            |  2 +-
 arch/sparc/include/asm/ttable.h         |  2 +-
 arch/sparc/include/asm/turbosparc.h     |  4 +-
 arch/sparc/include/asm/upa.h            |  4 +-
 arch/sparc/include/asm/vaddrs.h         |  2 +-
 arch/sparc/include/asm/viking.h         |  4 +-
 arch/sparc/include/asm/visasm.h         |  2 +-
 arch/sparc/include/uapi/asm/ptrace.h    | 24 ++++-----
 arch/sparc/include/uapi/asm/signal.h    |  4 +-
 arch/sparc/include/uapi/asm/traps.h     |  4 +-
 arch/sparc/include/uapi/asm/utrap.h     |  4 +-
 arch/sparc/kernel/Makefile              |  2 -
 arch/sparc/kernel/adi_64.c              |  4 +-
 arch/sparc/kernel/ds.c                  | 27 +++++-----
 arch/sparc/kernel/module.c              |  3 +-
 arch/sparc/kernel/of_device_32.c        |  1 +
 arch/sparc/kernel/of_device_64.c        |  1 +
 arch/sparc/kernel/pcic.c                |  7 +--
 arch/sparc/kernel/prom_32.c             | 13 +++--
 arch/sparc/kernel/prom_64.c             |  8 +--
 arch/sparc/kernel/prom_common.c         |  7 ++-
 arch/sparc/lib/M7memcpy.S               | 20 +++----
 arch/sparc/lib/Makefile                 |  2 +-
 arch/sparc/lib/Memcpy_utils.S           |  9 ++++
 arch/sparc/lib/NG4memcpy.S              |  2 +-
 arch/sparc/lib/NGmemcpy.S               | 29 +++++++----
 arch/sparc/lib/U1memcpy.S               | 19 +++----
 arch/sparc/lib/U3memcpy.S               |  2 +-
 arch/sparc/mm/Makefile                  |  2 -
 arch/sparc/mm/hugetlbpage.c             | 20 +++++++
 arch/sparc/prom/Makefile                |  1 -
 arch/sparc/prom/tree_64.c               |  2 +-
 drivers/char/hw_random/n2rng.h          |  4 +-
 84 files changed, 312 insertions(+), 262 deletions(-)

Thanks,
Andreas
