Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D14B389DF0
	for <sparclinux@vger.kernel.org>; Mon, 12 Oct 2026 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830927; cv=none; b=HIOmPG/SM3ko+O+LRgJqBtkh0qvUasQEJM1bliNCMn40tWr+WACAfbXrxThsrs+dFoxLWjHUmiVM0BB3Gb1Q950AZGxlBLIwos4AmOqpZ+eQkBsUZnfLjP/rhsReYriM8ZYIMdPdt6VfoVrvmiED/ze28FjUIa2adVr2RhXWZCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830927; c=relaxed/simple;
	bh=RXZU9pGmybZEzzVgTyCUUBPb33NmSEa3c7lCgL2izTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tD5br3SCan7jJVSEG+RY8zUlHvFslraV0y/I6gq5D+9CdMv6drC5Mhvf1/uqN75incpnNZXoI6IJWJ6yB4qE1JPoIkHRYpS4/U63qy1sa5EAxzM0oDkvxJI2I8MN1y2jNbcTU3V0IaJg3ddiWTKC4Pv0ueXOOf/AW/BTJ7TpgIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gO/NrSOU; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gO/NrSOU"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c34bff61551so206994666b.2
        for <sparclinux@vger.kernel.org>; Mon, 12 Oct 2026 11:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791830923; x=1792435723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SuQqbuz4y3M9yuu6TKfF/F/BBLi6OQx/9CpoEI3dfHI=;
        b=gO/NrSOU0URkG6AyNG38PYCCGTK+8Mlb8OoaKMmsstV+5DA/CPeP0DDAIbBufqT62A
         FneMlPeiidxhbIn48Srn5pT9Ga4DpqB1f1zYO0WqWneK3MaRnCpXKMH9Jj+ThIdh9gg3
         I7wiq2OZmPE8Vy61RY8VxZAy6WjfHmf2yycfHgRQbGOvTVKsbHwUAe3ZMQygIAWi9Cjh
         KPFCN1WjSuU6/bJEzOAayoaEagIIdDozNOo98df/uF9qZtnHUydOYqtXylvS9KfR+NA2
         4kGQbfgRKAs/D7EpQqIBuEre0Pwn8nA6FvgaL+8GKUM3AREzKwBLSTEpFjxCl7Npmcj1
         7aOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791830923; x=1792435723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SuQqbuz4y3M9yuu6TKfF/F/BBLi6OQx/9CpoEI3dfHI=;
        b=NdwpQDGqJ8rJ0HD7p2hcw0xjg9zdnJDQAI+OFYMFFiXPYU3fP1IkxDQbh9lxLQ9aFW
         fnCKHIkkHIMY7uOuG7VsNdblGJos5e0HNDwVOkQMEVBDQPZd1SVNY1j4wMAM9qlGyJuZ
         /NCBm9xNGOb+gyaDcnbmuKmXNunoKmw4PaKVhm2GQ8OawOKYs6xVf7+mPKFFzq/SwuzV
         qjATtfaBUm6U62+diFTEwbjNahqRjQrDSwUv/cezc+buI4mTgEauUDWjC/58e5uc08BX
         faiqzP+RtfqLPw3yIPgKFN/XDOnuqhTcCxGpL7XwUvz5/QfOXfUj9kE7TkRa5Kerehtc
         6MVg==
X-Forwarded-Encrypted: i=1; AKwUvBwvAhOUuys59Y8Zj1+2K4YXHSZzRN7obcztrmHMFgdTLrjH0CeFbz9hEUOf0wnCVjIRyaGZ0A9Db75m@vger.kernel.org
X-Gm-Message-State: AFq9FYLzd+z8Qh80YKG8cZj4QKjZd/Kmrm9c1/lPDgr7zpoocNEt1gmE
	EZ6zG3D6PRia7cgUC7iPfpDiAApuqQ2QDOquPHzXwot9ZU07fEwb5sb/
