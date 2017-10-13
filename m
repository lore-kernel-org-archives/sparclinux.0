From: Bob Picco <bob.picco@oracle.com>
Date: Fri, 13 Oct 2017 18:23:58 +0000
Subject: Re: [PATCH v12 00/11] complete deferred page initialization
Message-Id: <20171013182358.GE17753@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20171013173214.27300-1-pasha.tatashin@oracle.com>
In-Reply-To: <20171013173214.27300-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Pavel Tatashin wrote:	[Fri Oct 13 2017, 01:32:03PM EDT]
> Changelog:
> v12 - v11
> - Improved comments for mm: zero reserved and unavailable struct pages
> - Added back patch: mm: deferred_init_memmap improvements
> - Added patch from Will Deacon: arm64: kasan: Avoid using
>   vmemmap_populate to initialise shadow
[...]
> Pavel Tatashin (10):
>   mm: deferred_init_memmap improvements
>   x86/mm: setting fields in deferred pages
>   sparc64/mm: setting fields in deferred pages
>   sparc64: simplify vmemmap_populate
>   mm: defining memblock_virt_alloc_try_nid_raw
>   mm: zero reserved and unavailable struct pages
>   x86/kasan: add and use kasan_map_populate()
>   arm64/kasan: add and use kasan_map_populate()
>   mm: stop zeroing memory during allocation in vmemmap
>   sparc64: optimized struct page zeroing
> 
> Will Deacon (1):
>   arm64: kasan: Avoid using vmemmap_populate to initialise shadow
> 
>  arch/arm64/Kconfig                  |   2 +-
>  arch/arm64/mm/kasan_init.c          | 130 +++++++++++++--------
>  arch/sparc/include/asm/pgtable_64.h |  30 +++++
>  arch/sparc/mm/init_64.c             |  32 +++---
>  arch/x86/mm/init_64.c               |  10 +-
>  arch/x86/mm/kasan_init_64.c         |  75 +++++++++++-
>  include/linux/bootmem.h             |  27 +++++
>  include/linux/memblock.h            |  16 +++
>  include/linux/mm.h                  |  26 +++++
>  mm/memblock.c                       |  60 ++++++++--
>  mm/page_alloc.c                     | 224 +++++++++++++++++++++---------------
>  mm/sparse-vmemmap.c                 |  15 ++-
>  mm/sparse.c                         |   6 +-
>  13 files changed, 469 insertions(+), 184 deletions(-)
> 
> -- 
> 2.14.2
> 
Boot tested on ThunderX2 VM.
Tested-by: Bob Picco <bob.picco@oracle.com>
