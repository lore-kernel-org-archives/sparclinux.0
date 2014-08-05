From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 05 Aug 2014 03:51:37 +0000
Subject: Re: [PATCH] sparc64: Guard against flushing openfirmware mappings.
Message-Id: <CAGRGNgUVi=Rc-ydUzrHS4vHzsAF4bP_70FFt3Z_hrBgP8kRaHA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20140804.201710.101327918842040424.davem@davemloft.net>
In-Reply-To: <20140804.201710.101327918842040424.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David,

On Tue, Aug 5, 2014 at 1:17 PM, David Miller <davem@davemloft.net> wrote:
>
> Based almost entirely upon a patch by Christopher Alexander Tobias
> Schulze.
>
> In commit db64fe02258f1507e13fe5212a989922323685ce ("mm: rewrite vmap
> layer") lazy VMAP tlb flushing was added to the vmalloc layer.  This
> causes problems on sparc64.
>
> Sparc64 has two VMAP mapped regions and they are not contiguous with
> eachother.  First we have the malloc mapping area, then another
> unrelated region, then the vmalloc region.
>
> This "another unrelated region" is where the firmware is mapped.
>
> If the lazy TLB flushing logic in the vmalloc code triggers after
> we've had both a module unload and a vfree or similar, it will pass an
> address range that goes from somewhere inside the malloc region to
> somewhere inside the vmalloc region, and thus covering the
> openfirmware area entirely.
>
> The sparc64 kernel learns about openfirmware's dynamic mappings in
> this region early in the boot, and then services TLB misses in this
> area.  But openfirmware has some locked TLB entries which are not
> mentioned in those dynamic mappings and we should thus not disturb
> them.
>
> These huge lazy TLB flush ranges causes those openfirmware locked TLB
> entries to be removed, resulting in all kinds of problems including
> hard hangs and crashes during reboot/reset.
>
> Besides causing problems like this, such huge TLB flush ranges are
> also incredibly inefficient.  A plea has been made with the author of
> the VMAP lazy TLB flushing code, but for now we'll put a safety guard
> into our flush_tlb_kernel_range() implementation.
>
> Since the implementation has become non-trivial, stop defining it as a
> macro and instead make it a function in a C source file.
>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>
> Christopher, I adjusted your patch so that this interface is no longer
> implemented as a macro.  It's too large to keep inlining at this point.
>
>  arch/sparc/include/asm/tlbflush_64.h | 12 ++----------
>  arch/sparc/mm/init_64.c              | 23 +++++++++++++++++++++++
>  2 files changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/arch/sparc/include/asm/tlbflush_64.h b/arch/sparc/include/asm/tlbflush_64.h
> index 816d820..dea1cfa 100644
> --- a/arch/sparc/include/asm/tlbflush_64.h
> +++ b/arch/sparc/include/asm/tlbflush_64.h
> @@ -34,6 +34,8 @@ static inline void flush_tlb_range(struct vm_area_struct *vma,
>  {
>  }
>
> +void flush_tlb_kernel_range(unsigned long start, unsigned long end);
> +
>  #define __HAVE_ARCH_ENTER_LAZY_MMU_MODE
>
>  void flush_tlb_pending(void);
> @@ -48,11 +50,6 @@ void __flush_tlb_kernel_range(unsigned long start, unsigned long end);
>
>  #ifndef CONFIG_SMP
>
> -#define flush_tlb_kernel_range(start,end) \
> -do {   flush_tsb_kernel_range(start,end); \
> -       __flush_tlb_kernel_range(start,end); \
> -} while (0)
> -
>  static inline void global_flush_tlb_page(struct mm_struct *mm, unsigned long vaddr)
>  {
>         __flush_tlb_page(CTX_HWBITS(mm->context), vaddr);
> @@ -63,11 +60,6 @@ static inline void global_flush_tlb_page(struct mm_struct *mm, unsigned long vad
>  void smp_flush_tlb_kernel_range(unsigned long start, unsigned long end);
>  void smp_flush_tlb_page(struct mm_struct *mm, unsigned long vaddr);
>
> -#define flush_tlb_kernel_range(start, end) \
> -do {   flush_tsb_kernel_range(start,end); \
> -       smp_flush_tlb_kernel_range(start, end); \
> -} while (0)
> -
>  #define global_flush_tlb_page(mm, vaddr) \
>         smp_flush_tlb_page(mm, vaddr)
>
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index db5ddde..2cfb0f2 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -2707,3 +2707,26 @@ void hugetlb_setup(struct pt_regs *regs)
>         }
>  }
>  #endif
> +
> +#ifdef CONFIG_SMP
> +#define do_flush_tlb_kernel_range      smp_flush_tlb_kernel_range
> +#else
> +#define do_flush_tlb_kernel_range      __flush_tlb_kernel_range
> +#endif
> +
> +void flush_tlb_kernel_range(unsigned long start, unsigned long end)
> +{
> +       if (start < HI_OBP_ADDRESS && end > LOW_OBP_ADDRESS) {
> +               if (start < LOW_OBP_ADDRESS) {
> +                       flush_tsb_kernel_range(start, LOW_OBP_ADDRESS);
> +                       do_flush_tlb_kernel_range(start, LOW_OBP_ADDRESS);
> +               }
> +               if (end > HI_OBP_ADDRESS) {
> +                       flush_tsb_kernel_range(end, HI_OBP_ADDRESS);
> +                       do_flush_tlb_kernel_range(end, HI_OBP_ADDRESS);
> +               }

Stupid question (because I know it'll never happen) but wouldn't it be
better to make this even more explicit and handle cases where the
range starts or ends within the OpenFirmware range too?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
