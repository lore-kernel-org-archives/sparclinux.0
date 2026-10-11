Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40485456DE6
	for <sparclinux@vger.kernel.org>; Sun, 11 Oct 2026 19:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748669; cv=none; b=ONb3P1D4daFyYxX2G+z8RYpDNqrZ3i5wmjm+tzQ15oXo6AbOGgo6MEfT19uSD0G7hdS1ok5vfsso9LznBIHFokortZA7Yk5GHCVQ60GbZ9pCeRmI7qF/kcuWCEAN8+QA/Ap3rzS2AiJYHR1cBJuedXeXgvHFSBjvD1eOv+ewPQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748669; c=relaxed/simple;
	bh=kXot8RBIFwxlA/+fw9UjNqSx52fBPKCc3YvC/GH92U8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ruYTimT5Lj7fMzK9nDPKd134qsiVwQszRulVKbHi0HH0WSu3ZWbuhwHBsXWZSNY8emQmeYzSMFkagQHz2AFzl1eGXnrjE90FA0YYBgx2/KMHhL8MP8GsNkSz8ExVBmct04QLk55VoWchWaWhXkfRrTuENQIbbXfajJsucIWW3DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1AScMRE; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1AScMRE"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1aa2848d2so931768a12.3
        for <sparclinux@vger.kernel.org>; Sun, 11 Oct 2026 12:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791748666; x=1792353466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1nsk2mdhFsso8ym6DQn4vGnG7ZKpsogWBUPuZQB9l70=;
        b=N1AScMREVuB2viFgS51ELyz4plAWkkn8fLHKzEXF39RZ7FWREYyxXKckyloEq/jIzU
         zbg2rZRgzpMTs9a4cHzZFmbzNiip6f06uDu9EqmpNfBDQgrUO0FIbqRVip5Q8003dluX
         ltWnvCe84OCTGkdXyZ2tqhUb1ttuJbXQ6OXAb3uFN0EA0Ql4QFb65kmlaT/hSTUbGvOu
         /tifmALes8e5f4xRp7upOpFADc0luylUwKh6ZCAn29mwgwPu1lfi8F1HFFyfR4jXMGXx
         EqT5mg+Zvnl4kz/HVsLMsrNr7jrGvBbtBNidPMfT+0hVa1/6DG30fcWQSIO48iS3rSrU
         Khvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791748666; x=1792353466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1nsk2mdhFsso8ym6DQn4vGnG7ZKpsogWBUPuZQB9l70=;
        b=KIQyjUBMzYZ03NU7iqXhrqApi/C7uTXzaXHQwB4hM8jsD/Ak03SdMDViq84bWAb+VZ
         Zm5qevC4wM1x/RQSTf5IAW8XJF9RUGFbwKYcFxEF6Z8glg/a83k5zQrAQe00y2vyIfoz
         7E/doFHoabqjv5f+Hb80puOSFKPH6dc1x0YuXdrJsN/NOXWvndfraW67Zasx3iHoJPXm
         TZ6cCKGs/NaTOwllM1ojkR1O2bvtmzhyWbFTK0hbyw5kKJhBfYEiHviVgZB6ejOWGMvn
         FgeX0nph49mwnRU6m3lSV6FMBvPjvfGdpU6xLE6U+V5bYIHVuplmEpTTG6KROQm7N9sb
         XKsA==
X-Forwarded-Encrypted: i=1; AKwUvBzPsJn+zNP590pScVh7P7vNcbxWhdwf2OFHwzI2Br3TgXnqxsKg+U2aJJ2zTdrzkACade2qXqix9Cc9@vger.kernel.org
X-Gm-Message-State: AFq9FYJAftO6BGfph7E60ZViifqJbJY6aiCZzPVfj8O0LYYsPwDt9mwa
	0FFUUK3M8hGDVeHlcBIjYQD/8Af6m+LoSNMtg/RJY7GX60QqWDMm2Yrc
X-Gm-Gg: AYBFou0bWK8unSAvuEqk58+jOEQM3P41XE4cEXeW0YE273x6HLJbRRVhPU/Ngk0t+L7
	i6XVK2odyDyV+qc58+OU6L2P+MKc3mrRVjJrSSw/U5K0tZSmZDy+2cPyx0t5tHBwcuEgkUB6SE1
	z0bkNe6ulWUA6OYMkVpbafEnHS+mSAQoPMCj5GiwC7ZHCmUqNa5g+Jedo531Dh+F9g71N0qOaak
	ClB4Xpir2JsSLo7NJs6A04hjuyhCGPtiD63QnvR3rXSR6RiTAYsQ/taUbVwr7g/QgpARfZS/eeR
	ySzKQxgz35uR4OO6azY6eQmjKHX6ZleBK/zS2WyOqlFAuaEnmLjCd/SKBwePFxjASRukc+ySOVj
	HwGfR1i3WOnS9ZrS4VP9OY8ygU6+jYLVrUPzokiaf3B2IjzuoE7uq8Blu+jq4cmY6UoypwPvYs3
	LMgXUBsGFhTj8lydCWAOkdQM7bk7h7wyQozHovlClmMjzMQERgrzad2rllT1JvNqE1GP7qGYvXx
	aB7C4hqJAJUfz24YAlJlwxj6FcDV+w8966AAUYK
