Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E300A24293C
	for <sparclinux@vger.kernel.org>; Sun, 30 Aug 2026 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788091681; cv=none; b=jJGSCBfVO03O/rlaaB4MEe7bvNgQc3WTS5rZsYTo9/4g8etq1/vrZpvBD8RcTjQwkzw3MSGbQvFhn1jBCM6zIn7SHt2xIaiD/5EkzYOfUZhYrzCu0j20LXN2ZDK/mgPylPhUWD2GxUgHJqK08bhmJJk8G932kbglEDC2cetxpl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788091681; c=relaxed/simple;
	bh=/FYkKqjOgXBTeocYzF/gWQZoXBhylikyH5JPZkvewMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=onQaIy/oiJ8gor83BiWjmVyiByOpiZH55i4LEz+uNASYBNLgw24UIkO0TCSoWhPOeGT91AbaBlHkpS7B4jRXtZd1U8uA1BvpJ/rvsbvYPSFXzdR8bZU+gQOUdwmepFx3O98rTOPvoaaudH7fiCpxyrRZYThkIjakShmsMvq4BPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diRP1Zrx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diRP1Zrx"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c255acff671so342285766b.0
        for <sparclinux@vger.kernel.org>; Sun, 30 Aug 2026 05:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788091677; x=1788696477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ARCsbI43R+ubcqBuZAyDdhBTLbDUJX8Txm1zWlPafFI=;
        b=diRP1ZrxYmbypLAUu68xkCxUpP7buFFNoaBs/1Hl8ztERc5oRUwRY5RWXOXV6tL7Wh
         m2zYF64ZKVIA4z48gKpTLevnqF6bVqnPDlxmmMC4th6Omcuvj2PpHsfUdSpHAYfVFBeS
         MHMEoVFA7FGs1c2TMhNZAtVHWjIWDCoHv+0dZ3ASjuk92ufbbC6UmT/YzIgiXm+4dHvz
         a5HBkOm25VjAeQSxPcb8OUUl35M5gihiZYTEvi717FgPKC+Rx9W8wh0UwL02RARYEhY0
         58p6EDkVExwkg+FxWvvvVv8bT2K31lahJpJTZpp+brpHVMYZynyMdkKQcDIsdLt+ge+H
         pkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788091677; x=1788696477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ARCsbI43R+ubcqBuZAyDdhBTLbDUJX8Txm1zWlPafFI=;
        b=qdKXNsYGoU1orlNDeV6cRZ5RkbivhtwcGHkhs8zXlKqkgFYy5/Fd4O5TsJ3TUb5DUT
         UsE55R3wXl89PL1tXcwKErTb4f7TtIaOl/boZDptj7fJJl7KVBjOid/lhwRfKl5K74vz
         tZSAB7Zlv+rmQ7sxGZFw7VUs15MbEKK+nWYAllV3gfrx9PLrLJ/Oho1gCxrXnjKwAify
         aagI9S+ioOhyfZPmKtfsfnzOS3uurg1nhSY0WEcMRBZVk/kkmPLIYWld+qIrtoYxqgqv
         IXe1daSerVZRLHnLj23BFjadkWCDyzb/3sGUlw7QQA16fW9msopBZ5kOX+XIrAAx4WUi
         yytA==
X-Gm-Message-State: AFuF++n5PJWSfu+V4wRtVq6l0ZuzF4X2FaJXOK0MP0/QKj/2y/LphXTi
	DCsYiMiRy25fezsONL5Xwdi2dEdXSrBT98j+GI6NHVFcl682tAa6j27BGcpCJzzd
