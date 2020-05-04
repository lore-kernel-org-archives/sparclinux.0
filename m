From: Ira Weiny <ira.weiny@intel.com>
Date: Mon, 04 May 2020 23:27:26 +0000
Subject: Re: [PATCH V2 00/11] Subject: Remove duplicated kmap code
Message-Id: <20200504232725.GA1084304@iweiny-DESK2.sc.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200504010912.982044-1-ira.weiny@intel.com>
 <20200504013509.GU23230@ZenIV.linux.org.uk>
 <20200504050447.GA979899@iweiny-DESK2.sc.intel.com>
 <20200504053357.GV23230@ZenIV.linux.org.uk>
 <20200504201740.GA985739@iweiny-DESK2.sc.intel.com>
 <20200504210225.GW23230@ZenIV.linux.org.uk>
In-Reply-To: <20200504210225.GW23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Huang Rui <ray.huang@amd.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Christian Koenig <christian.koenig@amd.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Mon, May 04, 2020 at 10:02:25PM +0100, Al Viro wrote:
> On Mon, May 04, 2020 at 01:17:41PM -0700, Ira Weiny wrote:
> 
> > > || * arm: much, much worse.  We have several files that pull linux/highmem.h:
> > > || arch/arm/mm/cache-feroceon-l2.c, arch/arm/mm/cache-xsc3l2.c,
> > > || arch/arm/mm/copypage-*.c, arch/arm/mm/dma-mapping.c, arch/arm/mm/flush.c,
> > > || arch/arm/mm/highmem.c, arch/arm/probes/uprobes/core.c,
> > > || arch/arm/include/asm/kvm_mmu.h (kmap_atomic_pfn()).
> > > || Those are fine, but we also have this:
> > > || arch/arm/include/asm/pgtable.h:200:#define __pte_map(pmd)               (pte_t *)kmap_atomic(pmd_page(*(pmd)))
> > > || arch/arm/include/asm/pgtable.h:208:#define pte_offset_map(pmd,addr)     (__pte_map(pmd) + pte_index(addr))
> > > || and sure as hell, asm/pgtable.h does *NOT* pull linux/highmem.h.
> > 
> > It does not pull asm/highmem.h either...
> 
> No, but the users of those macros need to be considered.

Agreed, I was trying to point out that highmem.h was being pulled from
somewhere else prior to my series, sorry.

> 
> > > || #define pte_offset_map(dir, addr)               \
> > > ||         ((pte_t *) kmap_atomic(pmd_page(*(dir))) + pte_index(addr))
> > > ||         One pte_offset_map user in arch/microblaze:
> > > || arch/microblaze/kernel/signal.c:207:    ptep = pte_offset_map(pmdp, address);
> > > || Messy, but doesn't require any changes (we have asm/pgalloc.h included
> > > || there, and that pull linux/highmem.h).
> > 
> > AFAICS asm/pgtable.h does not include asm/highmem.h here...
> > 
> > So looks like arch/microblaze/kernel/signal.c will need linux/highmem.h
> 
> See above - line 39 in there is
> #include <asm/pgalloc.h>
> and line 14 in arch/microblaze/include/asm/pgalloc.h is
> #include <linux/highmem.h>
> It's conditional upon CONFIG_MMU in there, but so's the use of
> pte_offset_map() in arch/microblaze/kernel/signal.c 
> 
> So it shouldn't be a problem.

Ah ok, I did not see that one.  Ok I'll drop that change and this series should
be good.

I was setting up to submit another version with 3 more patches you have
suggested:

kmap: Remove kmap_atomic_to_page()
parisc/kmap: Remove duplicate kmap code
sparc: Remove unnecessary includes

Would you like to see those folded in?  I submitted 2 of the above as a
separate series already.

> 
> > > || * xtensa: users in arch/xtensa/kernel/pci-dma.c, arch/xtensa/mm/highmem.c,
> > > || arch/xtensa/mm/cache.c and arch/xtensa/platforms/iss/simdisk.c (all pull
> > > || linux/highmem.h).
> > 
> > Actually
> > 
> > arch/xtensa/mm/cache.c gets linux/highmem.h from linux/pagemap.h
> > 
> > arch/xtensa/platforms/iss/simdisk.c may have an issue?
> > 	linux/blkdev.h -> CONFIG_BLOCK -> linux/pagemap.h -> linux/highmem.h
> > 	But simdisk.c requires BLK_DEV_SIMDISK -> CONFIG_BLOCK...
> > 	<sigh>
> 
> Yep - see above re major chain of indirect includes conditional upon CONFIG_BLOCK
> and its uses in places that only build with such configs.  There's a plenty of
> similar considerations outside of arch/*, unfortunately...

Indeed.

FWIW the last 2 versions of this series have had no build failures with 0-day.

This series in particular just finished 164 configs without issue.

Would you like me to submit a new series?  With your additional patches?

Ira