X-Received: by 2002:a17:907:3d09:b0:c31:8cfe:9a25 with SMTP id a640c23a62f3a-c31a9fd33dcmr813951666b.9.1791748666339;
        Sun, 11 Oct 2026 12:57:46 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a3ae9fsm381315566b.26.2026.10.11.12.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:57:45 -0700 (PDT)
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
Subject: [PATCH v2 0/6] sparc64: add Fujitsu M3000 support
Date: Sun, 11 Oct 2026 21:55:52 +0200
Message-ID: <20261011195729.981243-1-linmag7@gmail.com>
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

This series adds support for the Fujitsu SPARC Enterprise M3000, with
SPARC64 VII+, Oberon PCIe and a firmware hvc console.
Based on Linux v7.3-rc1, commit cee9395acd8043be0644b25c34bfa86623f2b935.

Patches 1-3 fix existing sparc64 defects in generic clear_page, secondary
queued-spinlock acquisition and sun4u kernel huge-PUD mappings. Each has
a Fixes tag. Patches 4-6 add the CPU/MMU/SMP path, PCIe bridge and
firmware console.

Changes since v1:
- Split the tg3 firmware byte-order fix into a standalone netdev patch,
  as requested by Jakub. It has no code dependency on this series.
- Address Krzysztof's topology review: replace the root-model check and
  adjacent-CPU assumption with compatible core nodes and cpu/core/cmp
  ancestry. Unknown ancestry produces no inferred sibling groups;
  hardware CPU IDs are unchanged. This uses the observed firmware tree,
  without claiming that the root model is a documented binding.
- Address Greg's console-state review: group state by HVC term number.
  Retain static storage for early console use and firmware-visible locked
  mappings; the M3000 exposes one /chosen stdin/stdout pair.
- Replace READ_ONCE/WRITE_ONCE polling-state access with explicit locking.
  A spinlock protects active state and timer rearming; a mutex serializes
  open, last close and hangup while close waits for the timer callback.
- Remove the arbitrary eight-attempt write loop. No progress returns
  zero: HVC retries buffered TTY output but drops stalled console chunks.
  A firmware call that never returns remains unbounded.
- Retain the raw buffer lock because console writes can run in atomic
  contexts. The PROM lock protects firmware entry, not the buffer copies
  before and after it. Panic/NMI and recursive console safety remain
  unverified.
- Retain the service-name pointer cast: p1275_cmd_direct() takes unsigned
  long argument cells, as used by the existing prom_console_write_buf().
- Remove stale "experimental" wording and the console success message;
  add copyright, use min(), and fix the Makefile spacing and blank line.
- Retain CONFIG_SPARC64_VII and its HugeTLB/THP exclusions. Removing the
  option requires runtime feature gating and further MMU work. Retain
  separate VII demap routines: similar Cheetah assembly does not establish
  the same hardware synchronization requirement there.

Onboard BCM5718 networking also needs the standalone patch
"tg3: normalize inherited M3000 register byte order". Apply it alongside
this series for complete M3000 testing; it is not a build dependency.
The two submissions can be taken through their respective trees.

The six-patch SPARC series also applies and builds without the tg3 fix.
The tg3 patch applies and its driver builds independently on v7.3-rc1.
Applying both submissions in either order reproduces the tested tree.

The combined v2 tree, including the standalone tg3 fix, cross-built with
GCC 13.3 in SMP, true CONFIG_SMP=n and non-VII Ultra45 configurations.
Each prefix of that seven-patch tree applied and built. The combined,
uninstrumented SMP kernel booted from disk with eight threads; true UP
also booted from disk. Both reached Gentoo/OpenRC with hvc0. SMP topology
reports four cores, two threads per core and one package with reciprocal
sibling masks.

Bounded SMP fork/COW and remap/protection tests passed, as did UP COW.
Console testing covered login, 100 paired-open/last-close cycles,
hangup/reopen, paced input, idle input and concurrent output. Rapid
pasted input still loses characters. Mocked firmware tests exercised
partial writes, no progress, errors and invalid return counts; topology
fixtures covered sparse IDs, package separation and missing ancestry.
The Ultra45 configuration was compile-tested only for this revision;
topology fixtures do not establish multi-package hardware support.

Oberon MSI and native bridge error recovery, VII CPU offlining and
complete RAS recovery remain unimplemented. ECC recovery was not
fault-injected; urgent errors stop with a raw record. Raw-IPI page
lifetime and Oberon ordering remain audit topics.

Link to v1:
https://lore.kernel.org/sparclinux/20261002161515.932316-1-linmag7@gmail.com/
Link to tg3 patch (v3):
https://lore.kernel.org/sparclinux/20261011194228.981141-1-linmag7@gmail.com/

Magnus Lindholm (6):
  sparc64: return from the generic clear_page implementation
  sparc64: honor queued spinlock layout in secondary startup
  sparc64: avoid huge kernel PUD mappings on sun4u
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
 arch/sparc/kernel/irq_64.c          |  50 ++++--
 arch/sparc/kernel/pci_fire.c        |  31 +++-
 arch/sparc/kernel/pci_impl.h        |   1 +
 arch/sparc/kernel/prom_64.c         |  27 ++++
 arch/sparc/kernel/prom_irqtrans.c   |   7 +
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
 drivers/tty/hvc/hvc_m3000.c         | 205 ++++++++++++++++++++++++
 31 files changed, 1064 insertions(+), 34 deletions(-)
 create mode 100644 drivers/tty/hvc/hvc_m3000.c


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.43.0

