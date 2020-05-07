From: ira.weiny@intel.com
Date: Thu, 07 May 2020 14:59:48 +0000
Subject: [PATCH V3 00/15] Remove duplicated kmap code
Message-Id: <20200507150004.1423069-1-ira.weiny@intel.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, Christian Koenig <christian.koenig@amd.com>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

From: Ira Weiny <ira.weiny@intel.com>

The kmap infrastructure has been copied almost verbatim to every architecture.
This series consolidates obvious duplicated code by defining core functions
which call into the architectures only when needed.

Some of the k[un]map_atomic() implementations have some similarities but the
similarities were not sufficient to warrant further changes.

In addition we remove a duplicate implementation of kmap() in DRM.

Testing was done by 0day to cover all the architectures I can't readily
build/test.

---
Changes from V2:
	Collect review/acks
	Add kmap_prot consolidation patch from Christoph
	Add 3 suggested patches from Al Viro
	Fix include for microblaze
	Fix static inline for microblaze

Changes from V1:
	Fix bisect-ability
	Update commit message and fix line lengths
	Remove unneded kunmap_atomic_high() declarations
	Remove unneded kmap_atomic_high() declarations
	collect reviews
	rebase to 5.7-rc4

Changes from V0:
	Define kmap_flush_tlb() and make kmap() truely arch independent.
	Redefine the k[un]map_atomic_* code to call into the architectures for
		high mem pages
	Ensure all architectures define kmap_prot, use it appropriately, and
		define kmap_atomic_prot()
	Remove drm implementation of kmap_atomic()


Ira Weiny (15):
  arch/kmap: Remove BUG_ON()
  arch/xtensa: Move kmap build bug out of the way
  arch/kmap: Remove redundant arch specific kmaps
  arch/kunmap: Remove duplicate kunmap implementations
  {x86,powerpc,microblaze}/kmap: Move preempt disable
  arch/kmap_atomic: Consolidate duplicate code
  arch/kunmap_atomic: Consolidate duplicate code
  arch/kmap: Ensure kmap_prot visibility
  arch/kmap: Don't hard code kmap_prot values
  arch/kmap: Define kmap_atomic_prot() for all arch's
  drm: Remove drm specific kmap_atomic code
  kmap: Remove kmap_atomic_to_page()
  parisc/kmap: Remove duplicate kmap code
  sparc: Remove unnecessary includes
  kmap: Consolidate kmap_prot definitions

 arch/arc/include/asm/highmem.h        | 18 -------
 arch/arc/mm/highmem.c                 | 28 ++--------
 arch/arm/include/asm/highmem.h        |  9 ----
 arch/arm/mm/highmem.c                 | 35 ++-----------
 arch/csky/include/asm/highmem.h       | 12 +----
 arch/csky/mm/highmem.c                | 56 ++++----------------
 arch/microblaze/include/asm/highmem.h | 27 ----------
 arch/microblaze/mm/highmem.c          | 16 ++----
 arch/microblaze/mm/init.c             |  3 --
 arch/mips/include/asm/highmem.h       | 11 +---
 arch/mips/mm/cache.c                  |  6 +--
 arch/mips/mm/highmem.c                | 49 +++---------------
 arch/nds32/include/asm/highmem.h      |  9 ----
 arch/nds32/mm/highmem.c               | 39 ++------------
 arch/parisc/include/asm/cacheflush.h  | 30 +----------
 arch/powerpc/include/asm/highmem.h    | 28 ----------
 arch/powerpc/mm/highmem.c             | 21 ++------
 arch/powerpc/mm/mem.c                 |  3 --
 arch/sparc/include/asm/highmem.h      | 25 +--------
 arch/sparc/mm/highmem.c               | 20 ++------
 arch/sparc/mm/io-unit.c               |  1 -
 arch/sparc/mm/iommu.c                 |  1 -
 arch/x86/include/asm/fixmap.h         |  1 -
 arch/x86/include/asm/highmem.h        |  9 ----
 arch/x86/mm/highmem_32.c              | 50 ++----------------
 arch/xtensa/include/asm/highmem.h     | 27 ----------
 arch/xtensa/mm/highmem.c              | 22 ++++----
 drivers/gpu/drm/ttm/ttm_bo_util.c     | 56 ++------------------
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c  | 16 +++---
 include/drm/ttm/ttm_bo_api.h          |  4 --
 include/linux/highmem.h               | 74 ++++++++++++++++++++++++---
 31 files changed, 150 insertions(+), 556 deletions(-)

-- 
2.25.1
