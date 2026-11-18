Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794976348;
	b=FYDxi5+rVfHsELaIE3sTme/GKzxG6MaAq698SiL+BIOTVu7jdvqWWjia3nlXOE8RP6F6
	 Eb60sHUznnhkzP0QBynzmPoYf8ReDSX1MMOkaEbsKvnBdwljr6WDGweLTU4+p6njf96om
	 /VQWlweRkECny8qj96Qj9jTs+riDb0vlrpir8NW/2/YfwwASnRt8an92mnM1GsBehZiZQ
	 x+99QrsaN0P7te1AXHHkVlrr+0GQa0/50CeIevlHiQjWcen3rB4K7X/oZ82vn/aWpTbjf
	 4lpnoSX3DHx/atk9uj6vpbBkYGJqjQjtHvguMHFNZzVp8UznuCR2Fyq1uMtSILb58Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794976348;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=7MS9sX+VwlIh4X9xAEq10Tl8H83Ldhcl5BWCWkiO/T4=;
	b=gEEFGcGrBGcsa5Nx77Rky4HEbIVl2Gfwit6Kz8UuXE0nRjPP5lgvXpzimWPqbViNUfEv
	 fqo5LH2OWnkl1vdriBHQFhMorM231TGnst4UB1cL7/2ztw6w0h2rGKw74JZ3r1Pv8jy0E
	 0pIxyraQAr+3HwWj/9bvwsfdftUOIHs/S+RopW1eOd4ofMr8U70qSPBikkG+ygeqkP/BJ
	 /d+maOKjLpaWJ8JV4lNRf+RYO3zI+DyUJ/2HapZ9SnZ6/hqZJCXEkX/nfK6M2qgVmQTSH
	 4jo7gnJ85uI7Sfrg9Oa9rh9rLYUuWuGc5ssrIT2uD1KJHCc25AY3Oq0wFUr1fASkU/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=p0UjN81h;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24252606A334;
	Wed, 18 Nov 2026 04:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24252606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=p0UjN81h
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECCCA1596;
	Tue, 17 Nov 2026 20:32:22 -0800 (PST)
Received: from [10.163.128.4] (unknown [10.163.128.4])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 339513F882;
	Tue, 17 Nov 2026 20:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794976345; bh=mGDSNtodI21bLq4+K4VQm6Lw0wUHcWZaLpeVsLI8sl8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p0UjN81hgfNuYJHbl7yquDsT3i72OvHpwNBMIyqfWFMgSGo89/71Q7Sok0hzEiMaq
	 j3LGaIu8n7IHqWAPU+8tkD0AKEx6AzV6qY543089IEqaaXTn9ZLFgAKQvXPDiKD3RS
	 hA2IEUpDwaPsa3QUdfrIDnEp4BPvA6DqnJzyyFkY=
Message-ID: <a45d7c1a-08a8-4f18-82cb-535b6d1d3aab@arm.com>
Date: Wed, 18 Nov 2026 10:02:12 +0530
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] Optimize anonymous swapbacked large folio
 unmapping
To: "Garg, Shivank" <shivankg@amd.com>,
 "andreas@gaisler.com" <andreas@gaisler.com>,
 "david@kernel.org" <david@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "hughd@google.com" <hughd@google.com>, "ljs@kernel.org" <ljs@kernel.org>,
 "chrisl@kernel.org" <chrisl@kernel.org>,
 "kasong@tencent.com" <kasong@tencent.com>,
 "davem@davemloft.net" <davem@davemloft.net>
Cc: "geert@linux-m68k.org" <geert@linux-m68k.org>,
 "rppt@kernel.org" <rppt@kernel.org>, "nphamcs@gmail.com"
 <nphamcs@gmail.com>, "shikemeng@huaweicloud.com"
 <shikemeng@huaweicloud.com>, "vbabka@kernel.org" <vbabka@kernel.org>,
 "harry@kernel.org" <harry@kernel.org>, "riel@surriel.com"
 <riel@surriel.com>, "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "surenb@google.com" <surenb@google.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "youngjun.park@lge.com" <youngjun.park@lge.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "jannh@google.com" <jannh@google.com>,
 "liam@infradead.org" <liam@infradead.org>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 "mhocko@suse.com" <mhocko@suse.com>,
 "lance.yang@linux.dev" <lance.yang@linux.dev>,
 "baohua@kernel.org" <baohua@kernel.org>,
 "baoquan.he@linux.dev" <baoquan.he@linux.dev>,
 "pfalcato@suse.de" <pfalcato@suse.de>
References: <20261115143905.3045084-1-dev.jain@arm.com>
 <4c351ae2672a817df071b5a8b6b402846b897a75.camel@amd.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <4c351ae2672a817df071b5a8b6b402846b897a75.camel@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17/11/26 10:19 pm, Garg, Shivank wrote:
