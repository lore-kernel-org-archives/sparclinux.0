Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2126309DB1
	for <sparclinux@vger.kernel.org>; Mon,  1 Sep 2025 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718368; cv=none; b=eTtREszhDCjnoiSx0mcg1krszqqN7PVhvTrGBLJ5EN37su2OVOoHr91T2rWY7Ef84LSHaT+GvidifuSGRmjSrmJKQeoZKZL95eblkY1FQYD3/3kCscvdmuNXn/CQVo3uqk7ttwt+S4h7Sk1cRBSLOtHwu2ebAYos6Oh3gSq4E+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718368; c=relaxed/simple;
	bh=mKqCh67Y8GjWCP9TMAeIQOxT8NZFxglB07weMmMn2YY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bpmI31BjxXXw6FDVdleCgQa6OicNouNxV2mLvrlsIBwVdmoz2G0ttE7u/woOK49kcJ5wkvIXkIfdbD3VbWiUTBwkzBr6+SdLLjk6rjCC4qs4vYlC+kbK+dW+W4xkWuf0I48KVmXZD7ddJ8SuZpCxWcm74P9q68w+PhEvyUQFhXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=f2+0jrbv; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="f2+0jrbv"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afedbb49c26so627575966b.2
        for <sparclinux@vger.kernel.org>; Mon, 01 Sep 2025 02:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756718364; x=1757323164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IjlvOc7eDmq89ai1ZTLunEbTu4eGMpRVy5UBgVL+2qk=;
        b=f2+0jrbvllazQq6qkTQULI32d4ElFex75hfRYAJRO/ydb/LPYGnbhM/80J/Qvf4M2N
         MxPcbTuhccEM/Gv08YKcl75bUamgDiviFf6gAJiyrferkSLP/2cW7OIfX3LPxgaLoc1I
         MJ220OqhlZCjvzrfLwisawF3CyTFYTYV7vrvlYHxcGRviYdDQ1l6hX79Ytiz5Fj5HJZv
         ao+/Xo+mwRAV6LurzqzF3jdn4WxtbhTV2MNBnpKL4NYATqRI/XTTeXwHhhHrkcsb0UY2
         dEPz7P8ehtUc0CdTqjZ8xoZjNc8tuCBQPabp9qAbr7jCRt1zRakJJc5zZeSFzYDWlePU
         GSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718364; x=1757323164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjlvOc7eDmq89ai1ZTLunEbTu4eGMpRVy5UBgVL+2qk=;
        b=CYIa5kdfCELYtfGzn556IEkWcCrkcqTUVKjMlS/Ri8kn0AQ8mghxrV2ZPQj/ABk0xK
         q11jqZI+nCqXxE2/gfhKvfw1yN4WH8yQFLs1l+Mc1yh3JC9o/w7wzelSDzxSN3xbAm2g
         sw6iWIGhD2H1bpNuu2DKmtReQvH15yeuyq/2zY+EHbS/ZbYVHG1M6UToCQcKEctoZbWk
         haRHwEm5fFoa0TzsYXC6hNSjiHC99eB9i2zKFPpplz5VsvUgB0MBQTQdg6gaEY6ZMK/C
         C2lg0bnsO9SDdYiaWDgSLouZcEfRFqI0nuBD1VckooFE/0EZs9gHQrQCI7cvN0jS990z
         jWzw==
X-Forwarded-Encrypted: i=1; AJvYcCUWWQoiP4b9IKab/ZUvqL12004q2rzM4UoFmDYwpQxjAbOp+SG1rJAqQe2FYc/Y1lSKxnp/0ZPx2yIq@vger.kernel.org
X-Gm-Message-State: AOJu0YyNf4/SMgaF/o6YM3PZlNe8YKVv9swkpEH8HzicHvMNSo7Awxoe
	ZqgyGKX3hHazqw2Ibo3Cv7DzFXfjkcrdRsqLbw73lh9FAXGvL3ETqQ2L6OKHWH1lD9k=
X-Gm-Gg: ASbGncsLbdmzHUuNUW1S9rUmARqU1G1Z0phdMlTUOWw4aj72oTcY00HLtvW8cPdY8nr
	JzZsCwAawXneUaVo0iInfIpM2zI3Q9U9xtDY9UWngHss1QUcTrQBZKiTqzmjfEY9SK9VB+wy8X0
	Xgu2ZwCv4G77oDSqn6de7ixa/4buyFv1mOYcx6YPpfGIDhyL3h96tV2dicNbFnGySlij5YP8rSJ
	clnfDNJZW0ahTKz355jOgXXenAVw9v6kESJ7+Vk27jeYd6vFHO2F/9OZs60pRcbhWc36q1AoCCH
	0OJsfBPloU2kzYuopI9+6gTsWDysbUjzCROjnMlP0/GNo9NTNnL1zFEGtKsnWqKk5rEcYey0Ivd
	gI4fIqNBIc6EUbwm9Y1XaUJMV1ecNedJSYu9qVfGhXTfvusU/ESNJjbXUu9cycKCrUT/LvzCnXy
	jPSMAkLUHGBYMxoXkh/oizIPaj39YqOOqG
X-Google-Smtp-Source: AGHT+IFTes99iR4h1SIirBohNckEBvGOnxGmn6ipBhPiK9MotguUOISNLv8vVelWffxZXwdx4Lg8FA==
X-Received: by 2002:a17:907:94cd:b0:b04:2cc2:e49c with SMTP id a640c23a62f3a-b042cc31acemr254882266b.19.1756718364079;
        Mon, 01 Sep 2025 02:19:24 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm541005766b.12.2025.09.01.02.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:19:23 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com,
	linux@armlinux.org.uk,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	weixugc@google.com,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	max.kellermann@ionos.com,
	thuth@redhat.com,
	broonie@kernel.org,
	osalvador@suse.de,
	jfalempe@redhat.com,
	mpe@ellerman.id.au,
	nysal@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 00/12] mm: establish const-correctness for pointer parameters
