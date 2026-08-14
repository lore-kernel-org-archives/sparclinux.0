Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5447145A285
	for <sparclinux@vger.kernel.org>; Fri, 14 Aug 2026 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786705487; cv=none; b=RXIBE+RGkWLIsQLqreCefxGbo/wrvc11Fa/CBPBC5dnYtR7EE25JU9iVXBKPpD1xCknX+Tyuj7y2ha+yKluTliIbtU699ejiG+zK9naJCcPp0LrqiJ7o5eKxgjWu8YA0DfBl2Y3UY+I2FzHzv3eviJH1G+fbb1sqLnTz56sT6vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786705487; c=relaxed/simple;
	bh=HqQ0fEQGk1bZAGwWWc+vH0JEFr0l3ZEK/aZxKLaZ6ls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+qyd2ePFfpT97kK1eVLVFF0OiUlvJo97nfcjmkJ6wDTgWFm4pw+9JcqtfcPfpDzmeA367fp9iOPG2ddYdeXX9ku06TQuBAACmKoEa1CSr0xaRCQuXQPcgVCk34wpLjaKkzEcAbDAK3bgN25kz9buEk01z+x1Ynhjc5soTlxQ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWIiVexS; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWIiVexS"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15d47266baso100573866b.3
        for <sparclinux@vger.kernel.org>; Fri, 14 Aug 2026 04:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786705479; x=1787310279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AHkk9X5Auhk5oo3B+6JZ63WAKaoKtca2c/H9g4rcRdA=;
        b=MWIiVexSH9wpGvnAsb8BEhC8l5ROG9NkcmZD9K5GW/xsTAVoByj22IswGgXaVfBVtB
         ihz4JE4cxb4ugBwVvILTAH3QJkUKhcfvY+A6uhuVg3jXbqMItJzPHTwANNa5q6E2TdEe
         U63Zvf44vtW4I3rQEtlEl24r14qD0jH+FlLJhCgsVx1GUu+gg2LKro6kxkY5Eo5KMzpx
         fZG/DvzjHJv/IXZ0PGfqM0faY84c5AITgvlr62Df/FHmecqzYfs2KAtzBStDl1sGem39
         M6qckm3AclT/TARVIK9mWsew8sG9Ckk+mrbBzrSz4BP35brvZWoxL/BDfXp6nwA3BEpo
         sIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786705479; x=1787310279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AHkk9X5Auhk5oo3B+6JZ63WAKaoKtca2c/H9g4rcRdA=;
        b=D2fonjDAMqTavYxx+UTTFalcud4KGVs5A7icn2E5EBpqzaVv+OfgFSsb8EwzJEXXOY
         psYS0WtIU7IB0OnI+cupHEESpbmqM4RkrvnOWVQMz6sIQsrPdWdvmk5nIJihRmeWweGV
         Eobd0G7c9/FS6jGLw/5bvFcljH5NbTfLJwESgkDdP3vEv/Pho4eqsfT0ITJeHXuRXCC7
         fEBE5fpTltRlvQAkzBD5pjVf8gQrBcVLn/37s6STvs15M8imEUBHpYXoUOrT4vEcEGJk
         i1A79E8dudtHzCxoVJvuR2u10XrBbFFdTM75RTav+iOp3iIsMJMT9EgwgO3CL5KCeAXq
         HltA==
X-Gm-Message-State: AOJu0Yw45a79HEVt59E4g/KipOTkjfvEFGe3dwSWc0NIJtnBCRhHp54Q
	xQQrIo7qJhPbxMnxfKmHosPtpQId7BNhrT2kZZvykixTHZkMxgRCH0nWw9Czsw==
X-Gm-Gg: AR+sD10AkeldvazizIltyed8YBTUMUxjIcYEiXyWr1O3RaYFSSPxEEqDcWWRjUM1nw+
	2g/ECxxxkL58ep15xEvfxGVCauEY9VVQjmGBbai+cJa1IwxdXo3Eju6n4Vwzp7MV85FygWBB7/S
	of2BRNmTCwnVZGhNkQbkPjQW9jA3k+5d6HKMKKjBwVByd9HVpnBFMIFCubvbMH5DrTgrjNHGdaw
	L77SHHcEE1Af5KfThRab27JiPB2sN85MAN8MvRiMd1wJqerqokNxBrBIoNzpdohPRpE8RjORL5i
	yMK/csVPTyZhRKKsdeKDp0aqG6CzLjx6QmIdHuvaRtkqlxIQ5980ck1PQPR80eHIbwtOYLnA8O3
	Vee1kJO4PqjEq18Q/kx4KAqjjQm59Hk0kFBCBuGjbqDosplq7GC8ZumFtX+TRFpR1JHpJHdgsSq
	0bTo+sam74wRdPFi9fg+LRVpjDrj7X6AAPgjYxPYNedg9/QfnGYTz63lyMCAuoqOB1dIqmsqMDh
	tRaZDy5y0z+tfYNCpBZvvCzWHq+ufBU8tqgQh968g==
