From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 07 May 2020 20:53:07 +0000
Subject: Re: [PATCH V3 15/15] kmap: Consolidate kmap_prot definitions
Message-Id: <20200507135307.4ba10d99c611f17beab31751@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200507150004.1423069-1-ira.weiny@intel.com>
 <20200507150004.1423069-16-ira.weiny@intel.com>
In-Reply-To: <20200507150004.1423069-16-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ira.weiny@intel.com
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Christian Koenig <christian.koenig@amd.com>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Thu,  7 May 2020 08:00:03 -0700 ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> Most architectures define kmap_prot to be PAGE_KERNEL.
> 
> Let sparc and xtensa define there own and define PAGE_KERNEL as the
> default if not overridden.
> 

checkpatch considered useful ;)


From: Andrew Morton <akpm@linux-foundation.org>
Subject: kmap-consolidate-kmap_prot-definitions-checkpatch-fixes

WARNING: macros should not use a trailing semicolon
#134: FILE: arch/sparc/include/asm/highmem.h:33:
+#define kmap_prot __pgprot(SRMMU_ET_PTE | SRMMU_PRIV | SRMMU_CACHE);

total: 0 errors, 1 warnings, 100 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

./patches/kmap-consolidate-kmap_prot-definitions.patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

Please run checkpatch prior to sending patches

Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/sparc/include/asm/highmem.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/sparc/include/asm/highmem.h~kmap-consolidate-kmap_prot-definitions-checkpatch-fixes
+++ a/arch/sparc/include/asm/highmem.h
@@ -30,7 +30,7 @@
 /* declarations for highmem.c */
 extern unsigned long highstart_pfn, highend_pfn;
 
-#define kmap_prot __pgprot(SRMMU_ET_PTE | SRMMU_PRIV | SRMMU_CACHE);
+#define kmap_prot __pgprot(SRMMU_ET_PTE | SRMMU_PRIV | SRMMU_CACHE)
 extern pte_t *pkmap_page_table;
 
 void kmap_init(void) __init;
_
