Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C4137756C
	for <sparclinux@vger.kernel.org>; Mon, 28 Sep 2026 20:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790626128; cv=none; b=Ox2mCkVoQm/fRz4Q2hs7rEl1uEgI/gw/y5ctzV1VJypEp7954/oH0ftp9OscQox6b5AGur60pj0zvKTmpFCae+HaYzsdK0MI9Nhbyr2xtcNKms1au6TqwPlO8X5oFJo6ljrBi1Kk6Uu/nPzOeEDpoojqr3bhZRRjFoPFAtjPBto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790626128; c=relaxed/simple;
	bh=xMWE88EbzMyp3i07QnNwiRf7SNDo2VhNoPqT6IdwHB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kTKMazWzPOw2J1JNKB9FPZVLYwPWery4hjMcbWjNYz3naI9mR/ki3EIG0GCdergOb47pP/4JB7Vt9g3dvaP4fYQRvqSilPA9yp/xmCuwKBaZ81Ia8ZylwT+Eh15i3EdyieVvxtnK0ru4nv0dGuYo0Gu/J5bMD5Or+TyuzA8S63Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kn8aR9QH; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kn8aR9QH"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2af7721e4aso456690566b.1
        for <sparclinux@vger.kernel.org>; Mon, 28 Sep 2026 13:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790626124; x=1791230924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SMEvPxogfuA8v3y1GN0ADmILypPDhBWYOLVdDbor458=;
        b=Kn8aR9QHwlX/PPM4AFCtOx+aFt9IRN6RBi/boeXdFsql0XlilKedWIaHMmCxikdzdF
         6GG2wb0bNNUZc6x5QWdyPefsRx17H7MLfxjWBbnpuexc7moLb4xF4XYx950Gzg5195bj
         s54arJWNOHUisd17edqnMrcq9zjRY2nM+i6hzcr9LZtFlS4r4ybriLQRXZ7DTwWtzLtM
         j4aG5oxHEZb1qqV6YAYkr6gPTipI2fAuw9C9LrrP1GnX3idKqMav6V8dgJ2roZKZY8Fi
         NPb+ZrR6OFvAEXeW0xY60KAaW9/0jrwhPZV+lWahjHv2jwEK9kR3N398E6a7Mozr69XI
         nWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790626124; x=1791230924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SMEvPxogfuA8v3y1GN0ADmILypPDhBWYOLVdDbor458=;
        b=XrfqLJfky4neXsxVebtqPRbNreNd/9ZnXmALbDcjkPCO6UQUTca6/BCsr4zU+6PbOk
         +qsJ6owbLPRIgCLJQRsX08It9uo3f60SGnER6TqWbgfyxZcVbChw+2PrzJ0C0s+28tdM
         QzxAQ4X1u1emsGK/WbTQel4JTuaPgFUH+0Kd3/bEoxiyMNwpc33HElRM7LtW0kFymZ5x
         gGEqA5XEZKNW6Cp3h5oZLlT9DSo+e8YpvbWQ9ul6xVoLCScWgb5NwesydbQMtI0KYZ90
         0LQMaSTGO/JgpstM86MTRwWWnmVZ0L1ptsraivN/N0HYDWX6HAbHiqFuzfP6ThYahAkt
         Y7xA==
X-Forwarded-Encrypted: i=1; AKwUvByHfnayQ+56zsPJK2bbxSfxNsua1ybQF14u+smtSWvYOlx0j9hsCglPeGY9nRQBumw89+rGNXukMT2v@vger.kernel.org
X-Gm-Message-State: AFuF++kZRipKgc6bvEKx5snr8mCVLrIupunoim2vT1dNM6w+fy8TYPeS
	ULM9z2b4cL6fh1khk6WuCfBERxndUOdSc6ytbT+BtqcbkBCH/LILpD2b
X-Gm-Gg: AYBFou0hTpFrH/1pAQcM2Wx9Lvany0N/0hBAK67CIS0/5mpyiC52dlcgjiyRtLISb4m
	4pDVPcECDJqkPXeKezOY6OlRSlrfzeUVHaHHgpY8WGO+pBxNEF+eG9yUGOnw006SlwHgnRTqilU
	TjZe+vJW7S+pku+AZB3H+XjPt1OgMw1ddqOBQnw6Dnaf8ncjQjkL4UaUMED2Y5yvatAACcWJEWb
	cxYqrmhyk2QJr6AlTEWMmGopV3cnuTHISrjsU12lOFKgHpDDrQD5NMXj6eNCUCsL/1w9zv3E1WV
	5YEDcU5CcyBUe8x480+9F7vx1jpdWnY+5xIl4FXySNQDdQeU1F9kXlo//xO8RTJI1bdZx5jLkJ6
	LnlMQvvmWjyLvaME9L2qIa/3EDyoLod2SVKlhoZxndIqWftEMxf5xnfQb2ISqvIm4Y/AMdyTAwz
	C85jk3qzrcCZMJYDpuF1S6bmKDca+QGDSf/bCj2J8QUmo/XyxaY52BYIHOXFpCXOKEgdFzu/Htw
	quDcuHgF4ofZzIURFaEqLlaZMieVdIQe6AEn6J6
X-Received: by 2002:a17:907:e918:b0:c26:19de:913a with SMTP id a640c23a62f3a-c2ac2674c23mr1124875866b.45.1790626124156;
        Mon, 28 Sep 2026 13:08:44 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae76abc3asm509778166b.37.2026.09.28.13.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:08:43 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: linmag7@gmail.com,
	sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] sparc32: allow a kernel loaded away from the start of RAM
Date: Mon, 28 Sep 2026 22:06:21 +0200
Message-ID: <cover.1790548064.git.linmag7@gmail.com>
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

Link to SILO repo containing fixes:
https://github.com/linmag7/silo/tree/release

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
implements it for sun4m and sun4d. The probe and diagnostic are limited
to those platforms, avoiding a bogus kernel address on LEON.

Patch 3 sets HdrS to 0x0300, the protocol level that tells a boot loader
the kernel supports being located somewhere other than physical 0x4000.

No change in behaviour when phys_base is zero.

Changes since v2:
 - restrict the PAGE_OFFSET probe and diagnostic to sun4m and sun4d,
   avoiding a bogus kernel address on LEON (Andreas Larsson)
 - fix the diagnostic wording to "RAM starts at" (Andreas Larsson)

Patches 1 and 3 are unchanged from v2.

Changes since v1:
 - drop the (unsigned int) casts and print with %lx (Sam Ravnborg)
 - always report RAM start and kernel start, not only when they differ
   (Sam Ravnborg); in v3 this reporting is limited to sun4m and sun4d
 - collect Reviewed-by from Sam Ravnborg on patches 1 and 3

Patches 1 and 3 are unchanged from v1 apart from the collected tag.

The v2 series was tested on a SPARCstation 20 booting from SCSI to a
full userspace, with and without an initramfs, using a SILO carrying the
matching loader changes. Also boot tested under qemu-system-sparc -M
SS-5, and build tested for LEON and plain sparc32_defconfig. Each commit
builds on its own. 
The v3 version has been build and boot-tested on the SS-20. Emulation
cannot exercise patch 1: microSPARC-II takes a different cache flush
path, and qemu models no write-back cache, so a missed flush has no
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