> On Sun, 2026-11-15 at 14:38 +0000, Dev Jain wrote:
>> Speed up unmapping of anonymous swapbacked large folios by clearing
>> the ptes, and setting swap ptes, in one go.
>>
>> The following benchmark (stolen from Barry) is used to measure the
>> time taken to swapout 256M worth of memory backed by 64K large folios:
>>
>>  #define _GNU_SOURCE
>>  #include <stdio.h>
>>  #include <stdlib.h>
>>  #include <sys/mman.h>
>>  #include <string.h>
>>  #include <time.h>
>>  #include <unistd.h>
>>  #include <errno.h>
>>
>>  #define SIZE_MB 256
>>  #define SIZE_BYTES (SIZE_MB * 1024 * 1024)
>>
>>  int main() {
>>      void *addr = mmap(NULL, SIZE_BYTES, PROT_READ | PROT_WRITE,
>>                        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>      if (addr == MAP_FAILED) {
>>          perror("mmap failed");
>>          return 1;
>>      }
>>
>>      memset(addr, 0, SIZE_BYTES);
>>
>>      struct timespec start, end;
>>      clock_gettime(CLOCK_MONOTONIC, &start);
>>
>>      if (madvise(addr, SIZE_BYTES, MADV_PAGEOUT) != 0) {
>>          perror("madvise(MADV_PAGEOUT) failed");
>>          munmap(addr, SIZE_BYTES);
>>          return 1;
>>      }
>>
>>      clock_gettime(CLOCK_MONOTONIC, &end);
>>
>>      long duration_ns = (end.tv_sec - start.tv_sec) * 1e9 +
>>                         (end.tv_nsec - start.tv_nsec);
>>      printf("madvise(MADV_PAGEOUT) took %ld ns (%.3f ms)\n",
>>             duration_ns, duration_ns / 1e6);
>>
>>      munmap(addr, SIZE_BYTES);
>>      return 0;
>>  }
>>
>> Performance as measured on a Linux VM on Apple M3 (arm64):
>>
>> Vanilla - Mean: 37401913 ns, std dev: 12%
>> Patched - Mean: 17420282 ns, std dev: 11%
>>
>> resulting in more than 2x speedup.
>>
>> No regression observed on 4K folios.
>>
>> Performance as measured on bare metal x86:
>>
>> Vanilla - mean: 54986286 ns, std dev: 1.5%
>> Patched - mean: 51930795 ns, std dev: 3%
>>
>> I tried magnifying the difference on x86 by using 1M large folios, but
>> can't spot an obvious improvement (looks like my system is too fast to
>> benefit from batched atomic operations!), hinting that the benefit lies
>> mainly in the reduction of ptep_get() calls and the reduction of TLB
>> flushes during contpte-unfolding, on arm64.
>>
>> No regression is observed on 4K folios on x86 too.
>>
>> ---
>> Applies on mm-unstable (24231596edf2).
> 
> Hi Dev,
> 
> Most of this series touches rmap and core MM code, which now go
> through the new MM core tree:
> 
> T: git://git.kernel.org/pub/scm/linux/kernel/git/mm/core.git for-next

Oh I just saw the update in MAINTAINERS, thanks for informing didn't know
about this. I'll send v5.


> 
> So, it would probably be better to base the next version on this rather than mm-unstable.
> 
> Thanks,
> Shivank
> 
>>
>> mm-selftests pass.
>>
>> This breakout patchset is the final completion of
>> https://lore.kernel.org/all/20260526063635.61721-1-dev.jain@arm.com/
>>
>> The extra addition is the generic set_softleaf_ptes() helper.
>>
>> v3->v4:
>>  - Make page_anon_exclusive_batch return the exclusivity instead of
>>    computing that in the caller
>>  - Make ttu_anon_folio() return the number of unmapped pages, to simplify
>>    the code
>>
>> v2->v3:
>>  - page_anon_exclusive_batch returns unsigned long, shift to rmap.h
>>  - Drop a para in description of patch 5, use softleaf_is_swap to gate
>>    pte_swp_exclusive
>>  - finish_folio_unmap -> finish_folio_unmap_batch
>>  - Add patch 9 to do batching for sparc
>>    
>> v1->v2:
>>  - Add WARNs for folio span in folio_*_swap_pages
>>  - Trivial changes to page_anon_exclusive_batch
>>  - Add two sanity checks in patch 4
>>
>> Dev Jain (9):
>>   mm/swapfile: add batched version of folio_dup_swap
>>   mm/swapfile: add batched version of folio_put_swap
>>   mm: move anon-exclusive batch helper to rmap.h
>>   mm/rmap: Add batched version of folio_try_share_anon_rmap_pte
>>   mm/internal: rename swap offset helpers to softleaf offset
>>   mm/internal: add set_softleaf_ptes
>>   mm/memory: use set_softleaf_ptes for uffd-wp markers
>>   mm/rmap: batch unmap anonymous swap-backed large folios
>>   mm, sparc: batch arch_unmap_one()
>>
>>  arch/sparc/include/asm/pgtable_64.h |  10 ++-
>>  arch/sparc/kernel/adi_64.c          |  21 +++++
>>  include/linux/pgtable.h             |   6 +-
>>  include/linux/rmap.h                |  76 ++++++++++++++----
>>  mm/internal.h                       |  64 +++++++++++----
>>  mm/memory.c                         |  23 +++---
>>  mm/mprotect.c                       |  25 +-----
>>  mm/rmap.c                           | 119 ++++++++++++++++++++--------
>>  mm/shmem.c                          |   8 +-
>>  mm/swap.h                           |  35 +++++++-
>>  mm/swapfile.c                       |  39 +++++----
>>  11 files changed, 289 insertions(+), 137 deletions(-)

