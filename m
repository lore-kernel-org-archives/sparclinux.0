Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9477847D477;
	Thu, 24 Sep 2026 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255484; cv=none; b=k4miDLTgsdg0PM5DjkVkvC1mS1vqRPdvpvE/Eb7xAPf+PUQpdLF1NTm0piAKJv8AFGsIj34fjJhZMnQWK62oH3qFjIGrU7Z35nV/AMYwnuLFmWti+TdWqUK+CkeZ9oKDbP2icYIoruj4DoLwR95EUaPAbUaU2irW1yRZFQEtVj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255484; c=relaxed/simple;
	bh=e/9gnFks079cSu1f+MLquMjLMqHujT2ROPffEcmRtQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XzTwkMqkyqmv644Hm6G6wZbEMKzoCW2zv6CRyHm/O+KuS0CsWhCiriS7CgM2BMok3j7p+l6rFMFYTZhCO+SLlhdzH2H+pjvRi7CxtJxVsSthw8qVTnDhAjIqn1J7JPM1DlNzOKnayIrMV+2PvPHstA9IXifbtlMFHQCcpHV6sgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CqWCpPB0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CqWCpPB0"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 389691476;
	Thu, 24 Sep 2026 06:11:18 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 91D493F86F;
	Thu, 24 Sep 2026 06:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790255481; bh=e/9gnFks079cSu1f+MLquMjLMqHujT2ROPffEcmRtQE=;
	h=From:To:Cc:Subject:Date:From;
	b=CqWCpPB0XZVJf7lG7wEIips7LZon7+NJAG+6kS3Q8xUm9X6gBmLzS2CfeD3fgUHpA
	 xVpOE3uyt9pMvYBmARKgZkn8wPjjvaErYbkZsv1+PHFCIauuw1iSgat/MGFhjltWgp
	 y9WZJYU7zw8BYrHas8iZqDksMOyZR265ByGPcpPQ=
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
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
	jgg@ziepe.ca,
	thuth@redhat.com,
	sparclinux@vger.kernel.org,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com
Subject: [PATCH v3 0/9] Optimize anonymous swapbacked large folio unmapping
Date: Thu, 24 Sep 2026 13:09:28 +0000
Message-ID: <20260924131106.1730494-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
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
Applies on mm-unstable.

mm-selftests pass.

This breakout patchset is the final completion of
https://lore.kernel.org/all/20260526063635.61721-1-dev.jain@arm.com/

The extra addition is the generic set_softleaf_ptes() helper.

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
 arch/sparc/kernel/adi_64.c          |  21 ++++++
 include/linux/pgtable.h             |   6 +-
 include/linux/rmap.h                |  73 +++++++++++++-----
 mm/internal.h                       |  64 ++++++++++++----
 mm/memory.c                         |  20 ++---
 mm/mprotect.c                       |  18 +----
 mm/rmap.c                           | 110 ++++++++++++++++++++--------
 mm/shmem.c                          |   8 +-
 mm/swap.h                           |  35 ++++++++-
 mm/swapfile.c                       |  39 +++++-----
 11 files changed, 275 insertions(+), 129 deletions(-)


base-commit: 8d61431ed2607386b427752505379536eb634ce8
-- 
2.43.0

