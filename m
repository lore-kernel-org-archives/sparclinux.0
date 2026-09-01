Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15517302767
	for <sparclinux@vger.kernel.org>; Tue,  1 Sep 2026 21:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299199; cv=none; b=YYWXq5i5D7Ip1wGOarbWeJGbtCk2d8hggvrsKm4Qf+TihEbHyOTKDJTACx32Ld/dAVh469t4lhXxx1Dx2TIWv+Jdrl+wQ/atKJmlTZIzz2nJo0yR7UycCHObWI+Up24ueE+sXbIrt7DbKTjWHgg8V863W1PruhTaGnG/mBCzseU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299199; c=relaxed/simple;
	bh=Aqdm1DMCUWJk7SthyCfEusM9foeu8UE3FN3Fj5HjTbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GRxp5a66GIs/PI9TDMBgtF4OjOIuoH3i3ttExhUkU4gk1rDrCnL2mBGsxbZAD4rIrI3+57iIXXrnuOKdG8JzDMGef0MzKIDGl30dKYUtbo5yY9SDOsxDE9GjwtA/d15m2s8d5zmkQTFHYepq++uNHgiTopETkfwCo3KTtQ7zV7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URzRIHAH; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URzRIHAH"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15e592da74so34335166b.1
        for <sparclinux@vger.kernel.org>; Tue, 01 Sep 2026 14:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788299196; x=1788903996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3DPWdBLNBfFx8hiWentZjpeKy6LRostRRVyZaAU3P4c=;
        b=URzRIHAHxS6fUKQyDM+Rts0OZ9v59YN9HgO3vKYnHsYv33UWgA98X+D2XGkuIeo7GP
         BVPwI72aWB/zz/NOmH2W2GtLZQInKpJR98ZRgbZZ9uLbVm9aG4LyooVPWrsOA9KfL9ii
         /2kTqQgSq5gs4kulagChxbLAMNBv30j/xz0rgLjLd/3p8gxhkbGgqUVqWves9EjHn4eA
         jkNUWaeHBFnN1qyjFvTKfKR3+k7XFI8/woBhnUPrSoSZs4B8Lnd9PpNF1r7Z1WARKbay
         sOGXGZFteCuyuVF0qSL340HMYfASIuPyS5NgNwukaWkLOQJAXJrb+dCxutKSZO7BJvw8
         NETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788299196; x=1788903996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3DPWdBLNBfFx8hiWentZjpeKy6LRostRRVyZaAU3P4c=;
        b=a/i2ib5Ix4cZcPnMuT8JIrDXbAs36IMRDOawnHYIeLYS8M4ccalEM0WLQwz2M/nmvP
         aOq1eRRSw8+vXJWP4btWfrbgIVDgclJoetO3RO5iHRw6ZbmMZiZIY2PW4k+laL8ELnxg
         H3umxzJlUPZ+0fqnUMJpqGmvEY8vgtc8hDOA8D7b2fQJs3K0M0sjEjyRyEuCFJ3JJVJz
         CL9ICttBs5tIbHFraYalPYHgMaURXFWWCiCpCrxEOS2xUMsH/ZG2TIBhNPAE5ne4E+nE
         f0A2MCKw+3Pf/7pRbOjk/qxnS5iCN0K26rOgfkN+MjggT547QrPJp4WnisgtOo8RZfmq
         Nnng==
X-Gm-Message-State: AFuF++kes6Gvv8PvkJlQD7G+nJXPdwULdJlRG1t2Dz9FW+WZTVYnL1C8
	AYJ6/BE57rjRQVQ++i24f7Fxo/DIejk5JVZYd8UPCYDk72zeOt/HNzwWHBZ1Zg==
X-Gm-Gg: AR+sD12OhhUF4HZ5HYuwW0nkWoAYRROpYHI3J2rFJ6rearyMExRVrTSpV6c8ExF3zkh
	tQo6NPSVx8SEwkPvTDe7AysY/YTgJNJzVAHIXIEkjNRtrZjnx9e6mjWJtHV38Y3HGDXXjgQYNgd
	bcKa61Q3zB4UkUOCtC5RsckNZhctyDtFxTxgFz5APG/HV8tr7w1Cue+Hueh4I2QzI9ktGm3UVQH
	nTZ6iRsq2th5BZPrNV4kAAYYY23I7E3vUgud8TTUHs7adIJXkjjwp0Gd8Nh3cbdkVSGGPk6Nisg
	67gyK4L/jkOYlfFctVEf9JHtxQ4kAqInPmfuzAqXOtqWSPqS3Lst3w5KhoJig8Mbfz/R0L5MS5w
	V7TwgWL2qb7mqSIoL8BPWdwI8C4ppHdNgHZfAV6uW7YDGD3vCZIOPXzW0R3Oo/19UKoGstAA3xd
	1gkTMR3Pm8HeMwkYPM0yJrSau4YxZNxkHN1KOxGUGEUksqWnYBSiHG7lnLOpXLgIv2o9aRqak2R
	xHkH5yiYOqt7aZEkmruAC8R3rYjxnQ=
X-Received: by 2002:a17:907:c817:b0:c12:6d25:2c7a with SMTP id a640c23a62f3a-c25d55fdd03mr16325966b.17.1788299196079;
        Tue, 01 Sep 2026 14:46:36 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25cffc70fdsm27500866b.4.2026.09.01.14.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:46:35 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org
Cc: davem@davemloft.net,
	andreas@gaisler.com,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	glaubitz@physik.fu-berlin.de,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH v3 0/6] sparc32: replace sp_banks with memblock
Date: Tue,  1 Sep 2026 23:45:44 +0200
Message-ID: <20260901214611.60560-1-linmag7@gmail.com>
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
ROSS HyperSPARC (RT626) CPUs.
The v3 series was cross-compiled with the SPARCstation 20 and LEON
configurations as well as boot tested on a Sun SPARCstation 20
with dual ROSS HyperSPARC (RT626) CPUs.

Changes in v3:
- Add Sam's Reviewed-by tag to patch 4.
- Initialize max_pfn in patch 5 and use it as the highmem zone limit.
- Use PHYS_PFN() instead of open-coded PAGE_SHIFT conversions in patch 5.
- Remove the obsolete highstart_pfn and highend_pfn declarations.
- Use the generic max_low_pfn declaration from linux/memblock.h.
- Document removal of the duplicate private HIGHMEM summary.

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

 arch/sparc/include/asm/highmem.h    |   3 -
 arch/sparc/include/asm/leon.h       |   2 +-
 arch/sparc/include/asm/page_32.h    |  16 ---
 arch/sparc/include/asm/pgtable_32.h |   3 +-
 arch/sparc/include/asm/pgtsrmmu.h   |   1 -
 arch/sparc/kernel/setup_32.c        | 112 ++++++++++---------
 arch/sparc/mm/init_32.c             | 167 +---------------------------
 arch/sparc/mm/leon_mm.c             |   1 +
 arch/sparc/mm/srmmu.c               |  69 ++++--------
 arch/sparc/prom/memory.c            |  51 ++-------
 10 files changed, 98 insertions(+), 327 deletions(-)

-- 
2.43.0
