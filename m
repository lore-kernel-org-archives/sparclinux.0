From: Michal Hocko <mhocko@kernel.org>
Date: Tue, 04 Aug 2015 12:18:01 +0000
Subject: Re: Build failure (sparc32:allmodconfig) in -next due to 'memcg: export struct mem_cgroup'
Message-Id: <20150804121801.GA28571@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <20150802030220.GA25165@roeck-us.net>
In-Reply-To: <20150802030220.GA25165@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Vladimir Davydov <vdavydov@parallels.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On Sat 01-08-15 20:02:20, Guenter Roeck wrote:
> Hi,
> 
> Commit b65390c6c2178f ("memcg: export struct mem_cgroup") causes several
> build failures in -next (next-20150731) when trying to build
> sparc32:allmodconfig.
> 
> Below are some of the errors, as well as a bisect log.
> 
> Guenter
> 
> ---
> In file included from include/linux/pid_namespace.h:6:0,
>                  from include/linux/ptrace.h:8,
>                  from include/linux/ftrace.h:13,
>                  from include/linux/init_task.h:8,
>                  from init/init_task.c:1:
> include/linux/mm.h: At top level:
> include/linux/mm.h:888:7: error: conflicting types for 'page_address'
> ./arch/sparc/include/asm/highmem.h:59:10: note: previous implicit declaration of 'page_address' was here

This is weird:
* include/linux/mm.h:888

#if defined(HASHED_PAGE_VIRTUAL)
void *page_address(const struct page *page);
void set_page_address(struct page *page, void *virtual);
void page_address_init(void);
#endif

* arch/sparc/include/asm/highmem.h:59
static inline void *kmap(struct page *page)
{
        BUG_ON(in_interrupt());
        if (!PageHighMem(page))
                return page_address(page); 
        return kmap_high(page);
}

How come we have conflicting types here. page_address is clearly not
a function declaration in sparc code. Maybe something expands to an
incomplete c construct.

I have tried to crosscompile with
https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.6.3/ but
failed with strange errors.
$ PATH=/mnt/share/devel/miso/crosstool/sparc/gcc-4.6.3-nolibc/x86_64-linux/bin:$PATH CROSS_COMPILE=x86_64-linux- ARCH=sparc32 make allmodconfig
warning: (USB_OTG_FSM && FSL_USB2_OTG && USB_MV_OTG) selects USB_OTG which has unmet direct dependencies (USB_SUPPORT && USB && PM)
warning: (MFD_CROS_EC) selects CHROME_PLATFORMS which has unmet direct dependencies (X86 || ARM)
warning: (SND_SOC_ROCKCHIP_MAX98090 && SND_SOC_ROCKCHIP_RT5645) selects SND_SOC_ROCKCHIP_I2S which has unmet direct dependencies (SOUND && !M68K && !UML && SND && SND_SOC && CLKDEV_LOOKUP && SND_SOC_ROCKCHIP)
$ PATH=/mnt/share/devel/miso/crosstool/sparc/gcc-4.6.3-nolibc/x86_64-linux/bin:$PATH CROSS_COMPILE=x86_64-linux- ARCH=sparc32 make
x86_64-linux-gcc: warning: '-mcpu=' is deprecated; use '-mtune=' or '-march=' instead
cc1: error: unrecognized command line option '-mno-fpu'
cc1: warning: unknown register name: g5 [enabled by default]
cc1: warning: unknown register name: g7 [enabled by default]
kernel/bounds.c:1:0: error: bad value (v8) for -mtune= switch
Kbuild:44: recipe for target 'kernel/bounds.s' failed
make[1]: *** [kernel/bounds.s] Error 1
Makefile:1009: recipe for target 'prepare0' failed
make: *** [prepare0] Error 2

So either I am doing something wrong or the cross compiler is broken.
Could you send the preprocessed output of the failing compile?

