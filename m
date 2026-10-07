Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7D93DB626
	for <sparclinux@vger.kernel.org>; Wed,  7 Oct 2026 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394906; cv=none; b=evPpPsjhojdMhFrAhqfWmuyKrd834pkEvglw8qUiDhcZgt309InWqgd7ABB3vwm9iLPSL/YsYQ8PuHFuk/GaCaAivFNmFfJVs4T/Ph6/1u3YYwrCdliT99ZsI1o9/eA2QhQMJGwZM92QEzLSpQ/JGDx5rEyfAdlCheilLznS1FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394906; c=relaxed/simple;
	bh=5LqR81PLeUYNmaQcMI8mEWAwJMm2KQwCGHVpdWIy9uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n/LE3RMpeBLzr8mN57XOIt3DQQZD9YFxD/2JlivvpQg5o1XRgjzSO83Z+pXn0R8dIKk5ZIaYatNsT51uob05/fk15dOBH67yd8V9anL74zdC+Gx0e7YGUFXEeAv91sq9S29UETHQ3L5UUU76sjGvUownB9em7gKR9PQRG0gxL6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwQHQZOB; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwQHQZOB"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6af9befd04cso5934450a12.2
        for <sparclinux@vger.kernel.org>; Wed, 07 Oct 2026 10:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791394902; x=1791999702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5GD/jKW9Q4eoAJdmj93S1XE6ucuAUkHSvVfI2BqPTc0=;
        b=AwQHQZOBXoBIttL02VpdNkTtrt/B5LnGNhOD7rTcCMdADb7q8QpX55d2dgbCRPO8Ny
         cDeXKsr7PHQZg/io8ROEA9vIGPxAAPWWDNw3fBLC6z8oOhT8hffkptC+zRqacPe/2/5l
         U5gH+5qoTyjwIQ+/OZEO4yzkeNGAFeKSfb/mUUv1fn6wyn4FDjhbZTKkOg/9KO9UmGBX
         vacg765BUxDIe7zcUZdX4r2QOJlWEfD2yXFkZumbJzW4CiXuXV8Xe7rz9a5zK1ZVu6MQ
         JcL3uwCoTmrvvl4/dQud83Mf2Yxv1q2wqwzB0qfuiVbuahqAyJxn7HUX6lrVVJbKYsTf
         KBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791394902; x=1791999702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5GD/jKW9Q4eoAJdmj93S1XE6ucuAUkHSvVfI2BqPTc0=;
        b=rfawJJdTygEIgw3T1qF+5LiDy0aBzGcSjtwxpzCnmiMypBzeBl0vkJjMkJOCMWOeSX
         JQsAINm7ZecbRw7O133h4Zr4cMN2mnqrelSeb25YMP3uXJtXY8pR9WRc9NcSxxFaSC6v
         kB/o3frhusBQ5QqTwlFkMRFWJXr0JTDYk6qJ9IIODwroizsrz9ctfwvPJwFyCD6nyJo4
         Biv+kNa0+m+q9oMCzPoypmCxYDark9m4ES5WvkVp6cxAWXYq6/adtzZpNFWR5WKjf/wC
         B+YsPYF2wRi5+6m4kcLj5DcZYvcpwmwulfh2dcirZEbb6XMIt2m4Dd4YxVvHa5KUg4No
         mZ0Q==
X-Forwarded-Encrypted: i=1; AKwUvByeVYP7zZzAj/uzXma/rm/8qc7f7IhzM1zUD4Q1MM74V9DNblfyvyIYpCHkRqUQutIqYv6aLWY88rrL@vger.kernel.org
X-Gm-Message-State: AFq9FYKNUoGPBQmJ7hA2JRxL86My9FHc8wYrqYRUTm4XriaF2S+LI3c6
	gDJb1geRvBW2ZCdei//0iTDRQJt6sOvPuvgN/g3p1O9+BOvCaiGL1Dsj
X-Gm-Gg: AYBFou0CPLIiAxLp0NyjlbbLJiD17Ali6Byy3l1gVyNVkzzzFhBlLfj9GgQTJiwDrLp
	KD1UNlImvafTsqGdZEoORGiZj+eLBq9pjszI3WclSt0CJvv3Q2yTl/coupx+WoupRa3RToFQShA
	+jQRHKyRCgG/in898mvnFwMzOOYpUa80tRYo29jFOILkbGoe4qYgHpRSdZRxRPEE8b40BCT4m79
	FcUBmj/h4FpezC90zFWa+KPBHXN/1QbNqK2UnQ8I8qEtTrMX+3milcvLl24K03iYCdWOuumlMDA
	l0ISvcLQMsvF0nxBxkhEXtJYRqvdNZFuXIW98/wo/rxlkZfsEWX02JNAkHnO/iGkyij+uKViv7p
	IE3Ky9CkezM5CI+zgYYWsTaDBMprDZ1kyGehkxqU94kY/QktgCk8sUKeK6VF6nrR/Qhmrt8a8B3
	y906LTIb9y0G9Jkw3P4Y1UfwNS0ZMtBAEMQp4HksopiATjoEfBYe1hHlmupYHTtYtEiLdtMLiS4
	eYsSOp7eUhPgJ7qWuR0/qWU+n3sR2iahNuRGoOghc9S+e1ivXs=