X-Gm-Gg: AYBFou3oJogeMtVfdZGknduYupivlBe9TuIUnF4dsw6qAxU1s3OlWhhaxn+BrSfdBQN
	JINv+e5ZzmKyantzuS8wcUyoJs0QOv/+/prP3DdGDxWiOq+WTkTBA6jvlgUZ2bFxnTAwH/FLS+Q
	og+0brHSeTLPnqQvJGc8y+/MRUIVthDKfo1l/Ook4pEPj8U9ztr39V+o+DJQ43cGKvY70OsKSz0
	9hA5Go0e1CokBHd7dOxK07dInMRO1nBiAdM4yNfYY3R2bZMD4cvzIprlFpx7HvppSTu5r10uM9h
	RcQSumLZbM0qirf5Orx5TRq1Q3ta3IZgqyhPrc1eNb5jDGTjQL+Jr321NUzC3sFOvF0H7k+DkUA
	x6L71mfL9pnc82jVtFGQySuwlVW5/gK1Gt5aw9/pbLHRXm6PoudgIgb7yuo7W6cDsEiU/Tp2cFJ
	vysrDJ4/hLVVvZTIz9Z+2GzA/DLHQXr+YgTryOTMh1wpnSECYI/1S46AEDMW8S99+JnVc5dypQe
	bKEyLMvpXGHuIYg8ufYPq4alzlo8CP3mJh+m8Pc
X-Received: by 2002:a17:907:c003:b0:c34:cf13:a92b with SMTP id a640c23a62f3a-c34cf13b42bmr339345466b.3.1791830923181;
        Mon, 12 Oct 2026 11:48:43 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa5aa7sm488517666b.55.2026.10.12.11.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:48:42 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com
Subject: [PATCH v3 0/8] sparc64: add Fujitsu M3000 support
Date: Mon, 12 Oct 2026 20:48:01 +0200
Message-ID: <20261012184826.986050-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several years ago I salvaged an M3000 SPARC Enterprise box being
decommissioned at work. The box has been sitting ever since, as it did
not run Linux. It did not seem impossible to get Linux running, but
my earlier attempts failed. I recently found some documentation:
"SPARC JPS2: Common Specification" and the "Fujitsu SPARC64 VII
Extensions", which gave me some of the missing pieces.
Getting this up and running required extensive testing, some
kernel instrumentation, debug printouts and many reboot iterations.
For this, Codex proved very helpful. Along the way, I stumbled upon
some generic sparc and driver bugs that this series addresses as well.

This series adds CPU, MMU, SMP, Oberon PCIe and firmware console support
for the Fujitsu SPARC Enterprise M3000. It is based on v7.3-rc1.

Patches 1-5 are generic sparc64 fixes: the clear_page return, secondary
startup spinlock layout, sun4u kernel PUD mappings, IRQ allocation
failure handling and Fire firmware register-property validation.
Patches 6-8 add the M3000 support. The generic fixes are kept in this
series so that the architecture changes can be applied and tested
together.

The on-board BCM5718 also needs the separate netdev patch:

[PATCH net-next v3] tg3: normalize inherited BCM5718 register byte order
Link: https://lore.kernel.org/sparclinux/20261011194228.981141-1-linmag7@gmail.com/

That patch applies independently and is not included in this series.
It was included in the M3000 test kernel described below.

Changes since v2
---------------
- Add separate generic fixes for unchecked IRQ allocation failure and
  missing or short Fire reg properties, following the Sashiko review.
  IRQ setup now stops before publishing an invalid descriptor; register
  properties are validated before their entries are accessed.
- Mark fill_in_one_cpu() as __init to match its initialization-only
  caller and vii_cpu_topology(), fixing the section mismatch reported
  by the kernel test robot.
- Address Jiri Slaby's HVC review: reorder the console state to reduce
  padding, use guard()/scoped_guard() for locking, test the input
  pointer directly, and name the firmware argument counts and error
  return values. Keep the polling spinlock released during synchronous
  timer deletion, with the mutex held to serialize close and reopen.
- Retain the raw buffer lock for atomic console calls and the existing
  firmware polling policy. Zero still means zero bytes transferred;
  firmware argument-array positions remain the fixed interface layout.
- Remove the leftover experimental Oberon boot message.
- Fold the CPU and HVC corrections into their respective support
  patches. The two new generic fixes bring the SPARC series to eight
  patches; the tg3 fix remains separate.

