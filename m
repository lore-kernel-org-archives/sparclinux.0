Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738C449E5EE
	for <sparclinux@vger.kernel.org>; Sun, 18 Oct 2026 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331370; cv=none; b=EF8FZyFpzCFX96nVpYsKksKsunRITTap29XWwOP80aMzu2io8hMMes9CqVfApbt+qWsZmoKZwS32N6V0nGG1YuXHuz/6Ir7FBtsoTNAVI40dEbsEbKQoVkcJM/h7vj6NTtxP2PHHS1kI4qOIj1uBruIVz1EWZ8EG5p6XnPDMcvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331370; c=relaxed/simple;
	bh=Xu6SNXi//Tf104ap6o4tHGZFsV6K6UWUGmKw5C+hMlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QnmUnx+hH9SC6xqHGbqP+ybZ0MDCzvcdclBdZqdLotCqWE058envYisz7msa0/COKFwxI6MP+l/s1s4Xp2hoY4dNEFiTr+qnjvVMVWzJVgUpBxYvDpFfbT3gd6IBkzgxBPiFhj7KJMkkm9pFGUg+Df1NjKEl/wOhC0jnIB4hPFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqPc+lVz; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqPc+lVz"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c3fd91337baso169313466b.3
        for <sparclinux@vger.kernel.org>; Sun, 18 Oct 2026 06:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331367; x=1792936167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BZTGhLaI3EXputloxAEypMkmx+sontqDJHpA+jMjNlM=;
        b=iqPc+lVz5o/5eflo3a7bTkKKksNVDyX8tA4Iu3OLsKKh9k11wv3m6RfEVE8aTyUdYe
         peYiepitW77xfe680/ZtkG7QbwJD/aI5lJjhoHDviPeETdXlHkBMABipfbF95pLnegQT
         fEdPo3E1ufjaTGaauZCtTHJXj+nesbmwkY8u3Oe6roOzbq96deBRimYS4CSRkpXo3oSW
         cPCl4PR0NHuyt1W+hk2IlPBSUwQAnTvs35JNoMfniNVtQZyhu65LFNJrudytTpbh6Df6
         VBNVY43Gi4Mq9uGo9R+Mtb6455Nl64T5lx1BIL7rp6u01Rzx+EtM8bfZHUgFz7/CDpOw
         MOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331367; x=1792936167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BZTGhLaI3EXputloxAEypMkmx+sontqDJHpA+jMjNlM=;
        b=mrVfwtbM9Qdpzrk4yXJAwV5ha2IWMGEAe+diPXa12FwOn/IReOFVdq4zXBRHWFDsRl
         TGUo39xfWVrdLjdwWIhUYBHHdQCmgfwBr61I1q2gZTBx9jxP3LFvuD5RhZoZG64gmIow
         lXRfKaS/CcWMhAAR0685Glt0gOTKKMg/iBOm52hQcpTzAWxAyZi4eoUFs+Hx5a9B1AIq
         ZyKnW6XRRNxtx/rV5YO36lTDOH3bq1wPgZndkPi4BxKzEBpzFnpHyCivq5va00hWjatM
         6qjdf0731p3m1D9mViLKWtB2G+L7bZyVXpWG3Mz9GF0YnQT1WXS85SgnvMQmOI2kkoIT
         Lgmw==
X-Forwarded-Encrypted: i=1; AKwUvBw0b03MPG2U71lk2XjzY7iKz4LaCOzMIU5R6bx+jSMt3FuqaKnglcyd1GlZrlpTbeF6LmYaJbfAwHZH@vger.kernel.org
X-Gm-Message-State: AFq9FYLt0UcC2fYVRG6fITTrXLxrCnVwS4BZqqMHTVIE70AJ6LzrnHdz
	47p3I0Ji6fQm+fdBnoMjhLUvhbzfri2SYjCjbKPY24VwA2/Kucddqlwx
X-Gm-Gg: AYBFou3pb0TMA2yveDzby8yClqZBYBxs993QiIzOhEfikFGsUVyD0Ub97Is5fReOlj/
	KnvFI6FbXVDDeOAG/nxwulxXKjB9SRb72R2dqcwvTPIiRrA8OyQZh8PBB7Y0UOpyVUmvJT/Uqfg
	1C34q533NhXXMz5Ca/wsx4u6DhNMyOoehsGw8GY5PVzWPQFt7Pl8Po8MVw73INBbas+DF99UJm3
	nY6ET4Rh2j1nrwLcO4qcNjL3IfoAjep5rd/mwOFzUMscfKBO0ZZgrbGpGoATzFb27FWlfFbiVWl
	IlooRrQvnDB3oUlg0t+r40BLL+MLbz/eqV9fx+gb8u6Yh2VZar6qvjXZMhq5F02Bv4sA3NOvioQ
	chSV3pJ6jLCSbngingqz+RZ87s29y0bbsvrC5JwpgE0tOux712onOl43U0TgZ3TsYKdRR1qcsic
	UrQ/JYHIDKKYtCoo7rvWAHYZCtfTAy6TeBg3r10gGEj8H86I4bc5Dpo3H7/fkwcjHd+zAVdolW7
	cG1bj4YS2bF2dbL61jZzDgx6zwm16x3thXayLeO
