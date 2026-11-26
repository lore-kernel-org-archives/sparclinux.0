Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685482;
	b=5e/aT3c5+um7PkzvEIa948QL7BYOLxfkgGt2bRutF0A6iiRVKWvzTpxntofaSSEux/1W
	 Ye19S1kBgqO2rJF7wez6J+zfRq0nh8LvRrJlViupDHWyEs1ONzHXLqg4PWQDp5atJtvFZ
	 mD5zizlkII/nW9Ny4vRRgPhdMg8ZYTc3mJF65xQNjL1gQhJRYWA1jfnPUs/DXfV50Tjyg
	 ELTQTFlMaZb53xbzUiCUNZtoxfTAZEAlv0X4HU0hqTZiJHG957JaD6hWGGYgVp1DpdfAe
	 X12uscDa43JP8pH1FIxvBGrOM0wgySX2CFEY1kcMxv9RXPjExHt9V5NkkhYSi3dqAyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bv628Lo8+AyC8L/xOfSVfDz11Wpf4GPudGyr5smvzyE=;
	b=gyLkHiWPNUuUR9jml52jonBK1a/2Cgb7hqnt6baf8nwDW1/8pkx+su1uXTqj4EwihJav
	 azGJEub9ToMEfXzZQTvHja4jzCU7aek72I622+Sfcvygdkb+gFPtSlbsxY5LsWFMaXr1m
	 qLOSORzNsk9OfNKxK3XhAn8OKSENvDMPmdcbnbpU0Gf698B8j5O3OFqkoGLWEKoGJcZ0R
	 UmSxXv8dg3eVNnRXjzaJnhfyOp/kxciaV5GTarZgPBmvbQPlalwZmaO0Z9NeA/TIGyzZf
	 N4p/iSIvEqxY/Pk2Hts59b7MmGhNyi9VmhTeyWSiDIUk6ZY0VXVGwPuWwgpKLHJ5AVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iknZuzk7;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC632606A31C
	for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 09:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC632606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iknZuzk7
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c5198302d38so423127666b.0
        for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 01:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685480; x=1796290280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bv628Lo8+AyC8L/xOfSVfDz11Wpf4GPudGyr5smvzyE=;
        b=iknZuzk7biLzj0DS7fZ7ITEjwEEZOg3KWKlY9DPOgu4/xtIWQt3boujvyZ4EZGFdhE
         cyVZNybSGXVkQg4KJ84RFTM5z1sIcXbpfDM1s5BkAu26N41bS9aWH+At7PWmBglINSC4
         /kJvd3h1Qq9SrJMNgL3StRhlXZQRTtAFIshYyMsmrDNTT1Dtjsrv59JUKg2qSafGM+1u
         ceNzu/t2DxxdY4Zv3TRSgXJ6H1AGwnFCN4hdXxLzto7Gspp/F7WWltQIxpeK5P9TFl+n
         efwmO6TF87WVZ6IovAm1TmVz1ew7m2OY5nY55RGOZcKiyoYER/IV2CuteD8sTSgUkGLf
         rdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685480; x=1796290280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bv628Lo8+AyC8L/xOfSVfDz11Wpf4GPudGyr5smvzyE=;
        b=2dzSnZoXQp671WmE+y1oZRldJ41iqSd91/errmglBqNpbghBjwIUr3F2xZfRc/JUwt
         94FFTFqBG+ynqBE+dukPKBf0lJPFZu1fRE4PKDmYG0WwAeuwD2vNm3TYcbXdUAn/o1hi
         cMImW79pstc7rPZNJm423NKoQ0uzDguwZgroD/cQVaA3HvXObGTpGccFuEiHPtKFN6ro
         xRSMwcDDkdOr/HMev4hDUbJXGa1b3sSN74XYv2ZMpuVAJ80JjacmCjpcQRk87L8fbMaU
         HqC/UtXTguhYms+4vtT/BYUesQu5zSqsXqS+JklwehpRNvvwzeArWJFOU7YTwnSEcOMc
         OfAw==