> In file included from include/linux/highmem.h:7:0,
>                  from include/linux/bio.h:23,
>                  from include/linux/writeback.h:192,
>                  from include/linux/memcontrol.h:30,
>                  from include/linux/swap.h:8,
>                  from ./arch/sparc/include/asm/pgtable_32.h:17,
>                  from ./arch/sparc/include/asm/pgtable.h:6,
>                  from arch/sparc/kernel/traps_32.c:23:
> include/linux/mm.h: In function 'is_vmalloc_addr':
> include/linux/mm.h:371:17: error: 'VMALLOC_START' undeclared (first use in this function)
> include/linux/mm.h:371:17: note: each undeclared identifier is reported only once for each function it appears in
> include/linux/mm.h:371:41: error: 'VMALLOC_END' undeclared (first use in this function)
> include/linux/mm.h: In function 'maybe_mkwrite':
> include/linux/mm.h:556:3: error: implicit declaration of function 'pte_mkwrite'

Hmm, this is a clear dependency between headers. I am not
sure why this header is even needed. swap_entry is defined in
linux/mm_types.h. Does the code compile if you replace this include by
include <linux/mm_types.h>?

But maybe we should rather get rid of the include and make __swp_type,
__swp_offset and __swp_entry macros and mimic 64b header. Something like
the (untested) patch below:

> In file included from include/linux/highmem.h:7:0,
>                  from include/linux/bio.h:23,
>                  from include/linux/writeback.h:192,
>                  from include/linux/memcontrol.h:30,
>                  from include/linux/swap.h:8,
>                  from ./arch/sparc/include/asm/pgtable_32.h:17,
>                  from ./arch/sparc/include/asm/pgtable.h:6,
>                  from ./arch/sparc/include/asm/pgalloc_32.h:8,
>                  from ./arch/sparc/include/asm/pgalloc.h:6,
>                  from arch/sparc/kernel/sun4m_irq.c:16:
> include/linux/mm.h: In function 'pte_lockptr':
> include/linux/mm.h:1422:2: error: implicit declaration of function 'pmd_page' [-Werror=implicit-function-declaration]
> include/linux/mm.h:1422:2: error: passing argument 1 of 'ptlock_ptr' makes pointer from integer without a cast [-Werror]
> include/linux/mm.h:1396:27: note: expected 'struct page *' but argument is of type 'int'
> include/linux/mm.h: In function 'pgtable_init':
> include/linux/mm.h:1465:2: error: implicit declaration of function 'pgtable_cache_init'

This falls into the same category.
---
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index f06b36a00a3b..df5c9b16ea12 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -348,22 +348,14 @@ void srmmu_mapiorange(unsigned int bus, unsigned long xpa,
 void srmmu_unmapiorange(unsigned long virt_addr, unsigned int len);
 
 /* Encode and de-code a swap entry */
-static inline unsigned long __swp_type(swp_entry_t entry)
-{
-	return (entry.val >> SRMMU_SWP_TYPE_SHIFT) & SRMMU_SWP_TYPE_MASK;
-}
-
-static inline unsigned long __swp_offset(swp_entry_t entry)
-{
-	return (entry.val >> SRMMU_SWP_OFF_SHIFT) & SRMMU_SWP_OFF_MASK;
-}
-
-static inline swp_entry_t __swp_entry(unsigned long type, unsigned long offset)
-{
-	return (swp_entry_t) {
-		(type & SRMMU_SWP_TYPE_MASK) << SRMMU_SWP_TYPE_SHIFT
-		| (offset & SRMMU_SWP_OFF_MASK) << SRMMU_SWP_OFF_SHIFT };
-}
+#define __swp_type(entry)	(((entry).val >> SRMMU_SWP_TYPE_MASK) & SRMMU_SWP_TYPE_MASK)
+#define __swp_offset(entry) (((entry).val >> SRMMU_SWP_OFF_SHIFT) & SRMMU_SWP_OFF_MASK)
+#define __swp_entry(type, offset)	\
+	( (swp_entry_t) \
+	  { \
+	  	(((type) & SRMMU_SWP_TYPE_MASK) << SRMMU_SWP_TYPE_SHIFT | \
+	  	((offset) & SRMMU_SWP_OFF_MASK) << SRMMU_SWP_OFF_SHIFT) \
+	  } )
 
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
-- 
Michal Hocko
SUSE Labs
