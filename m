Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794753562;
	b=yZVfEGttjpNgVCCllEfL18tuSZKvp7VVFfZUp6EpeTRYcQuqENWUquPJGHjT7kuuIWOU
	 YpdMCztvhHAlSYgw7b+C9gBdi3MoSioN9/rJnkepz8zGRii7kHz8BueI8getsHFsTuQge
	 /UO6B1Ah3w/mYnc8iBBuJCLEhmE4SwBfC2KpdwSL6lQ/Y/ulMB8d1kS6pCq0QWLcTGkuo
	 erj6Zw/Vb1p1rVZQU1NargmW7fWoc3+pxKGnPLj4ztea5/p7E4RULy3klQyNStk1ZoZy7
	 ajepCV+Xsk8QtySFGSvOqkDQL1GDt0LZzWM2JX6C4PjErMop3lu6Vs3WjV3t1j/4sNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794753562;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ZaejXHaBUpAvEwKuL1oBVBhqrVdgMX2jfRxMaYZY1C0=;
	b=Rx1+vcPeIVVcga5XGy0+S6Tpas85+7uZgdf8cB2WDGA6c2FarOqT+fbMHiSsoGJeHO5n
	 gZ9I+7QyEZTnEbcYzcpuHbdj0oOX6C6AgpUJc1r9Fj1FVbccwQgc+LxhyoVZBwWlcHfuc
	 BtHZOjZh8CdZp/qEspd5dqWx/wmwCM/LIGETyxa/5peLrpuRQ5JvalOa+fNabpDFAl8rC
	 M+T8/zPU6ksavKuw0hVtr6qFr11kKcHCiXMVd7ZQnwuuvykouBT0oD+M10eejytewgx5y
	 nhORekwtHrFJ9WoS5Lr2gvDjnA0yL8mD87+GbYKS23oURsHrNHJmCJSzUhaTaSc0fqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Y7Vd6qgN;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEA9606A31F;
	Sun, 15 Nov 2026 14:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEEA9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Y7Vd6qgN
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84E751476;
	Sun, 15 Nov 2026 06:39:16 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ACC043F85F;
	Sun, 15 Nov 2026 06:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794753559; bh=jI0WbTDOJd6J5+na5JHcdV0AETzFP4/ftE8ndjLZuMw=;
	h=From:To:Cc:Subject:Date:From;
	b=Y7Vd6qgN125q8hK35gQR0raUdxPiX5gSqSFy44kpN+z29FlGNNe97oyKtLMGxDtlE
	 Z/Y0dYXpMbLieTfKz8aDW2YRqEltVKVwNb+kxYClYQWm/5ZbkGfdaEkJ5vK6fiVuNF
	 RTmXNEProFAb29tj75RfnqnFRB6o6JsA/6UCCFok=
From: Dev Jain <dev.jain@arm.com>
To: david@kernel.org,
	ljs@kernel.org,
	akpm@linux-foundation.org,
	hughd@google.com,
	chrisl@kernel.org,
	kasong@tencent.com,
	davem@davemloft.net,
	andreas@gaisler.com
Cc: Dev Jain <dev.jain@arm.com>,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
	baolin.wang@linux.alibaba.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	youngjun.park@lge.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	pfalcato@suse.de,
	anshuman.khandual@arm.com,
	geert@linux-m68k.org,
	sparclinux@vger.kernel.org,
	ryan.roberts@arm.com
Subject: [PATCH v4 0/9] Optimize anonymous swapbacked large folio unmapping
Date: Sun, 15 Nov 2026 14:38:55 +0000
Message-ID: <20261115143905.3045084-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.43.0
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

Speed up unmapping of anonymous swapbacked large folios by clearing
the ptes, and setting swap ptes, in one go.