X-Forwarded-Encrypted: i=1; AL+hErGwcQd08F2oUvDgllOiBc2WnYJp7DCsPDx6dnfm+QZwbKv+pNWoH+52Ddnc/TmnhurmQB+nxgEcqsQP@vger.kernel.org
X-Gm-Message-State: APuU4Z+exOpSI0j+2tg8wdHDyClCrdhgIv8BWQ+zt4usqZnJpv0Kh3rU
	d+Xn93HLyjVA3T83YIxTBOQzpBl/tJuRPlfSP+lQfE0TqSNYNiivt4aeMlyHlmfQ
X-Gm-Gg: AZFdTZcXXM09u8S5eMN51wUFljNYq6mwXoN57tibpXjetP6xtJV/4g0S7fp3MZtfUCA
	t7lTmrTBZLmf04EgUl1ruq8WqQeTqnBQ0TDvgAx173959XffqMad3TJ86VMfJkDC6kypp4HW04M
	pPsG4GW2l0/Hgf8EXi3gtupa1dDXhNkBMqA+DYbghspMoqdU+rBwctJoX39c8SSUqTm4bGQf+En
	ItdvPnhx0Brb0NvmgxGQH4KLYp3Swi4qJWaoDnecD9OZ31hgfSzuWze1rYukcjR/yOt5p/kDwdY
	wwCY2zOBalREtwmtOFLRyLNttTU8KtKo37W113SdgzdM3ER+YXkR/ASoca73ZWgsV4tus+Hj2WS
	c5tUCW9/SR7p2NUfyFfcZKi2jiXQcMA/lskJBhOWUa3sxOHUtwFyjm1QOE2b8O3+RJ8mU20wkaS
	M7CLrCuCm/BsvjBwK96CVtcdpoi9c1pFnzVRCR37XmfTa/qyMdL4Qm+AiX3HisaAzLN7mzHcbSH
	o718rkiNKGGN0oLgKE6fVGCT+aOKR7xbKV5VbiST9Fo7AxMuV3UomtdXDdNHF2EYcdhLOYWm6ml
	APEfm/oTLA4k1sYv7W1CLccJfFs0qurphnUd8jj478SkFHmK9kQpNjDnL3tpzTW7vLcNDXw=
X-Received: by 2002:a17:906:9f8f:b0:c51:bdd9:9062 with SMTP id a640c23a62f3a-c51bdd9945fmr205622166b.29.1795685479871;
        Thu, 26 Nov 2026 01:31:19 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdee82sm597090066b.66.2026.11.26.01.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:31:19 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH 00/18] sparc32: LEON SMP, timer accounting and legacy board support
Date: Thu, 26 Nov 2026 10:30:05 +0100
Message-ID: <20261126093106.1345825-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes four problems on LEON SMP and restores Linux boot
on the dual-CPU GR-LEON4-ITX with its factory U-Boot. Patches 1-4 can
be merged separately from the firmware and board support. Patch 1
gives cross-call IRQ15 highest priority so a lower-numbered interrupt
cannot block it at the controller. Patches 2 and 3 fix stale TLB and
I-cache entries on remote CPUs. Patch 4 fixes nested timer IRQ
accounting that made idle CPUs appear fully busy.

Thanks to Sam for providing me with a LEON4 board for testing, and to
Andreas for helping make that possible. This work grew out of my
ongoing efforts to fix similar issues on legacy Sun systems with
SuperSPARC and HyperSPARC CPUs.

Base and prerequisites
----------------------
The base is Andreas Larsson's for-next at c95443b98771, plus two posted
patches from "sparc32: repair cache hooks, mappings and TLB tracking".

  [PATCH 8/9] sparc32: retain mm_cpumask across TLB shootdowns
  Message-ID: 20261108223516.1125534-9-linmag7@gmail.com

  [PATCH 9/9] sparc32: enroll and order CPUs before switching address spaces
  Message-ID: 20261108223516.1125534-10-linmag7@gmail.com