Testing
-------
The candidate source tree, including the separate tg3 patch, was built
with W=1 using GCC 13.3 and Clang 23.1.3. Neither build reports the
CPU topology section mismatch or warnings in the changed HVC code.
Other warnings remain in existing code. This does not reproduce the
robot's exact Clang 24 development compiler and defconfig combination.

The GCC kernel booted from disk into OpenRC and SSH on an M3000 with
all eight CPUs and 16 GiB of RAM. Bounded fork/COW, CPU migration,
file write/read verification and network transfer checks passed.
HVC checks covered output, paced input after idle, concurrent open and
close, and hangup/reopen. The kernel remained untainted, with no new
WARNING, BUG or Oops reports during these checks.

The final export plus tg3 differs from that boot-tested source tree only
by removal of the experimental Oberon boot message. It applies cleanly
to v7.3-rc1 and has been rebuilt with GCC and W=1; the final export has
not been rebooted. The Clang image was not booted. This revision has not
been retested on the Ultra45 or in UP mode, and these bounded tests do
not establish long-term stability or exercise hardware failure paths.

Current limitations
-------------------
SPARC64 VII support remains a Kconfig option because this path currently
excludes HugeTLB and THP. Removing that restriction requires further
large-page MMU work and testing. CPU offlining is not supported.

Oberon uses legacy interrupts; MSI and native bridge error recovery are
not implemented. CPU error handling is limited to the supported
restrainable ECC path; other unhandled error traps remain fatal.

The HVC backend relies on firmware calls. A firmware call that does not
return remains unbounded, and fast pasted input can exceed the firmware
FIFO. The console tests above do not establish panic-path reliability.

Magnus Lindholm (8):
  sparc64: return from the generic clear_page implementation
  sparc64: honor queued spinlock layout in secondary startup
  sparc64: avoid huge kernel PUD mappings on sun4u
  sparc64: stop IRQ setup when descriptor allocation fails
  sparc64: validate Fire register properties before initialization
  sparc64: add SPARC64 VII CPU, MMU and SMP support
  sparc64: add M3000 Oberon PCIe support
  hvc: add an M3000 firmware console backend

 MAINTAINERS                         |   6 +
 arch/sparc/Kconfig                  |  20 +++
 arch/sparc/include/asm/head_64.h    |  15 ++
 arch/sparc/include/asm/iommu_64.h   |   1 +
 arch/sparc/include/asm/irq_64.h     |   1 +
 arch/sparc/include/asm/setup.h      |   5 +
 arch/sparc/include/asm/smp_64.h     |   4 +
 arch/sparc/include/asm/spitfire.h   |   1 +
 arch/sparc/include/asm/trap_block.h |   6 +
 arch/sparc/kernel/cpu.c             |   3 +
 arch/sparc/kernel/entry.h           |   2 +
 arch/sparc/kernel/head_64.S         |  18 +++
 arch/sparc/kernel/helpers.S         |  41 +++++
 arch/sparc/kernel/iommu.c           |  44 ++++++
 arch/sparc/kernel/irq_64.c          |  54 +++++--
 arch/sparc/kernel/pci_fire.c        |  37 ++++-
 arch/sparc/kernel/pci_impl.h        |   1 +
 arch/sparc/kernel/prom_64.c         |  29 +++-
 arch/sparc/kernel/prom_irqtrans.c   |  15 +-
 arch/sparc/kernel/ptrace_64.c       |   7 +
 arch/sparc/kernel/setup_64.c        |  55 +++++++
 arch/sparc/kernel/smp_64.c          |  89 ++++++++++-
 arch/sparc/kernel/trampoline_64.S   |  53 ++++++-
 arch/sparc/kernel/traps_64.c        |  27 ++++
 arch/sparc/lib/GENpage.S            |   3 +
 arch/sparc/mm/init_64.c             | 110 ++++++++++++-
 arch/sparc/mm/tsb.c                 |  19 ++-
 arch/sparc/mm/ultra.S               | 236 ++++++++++++++++++++++++++++
 drivers/tty/hvc/Kconfig             |  10 ++
 drivers/tty/hvc/Makefile            |   1 +
 drivers/tty/hvc/hvc_m3000.c         | 202 ++++++++++++++++++++++++
 31 files changed, 1077 insertions(+), 38 deletions(-)
 create mode 100644 drivers/tty/hvc/hvc_m3000.c


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