X-Received: by 2002:a05:6402:44c8:b0:6ac:62aa:e3e3 with SMTP id 4fb4d7f45d1cf-6aff2953907mr2244503a12.29.1791394901814;
        Wed, 07 Oct 2026 10:41:41 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b009e80cd8sm356802a12.8.2026.10.07.10.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:41:41 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH v5 0/6] sparc32: replace sp_banks with memblock
Date: Wed,  7 Oct 2026 19:41:09 +0200
Message-ID: <20261007174128.959307-1-linmag7@gmail.com>
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

The series applies on top of Andreas Larsson's for-next branch at
22a749706e3b (sparc64: decide the TSB huge-page window fixup before the
bank switch), which includes the sparc32 relocation and Viking fixes.
setup_memory() preserves the sun4m/sun4d PAGE_OFFSET probe and diagnostics
from that branch, removing RAM below the mapped physical address using
memblock instead of trimming sp_banks.

Link: https://lore.kernel.org/sparclinux/20260816075141.3489194-1-linmag7@gmail.com/T/#t

The v1 series was boot tested on a Sun SPARCstation 20 with dual
SuperSPARC-II CPUs (SM71).
The v2 series was boot tested on a Sun SPARCstation 20 with dual
ROSS HyperSPARC (RT626) CPUs.
The v3 series was cross-compiled with the SPARCstation 20 and LEON
configurations as well as boot tested on a Sun SPARCstation 20
with dual ROSS HyperSPARC (RT626) CPUs.
The v4 series was cross-compiled with the SPARCstation 20 SMP configuration
and a sparc32_defconfig-derived LEON configuration, both with HIGHMEM
enabled. Boot tested on a SPARCstation 20 SMP (ROSS).
The v5 series was cross-compiled with the SPARCstation 20 SMP and LEON
configurations, both with HIGHMEM enabled. Boot tested on a SPARCstation 20
SMP (ROSS).

Changes in v5:
- Rebase onto Andreas Larsson's for-next branch, resolving the patch 5
  conflict and preserving the updated phys_base handling, including the
  sun4m/sun4d probe restriction and diagnostics, from the relocation fixes.
- Retain Sam's Reviewed-by tags on all six patches.

Changes in v4:
- Use max_pfn in LEON's _pfn_valid() check, preserving the bounds of
  last_valid_pfn instead of restricting the check to lowmem, as requested
  by Andreas Larsson.
- Correct the description: LEON systems can use highmem.
- Carry Sam's Reviewed-by tag on patch 5; all six patches now retain his
  review tags.
- Rebase onto Linux 7.3-rc1 plus the three prerequisite patches; adjust
  patch 6's context without changing its code changes.

Changes in v3:
- Add Sam's Reviewed-by tag to patch 4.
- Initialize max_pfn in patch 5 and use it as the highmem zone limit.
- Use PHYS_PFN() instead of open-coded PAGE_SHIFT conversions in patch 5.
- Remove the obsolete highstart_pfn and highend_pfn declarations.
- Use the generic PFN limit declarations from linux/memblock.h.
- Document removal of the duplicate private HIGHMEM summary.

Changes in v2:
- Add Sam's Reviewed-by tags to patches 1-3 and 6. Patch 6 is the
  unchanged source change from patch 5 in v1, renumbered by the new patch.
- Drop the unused sparc_valid_addr_bitmap in a preparation patch.
- Use for_each_mem_pfn_range() and the standard max_low_pfn variable in
  the early memory setup. The change to LEON's PFN check made in v2 is
  corrected in v4 to preserve its original bounds.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://lore.kernel.org/r/20260817153237.GA702187@ravnborg.org
Link: https://lore.kernel.org/r/20260901214611.60560-1-linmag7@gmail.com

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
 arch/sparc/kernel/setup_32.c        | 117 ++++++++++---------
 arch/sparc/mm/init_32.c             | 167 +---------------------------
 arch/sparc/mm/leon_mm.c             |   1 +
 arch/sparc/mm/srmmu.c               |  69 ++++--------
 arch/sparc/prom/memory.c            |  51 ++-------
 10 files changed, 103 insertions(+), 327 deletions(-)


base-commit: 22a749706e3b0f857d5169a61f2f86a160eb9abd
-- 
2.43.0
