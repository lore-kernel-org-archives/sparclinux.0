From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 25 Mar 2016 19:19:18 +0000
Subject: Re: [Patch V2 2/2] sparc64 changes
Message-Id: <20160325191918.GA28419@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1458772868-10255-3-git-send-email-dave.kleikamp@oracle.com>
In-Reply-To: <1458772868-10255-3-git-send-email-dave.kleikamp@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Dave.

A few commnets from reading the patch, as I have no knowledge of the code it patches.
And comments are biaes towards kernel ways of doing this.

	Sam

On Wed, Mar 23, 2016 at 05:41:08PM -0500, Dave Kleikamp wrote:
> Based on original work by Karl Volz <karl.volz@oracle.com>

Should this patch follow the kernel standards, then
the description should be far more elaborated.
And I dunno if a s-o-b is appropriate too.

> @@ -104,6 +104,7 @@ void add_extra_lib(char *);
>  #undef X86_64
>  #undef ARM
>  #undef ARM64
> +#undef SPARC64
>  
>  #define UNKNOWN 0
>  #define X86     1
> @@ -117,6 +118,7 @@ void add_extra_lib(char *);
>  #define ARM	9
>  #define ARM64   10
>  #define MIPS    11
> +#define SPARC64 12
>  
>  #define TARGET_X86    "TARGET=X86"
>  #define TARGET_ALPHA  "TARGET=ALPHA"
> @@ -129,6 +131,7 @@ void add_extra_lib(char *);
>  #define TARGET_ARM    "TARGET=ARM"
>  #define TARGET_ARM64  "TARGET=ARM64"
>  #define TARGET_MIPS   "TARGET=MIPS"
> +#define TARGET_SPARC64 "TARGET=SPARC64"
>  
>  #define TARGET_CFLAGS_X86    "TARGET_CFLAGS=-D_FILE_OFFSET_BITSd"
>  #define TARGET_CFLAGS_ALPHA  "TARGET_CFLAGS="
> @@ -149,6 +152,7 @@ void add_extra_lib(char *);
>  #define TARGET_CFLAGS_MIPS            "TARGET_CFLAGS=-D_FILE_OFFSET_BITSd"
>  #define TARGET_CFLAGS_MIPS_ON_X86     "TARGET_CFLAGS=-D_FILE_OFFSET_BITSd"
>  #define TARGET_CFLAGS_MIPS_ON_X86_64  "TARGET_CFLAGS=-m32 -D_FILE_OFFSET_BITSd"
> +#define TARGET_CFLAGS_SPARC64         "TARGET_CFLAGS=-mcpu=v9 -fPIC -fno-builtin"
Are you missing -m64 here? At least we use -m64 when building the kernel.

>  
>  #define GDB_TARGET_DEFAULT        "GDB_CONF_FLAGS="
>  #define GDB_TARGET_ARM_ON_X86     "GDB_CONF_FLAGS=--target=arm-elf-linux"
> @@ -378,6 +382,9 @@ get_current_configuration(struct supported_gdb_version *sp)
>  #ifdef __mips__
>          target_data.target = MIPS;
>  #endif
> +#if defined(__sparc__) && defined(__arch64__)
> +	target_data.target = SPARC64;
> +#endif

In another place in the patch following is used to detect sparc64:
> +#ifdef __sparc_v9__
> +#define SPARC64
> +#endif

Looks strange that two different approaches are used.

> --- a/defs.h
> +++ b/defs.h
> @@ -71,7 +71,7 @@
>  
> +#ifdef __sparc_v9__
> +#define SPARC64
> +#endif
This is the place that was quoted above.