Patch 2 needs both. The generic SMP flush uses mm_cpumask to find CPUs
that may hold a translation. The prerequisites keep CPUs in that mask
across shootdowns and record each CPU before it enters an address space.

  https://lore.kernel.org/sparclinux/20261108223516.1125534-1-linmag7@gmail.com/

Factory U-Boot and memory
-------------------------
Patches 5-14 handle the legacy PROM console and machine identification,
preserve the Linux IRQ14 vector during startup and discover the AMBA
and I2C devices missing from the firmware tree. On this board, cached
LDSTUB lock acquisitions can stall. Patch 10 selects ASI 1 for kernel
and module locks when the GRLIB system ID matches 0x01020db4. Patch 11
restores the header offsets that factory U-Boot checks, at a cost of
32 KiB in LEON-enabled images.

Patches 15-16 recover 62 MiB of upper SDRAM. The factory PROM reports
only the lower 192 MiB minus 8 KiB. With the upper banks enabled,
importing U-Boot's SDRAM mappings leaves aliases in the kernel's I/O
and vmalloc areas. Linux skips that import on this board and checks the
PROM map, DDR2 geometry and active scanout before adding RAM. The 8 KiB
PROM and 2 MiB framebuffer reservation stay outside the page allocator.
Mapping and unmapping a HIGHMEM page incurs cache and TLB flushes on
both CPUs. The workload cost is unmeasured. Booting with mem=192M
keeps the original memory limit for comparison.

Patch 17 joins the APB control registers and AHB windows into the
single device expected by the GRPCI1 host driver. Patch 18 describes
the DS1672 at address 0x68 on I2CM0. The LEON4-ASIC-DEMO was also
sold as a standalone chip. System ID 0x01020db4 identifies the ASIC,
and I2CM0 is at 0xc0000700 on that chip.

Andreas, did any other carrier ship with this ASIC and the factory
GR-LEON4-ITX U-Boot? If so, is there a firmware property or board ID
we can use to tell which carriers have the DS1672? Patches 1-17 can
proceed while we confirm the match for patch 18.

Testing
-------
Hardware testing used a dual-CPU GR-LEON4-ITX with PREEMPT_VOLUNTARY.
The TLB, I-cache, timer and cross-CPU memory tests used integration
kernels with other pending sparc32 work, including earlier revisions of
the LEON changes. The module-reload comparisons used for-next and both
posted prerequisites, with the TLB fix as the only source difference
within each pair.

* During a HIGHMEM unmap, the Ethernet debug link (EDCL) showed CPU0
  spinning on the cross-call lock held by CPU1. CPU1 was waiting for
  CPU0 to acknowledge IRQ15. With patch 1, the board booted from the
  Maxtor and EDCL confirmed ILEVEL=0x800e with both CPUs online.
* In the TLB and I-cache tests, one CPU changed a mapping or rewrote
  an instruction. The other CPU read the page or executed the code. The
  baseline returned stale results. Each fix made the corresponding
  remote test pass. Repeated module loads also faulted without the TLB
  fix. With it, the corrected harness completed 74 load/unload cycles.
* In an earlier boot with patches 2-16 and both CPUs online, EDCL and
  a test module confirmed ASI 1 at kernel and module lock sites.
  The module's lock tests passed. In
  Gentoo, we checked per-CPU accounting at rest and with a workload
  pinned to one CPU. The idle CPU continued to report idle time.
* The CPUs took turns writing and verifying page patterns in both
  HIGHMEM banks. An EDCL page-table walk confirmed coverage above 98%
  in each bank, with all tested pages outside the reserved ranges
  and the 800x600 framebuffer active. A second walk found no inherited
  U-Boot SDRAM mappings in the PROM-import window.
* Gentoo booted from the Maxtor on a PCI 53C895 with sym53c8xx.burst=0.
  The stage3 install with bursts enabled logged 15 PCI master aborts
  (status 0x2000), each followed by a SCSI bus reset. The install with
  bursts disabled logged no master aborts. The cause is unknown.
  The DS1672 registered as rtc0 at boot, set the system clock and
  returned advancing times in two hwclock reads.