X-Received: by 2002:a17:906:630b:b0:c3e:e677:563a with SMTP id a640c23a62f3a-c41a02fb699mr350769366b.47.1792331366361;
        Sun, 18 Oct 2026 06:49:26 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:24 -0700 (PDT)
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
Subject: [PATCH v4 00/10] sparc64: add Fujitsu M3000 support
Date: Sun, 18 Oct 2026 15:45:02 +0200
Message-ID: <20261018134738.1016106-1-linmag7@gmail.com>
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
Codex assisted with debugging, instrumentation, code drafting, review
and commit-message preparation. Along the way, I stumbled upon some
generic sparc and driver bugs that this series addresses as well.

This series adds CPU, MMU, SMP, Oberon PCIe and firmware console support
for the Fujitsu SPARC Enterprise M3000, based on v7.3-rc1. It also applies
cleanly to the SPARC for-next snapshot a9e88d617a25.

Patches 1-7 fix generic sparc64 code used by the port: page clearing,
secondary startup locking, kernel PUD mappings, IRQ allocation,
firmware-property validation, DMA segment boundaries and IOMMU table
initialization. Patches 8-10 add VII, Oberon and HVC support.
VII CPUs and Oberon bridges are detected at runtime; no platform-specific
CPU or bridge Kconfig selection is required. HVC remains selectable.

Four independent fixes are in a separate follow-up series: IOMMU context
cleanup, PROM short writes, cookie IRQ allocation and interrupt-vector
bounds. They are useful independently and are not prerequisites for
applying or building this series. The PROM short-write fix also affects
the M3000 early console if firmware returns short writes.

The on-board BCM5718 also needs the separately submitted netdev patch:
  [PATCH net-next v3] tg3: normalize inherited BCM5718 register byte order
It is independent of this SPARC series and was included in hardware
validation kernels.

Changes since v3
----------------
- Add generic fixes for DMA segment-boundary checks on sun4u/sun4v and
  initialization of IOMMU page-table entries. Keep the four unrelated
  fixes listed above in their own series.
- Base the huge-PUD guard on the selected hardware page encoding,
  including the sun4v small-page fallback.
- Check for sun4v before reading %ver during secondary startup; restrict
  VII CPU/FPU names to sparc64 builds.
- Reserve only required locked TLB slots. Accept arbitrary 4MB offset
  bits on VII readback while checking all size and address bits.
- Preserve VII PA[46:43] in pte_pfn() and pte_modify(), leaving other
  processors' masks unchanged.
- Require disabled shared-context and TSB-prefetch valid bits at CPU
  entry and firmware handoffs. Record unsupported state and halt.
- Capture secondary MCNTL before the MMU-state check and identify an
  uncaptured value accurately. Explain the silent-halt limitation and
  print an error before halting on an out-of-range trap branch.
- Correct the fatal-trap marker, clarify manual references, queued-lock
  ordering and IPI wording, and complete the generic fixes' Fixes tags.
- Carry Greg Kroah-Hartman's Reviewed-by on the unchanged HVC C code,
  clarify its Kconfig help and add sparclinux maintainer routing.
- Remove the VII and Oberon Kconfig options, retaining runtime CPU and
  firmware-compatible checks and sun4v startup bypasses. Reject unsupported
  VII HugeTLB/THP mappings at runtime before page-size setup side effects;
  preserve huge-page support on other processors.
- Fold VII corrections into CPU enablement. This is ten patches versus
  eight in v3; tg3 remains separate.

Testing
-------
The final code plus the separately submitted tg3 fix booted on
M3000 with eight CPUs and 16 GiB. The four generic follow-up fixes and
the experimental Oberon error/MSI series were absent. It passed 32
fork/COW rounds over 64 pages, migration across all CPUs, 1,000 concurrent
remap/protection rounds, 32 MiB direct-disk verification, network image
checksum verification and per-CPU HVC open/write/close checks. Taint stayed
zero, with no kernel warning, Oops or panic in the collected log.

With HugeTLB and THP compiled in, VII rejected huge-page boot reservations,
MAP_HUGETLB, hugetlbfs and forced huge tmpfs mounts, and MADV_COLLAPSE.
Huge-page pool controls were absent; base-page data and protection checks
passed. Since that boot, only commit text and a stray Kconfig blank line
were changed; executable source is unchanged. The tg3 fix is accounted
for separately.

The same runtime-detection changes were also tested in the preceding
hardware follow-up tree: M3000 SMP and true UP; Ultra45 / UltraSPARC IIIi
UP; and a T5120 sun4v LDOM with eight threads on one physical T2 core.
The identical SMP image booted on M3000 and the T5120 guest. Ultra45 used
its own UP configuration. COW and disk checks passed on each. Ultra45 and
T5120 faulted and verified real HugeTLB mappings; THP collapse produced
16 MiB of anonymous huge pages. These other-platform boots include the
experimental follow-up code and are not exact final-v4 runtime tests.
Ultra45 retains its existing ATAPI DMA advisory messages.