X-Received: by 2002:a17:907:80a:b0:c20:2b23:71cc with SMTP id a640c23a62f3a-c2129b96a14mr220288366b.10.1786705479319;
        Fri, 14 Aug 2026 04:04:39 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c21233a12e6sm92028366b.12.2026.08.14.04.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 04:04:38 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH 0/3] sparc32: allow a kernel loaded away from the start of RAM
Date: Fri, 14 Aug 2026 12:52:31 +0200
Message-ID: <20260814105723.3454511-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many years ago I ran Linux on my SPARCstation hardware and tried to keep
up with new releases, but somewhere around 3.x I hit a wall, sooner for
SMP builds since they are larger. As the kernel grew it simply became too
big for SILO to load. On this machine the last one that fit was 2.6.32,
at 2598956 bytes against a 2605056 byte window: six kilobytes to spare.
3.12 was 184KB over. Fixing it turned out to need more than SILO changes,
the kernel side needed work too, and I never got around to giving it
serious thought. I recently dusted off my old SPARCs and picked the
journey back up.

A current sparc32 kernel no longer fits in the window SILO loads into:
0x4000 up to SILO's own text at 0x280000, about 2.5MB. Loading it higher
instead exposes two places that assume the kernel sits at the start of
RAM.

Patch 1 is an independent pre-existing bug. viking_flush_page() and
viking_mxcc_flush_page() compute a physical address as vaddr -
PAGE_OFFSET, which is __pa() without phys_base. It is wrong regardless of
the rest of this series; it simply cannot be observed while phys_base is
zero. When it is not, iommu_flush_iotlb() flushes the wrong page, the
IOMMU walks stale IOPTEs and every DMA transfer fails. It comes first so
that no commit in the series leaves Viking DMA broken.

Patch 2 makes setup_arch() discover a non-zero phys_base. It takes it from
the lowest sp_banks[] entry today, and phys_base is the offset __pa() and
__va() are defined in terms of, so once the kernel is loaded elsewhere
every early translation is wrong by the difference, including the physical
addresses written into page table descriptors. The tablewalker then
follows pointers into pages holding nothing, while the same tables read
back correctly through the nocache view, and the machine stops right after
the context table pointer is installed with no console left to say why.
The probe is the architecture's existing __get_phys(), which already
implements it for sun4m and sun4d and returns zero elsewhere.

Patch 3 sets HdrS to 0x0300, the protocol level that tells a boot loader
the kernel supports being located somewhere other than physical 0x4000.

No change in behaviour when phys_base is zero.

Tested on a SPARCstation 20 booting from SCSI to a full userspace, with
and without an initramfs, using a SILO carrying the matching loader
changes. Tested with both CPU module types this machine accepts, single
and dual:

  SuperSPARC-II, TI Viking/MXCC   the path patch 1 corrects
  HyperSPARC RT625, ROSS SRMMU    the only variant whose DVMA mappings
                                  are page coloured

With two SuperSPARC modules fitted the flushes patch 1 corrects are
reached through cross calls; 400MB of concurrent raw block reads on both
CPUs completed with no DMA errors, where a single transfer failed
immediately without the patch. HyperSPARC, which takes a different flush
path entirely, boots and runs DMA with no errors and no change in disk
throughput.

Also boot tested under qemu-system-sparc -M SS-5, and build tested for
LEON and plain sparc32_defconfig. Each commit builds on its own.
Emulation cannot exercise patch 1: microSPARC-II takes a different cache
flush path, and qemu models no write-back cache, so a missed flush has no
consequence there.

The cost is the RAM below the load address, which the loader chooses.

Magnus Lindholm (3):
  sparc32: honour phys_base in the viking cache flush routines
  sparc32: derive phys_base from the PAGE_OFFSET mapping
  sparc32: advertise relocatable kernel with HdrS 0x0300

 arch/sparc/kernel/head_32.S  |  2 +-
 arch/sparc/kernel/setup_32.c | 40 ++++++++++++++++++++++++++++++++++++
 arch/sparc/mm/viking.S       |  6 ++++++
 3 files changed, 47 insertions(+), 1 deletion(-)

-- 
2.43.0