> +#ifdef NEED_ALIGNED_MEM_ACCESS
> +
> +#define DEF_LOADER(TYPE)			\
> +static inline TYPE				\
> +load_##TYPE (char *addr)			\
> +{						\
> +	TYPE ret;				\
> +	size_t i = sizeof(TYPE);		\
> +	while (i--)				\
> +		((char *)&ret)[i] = addr[i];	\
> +	return ret;				\
> +}
> +
> +DEF_LOADER(int);
> +DEF_LOADER(uint);
> +DEF_LOADER(long);
> +DEF_LOADER(ulong);
> +DEF_LOADER(ulonglong);
> +DEF_LOADER(ushort);
> +DEF_LOADER(short);
> +typedef void *pointer_t;
> +DEF_LOADER(pointer_t);
> +
> +#define LOADER(TYPE) load_##TYPE
> +
> +#define INT(ADDR)       LOADER(int) ((char *)(ADDR))
> +#define UINT(ADDR)      LOADER(uint) ((char *)(ADDR))
> +#define LONG(ADDR)      LOADER(long) ((char *)(ADDR))
> +#define ULONG(ADDR)     LOADER(ulong) ((char *)(ADDR))
> +#define ULONGLONG(ADDR) LOADER(ulonglong) ((char *)(ADDR))
> +#define ULONG_PTR(ADDR) ((ulong *) (LOADER(pointer_t) ((char *)(ADDR))))
> +#define USHORT(ADDR)    LOADER(ushort) ((char *)(ADDR))
> +#define SHORT(ADDR)     LOADER(short) ((char *)(ADDR))
> +#define UCHAR(ADDR)     *((unsigned char *)((char *)(ADDR)))
> +#define VOID_PTR(ADDR)  ((void *) (LOADER(pointer_t) ((char *)(ADDR))))
> +
> +#else
> +
>  #define INT(ADDR)       *((int *)((char *)(ADDR)))
>  #define UINT(ADDR)      *((uint *)((char *)(ADDR)))
>  #define LONG(ADDR)      *((long *)((char *)(ADDR)))
> @@ -2195,6 +2246,8 @@ struct builtin_debug_table {
>  #define UCHAR(ADDR)     *((unsigned char *)((char *)(ADDR)))
>  #define VOID_PTR(ADDR)  *((void **)((char *)(ADDR)))
>  
> +#endif /* NEED_ALIGNED_MEM_ACCESS */
> +

The NEED_ALIGNED_MEM_ACCESS is generic - and could have been
handled in a dedicated patch.

>  
> +#ifdef SPARC64
> +#define _64BIT_
> +#define MACHINE_TYPE       "SPARC64"
> +
> +#define PTOV(X) \
> +	((unsigned long)(X)-(machdep->machspec->phys_offset)+(machdep->kvbase))
> +#define VTOP(X) \
> +	((unsigned long)(X)-(machdep->kvbase)+(machdep->machspec->phys_offset))
Some spaces would make wonders for readability.

> +extern int sparc64_IS_VMALLOC_ADDR(ulong vaddr);
> +#define IS_VMALLOC_ADDR(X)    sparc64_IS_VMALLOC_ADDR((ulong)(X))
> +#define PAGE_SHIFT	(13)
> +#define PAGE_SIZE	(1UL << PAGE_SHIFT)
> +#define PAGE_MASK	(~(PAGE_SIZE-1))
> +#define PAGEBASE(X)     (((ulong)(X)) & (ulong)machdep->pagemask)
> +#define THREAD_SIZE	(2*PAGE_SIZE)
Spaces missing again.

> +/* S3 Core
> + *	Core 48-bit physical address supported.
> + *	Bit 47 distinguishes memory or I/O. When set to "1" it is I/O.
> + */
> +#define PHYS_MASK_SHIFT   (47)
> +#define PHYS_MASK         (((1UL) << PHYS_MASK_SHIFT) - 1)
> +
> +typedef signed int s32;
> +
> +/*
> + * This next two defines are convenience defines for normal page table.
> + */
> +#define PTES_PER_PAGE		(1UL << (PAGE_SHIFT - 3))
> +#define PTES_PER_PAGE_MASK	(PTES_PER_PAGE - 1)
> +
> +/* 4-levels / 8K pages */
> +#define PG_LVL4_PDIRS_BITS	(53)
> +#define PG_LVL4_PGDIR_SHIFT	(43)
> +#define PG_LVL4_PTRS_PER_PGD	(1024)
> +#define PG_LVL4_PUD_SHIFT	(33)
> +#define PG_LVL4_PTRS_PER_PUD	(1024)
> +#define PG_LVL4_PMD_SHIFT	(23)
> +#define PG_LVL4_PTRS_PER_PMD	(1024)
> +#define PG_LVL4_PTRS_PER_PTE	(1UL << (PAGE_SHIFT-3))

If these definitions was a copy of the kernel definitions,
then it would be much easier to follow and check.
From the kernel:
/* PMD_SHIFT determines the size of the area a second-level page
 * table can map
 */
#define PMD_SHIFT       (PAGE_SHIFT + (PAGE_SHIFT-3))
#define PMD_SIZE        (_AC(1,UL) << PMD_SHIFT)
#define PMD_MASK        (~(PMD_SIZE-1))
#define PMD_BITS        (PAGE_SHIFT - 3)

/* PUD_SHIFT determines the size of the area a third-level page
 * table can map
 */
#define PUD_SHIFT       (PMD_SHIFT + PMD_BITS)
#define PUD_SIZE        (_AC(1,UL) << PUD_SHIFT)
#define PUD_MASK        (~(PUD_SIZE-1))
#define PUD_BITS        (PAGE_SHIFT - 3)

/* PGDIR_SHIFT determines what a fourth-level page table entry can map */
#define PGDIR_SHIFT     (PUD_SHIFT + PUD_BITS)
#define PGDIR_SIZE      (_AC(1,UL) << PGDIR_SHIFT)
#define PGDIR_MASK      (~(PGDIR_SIZE-1))
#define PGDIR_BITS      (PAGE_SHIFT - 3)



> +/* Down one huge page */
> +#define PG_LVL4_SPARC64_USERSPACE_TOP  (-(1UL << 23UL))
If 23 is PG_LVL4_PMD_SHIFT - then use this constant.

> +#define PAGE_PMD_HUGE		 (0x0100000000000000UL)
> +#define HPAGE_SHIFT		(23)

> +
> +/* These are for SUN4V.  */
> +#define _PAGE_VALID		(0x8000000000000000UL)
> +#define _PAGE_NFO_4V		(0x4000000000000000UL)
> +#define	_PAGE_MODIFIED_4V	(0x2000000000000000UL)
> +#define	_PAGE_ACCESSED_4V	(0x1000000000000000UL)
> +#define	_PAGE_READ_4V		(0x0800000000000000UL)
> +#define	_PAGE_WRITE_4V		(0x0400000000000000UL)
> +#define	_PAGE_PADDR_4V		(0x00FFFFFFFFFFE000UL)
> +#define _PAGE_PFN_MASK		(_PAGE_PADDR_4V)
> +#define	_PAGE_P_4V		(0x0000000000000100UL)
> +#define	_PAGE_EXEC_4V		(0x0000000000000080UL)
> +#define	_PAGE_W_4V		(0x0000000000000040UL)
> +#define _PAGE_PRESENT_4V	(0x0000000000000010UL)
> +#define	_PAGE_SZALL_4V		(0x0000000000000007UL)
> +/* There are other page sizes. Some supported. */
> +#define	_PAGE_SZ4MB_4V		(0x0000000000000003UL)
> +#define	_PAGE_SZ512K_4V		(0x0000000000000002UL)
> +#define	_PAGE_SZ64K_4V		(0x0000000000000001UL)
> +#define _PAGE_SZ8K_4V		(0x0000000000000000UL)
> +
> +#define SPARC64_MODULES_VADDR	(0x0000000010000000UL)
> +#define SPARC64_MODULES_END	(0x00000000f0000000UL)

> +#define LOW_OBP_ADDRESS		(0x00000000f0000000UL)
> +#define HI_OBP_ADDRESS		(0x0000000100000000UL)
These two are not used and can be deleted.
Did not check all of tham but OBP stuff triggered me.

> +#define SPARC64_VMALLOC_START	(0x0000000100000000UL)
> +
> +#define SPARC64_STACK_SIZE	0x4000
> +#define PTRS_PER_PGD		(1024)
> +
> +/* sparsemem */
> +#define _SECTION_SIZE_BITS      30
> +#define _MAX_PHYSMEM_BITS_LVL4  53
> +
> +#define STACK_BIAS	2047
> +
> +struct machine_specific {
> +	ulong flags;
> +	ulong userspace_top;
> +	ulong page_offset;
> +	ulong vmalloc_start;
> +	ulong vmalloc_end;
> +	ulong modules_vaddr;
> +	ulong modules_end;
> +	ulong phys_offset;
> +	ulong __exception_text_start;
> +	ulong __exception_text_end;
> +	struct pt_regs *panic_task_regs;
> +	ulong pte_protnone;
> +	ulong pte_file;
> +	uint pgd_shift;
> +	uint pud_shift;
> +	uint pmd_shift;
> +	uint ptes_per_pte;
> +};
Most of the values in machine_specific are in reality constants.
Do we really gain anything colleting the various constants in a struct?
Look like this may have been copied from an arch where much more is dynamic.

> +
> +#define TIF_SIGPENDING	(2)
> +#define SWP_OFFSET(E)	((E) >> (13UL+8UL))
> +#define SWP_TYPE(E)	(((E) >> (13UL)) & 0xffUL)
> +#define __swp_type(E)	SWP_TYPE(E)
> +#define	__swp_offset(E)	SWP_OFFSET(E)

The SWP_OFFSET indirection is just obscufation - should be dropped.
Same with SWP_TYPE.
Maybe this is needed in generic code - but at least not in this patch.

And the 13UL is PAGE_SHIFT hardcoded - replace this with PAGE_SHIFT.

>  /*
> + * sparc64.c
> + */
> +#ifdef SPARC64
> +void sparc64_init(int);
> +void sparc64_dump_machdep_table(ulong);
> +int sparc64_vmalloc_addr(ulong);
> +#define display_idt_table() \
> +	error(FATAL, "The -d option is not applicable to sparc64.\n")
Is a macro really needed?
A static inline is preferable due to better typechecks etc.
Not that there are much to check here - but in general.

> diff --git a/sparc64.c b/sparc64.c
> new file mode 100644
> index 0000000..7d26137
> --- /dev/null
> +++ b/sparc64.c
> @@ -0,0 +1,1186 @@
> +#ifdef SPARC64
> +
> +#include "defs.h"
> +#include <stdio.h>
> +#include <elf.h>
> +#include <asm/ptrace.h>
> +#include <linux/const.h>
> +
> +/* Things not done, debugged or tested at this point:
> + * 1) uvtop swap handling
> + * 2) uniform page table layout - like we had in 1st quarter of 2013
> + * 3) and whatever can't be thought of.
> + */
> +#define	true	(1)
> +#define	false	(0)
Irk - this should be provided by compiler/glibc.

> +static const unsigned long not_valid_pte = ~0UL;
> +static struct machine_specific sparc64_machine_specific;
> +static unsigned long sparc64_ksp_offset;
> +#define	MAGIC_TT		(0x1ff)
I see this used in places like this:
(regs->magic & ~MAGIC_TT) != PT_REGS_MAGIC
But the name MAGIC_TT does not give much clue what this is for.

And the mix of defines, then prototypes, then (even no empty line) a define again
does not increase readability.

> +static uint page_size(void)
> +{
> +	return machdep->pagesize;
> +}
I cannot see the vaule of hiding PAGE_SIZE first in a struct, and now in a static function.
Unless this is required by code I cannot see in the patch of course.
 
> +static void
> +sparc64_display_machine_stats(void)
> +{
> +	int c;
> +	struct new_utsname *uts;
> +	char buf[BUFSIZE];
> +	ulong mhz;
> +
> +	uts = &kt->utsname;
> +
> +	fprintf(fp, "          MACHINE TYPE: %s\n", uts->machine);
> +	fprintf(fp, "           MEMORY SIZE: %s\n", get_memory_size(buf));
> +	fprintf(fp, "                  CPUS: %d\n", kt->cpus);
> +	fprintf(fp, "       PROCESSOR SPEED: ");
> +	if ((mhz = machdep->processor_speed()))
> +		fprintf(fp, "%ld Mhz\n", mhz);
> +	else
> +		fprintf(fp, "(unknown)\n");
> +	fprintf(fp, "                    HZ: %d\n", machdep->hz);
> +	fprintf(fp, "             PAGE SIZE: %d\n", PAGESIZE());
PAGESIZE() is a function call?

> +	fprintf(fp, "   KERNEL VIRTUAL BASE: %lx\n", machdep->kvbase);
> +	fprintf(fp, "   KERNEL VMALLOC BASE: %lx\n", vt->vmalloc_start);
> +	fprintf(fp, "   KERNEL MODULES BASE: %lx\n", MODULES_VADDR);
> +	fprintf(fp, "     KERNEL STACK SIZE: %ld\n", STACKSIZE());
STACKSIZE is not defined. Assuming it comes from the generic part somehow.


> +static void sparc64_display_memmap(void)
> +{
> +	unsigned long iomem_resource;
> +	unsigned long resource;
> +	unsigned long start, end, nameptr;
> +	int size = STRUCT_SIZE("resource");
> +	char *buf = GETBUF(size);
> +	char name[32];
In the kernel work we try to avoid mixing local variable definitions
and assignments - as code like the above is a little hard to read.

> +static void sparc64_cmd_mach(void)
> +{
> +	int c;
> +	int mflag = 0;
> +
> +	while ((c = getopt(argcnt, args, "cm")) != EOF) {
> +		switch (c) {
> +		case 'm':
> +			mflag++;
> +			sparc64_display_memmap();
> +			break;
> +		case 'c':
> +			fprintf(fp, "SPARC64: '-%c' option is not supported\n",
> +				c);
> +			break;
> +		default:
> +			argerrs++;
> +			break;
> +		}
> +	}
Was this a better place to handle that -d flag is not supported?

> +static int sparc64_phys_live_valid(unsigned long paddr)
> +{
> +	unsigned int nr;
> +	int rc = false;
> +
> +	for (nr = 0U; nr != nr_phys_ranges; nr++) {
What is gained by 0U versus 0 here?

> +		if (paddr >= phys_ranges[nr].start &&
> +			paddr < phys_ranges[nr].end) {
> +			rc = true;
> +			break;
> +		}
> +	}
> +	return rc;
> +}
> +
> +static int sparc64_phys_kdump_valid(unsigned long paddr)
> +{
> +	return true;
> +}
> +
> +static void sparc6_phys_base_live_limits(void)
> +{
> +	if (nr_phys_ranges >= NR_PHYS_RANGES)
> +		error(FATAL, "sparc6_phys_base_live_limits: "
> +			"NR_PHYS_RANGES exceeded.\n");
> +	else if (nr_kimage_ranges >= NR_IMAGE_RANGES)
> +		error(FATAL, "sparc6_phys_base_live_limits: "
> +			"NR_IMAGE_RANGES exceeded.\n");
> +}
> +
> +static void sparc64_phys_base_live_valid(void)
> +{
> +	if (!nr_phys_ranges)
> +		error(FATAL, "No physical memory ranges.");
> +	else if (!nr_kimage_ranges)
> +		error(FATAL, "No vmlinux memory ranges.");
> +}
> +
> +static void sparc64_phys_base_live(void)
> +{
> +	char line[BUFSIZE];
> +	FILE *fp;
> +
> +	fp = fopen("/proc/iomem", "r");
> +	if (fp = NULL)
> +		error(FATAL, "Can't open /proc/iomem. We can't proceed.");
> +
> +	while (fgets(line, sizeof(line), fp) != 0) {
> +		unsigned long start, end;
> +		int count, consumed;
> +		char *ch;
> +
> +		sparc6_phys_base_live_limits();
If we exceed NR_PHYS_RANGES or NR_IMAGE_RANGES then we would fault below,
because the execution continue. (If error() returns that is).
Error handling looks a little ackward.

> +		count = sscanf(line, "%lx-%lx : %n", &start, &end, &consumed);
> +		if (count != 2)
> +			continue;
> +		ch = line + consumed;
> +		if (memcmp(ch, "System RAM\n", 11) = 0) {
> +			end = end + 1;
> +			phys_ranges[nr_phys_ranges].start = start;
> +			phys_ranges[nr_phys_ranges].end = end;
> +			nr_phys_ranges++;
> +		} else if ((memcmp(ch, "Kernel code\n", 12) = 0) ||
> +				(memcmp(ch, "Kernel data\n", 12) = 0) ||
> +				(memcmp(ch, "Kernel bss\n", 11) = 0)) {
> +			kimage_ranges[nr_kimage_ranges].start = start;
> +			kimage_ranges[nr_kimage_ranges].end = end;
> +			nr_kimage_ranges++;
> +		}
> +	}
> +
> +	(void) fclose(fp);
> +	sparc64_phys_base_live_valid();
> +}
> +
> +}

> +
> +static int sparc64_is_linear_mapped(unsigned long vaddr)
> +{
> +	int rc = 0;
> +
> +	if  ((vaddr & PAGE_OFFSET) = PAGE_OFFSET)
> +		rc = 1;
> +	return rc;

Just do a simple:
   return (vaddr & PAGE_OFFSET) = PAGE_OFFSET;

> +static unsigned long fetch_page_table_level(unsigned long pte_kva,
> +				unsigned long vaddr, unsigned int shift,
> +				unsigned int mask, const char *name,
> +				int verbose)
> +{
Coding style nit.
In some places the return type is on a separate line,
other places on the same line as the function name.
And the extra parameters would be better located aligned with the first
parameter on the first line (using TABS and SPACES as appropriate).
But all this is from being used to kernel style.
General note that apply to the whole patch.

> +int sparc64_IS_VMALLOC_ADDR(ulong vaddr)
> +{
> +	int ret = (vaddr >= machdep->machspec->vmalloc_start &&
> +		vaddr < machdep->machspec->vmalloc_end);
> +
> +	return ret;
This could be a one-liner.
And if you insist on using a local variable then name it rc as in other palces.

> +}
> +
> +static int sparc64_dis_filter(ulong vaddr, char *inbuf, unsigned int radix)
> +{
> +		return false;
> +}
Two tab indent?

> +{
> +	struct {struct sparc_stackf sf; struct pt_regs pr; }
> +		exception_frame_data;
Does this really need to be inside the function body?


> +	unsigned long exception_frame = bt->stacktop;
> +	unsigned long first_frame;
> +	struct reg_window one_down;
> +	int rc;
> +
> +	exception_frame = exception_frame - TRACEREG_SZ - STACKFRAME_SZ;
> +	rc = readmem(exception_frame, KVADDR, &exception_frame_data,
> +		sizeof(exception_frame_data), "EF fetch.", RETURN_ON_ERROR);
> +	if (!rc)
> +		goto out;
> +	if (exception_frame_data.pr.magic != 0x57ac6c00)
Please use PT_REGS_MAGIC. Do you need to mask out the lower 9 bits as doen in other places?


> +		goto out;
> +	first_frame = exception_frame - sizeof(struct reg_window);
> +
> +	rc = readmem(first_frame, KVADDR, &one_down, sizeof(struct reg_window),
> +		"Stack fetch.", RETURN_ON_ERROR);
> +	if (!rc)
> +		goto out;
> +	/* Extra arguments. */
> +	first_frame = first_frame - (6 * 8);
Where did 6 * 8 suddenly come from?

> +
> +	rc = readmem(first_frame, KVADDR, &one_down, sizeof(struct reg_window),
> +		"Stack fetch.", RETURN_ON_ERROR);
> +	if (!rc)
> +		goto out;
> +out:
> +	return rc;
> +}
> +
> +/* Need to handle hardirq and softirq stacks. */
> +static int kstack_valid(struct bt_info *bt, unsigned long sp)
> +{
> +	unsigned long thread_info = SIZE(thread_info);
> +	unsigned long base = bt->stackbase + thread_info;
> +	unsigned long top = bt->stacktop - sizeof(struct sparc_stackf) -
> +		sizeof(struct pt_regs);
> +	int rc = false;
> +
> +	if (sp & (16U - 1))
> +		goto out;
Where did 16U come from?

> +
> +	if ((sp >= base) && (sp <= top))
> +		rc = true;
> +out:
> +	return rc;
> +}
> +
> +static void sparc64_print_eframe(struct bt_info *bt, unsigned long stack_top)
> +{
> +	struct {struct sparc_stackf sf; struct pt_regs pr; } k_entry;
Duplicated - was also in previous function.

> +	struct pt_regs *regs = &k_entry.pr;
> +	unsigned long efp;
> +	unsigned int tt;
> +	int rc;
> +	struct reg_window window;
> +	unsigned long rw;
> +
> +	efp = bt->stkptr + STACK_BIAS - TRACEREG_SZ - STACKFRAME_SZ;
> +	rc = readmem(efp, KVADDR, &k_entry, sizeof(k_entry),
> +		     "Stack frame and pt_regs.", RETURN_ON_ERROR);
> +	if (!rc)
> +		goto out;
> +	if ((regs->magic & ~MAGIC_TT) != PT_REGS_MAGIC) {
> +		efp = stack_top - (sizeof(struct pt_regs) +
> +			sizeof(struct sparc_stackf));
> +		rc = readmem(efp, KVADDR, &k_entry, sizeof(k_entry),
> +			"Stack frame and pt_regs.", RETURN_ON_ERROR);
> +		if (!rc)
> +			goto out;
> +		/* Kernel thread or not in kernel any longer? */
> +		if ((regs->magic & ~MAGIC_TT) != PT_REGS_MAGIC)
> +			goto out;
> +	}
> +	tt = regs->magic & MAGIC_TT;
> +	fprintf(fp, "TSTATE=0x%lx TT=0x%x TPC=0x%lx TNPC=0x%lx\n",
> +		regs->tstate, tt, regs->tpc, regs->tnpc);
> +	fprintf(fp, " g0=0x%.16lx  g1=0x%.16lx  g2=0x%.16lx\n",
> +		regs->u_regs[0],
> +		regs->u_regs[1],
> +		regs->u_regs[2]);
> +	fprintf(fp, " g3=0x%.16lx  g4=0x%.16lx  g5=0x%.16lx\n",
> +		regs->u_regs[3],
> +		regs->u_regs[4],
> +		regs->u_regs[5]);
> +#define	___INS	(8)
> +	fprintf(fp, " g6=0x%.16lx  g7=0x%.16lx\n",
> +		regs->u_regs[6],
> +		regs->u_regs[7]);
> +	fprintf(fp, " o0=0x%.16lx  o1=0x%.16lx  o2=0x%.16lx\n",
> +		regs->u_regs[___INS+0],
> +		regs->u_regs[___INS+1],
> +		regs->u_regs[___INS+2]);
> +	fprintf(fp, " o3=0x%.16lx  o4=0x%.16lx  o5=0x%.16lx\n",
> +		regs->u_regs[___INS+3],
> +		regs->u_regs[___INS+4],
> +		regs->u_regs[___INS+5]);
> +	fprintf(fp, " sp=0x%.16lx  ret_pc=0x%.16lx\n",
> +		regs->u_regs[___INS+6],
> +		regs->u_regs[___INS+7]);
> +#undef	___INS
> +	rw = bt->stkptr + STACK_BIAS;
> +	if (!kstack_valid(bt, rw))
> +		goto out;
> +	rc = readmem(rw, KVADDR, &window, sizeof(window),
> +		     "Register window.", RETURN_ON_ERROR);
> +	if (!rc)
> +		goto out;
> +	fprintf(fp, " l0=0x%.16lx  l1=0x%.16lx  l2=0x%.16lx\n",
> +		window.locals[0], window.locals[1], window.locals[2]);
> +	fprintf(fp, " l3=0x%.16lx  l4=0x%.16lx  l5=0x%.16lx\n",
> +		window.locals[3], window.locals[4], window.locals[5]);
> +	fprintf(fp, " l6=0x%.16lx  l7=0x%.16lx\n",
> +		window.locals[6], window.locals[7]);
> +	fprintf(fp, " i0=0x%.16lx  i1=0x%.16lx  i2=0x%.16lx\n",
> +		window.ins[0], window.ins[1], window.ins[2]);
> +	fprintf(fp, " i3=0x%.16lx  i4=0x%.16lx  i5=0x%.16lx\n",
> +		window.ins[3], window.ins[4], window.ins[5]);
> +	fprintf(fp, " i6=0x%.16lx  i7=0x%.16lx\n",
> +		window.ins[6], window.ins[7]);
> +out:
> +	return;
> +}
> +
> +static void sparc64_print_frame(struct bt_info *bt, int cnt, unsigned long ip,
> +						unsigned long ksp)
> +{
> +	char *symbol = closest_symbol(ip);
> +
> +	fprintf(fp, "#%d [%lx] %s at %lx\n", cnt, ksp, symbol, ip);
> +
> +	if (bt->flags & BT_LINE_NUMBERS) {
> +		char buf[BUFSIZE];
> +
> +		get_line_number(ip, buf, false);
> +		if (strlen(buf))
> +			fprintf(fp, "\t%s\n", buf);
> +	}
> +}
> +
> +static void sparc64_back_trace(struct bt_info *bt)
> +{
> +	unsigned long stack_top = bt->stacktop;
> +	unsigned long ip = bt->instptr;
> +	unsigned long ksp = bt->stkptr;
> +	struct reg_window window;
> +	int cnt = 0;
> +	int rc;
> +
> +	do {
> +		if (!kstack_valid(bt, ksp + STACK_BIAS))
> +			break;
> +		rc = readmem(ksp + STACK_BIAS, KVADDR, &window, sizeof(window),
> +			"KSP window fetch.", RETURN_ON_ERROR);
> +		if (!rc)
> +			goto out;
> +		sparc64_print_frame(bt, cnt, ip, ksp);
> +		ksp = window.ins[6];
> +		ip = window.ins[7];
> +		cnt++;
> +	} while (cnt != 50);
> +	sparc64_print_eframe(bt, stack_top);
> +out:
> +	return;
> +}
> +
> +static ulong sparc64_processor_speed(void)
> +{
> +	int cpu;
> +	unsigned long clock_tick;
> +	struct syment *sp;
> +
> +	if (!MEMBER_EXISTS("cpuinfo_sparc", "clock_tick")) {
> +		error(WARNING, "sparc64 expects clock_tick\n");
> +		return 0UL;
> +	}
> +
> +	sp = per_cpu_symbol_search("__cpu_data");
> +	if (!sp)
> +		return 0UL;
> +	for (cpu = 0; cpu < kt->cpus; cpu++) {
> +		if (!in_cpu_map(ONLINE, cpu))
> +			continue;
> +		if (!readmem(sp->value + kt->__per_cpu_offset[cpu] +
> +			     MEMBER_OFFSET("cpuinfo_sparc", "clock_tick"),
> +			     KVADDR, &clock_tick, sizeof(clock_tick),
> +			     "clock_tick", QUIET|RETURN_ON_ERROR))
> +			continue;
> +		return clock_tick/1000000;
> +	}
> +	return 0UL;
> +}
> +
> +static ulong sparc64_get_task_pgd(ulong task)
> +{
> +	struct task_context *tc = task_to_context(task);
> +	ulong pgd = NO_TASK;
> +
> +	if (!tc)
> +		goto out;
> +	readmem(tc->mm_struct + OFFSET(mm_struct_pgd), KVADDR,
> +		&pgd, sizeof(unsigned long), "User pgd.", RETURN_ON_ERROR);
> +out:
> +	return pgd;
> +}
> +
> +static int sparc64_uvtop(struct task_context *tc, ulong va, physaddr_t *ppaddr,
> +						int verbose)
> +{
> +	unsigned long pgd = sparc64_get_task_pgd(tc->task);
> +	unsigned long paddr;
> +	int rc = false;
> +
> +	if (pgd = NO_TASK)
> +		goto out;
> +	paddr = sparc64_page_table_walk(pgd, va, verbose);
> +	/* For now not_valid_pte skips checking for swap pte. */
> +	if (paddr = not_valid_pte) {
> +		*ppaddr = 0UL;
> +		goto out;
> +	}
> +	*ppaddr = paddr;
> +	rc = true;
> +out:
> +	return rc;
> +}
> +
> +static unsigned long sparc64_vmalloc_translate(unsigned long vaddr, int verbose)
> +{
> +	unsigned long paddr = sparc64_page_table_walk(vt->kernel_pgd[0],
> +							vaddr, verbose);
> +
> +	return paddr;
> +}
> +
> +static unsigned long sparc64_linear_translate(unsigned long vaddr)
> +{
> +	unsigned long paddr = __pa(vaddr);
> +
> +	if (sparc64_verify_paddr(paddr) = false)
> +		error(FATAL,
> +			"sparc64_linear_translate: This physical address"
> +			" (0x%lx) is invalid.", paddr);
> +
> +	return paddr;
> +}
> +
> +static int sparc64_is_vmalloc_mapped(unsigned long vaddr)
> +{
> +	struct machine_specific *ms = &sparc64_machine_specific;
> +	int rc = 0;
> +
> +	/* We exclude OBP range whose TTEs were captured by kernel in
> +	 * early boot. It is possible to fetch these but for what purpose?
> +	 */
Comment says OBP but code used modules_vaddr / modules_end, vmalloc_start, vmalloc_end

> +	if ((vaddr >= ms->modules_vaddr && vaddr < ms->modules_end) ||
> +		(vaddr >= ms->vmalloc_start && vaddr < ms->vmalloc_end))
> +		rc = 1;
> +	return rc;
> +}
> +
> +static int sparc64_is_kvaddr(ulong vaddr)
> +{
> +	int rc = kimage_va_range(vaddr);
> +
> +	if (rc)
> +		goto out;
> +	rc = sparc64_is_linear_mapped(vaddr);
> +	if (rc)
> +		goto out;
> +	rc = sparc64_is_vmalloc_mapped(vaddr);
> +out:
> +	return rc;
> +}
Use goto for error handling.
The above is not easy to read/parse.


> +
> +static int sparc64_kvtop(struct task_context *tc, ulong vaddr,
> +					physaddr_t *paddr, int verbose)
> +{
> +	unsigned long phys_addr;
> +	int rc = false;
> +
> +	if (kimage_va_range(vaddr))
> +		phys_addr = kimage_va_translate(vaddr);
> +	else if (sparc64_is_vmalloc_mapped(vaddr)) {
> +		phys_addr = sparc64_vmalloc_translate(vaddr, verbose);
> +		if (phys_addr = not_valid_pte)
> +			goto out;
> +	} else if (sparc64_is_linear_mapped(vaddr))
> +		phys_addr = sparc64_linear_translate(vaddr);
> +	else {
> +		error(WARNING,
> +		"This is an invalid kernel virtual address=0x%lx.",
> +			vaddr);
> +		goto out;
> +	}
Coding style nit.
If you need {} then use it for all statements, also single liners.

So use:
if (foo()) {
	bar();
} else {
	baz();
	baz2();
}

> diff --git a/task.c b/task.c
> index 7b01951..f21d0f8 100644
> --- a/task.c
> +++ b/task.c
> @@ -2368,7 +2369,11 @@ store_context(struct task_context *tc, ulong task, char *tp)
>  
>          tc->pid = (ulong)(*pid_addr);
>  	strlcpy(tc->comm, comm_addr, TASK_COMM_LEN); 
> -        tc->processor = *processor_addr;
> +#ifdef SPARC64
> +	tc->processor = *(unsigned short *)processor_addr;
> +#else
> +	tc->processor = *processor_addr;
> +#endif
This looks like it is papering over something that needs a proper fix.
And it does not look sparc64 specific, so should be a separate patch.

>          tc->ptask = *parent_addr;
>          tc->mm_struct = *mm_addr;
>          tc->task = task;
> @@ -5266,8 +5271,15 @@ task_flags(ulong task)
>  
>  	fill_task_struct(task);
>  
> -	flags = tt->last_task_read ?
> -		 ULONG(tt->task_struct + OFFSET(task_struct_flags)) : 0;
> +	if (tt->last_task_read) {
> +		if (SIZE(task_struct_flags) = sizeof(unsigned int))
> +			flags = UINT(tt->task_struct +
> +				     OFFSET(task_struct_flags));
> +		else
> +			flags = ULONG(tt->task_struct +
> +				      OFFSET(task_struct_flags));
> +	} else
> +		flags = 0;
This also looks like it is paerign over something that should see a proper fix.
And it does not look sparc64 specific, so should be in a separate patch.