Date: Mon,  1 Sep 2025 11:19:03 +0200
Message-ID: <20250901091916.3002082-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

This patch series systematically adds const qualifiers to pointer
parameters throughout the memory management (mm) subsystem,
establishing a foundation for improved const-correctness across the
entire Linux kernel.

Const-correctness provides multiple benefits:

1. Type Safety: The compiler enforces that functions marked as taking
   const parameters cannot accidentally modify the data, catching
   potential bugs at compile time rather than runtime.

2. Compiler Optimizations: When the compiler knows data won't be
   modified, it can generate more efficient code through better
   register allocation, code motion, and aliasing analysis.

3. API Documentation: Const qualifiers serve as self-documenting code,
   making it immediately clear to developers which functions are
   read-only operations versus those that modify state.

4. Maintenance Safety: Future modifications to const-correct code are
   less likely to introduce subtle bugs, as the compiler will reject
   attempts to modify data that should remain unchanged.

The memory management subsystem is a fundamental building block of the kernel.
Most higher-level kernel subsystems (filesystems, drivers, networking) depend
on mm interfaces. By establishing const-correctness at this foundational level:

1. Enables Propagation: Higher-level subsystems can adopt const-correctness
   in their own interfaces. Without const-correct mm functions, filesystems
   cannot mark their own parameters const when they need to call mm functions.

2. Maximum Impact: Changes to core mm APIs benefit the entire kernel, as
   these functions are called from virtually every subsystem.

3. Prevents Impedance Mismatch: Without const-correctness in mm, other
   subsystems must either cast away const (dangerous) or avoid using const
   altogether (missing optimization opportunities).

This series adds const qualifiers to pointer parameters in functions that
perform read-only operations on:
- struct page, folio, and ptdesc
- struct vm_area_struct and vm_fault
- struct mm_struct and address_space
- struct zone, lruvec, and mem_section
- Various architecture-specific mm structures

Each patch focuses on a specific header or subsystem component to ease review
and bisection.

This work was initially posted as a single large patch:
 https://lore.kernel.org/lkml/20250827192233.447920-1-max.kellermann@ionos.com/

Following feedback from Lorenzo Stoakes and David Hildenbrand, it has been
split into focused, reviewable chunks. The approach was validated with a
smaller patch that received agreement:
 https://lore.kernel.org/lkml/20250828130311.772993-1-max.kellermann@ionos.com/

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v1 -> v2:
- made several parameter values const (i.e. the pointer address, not
  just the pointed-to memory), as suggested by Andrew Morton and
  Yuanchu Xie
- drop existing+obsolete "extern" keywords on lines modified by these
  patches (suggested by Vishal Moola)
- add missing parameter names on lines modified by these patches
  (suggested by Vishal Moola)
- more "const" pointers (e.g. the task_struct passed to
  process_shares_mm())
- add missing "const" to s390, fixing s390 build failure
- moved the mmap_is_legacy() change in arch/s390/mm/mmap.c from 08/12
  to 06/12 (suggested by Vishal Moola)

v2 -> v3:
- remove garbage from 06/12
- changed tags on subject line (suggested by Matthew Wilcox)

v3 -> v4:
- more verbose commit messages including a listing of function names
  (suggested by David Hildenbrand and Lorenzo Stoakes)

Max Kellermann (12):
  mm/shmem: add `const` to pointer parameters for improved
    const-correctness
  mm/pagemap: add `const` to pointer parameters for improved
    const-correctness
  mm/mmzone: add const to pointer parameters for improved
    const-correctness
  fs: add const to pointer parameters for improved const-correctness
  mm/oom_kill: add const to pointer parameter for improved
    const-correctness
  mm/util, s390: add const to pointer parameters for improved
    const-correctness
  parisc: add `const` to mmap_upper_limit() parameter
  mm/util, s390, sparc, x86: add const to arch_pick_mmap_layout()
    parameter
  mm/mm_types: add const to pointer parameters for improved
    const-correctness
  mm/mm_inline: add const to pointer parameters for improved
    const-correctness
  mm: add const to pointer parameters for improved const-correctness
  mm/highmem: add const to pointer parameters for improved
    const-correctness

 arch/arm/include/asm/highmem.h      |  6 +--
 arch/parisc/include/asm/processor.h |  2 +-
 arch/parisc/kernel/sys_parisc.c     |  2 +-
 arch/s390/mm/mmap.c                 |  7 ++--
 arch/sparc/kernel/sys_sparc_64.c    |  3 +-
 arch/x86/mm/mmap.c                  |  7 ++--
 arch/xtensa/include/asm/highmem.h   |  2 +-
 include/linux/fs.h                  |  7 ++--
 include/linux/highmem-internal.h    | 38 ++++++++++---------
 include/linux/highmem.h             |  8 ++--
 include/linux/mm.h                  | 48 +++++++++++------------
 include/linux/mm_inline.h           | 26 +++++++------
 include/linux/mm_types.h            |  4 +-
 include/linux/mmzone.h              | 42 ++++++++++----------
 include/linux/pagemap.h             | 59 +++++++++++++++--------------
 include/linux/sched/mm.h            |  4 +-
 include/linux/shmem_fs.h            |  4 +-
 mm/highmem.c                        | 10 ++---
 mm/oom_kill.c                       |  3 +-
 mm/shmem.c                          |  6 +--
 mm/util.c                           | 20 ++++++----
 21 files changed, 162 insertions(+), 146 deletions(-)

-- 
2.47.2