The following benchmark (stolen from Barry) is used to measure the
time taken to swapout 256M worth of memory backed by 64K large folios:

 #define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/mman.h>
 #include <string.h>
 #include <time.h>
 #include <unistd.h>
 #include <errno.h>

 #define SIZE_MB 256
 #define SIZE_BYTES (SIZE_MB * 1024 * 1024)

 int main() {
     void *addr = mmap(NULL, SIZE_BYTES, PROT_READ | PROT_WRITE,
                       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
     if (addr == MAP_FAILED) {
         perror("mmap failed");
         return 1;
     }

     memset(addr, 0, SIZE_BYTES);

     struct timespec start, end;
     clock_gettime(CLOCK_MONOTONIC, &start);

     if (madvise(addr, SIZE_BYTES, MADV_PAGEOUT) != 0) {
         perror("madvise(MADV_PAGEOUT) failed");
         munmap(addr, SIZE_BYTES);
         return 1;
     }

     clock_gettime(CLOCK_MONOTONIC, &end);

     long duration_ns = (end.tv_sec - start.tv_sec) * 1e9 +
                        (end.tv_nsec - start.tv_nsec);
     printf("madvise(MADV_PAGEOUT) took %ld ns (%.3f ms)\n",
            duration_ns, duration_ns / 1e6);

     munmap(addr, SIZE_BYTES);
     return 0;
 }

Performance as measured on a Linux VM on Apple M3 (arm64):

Vanilla - Mean: 37401913 ns, std dev: 12%
Patched - Mean: 17420282 ns, std dev: 11%

resulting in more than 2x speedup.

No regression observed on 4K folios.

Performance as measured on bare metal x86:

Vanilla - mean: 54986286 ns, std dev: 1.5%
Patched - mean: 51930795 ns, std dev: 3%

I tried magnifying the difference on x86 by using 1M large folios, but
can't spot an obvious improvement (looks like my system is too fast to
benefit from batched atomic operations!), hinting that the benefit lies
mainly in the reduction of ptep_get() calls and the reduction of TLB
flushes during contpte-unfolding, on arm64.

No regression is observed on 4K folios on x86 too.

---
Applies on mm-unstable (24231596edf2).

mm-selftests pass.

This breakout patchset is the final completion of
https://lore.kernel.org/all/20260526063635.61721-1-dev.jain@arm.com/

The extra addition is the generic set_softleaf_ptes() helper.

v3->v4:
 - Make page_anon_exclusive_batch return the exclusivity instead of
   computing that in the caller
 - Make ttu_anon_folio() return the number of unmapped pages, to simplify
   the code

v2->v3:
 - page_anon_exclusive_batch returns unsigned long, shift to rmap.h
 - Drop a para in description of patch 5, use softleaf_is_swap to gate
   pte_swp_exclusive
 - finish_folio_unmap -> finish_folio_unmap_batch
 - Add patch 9 to do batching for sparc
   
v1->v2:
 - Add WARNs for folio span in folio_*_swap_pages
 - Trivial changes to page_anon_exclusive_batch
 - Add two sanity checks in patch 4

Dev Jain (9):
  mm/swapfile: add batched version of folio_dup_swap
  mm/swapfile: add batched version of folio_put_swap
  mm: move anon-exclusive batch helper to rmap.h
  mm/rmap: Add batched version of folio_try_share_anon_rmap_pte
  mm/internal: rename swap offset helpers to softleaf offset
  mm/internal: add set_softleaf_ptes
  mm/memory: use set_softleaf_ptes for uffd-wp markers
  mm/rmap: batch unmap anonymous swap-backed large folios
  mm, sparc: batch arch_unmap_one()

 arch/sparc/include/asm/pgtable_64.h |  10 ++-
 arch/sparc/kernel/adi_64.c          |  21 +++++
 include/linux/pgtable.h             |   6 +-
 include/linux/rmap.h                |  76 ++++++++++++++----
 mm/internal.h                       |  64 +++++++++++----
 mm/memory.c                         |  23 +++---
 mm/mprotect.c                       |  25 +-----
 mm/rmap.c                           | 119 ++++++++++++++++++++--------
 mm/shmem.c                          |   8 +-
 mm/swap.h                           |  35 +++++++-
 mm/swapfile.c                       |  39 +++++----
 11 files changed, 289 insertions(+), 137 deletions(-)

-- 
2.43.0