X-Gm-Gg: AR+sD11juLVBYQgYGUrqNbZZayDgHext3dLU77T0HyNaFT1wFFWXgoip5uTVIPnmgL2
	BxYWaJr35a1yIN2NuhAgEGK7ZNgg3o6/lKRS1iBGke7PpT3rDnXqrrodMwuxeIvh6VM/DeiqSXU
	DhlKPj1OLeQOpOimx1uVFFLwuqey9wRq+JENXkBr/ZKG+BiR4pLqY5Q0xxV8BPoG20cX18G5Qhi
	wXr/Mzi+XuhagI8JtfFpb2eIz7/saBCeD1YzY5H6tbH75zuAw675crzmIRc+LKz8g+FdDg/3ohB
	aK0EbS7sKjyCSf6xsssvEJ0bSJ1OlIglL/HXQTwlMPOKLN3bONxpAn4DhFZf9lLyJHYrp7cdLbB
	6Xp57B2vPmSV5g9qi030iwRmLRlia3ffk13mRdFm7CtOzqZRB2mfkidre4WUPbBsRzgL2nSAeIK
	qjvbPMg6d7YCgQa8S17vCSEOCV4WldbgK3zLgk2JXnwMMNZ9yaxl4B+oZCFFIoHaHTy9mEOjVcr
	alTwlhG4xbGUGgUP/yqxosND6HsPYDAT6LQTC28WpM=
X-Received: by 2002:a17:907:e1c5:20b0:c25:895c:62dc with SMTP id a640c23a62f3a-c25895c6693mr169709866b.14.1788091676907;
        Sun, 30 Aug 2026 05:07:56 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee09eb6sm304287966b.10.2026.08.30.05.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 05:07:56 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org
Cc: davem@davemloft.net,
	andreas@gaisler.com,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	glaubitz@physik.fu-berlin.de,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH v2 0/6] sparc32: replace sp_banks with memblock
Date: Sun, 30 Aug 2026 14:06:39 +0200
Message-ID: <20260830120742.20950-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the sparc32-private sp_banks memory description with memblock.

The first two patches convert the SRMMU consumers that already run after
bootmem_init() has populated memblock. The third patch moves memblock
population to prom_meminit() and applies the mem= limit there. Patch 4
removes an unused address bitmap before patch 5 moves the early memory
setup into setup_32.c. Patch 6 removes the now-unused sp_banks array.

This work is based on an earlier eight-patch series by Sam Ravnborg.
Patch 2 directly carries over Sam's memblock sizing conversion. The series
has otherwise been substantially reorganized and reworked for the current
kernel. It retains the sparc32 mem= command-line option by using
memblock_enforce_memory_limit() and uses memblock's exclusive range-end
semantics throughout.

The series applies on top of the sparc32 phys_base and Viking fixes.
setup_memory() preserves relocated-kernel handling by removing RAM below
the physical address to which PAGE_OFFSET maps.

Link: https://lore.kernel.org/sparclinux/20260816075141.3489194-1-linmag7@gmail.com/T/#t

The v1 series was boot tested on a Sun SPARCstation 20 with dual
SuperSPARC-II CPUs (SM71).
The v2 series was boot tested on a Sun SPARCstation 20 with dual
ROSS Hypersparc (RT626) CPUSs.

Changes in v2:
- Add Sam's Reviewed-by tags to patches 1-3 and 6. Patch 6 is the
  unchanged source change from patch 5 in v1, renumbered by the new patch.
- Drop the unused sparc_valid_addr_bitmap in a preparation patch.
- Use for_each_mem_pfn_range() and the standard max_low_pfn variable in
  the early memory setup. This tightens LEON's _pfn_valid() upper bound
  from all memory to the lowmem limit, with no functional change because
  LEON does not use highmem.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://lore.kernel.org/r/20260817153237.GA702187@ravnborg.org

Magnus Lindholm (6):
  sparc32: use memblock when mapping the kernel
  sparc32: use memblock to find available system memory
  sparc32: populate memblock from the PROM memory map
  sparc32: drop unused valid address bitmap
  sparc32: move early memory setup to setup_arch
  sparc32: drop sp_banks

 arch/sparc/include/asm/leon.h       |   2 +-
 arch/sparc/include/asm/page_32.h    |  16 ---
 arch/sparc/include/asm/pgtable_32.h |   3 +-
 arch/sparc/include/asm/pgtsrmmu.h   |   2 +-
 arch/sparc/kernel/setup_32.c        | 115 ++++++++++---------
 arch/sparc/mm/init_32.c             | 167 +---------------------------
 arch/sparc/mm/srmmu.c               |  67 ++++-------
 arch/sparc/prom/memory.c            |  51 ++-------
 8 files changed, 100 insertions(+), 323 deletions(-)


base-commit: e6de5705a9f0d81f67bdb2917108784b5839cecd
-- 
2.43.0