Before the IRQ15 change, an integration kernel with patches 2-18 booted
Gentoo on a dual HyperSPARC SS-20 with both CPUs online. Those patches
also built at each step with modules for LEON and generic sparc32,
both UP and SMP, without warnings or errors. That tip also built with
sparc64_defconfig. Host tests covered the U-Boot header, firmware
discovery, lock selection, framebuffer conflicts and GRPCI1 pairing.
Full-preemption and context-exhaustion testing remain open.

OpenAI Codex assisted with implementation, board-capture analysis and
validation tooling.

Magnus Lindholm (18):
  sparc32,leon: give the cross-call IRQ highest priority
  sparc32,leon: retain SMP TLB shootdowns
  sparc32,leon: publish instruction updates across CPUs
  sparc32,leon: avoid nested IRQ accounting in the timer handler
  sparc32: preserve both LEON PROM character-output conventions
  sparc32: tolerate firmware nodes without a name property
  sparc32: skip unavailable PROM V0 console metadata
  sparc32,leon: identify LEON before the firmware model lookup
  sparc32,leon: preserve the Linux IRQ14 vector during startup
  sparc32,leon: use ASI 1 for locks on the GR-LEON4-ITX
  sparc32,leon: restore the kernel header offsets used by U-Boot
  sparc32: recognize the legacy LEON firmware machine ID
  sparc32,leon: discover AMBA devices for legacy U-Boot PROMs
  sparc32,leon: describe legacy AMBA I2C controllers
  sparc32,leon: skip the GR-LEON4-ITX PROM mapping import
  sparc32,leon: use the upper SDRAM on the GR-LEON4-ITX
  sparc32,leon: combine legacy GRPCI1 plug-and-play resources
  sparc32,leon: describe the DS1672 on the GR-LEON4-ITX

 arch/sparc/include/asm/cacheflush_32.h |   2 +-
 arch/sparc/include/asm/ldstub.h        |  46 +++
 arch/sparc/include/asm/leon.h          |   3 +
 arch/sparc/include/asm/leon_amba.h     |   2 +
 arch/sparc/include/asm/machines.h      |   1 +
 arch/sparc/include/asm/oplib_32.h      |   2 +
 arch/sparc/include/asm/sections.h      |   2 +
 arch/sparc/include/asm/spinlock_32.h   |  32 +-
 arch/sparc/kernel/Makefile             |   1 +
 arch/sparc/kernel/head_32.S            |  46 ++-
 arch/sparc/kernel/idprom.c             |   2 +
 arch/sparc/kernel/leon_kernel.c        |   2 -
 arch/sparc/kernel/leon_legacy.c        | 487 +++++++++++++++++++++++++
 arch/sparc/kernel/leon_smp.c           |   9 +
 arch/sparc/kernel/module.c             |  25 ++
 arch/sparc/kernel/prom.h               |   5 +
 arch/sparc/kernel/prom_32.c            |  16 +
 arch/sparc/kernel/prom_common.c        |   1 +
 arch/sparc/kernel/setup_32.c           |  57 ++-
 arch/sparc/kernel/vmlinux.lds.S        |   5 +
 arch/sparc/lib/locks.S                 |  24 +-
 arch/sparc/mm/leon_mm.c                |   3 +-
 arch/sparc/mm/srmmu.c                  |  21 +-
 arch/sparc/prom/console_32.c           |   5 +-
 arch/sparc/prom/init_32.c              |  23 ++
 drivers/of/pdt.c                       |   9 +-
 include/linux/of_pdt.h                 |   5 +
 27 files changed, 793 insertions(+), 43 deletions(-)
 create mode 100644 arch/sparc/include/asm/ldstub.h
 create mode 100644 arch/sparc/kernel/leon_legacy.c


base-commit: c95443b98771a74c6689f5e7bbc56794fe95f550
prerequisite-patch-id: f4142189700ce7c766378c481a47244a7dd13140
prerequisite-patch-id: d2a8aa69c22fd06cbd2dae10f81e1c6db1b95a6d
-- 
2.43.0

