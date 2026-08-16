Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB0630EF68
	for <sparclinux@vger.kernel.org>; Sun, 16 Aug 2026 07:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786866808; cv=none; b=PMZTFiT37y6RwhduufCR7ArKqZbcifpkcU447JIcj3N7bxD9mdW3RXpb6aGNmOVCmEtzXH42JonhijyEXqEcnYPnW0taL1MBt8wG6Mvb0kj+2f/KZFv/q500vZzZ1Qp+mYJ49dtPo5xPBSUwPOJ06Yk1OT7RjJ5Qdc/Wucpx79Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786866808; c=relaxed/simple;
	bh=iJws9cMU3JxPn+6thXAIZwVSZOHadQXF+fFjSWfuO/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DiPRDyvWbOd1sgMz54AXoVySvk2WRo2p+j2WydIoUL/ysD/8xLGR/rLOIyKeSdOK6kdp97VmlxUbLnWpNPySKVMAaemWDcYSlLBaiLh68sXmjNMyDgEwz2eerRh6yFabU4e9TiccrNfjIRqawxecKjgT05OnMbbbkfKBQ3Sus9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+HxHZTn; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+HxHZTn"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b15dcaca31so2171726e87.0
        for <sparclinux@vger.kernel.org>; Sun, 16 Aug 2026 00:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786866805; x=1787471605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sdpGdtIJTgPziDsxDwqeF79PiinqDS6T265fdArr+gw=;
        b=j+HxHZTn5IINqh9/k3aPF/8b0SLYyvaIBmnM9bswkfaHKug1mu3lK47uP3AKU2Fe1n
         uQF2jdPfwZZg8uva4PAf2uv553sYI3PUAR0KS2SmywP30p48/TAAUEer01MEvrHQAnH1
         7O30SPvqrrI/Jf7w8Od8ILcjBz+PXnq2BU4ecCAAiNyxkAUE/02fNKWsfJHfkvJ3PHXS
         tiSqfmAfHgrpnZVfBhw8AAGm0qB++LWwvsW8Lr8rW8/upyKRR1aolEaihfMPnmqq6o9o
         pbckWhPphwh/JZctJzw8VaurTNBc6F42Z9jp86xf+REs6beq58s8WES+NeCY9aSoX8Sj
         5pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786866805; x=1787471605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sdpGdtIJTgPziDsxDwqeF79PiinqDS6T265fdArr+gw=;
        b=om5PfQSnPavh2pgRnXIszuw/6WjdLhpMnDJgHihKqzPJcwI5z01v2SOIXVgb6r2PlT
         eiliKy97hRIUT53mqMj4OP5Zh/XFxC7yZftpZTpcJ+oILTjHIrnj40L7weQdeeKwSlQW
         7FCTniTEZ94WI0Q8VUGWPcyiZrbNFvSE9dMQsTPkScZcHY5j1XWr01uvSF5DtylpANPs
         /q2hdXfgzDwBxTFm7nqCmADbRHswuaGovOde/qlZgcybTOznHNP8V3s42VX1NCjtYoy+
         n3poLGfsfX/NbbIZcUFuOVAZDXVJP8FnxZx1J1DTbapcZPxkwob8sk8RXoFmKnqTsjOt
         IY/A==
X-Gm-Message-State: AOJu0YwbQgFs74ZaTVhM8K6Y8Ih4AhOv3k9ueDG98IP14rbZwkbf4F7N
	/weKXIl7YiAvVnLJkGjiE+e/gDb4pQiBO9UDFMqFC1WUVxcSlQz2jQWy5hBBqQ==
X-Gm-Gg: AR+sD11i8lj/76DrROP8fI4m+tKzoHHbuc4lIriwQgWCJbApX184ucvnX6zb8U+fBjF
	1kP/i09hoHlwbPYOAFXL/uCLmHvFGkyVCaGzt2qjJyN6C6cMcybOQQ7RxI5IRJVnFXzW13nspGe
	qj8U5SrG1CHGd5+sKt1k7qzS3au5DTsWniJjbyCN1E5B1iMpN1eGvBAKru6h16Xmvu/6LpnrYdw
	f4FrCHaUpb4xgZ/6a60ExOHzkGYCM9OYvnPZCGvFvtdscBk1nEtmDSi0nGQA+H9gWm7+HU1l+Rx
	9Pwm9weP3AU0Bc4fJBQPPASdkm6uL9NUAyXZ7AbNXDni7J2nFuHOdzkt8PwgLpjCZ+vOaE4H9Hf
	QyfMFoKyqXsATpeTm3Q25vmFJASbpQpoAYhW3XAhsqklX/jyUt7Z9H+v75xlxlKB2rY5TTKtpWE
	12dKPsVguchWo47T3z/f1boMGqUX0vPgB45DNSzG6lioC3+LT+r+lPCGSix/ossVVYU6KlmCGgw
	QfsCu1URXzByL2gKUjDvOhYD+42DUk2
X-Received: by 2002:a05:6512:10ce:b0:5b2:1de0:5ea2 with SMTP id 2adb3069b0e04-5b459140f73mr2365592e87.16.1786866804662;
        Sun, 16 Aug 2026 00:53:24 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b458b9a8d4sm1631136e87.15.2026.08.16.00.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 00:53:23 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH v2 0/3] sparc32: allow a kernel loaded away from the start of RAM
Date: Sun, 16 Aug 2026 09:50:14 +0200
Message-ID: <20260816075141.3489194-1-linmag7@gmail.com>
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

Changes since v1:
 - drop the (unsigned int) casts and print with %lx (Sam Ravnborg)
 - always report RAM start and kernel start, not only when they differ
   (Sam Ravnborg). Note this means one line at every sparc32 boot; on
   platforms where __get_phys() is not implemented it reads as
   "kernel is at 0x0".
 - collect Reviewed-by from Sam Ravnborg on patches 1 and 3

Patches 1 and 3 are unchanged from v1 apart from the collected tag.

Tested on a SPARCstation 20 booting from SCSI to a full userspace, with
and without an initramfs, using a SILO carrying the matching loader
changes. Also boot tested under qemu-system-sparc -M SS-5, and build
tested for LEON and plain sparc32_defconfig. Each commit builds on its
own. Emulation cannot exercise patch 1: microSPARC-II takes a different
cache flush path, and qemu models no write-back cache, so a missed flush
has no consequence there.

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