GCC 13.3/binutils 2.42 W=1 vmlinux builds passed in UP and SMP at each of
the revised commits 8-10. Unchanged commits 1-7 retain their earlier
per-commit build results. Existing FusionMPT warnings remain. The runtime
detection tree also passed builds with PCI disabled, HVC disabled, huge
pages disabled, and sparc64 defconfig.

Earlier targeted harnesses reproduce the generic bugs and VII PTE/readback
issues. A read-only M3000 diagnostic found shared-context and prefetch
state disabled on all CPUs at startup and across thousands of PROM calls;
it is absent from this series. No unsupported MMU state was injected on
hardware. These are bounded regression tests, not a long-term stability
or performance claim.

Current limitations
-------------------
VII HugeTLB and THP need further MMU work and testing and are refused at
runtime. Compiling them in remains supported for other processors in the
same kernel. VII CPU offlining is not supported.

Runtime CPU/bridge matching can also select these paths on other VII/VII+
systems, including M4000-M9000. Only the M3000 has been tested; mixed
VI/VII domains are unsupported, and hvc0 binds only on the M3000.

Shared contexts and hardware TSB prefetch must remain disabled. If the
state check fails while PROM is locked, the firmware console cannot
report it and other CPUs can stall behind that lock. The four-word
sparc64_vii_mmu_fault record is identified in System.map; recovering it
after a reset has not been validated. Supporting enabled firmware modes
requires a preservation/restoration protocol.

Oberon uses legacy interrupts; MSI and native bridge error recovery are
not implemented. A boot with PCI_MSI=y and a larger NR_CPUS remains useful
validation. CPU error handling supports restrainable ECC; other patched
error traps remain fatal, including PCI config-access errors. IPI retry
policy and broader error recovery remain separate work.

HVC calls firmware; a call that never returns remains unbounded. Fast
pasted input can exceed the firmware FIFO, and console testing does not
establish panic-path reliability.

Magnus Lindholm (10):
  sparc64: return from the generic clear_page implementation
  sparc64: honor queued spinlock layout in secondary startup
  sparc64: avoid huge kernel PUD mappings with small hardware pages
  sparc64: stop IRQ setup when descriptor allocation fails
  sparc64: validate Fire register properties before initialization
  sparc64: retain the DMA segment start across SG entries
  sparc64: zero newly allocated IOMMU page tables
  sparc64: add SPARC64 VII CPU, MMU and SMP support
  sparc64: add M3000 Oberon PCIe support
  hvc: add an M3000 firmware console backend

 MAINTAINERS                         |   7 +
 arch/sparc/include/asm/head_64.h    |  11 ++
 arch/sparc/include/asm/hugetlb.h    |   3 +
 arch/sparc/include/asm/iommu_64.h   |   1 +
 arch/sparc/include/asm/irq_64.h     |   1 +
 arch/sparc/include/asm/pgtable_64.h |  13 +-
 arch/sparc/include/asm/setup.h      |   7 +
 arch/sparc/include/asm/smp_64.h     |   2 +
 arch/sparc/include/asm/spitfire.h   |   1 +
 arch/sparc/include/asm/trap_block.h |   6 +
 arch/sparc/kernel/cpu.c             |   7 +
 arch/sparc/kernel/entry.h           |   2 +
 arch/sparc/kernel/head_64.S         |  20 +++
 arch/sparc/kernel/helpers.S         | 126 +++++++++++++++
 arch/sparc/kernel/iommu.c           |  50 +++++-
 arch/sparc/kernel/irq_64.c          |  54 +++++--
 arch/sparc/kernel/pci_fire.c        |  35 ++++-
 arch/sparc/kernel/pci_impl.h        |   1 +
 arch/sparc/kernel/pci_sun4v.c       |   4 +-
 arch/sparc/kernel/prom_64.c         |  28 +++-
 arch/sparc/kernel/prom_irqtrans.c   |  13 +-
 arch/sparc/kernel/ptrace_64.c       |   7 +
 arch/sparc/kernel/setup_64.c        |  57 +++++++
 arch/sparc/kernel/smp_64.c          |  83 +++++++++-
 arch/sparc/kernel/trampoline_64.S   |  74 ++++++++-
 arch/sparc/kernel/traps_64.c        |  27 ++++
 arch/sparc/lib/GENpage.S            |   3 +
 arch/sparc/mm/init_64.c             | 121 +++++++++++++-
 arch/sparc/mm/tsb.c                 |  19 ++-
 arch/sparc/mm/ultra.S               | 236 ++++++++++++++++++++++++++++
 drivers/tty/hvc/Kconfig             |  11 ++
 drivers/tty/hvc/Makefile            |   1 +
 drivers/tty/hvc/hvc_m3000.c         | 202 ++++++++++++++++++++++++
 33 files changed, 1189 insertions(+), 44 deletions(-)
 create mode 100644 drivers/tty/hvc/hvc_m3000.c

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935

-- 
2.43.0

