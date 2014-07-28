From: David Miller <davem@davemloft.net>
Date: Mon, 28 Jul 2014 23:02:37 +0000
Subject: Re: [PATCH] Prevent flushing of locked PROM ITLB entry (RED State Exception or hang on reboot)
Message-Id: <20140728.160237.1474420509355369500.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201407271539.40156.cat.schulze@alice-dsl.net>
In-Reply-To: <201407271539.40156.cat.schulze@alice-dsl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
Date: Sun, 27 Jul 2014 15:39:39 +0200

As mentioned for your previous two patches, please format your Subject
line properly, and provide a proper "Signed-off-by: " tag.

> On UltraSPARC systems, the PROM establishes a locked ITLB entry that needs
> to be present on return to the PROM (which happens when the system reboots).
> If the kernel tries to reboot with this ITLB entry not being present, a
> RED State Exception is caused, which *may* cause a restart as well, but some
> internal state may be corrupted. (It was observed that PCI resource information
> from the PROM was badly damaged when a linux kernel was started after such a
> RED State Exception, causing subsequent resource allocation errors in the
> kernel.) In other cases, the machine might also hang after the RED State Exception.
> 
> The locked PROM ITLB entry is flushed by flush_tlb_kernel_range(start, end) when
> the flushed interval contains the PROM region from 0xf0000000 to 0x100000000UL.
> This seems to happen when __vunmap() is called and triggers a __purge_vmap_area_lazy()
> call, where both virtual mappings below 0xf0000000 (kernel modules) and above
> 0x100000000UL (data mappings) are to be flushed. The kernel at present does not consider
> that there might also be a PROM mapping in between, and forces all existing mappings
> in the interval determined by __purge_vmap_area_lazy() to be removed.
> 
> The flushing of the locked PROM ITLB entry happens in our case already during the boot
> process when modules are loaded and unloaded for probing purposes.
> 
> With this patch, the affected SunBlade 2000 was able to reboot without problems again.

There are stylistic problems with your change, but I would also really
like to know who calls flush_tlb_kernel_range() for an area covering
the firmware's protected area?

That's where the bug more likely is.

There are only calls to this function from outside of the sparc code, first:

mm/highmem.c

which is not relevant because sparc64 doesn't use highmem, and then we have:

mm/percpu-vm.c
mm/vmalloc.c

So it has to be one of the calls in these two files causing the problem.

For the vmalloc case that would be odd, since we clearly define the VMALLOC
range to be outside of the firmware's special range:

#define VMALLOC_START		_AC(0x0000000100000000,UL)
#define VMALLOC_END		_AC(0x0000010000000000,UL)

>  #define flush_tlb_kernel_range(start,end) \
> -do {   flush_tsb_kernel_range(start,end); \
> -       __flush_tlb_kernel_range(start,end); \
> +do { \
> +       if((start < 0x100000000UL) && (end > 0xf0000000)) { \

Space between "if" and "(" please.  Also, please use the existing macros
LOW_OBP_ADDRESS and HI_OBP_ADDRESS instead of magic address values.

> +               if(start < 0xf0000000) { \

Likewise.

> +                         flush_tsb_kernel_range(start, 0xf0000000); \
> +                       __flush_tlb_kernel_range(start, 0xf0000000); \

These are indented differently, they should be on the same column, and
please use TAB characters.

>  #define flush_tlb_kernel_range(start, end) \
> -do {   flush_tsb_kernel_range(start,end); \
> -       smp_flush_tlb_kernel_range(start, end); \
> +do { \

Likewise for all of this macro too.
