From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Tue, 13 Jul 2004 16:02:57 +0000
Subject: sparc32 status
Message-Id: <20040713160257.GA8148@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Due to a conflict of interest, I'll no longer be maintaining the
sparc32 tree.  Although I hope there will soon be an announcement of a
new maintainer, in the interim please direct all patches and bug
reports to the list.

For those interested in working on sparc32, here is my latest todo
list.  This was originally from Pete.  His comments generally start
with ## and mine with **.  The items which I believe to be working
properly are at the bottom.  This means that if you're still having a
problem with one of them you need to make noise.



 ## (De-)Alias
flush_user_windows is the same code as WINDOW_FLUSH, but
WINDOW_FLUSH is used on sun4m only. Make generic? Add calls to .S?

From: DaveM

WINDOW_FLUSH is a macro of assembly merely for the convenience of
the sun4m cache/tlb flushing code.  Calling out to a common routine
isn't easy because we want to keep these timing critical cache/tlb
flush routines from needing to allocate a stack frame.

I suggest to put this on backburner for now.

 ## Get rid of fork_kpsr, fork_kwim. See comment above sparc64 sys_vfork.

 ## CONFIG_PREEMPT - rtrap.S

 ## Rewrite ioport.c, keep local directory of resources (indexed).

 ## JavaStation userland -- grab the userland and try it out.
"Chris Newport" <crn@netunix.com>
ftp://ftp.netunix.co.uk/pub/splack/splack-current/tftpboot/README.JAVASTATION

 ## Remove __irq_itoa
Very sophisticated on sparc64 (irq is a pointer).
Ask DaveM to make it index into ivector_table[].
-- We now have sun4d, restore that first and compare.

From: DaveM
sun4d IRQ scheme is almost identical to sparc64 sun4u one,
in fact sun5 architecture is basically sun4d + improvements.
I am fine to make sparc64 irq into an index.

 ## JSFLASH bitrotted
-- Migrate to MTD
-- Jarno has it

 ## How about getting current back to g6, and extract current_thread_info()
from the stack pointer. Be "cycle counting maniac".

From: DaveM
To be honest, if you take my advice and move most of thread stuff
into thread_info, 'current' becomes much much less important.

** Pete did some of the thread stuff.  There's still a bit left to do.

 ## Galvanize STRICT_MM_TYPECHECKS
Dave says he'd run it all the time, but structure passing convention
puts all them on stack. -- deferred. Ask Jakub to change C ABI?

** Even worse, what to do about large PMD?  See the next item.

 ## Make sure we do not cause actual assignment of *dir (a BIIIG struct).
static inline void free_one_pmd(mmu_gather_t *tlb, pmd_t * dir)
{
        struct page *page;

        if (pmd_none(*dir))
                return;
        if (pmd_bad(*dir)) {
                pmd_ERROR(*dir);
                pmd_clear(dir);
                return;
        }
        page = pmd_page(*dir);
        pmd_clear(dir);
        pgtable_remove_rmap(page);
        pte_free_tlb(tlb, page);
}
-- Bug Riel.

 ## Get rid of srmmu_early_allocate_ptable_skeleton and __nocache_fix
Perhaps not that easy; consider what if we do large page mapping.

** I think this can't be done.  Large mapping has been around forever.

 ## Kill pg0 .. pg3. Only used on sun4c, what for?
From: DaveM
It is used to build the VMALLOC pmds/pte_tables at boot time
so that we don't need to do it later.  This was needed for some
reason, but it escapes me now.

 ## srmmu_pte_alloc_one is a bunch of longish macros. Shorten? Profile?

 ## Merge sunsu.c with the new (2.5.32) generic serial, 8250. kgdb anew?
 ## su_inb vs. serial_inp in su.c: should be uniform.
-- sunsu.c same.
-- Investigate a move to 8250.c instead.
 ##
sunsu.c: In function `wait_for_xmitr':
sunsu.c:1309: warning: implicit declaration of function `udelay'
 ## SysRq does not work on su console

 ## Finish the kgdb: remove sparc-stub.c	-- NO. MAY BE USED AGAIN.
 ## ...
[DaveM] I zapped all the SERIAL/CONSOLE checks and the kgdb references
[DaveM] from sparc64
[DaveM] CONFIG_SERIAL_CONSOLE is just plain remnant...
[DaveM] look it only exists as define_bool in sparc config.in now
[DaveM] we have to add some machinery to drivers/serial/Config.in if you want 
           user to be able to switch this

 ## Shortcut __nocache_va, __nocache_pa. Goddamn mess.

I don't see any reasonable way to clean this up.  Probably best just to
consider nocache a failed experiment and move on.

 ## 2002/10/02 pci_alloc_consistent out of vmalloc-ed space
Mary Ann Diehl <mdiehl1@stny.rr.com>
mem_map_reserve(virt_to_page(return_value_from_pci_alloc_consistent));
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0210.0/0807.html
DaveM: Put this on hold, more thought is needed. (cache coherency)

 ## Make sure ntpd continues to work with "fixed" do_gettimeofday().

 ##
btfix.s is not destroyed when the command returned non-zero.

 ## div64.h only uses 32 lower bits (silently)?!
-- Davem sent fix outline, implement.
-- Use hw div and %y on v8's.

 ## Test sunzilog.c on ancient sun4c's (my IPC got OBP 2.x, need 1.6).

 ## Check we do it right
<paulus> so, inside an interrupt handler, current_thread_info()->preempt_count
           & HARDIRQ_MASK should be non-zero
<zwane_> thats the problem
<zwane_> gimme a sec
<zwane_> not all the bases where covered
<zwane_> its in traps.c
<zwane_> do_nmi
<zwane_> needs irq_enter
<wli> hehe
<zwane_> well thats nifty
<willy> bingo ;-)

** I believe I've gotten this mostly right now, but some sanity checks
** are definitely in order.

 ## URL
http://bugme.osdl.org/buglist.cgi?short_desc_type=allwordssubstr&short_desc=&product=Platform+Specific%2FHardware&component=S390-31&component=S390-64&component=SPARC32&component=SPARC64&long_desc_type=allwordssubstr&long_desc=&emailassigned_to1=1&emailtype1=substring&email1=&emailassigned_to2=1&emailreporter2=1&emailcc2=1&emailtype2=substring&email2=&bugidtype=include&bug_id=&changedin=&chfieldfrom=&chfieldto=Now&chfieldvalue=&cmdtype=doit&newqueryname=&order=Reuse+same+sort+as+last+time&field0-0-0=noop&type0-0-0=noop&value0-0-0
 ## Add %wim to panic printouts

 ## E's patch
http://marc.theaimsgroup.com/?l=linux-ultrasparc&m3653103608133&w=2

 ## I do not remember adding this. WTF?
+       ld      [%o0 + 0x00], %o0       /* XXX vma->vm_mm GROSS XXX */

From: DaveM

It is my comment, flush_* take vma args, but these assembler routines
need to work with mm_struct.

Some routines actually want to get at other 'vma' members (for
exmaple, tsunami_flush_cache_page).

Longer term, once conversion away from flush_page_to_ram() to
flush_dcache_page et al. interfaces occur, 'vma' arg will be even more
important to flush_cache_foo() implementation.

 ## flush_page_to_ram will be deprecated soon.
Easiest conversion is probably:

1) Run sed s'/flush_page_to_ram/sparc_page_to_ram/' on all sparc
   sources.

2) #define flush_page_to_ram(page) do { } while (0)

3) #define flush_dcache_page(page) sparc_page_to_ram(page)
4) #define clear_user_page(addr, vaddr, page) \
           do { clear_page(addr); \
                sparc_page_to_ram(page); \
           } while (0)
   #define copy_user_page(to, from, vaddr, page) \
           do { copy_page(to, from); \
                sparc_page_to_ram(page); \
           } while (0)

But, like I said, in longer term full conversion to sparc64'like
flush_dcache_page is nearly mandatory.  I can give implementation
outline, it actually isn't much work.

-- 2003/02/01 Willy does the conversion, hurray!

 ## Migrate to thread_into & TI_FOO.
-  ({ ELF_CORE_COPY_REGS((*(__elf_regs)), (__tsk)->thread_info->kregs); 1; })
+  ({ ELF_CORE_COPY_REGS((*(__elf_regs)), (__tsk)->thread.kregs); 1; })

But this is one of many reasons I want the sparc32 thread_info stuff
to match what sparc64 does.  I wouldn't have made this trivial error
if things were consolidated.

 ## davem's switch_to clobber
BTW, if ever bored a good audit for sparc32 would be to verify
all inline asm's, the two most common errors are:

1) Output constraints are wrong.  In multi instruction asm's
   producing some output, you almost always must use =&r
   for output operands.  Otherwise gcc may allocate the same
   register to some input as one of the outputs, but if the
   output is clobbered before all the inputs are used it will
   be wrong.

2) Missing "cc" clobber when condition codes change as a result
   of the asm.

-- script the thing

 ## gcc-3 (see davem's mail)
3) prepare_arch_switch() has to execute in the same stack frame
   as switch_to() for it to flush the correct register windows.

 ## E's interrupt -> pil  sbint_new.diff 2002/12/04
 ## Eric's way to generate tables - add to source comments.
From OBP: "sbus-intr>cpu"
More specifically, something like "1 sbus-intr>cpu ." etc, etc.
-- DONE? Verify.
-- 2.4 - get people to test, goddamit

 ## HIGHMEM is needed for sun4c: Dave's e-mail near "ravnborg" thread.
-- Is it really that necessary?

 ## Reif's VME interrups, cleanup of sun4m masking. 2002/12/07

 ##
Serial: Sun Zilog driver (2 chips).
ioremap: done with statics, switching to malloc
zs2 at 0xfd014004 (irq = 44) is a Zilog8530
zs3 at 0xfd014000 (irq = 44) is a Zilog8530
ttyS0 at MMIO 0x0 (irq = 44) is a SunZilog
ttyS1 at MMIO 0x0 (irq = 44) is a SunZilog
              ^^^ ?!
We set membase (via sunzilog_chip_regs) - correctly to the virtual address.
We do NOT set mapbase - should be physical address (our physical is 36 bits).

** I submitted a patch for this to just display the mapped address,
but Pete didn't like it.  Probably need to get it from sdev.

 ## Verify that low 16K are used for something (put into the memory map)

 ## prof_counter use per-cpu 2003/01/13 -- do soon
-- oh crap, this is getting stale 2003/02/12

 ## sunzilog
Discuss with DaveM. I want to print from under cli.
        if (ZS_IS_CONS(up)) {
                /* TX still busy?  Just wait for the next TX done interrupt.
                 *
                 * It can occur because of how we do serial console writes.  It
would
                 * be nice to transmit console writes just like we normally would for
                 * a TTY line. (ie. buffered and TX interrupt driven).  That is
not
                 * easy because console writes cannot sleep.  One solution might be
                 * to poll on enough port->xmit space becomming free.  -DaveM
                 */

 ## 2.4 Spot cannot build modules for sun4 2003/01/27

 ## Run NON-CONSOLE Zilog real hard (getty+uucp).

 ## oprofile -> see DaveM's e-mail with patch for sparc64 2003/03/24

 ## Don't call prom_probe_memory twice
First call, after loadmmu.
Second call, from paging_init -> srmmu_paging_init -> .....nocache_calcsize.

 ## nocache improvements
Problem: 2.5 uses much more, sometimes. So, it runs out.
Problem: Generic bitmap lookup does not use right heuristics,
  so it fragments heavily. PMDs start failing at 60% full.
Solution: Use dynamically allocated pages of nocache, at least of page-sized
  requests. Uncache pages in-place (in address space). Do not use aliasing.
Implications?

 ## Everything is incredibly slow on mallorn under 2.5.
(vmstat coredumps, so no data)

 ## Using 4 times more pagetables than on 2.4

** Leaked pmds in fault.c, plus the bitext stuff.  This seems to be back to
almost sane values now.

 ## smp_capture => removal of cli()/sti().
./arch/sparc64/kernel/smp.c:void smp_capture(void)
./arch/sparc64/kernel/unaligned.c:      smp_capture();
./arch/sparc64/prom/misc.c:     smp_capture();

** cli/sti are gone but the smp_capture needs to be converted to sparc64 type.

 ## New iommu - le0 on lebethron does not work: says "cable problem".
Both AUI and TP fail.

** Can't reproduce.

 ## Implement get_cycles(): Freitag says non-monotonous is ok.

 ## signal problem in 2.4
http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2003-July/016042.html

 ## volatile unsigned long * in bitops.

fs/ext2/balloc.c: In function `grab_block':
fs/ext2/balloc.c:270: warning: passing arg 2 of `test_le_bit' from incompatible
pointer type
fs/ext2/balloc.c:284: warning: passing arg 1 of `find_next_zero_le_bit' from incompatible pointer type
fs/ext2/balloc.c:301: warning: passing arg 2 of `test_le_bit' from incompatible
pointer type
fs/ext2/balloc.c:306: warning: passing arg 1 of `find_next_zero_le_bit' from incompatible pointer type
fs/ext2/balloc.c: In function `block_in_use':
fs/ext2/balloc.c:556: warning: passing arg 2 of `test_le_bit' from incompatible
pointer type

 ## 2.4: Peter Jones' make -j patch  2003/05/18

 ## Kill  if (.... && !serial_console)  from process.c:machine_power_off.
-- Done for 2.5.70 level, don't forget.
-- Also, persuade Dave & Eric to kill it in sparc64

 ## barrier in cpu_relax

[zaitcev@niphredil linux-2.6.0-test2-sparc]$ cat src.list| LANG=C xargs grep irqs_running | more
./arch/sparc/kernel/irq.c:      printk("irq:  %d [ ", irqs_running());
./arch/sparc/kernel/irq.c:      if (irqs_running()) {
./arch/sparc/kernel/irq.c:              if (!irqs_running() &&
./arch/sparc/kernel/irq.c:              while (irqs_running() ||
./include/asm-sparc/hardirq.h:static __inline__ int irqs_running(void)

 -- Use cpu jail for synchronize_irqs?
Probably not. Jail cannot wait out currently running interrupts,
it breaks them as soon as CPU is unmasked. The old synchronize_irq()
did cli+sti, which was probably not what's asked from it.

** Do it like i386, with an extra flag.  joshk did some of this.

 ## Implement a better sched_clock
/*
 * Returns nanoseconds
 */
unsigned long long sched_clock(void) {
        return (unsigned long long)jiffies * (1000000000 / HZ);
}

But for best CPU scheduler results the architecture should try to return a
higher-resolution number than this of course.

sched_clock() has no absolute time requirements: it just has to return some
number which goes up by 1,000,000,000 times per second.

A microsecond is 1% accurate at 10k context switches/sec.  That should suffice.

-- espdma errors on hypersparc at boot (error bit is set, why?)

-- SMP hangs on userland startup

-- spot's sun4 patch

-- IGAFB patch From: Tim Vandermeersch <Tim.Vandermeersch@pandora.be>

-- sun4d ranges fixup is hosed, see sbus.c:sbus_bus_ranges_init:

/*
 * XXX This functions appears to be a distorted version of
 * prom_sbus_ranges_init(), with all sun4d stuff cut away.
 * Ask DaveM what is going on here, how is sun4d supposed to work... XXX
 */

-- New LEON patch, it's much better.  Can btfixup of some kind be used
for the ASI number?  Not any existing kind I think.

********************* FIXED/DONE ********************

 ## Fix nonzero phys_base (account in page_to_phys, etc.)
 ## ak:
<zaitcev> Suppose, that I have a Linux box with RAM not starting at physical 
           address zero. Will pfn be an index into mem_map, or a (phys_addr >> 
           PAGE_SHIFT) ?
<freitag> zaitcev: it's normally both (at least on i386)
<freitag> mem_map mapping the hole
<freitag> if you don't want that you need CONFIG_DISCONTIG
<zaitcev> Oh

From: DaveM

Please, use sparc64 as model, it is much simpler.

Actually... looking to current {srmmu,sun4c}.c, it makes precisely
the same thing as sparc64, passing lowest pfn to
free_area_init_node().

The only missing part is fixing mem_map[] indexing to take
(phys_base >> PAGE_SHIFT) into account.  Again, look to sparc64
for guidance.

-- pfn must be a hardware recognized physical page number, the one used
   in PTEs, IOPTEs, etc. Otherwise, it's a mess. Thus, it covers the hole.
   BUT, the mem_map does not have to.

** DONE

 ## omit or not omit [the frame pointer], that is the question.
  sparc-unknown-linux-gnu-gcc -Wp,-MD,./.sched.o.d -D__KERNEL__
 -I/q/zaitcev/ksrc/linux-2.5.24-sparc/include
 -Wall -Wstrict-prototypes -Wno-trigraphs -O2
 -fomit-frame-pointer -fno-strict-aliasing -fno-common
 -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7 -nostdinc
 -iwithprefix include    -fno-omit-frame-pointer -DKBUILD_BASENAME=sched
 -c -o sched.o sched.c

My precise suggestion is some CONFIG_SCHED_NO_NEED_FRAME_POINTER, bool
it to 'y' on IA64, sparc32, sparc64.  In kernel/Makefile replace that
ugly CONFIG_IA64 test and comment a test on the new config option.

** Irrelevant now?

 ## %l5, %l6 they are used to call do_signal. Only syscall path sets them.
RESTORE_ALL gets to them.

        clr     %o0
        mov     %l5, %o2
        mov     %l6, %o3
        call    C_LABEL(do_signal)
         add    %sp, REGWIN_SZ, %o1     ! pt_regs ptr

From: DaveM

RESTORE_ALL clears l6, which makes l5 be ignored by do_signal().

This is almost identical to how sparc64 works, l6 non-zero means that
we are returning from a syscall.  Zero value means we are not.

-- Cannot believe it works, but it does

 ## Kill cli, sti, save_and_cli from arch code. Be proactive.

** DONE

 ## Make System.map corresponding to arch/sparc/boot/image.
-- Fixed by RobR, a little crude, but works (runs nm twice)
-- diff System.map arch/sparc/boot/System.map
[zaitcev@lebethron linux-2.5.62-sbus]$ grep ROOT_DEV System.map
f0232e04 B ROOT_DEV
[zaitcev@lebethron linux-2.5.62-sbus]$ grep ROOT_DEV arch/sparc/boot/System.map
f0233e04 B ROOT_DEV
[zaitcev@lebethron linux-2.5.62-sbus]$
  They are offset by a whole page, is this ok? Why? btfixup?
  Actually, only some of symbols are offset -> init symbols
 ## Now, get rid of duplicated System.map

** DONE

 ## Down with NEW_GAS
From: DaveM

Actually, the right fix is to remove the NEW_GAS altogether, every
binutils people should be using now to build kernels should be able to
grok those options and specifying them when elf32-sparc is the default
is totally harmless.

... blow away all of the a.out build support cruft.
There is zero use for any of this ancient crap anymore.

This means C_SYMBOL() et al. may die as well.

I had been meaning to do this for years.

** DONE
 
 ## Implement a debugging mode for spin_unlock_irq_restore which compares
CWP with the stored value and tracebacks instead of blowing up unpredictably.
-- Maybe not, see below
 ## 2002/11/13 Benchmark? Cute assembly trick? Deprecate Cypress support?
<zaitcev> Dave, why are you against masking CWP in setipl?
<davem> It's expensive
<davem> If you do it, then fine, but move setipl into external function because
           it is too fat to inline
<zaitcev> Hmm... In CPUs I worked with, writing PSR was expensive
<zaitcev> Oh
<davem> Every damn spinlock,rwlock,softint,etc. operation makes this
<zaitcev> That's even worse
<zaitcev> OK, I see your point
<davem> :)

** DONE

 ##
The post 2.5.62 posix-timers.c passes spin_lock_irqsave flags around between
functions. If you still put your window pointer in there you'll need to fix
that.

** DONE
                                                                                
-Andi
 ## When CWP is removed from flags, fix Rusty's Kernel Locking Guide,
"The Fucked Up Sparc" chapter (google), or URL:
 http://kernelnewbies.org/documents/kdoc/kernel-locking/sparc.html

** DONE

 ## New modutils
http://www.kernel.org/pub/linux/kernel/people/rusty/module-init-tools-0.7.tar.gz
http://www.kernel.org/pub/linux/kernel/people/rusty/modules

** This stuff works now 2-6-04

 ##
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?

** I don't see this any more.

 ##
From: Robert Reif

Looks like xconfig doesn't like the changes from:
    if [ "$ARCH" = "sparc" -o "$ARCH" = "sparc64" ]; then
to
    if [ "$CONFIG_SPARC32" = "y" -o "$CONFIG_SPARC64" = "y" ]; then
in 2.4.20.

** Obsolete, ignore.

 ## (mallorn, but should be generic). 2.5.54 with fixed zilog R9.
Give root password for maintenance
(or type Control-D for normal startup):
  <--- Then no input on console. Not even break.
-- Rx_INT lost, fixed
-- 2003/12/24 Recheck with Keith's patches to 2.6.0
** This is fixed.

 ## Same bug on 2.4.21-pre3! (no input)
Give root password for maintenance
(or type Control-D for normal startup):
-- Works in some situations, but not others - root fs or non-root fs?

** No problems.

 ## Al's swapoff bug. 2003/01/13
It looks like something is raising SIGSEGV on the exit from syscall - after
sys_swapon() had done its thing (and no, it's not sys_swapon() itself - happens
even if you call it as non-root, so it just checks capabilities and sods off).
-- Still happening?

** Fixed by Pete.

 ## Dot in exported symbols - Rusty is stirring trouble.
Kai says - move EXPORT_SYMBOL_DOT to generic, or it will break over and over.
** This is fixed, sort of.  Make generic later?
** Rusty beat me into submission.  It's done for good.

 ##
<kai> anton: The compiler cannot know that we're currently creating a module, so it'll just put a direct call to .function in the code. When that code is loaded as a module, you'll thus see an unresolved symbol .function. The generic code puts the value of the descriptor "function" in there instead, and then the arch code when doing the relocations creates a trampoline, putting the actual function address from the descriptor right into it. Sounds righ
<kai> t?
<anton> yep! :)
<anton> i wonder how ia64 handles it, it has function descriptors too
.....
<zaitcev> I'm the victim of .mul and .div
<anton> rusty has his sights on them :)
<f> what do function descriptors have to do with modules? I thought the trampolines were to be able to put modules everywhere in the virtual space, but not using 64bit jumps.
<anton> f: they do 2 things, yes they are also needed to put modules everywhere
<anton> f: but since we have a different TOC (effectively a GOT, referenced by offsets to r2) we need to load/restore it
<kai> zaitcev: I had a new EXPORT_SYMBOL_DOT() for sparc. But since we just blindly skip '.' now for ppc64, it's not necessary, the EXPORT_SYMBOL() works.
<kai> However, at least I understand why now, and I'm still not quite happy. Just skipping blindly isn't very clean IMO.
<anton> f: with rusty's patch to created shared .o files this work would be done for us
<anton> but it broke badly on mips i think, so its not happening for 2.6
<kai> anton: I think that was rth's patch. Anyway, I don't know how much that affects the generic kernel/module.c, apart from that there's nothing preventing ppc64 to add "-shared" to LDFLAGS_module.
<anton> kai: yeah I think you are right, rth did all that work

 ## Whaaat... use CONFIG_SPIN_LOCK_DEBUG, compare w/i386
#define SPIN_LOCK_DEBUG

** Seems to have been fixed long ago.

 ## 2.4 modprobe does not use path. 2.4.21-pre3
[root@mallorn zaitcev]# modprobe openpromfs
modprobe: Can't locate module openpromfs
[root@mallorn zaitcev]# insmod openpromfs.o
openpromfs.o: openpromfs.o: No such file or directory
[root@mallorn zaitcev]# insmod /lib/modules/2.4.21-pre3-sparc/kernel/fs/openpromfs/openpromfs.o
[root@mallorn zaitcev]# lsmod
Module                  Size  Used by
openpromfs             12128   0  (unused)
[root@mallorn zaitcev]#
-- Ancient modutils.

** nonissue

 ## 2.4 self
Kernel debugging (CONFIG_DEBUG_KERNEL) [N/y/?] (NEW) y
  Debug high memory support (CONFIG_DEBUG_HIGHMEM) [N/y/?] (NEW)
scripts/Configure: Can't reopen pipe to command substitution (fd 5): No child processes
  Debug memory allocations (CONFIG_DEBUG_SLAB) [N/y/?] (NEW)
-- This typically means a syntax error in Config.in. But where?

** Obsolete, ignore

 ## Restore fixed pkmap placement.

** Done 2-6-04

 ## Aiming for the worst possible fragmentation with the new code, are we?
srmmu: systemavail 32368 nocache_napages 256
srmmu: nocache_init for 1048576 bytes
srmmu: pool f027a000 alias fc000000 bitmap f037a000 bits 4096
srmmu: get size 4 align 4, got 0
srmmu: get size 1 align 1, got 4
srmmu: get size 16 align 16, got 16
srmmu: past srmmu_nocache_init
srmmu: get size 1 align 1, got 32
srmmu: get size 16 align 16, got 48
srmmu: past map_kernel
srmmu: get size 1 align 1, got 64
srmmu: past poke_srmmu
srmmu: get size 1 align 1, got 65
srmmu: get size 16 align 16, got 80
srmmu: get size 16 align 16, got 96
srmmu: get size 16 align 16, got 112
srmmu: get size 16 align 16, got 128
srmmu: get size 1 align 1, got 144
srmmu: get size 16 align 16, got 160
srmmu: get size 16 align 16, got 176
On node 0 totalpages: 7458

srmmu: out of nocache 4096: 1048576/613632
-- Only 60% in use

** I've improved this somewhat by modifying the bitext.c algorithm.  It
has slightly lower fragmentation, but more importantly I also fixed a bug
that caused the "iommu out" message - turns out it would never wrap around
to the beginning of the area once allocations exhausted the end.

 ## cron misbehaviour
[root@mallorn /root]# srmmu: out of nocache 4096: 1048576/613632
VM: killing process bash
srmmu: out of nocache 4096: 1048576/613632
VM: killing process bash
-- When cron starts forking like crazy
-- Runaway cron is present regardless of gcc-3 support.
++ Seems like the ptrace fix fixed it. Hmm....
** This is no longer observed

 ##
[root@mallorn /root]# vmstat 5
 procs                  memory    swap        io    system         cpu
 r b w  swpd  free  buff cache  si  so   bi   bo   in   cs  us  sy  id
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 00000008
tsk->{mm,active_mm}->pgd = fc1f2000
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
vmstat(270): Oops [#1]
PSR: 414010c6 PC: f0018854 NPC: f0018858 Y: 00000000    Not tainted
                  dump_fpu
g0: 018b0e79 g1: 00080000 g2: 00000000 g3: 00000000 g4: 00002000 g5: 500952b0 g6: f1148000 g7: 00000040
o0: f1140d30 o1: f1140db0 o2: f1140db8 o3: f1140db4 o4: 1f8454b4 o5: 00000000 sp: f1149c00 o7: f001884c
l0: f0214800 l1: f07bba1c l2: f07bba0c l3: f1140aca l4: f01cf800 l5: 00000000 l6: 41401fe0 l7: 5014480c
i0: 00000000 i1: f1f12000 i2: 00000004 i3: 00000750 i4: f11407b0 i5: 00000010 fp: f1149c68 i7: f00b894c
Caller[f00b894c] elf_core_dump
Caller[f0092c00] do_coredump
Caller[f004bacc]
Caller[f001a054]
Caller[f0015804]
Caller[50099828]
Instruction DUMP: 9402a608  7ffff118  9602e604 <d2060000> 11000004  902a4008  c02420d4  d0260000  d201a004
Segmentation fault
[root@mallorn /root]#

-- On ppc64:
 int
 dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpregs)
 {
-       if (regs->msr & MSR_FP)
+       if (regs && regs->msr & MSR_FP)
                giveup_fpu(current);
        memcpy(fpregs, &current->thread.fpr[0], sizeof(*fpregs));
        return 1;
Problem here is that the NPTL patch introduces calling dump_fpu() with
NULL as regs.  The ppc64 dump_fpu() uses regs (it seems other
dump_fpu() implementations do not).

** Seems not to happen any more.

 ## mallorn - while building a kernel
[root@mallorn /root]# kernel BUG at mm/rmap.c:305!
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 0000003e
tsk->{mm,active_mm}->pgd = fc12a000
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
cc1(5099): Oops [#1]
PSR: 410010c0 PC: f0079398 NPC: f007939c Y: 00000000    Not tainted
g0: f0221c00 g1: f0d5600c g2: 00000000 g3: 41901fe2 g4: f0035054 g5: 00000008 g6: f0d56000 g7: 00000000
o0: 0000001d o1: f0221c00 o2: f01d5800 o3: 414010e0 o4: f0221c00 o5: f0221c08 sp: f0d577f8 o7: f0079390
l0: f0690948 l1: 00000000 l2: 0008e000 l3: 00000002 l4: 00000000 l5: 00030009 l6: f01dd000 l7: f01db800
i0: f04d63f0 i1: fc139238 i2: 00104a8a i3: f022dc2c i4: f022dc00 i5: f022dc24 fp: f0d57870 i7: f007975c
Caller[f007975c]
Caller[f006bb1c]
Caller[f006c574]
Caller[f006d5b0]
Caller[f006d62c]
Caller[f006d73c]
Caller[f0062950]
Caller[f0072ddc]
Caller[f00730d4]
Caller[f00738a0]
Caller[f0024728]
Caller[f00146f4]
Caller[0018f78c]
Instruction DUMP: 9215a138  7fff0fd9  94102131 <c0244000> d2046044  11074912  9012233c  80a24008  02800008
Unable to handle kernel NULL pointer dereference in mna handler<1> at virtual address 00000043
 <------ next oops is bogus (NULL + 43)

** Fixed, most likely by highmem rework.

 ## The opposite of the above, with 2.5.69-bk6 + highmem_io
[/sbin/fsck.ext2] fsck.ext2 -a /dev/sda6
/dev/sda6 was not cleanly unmounted, check forced.
Unable to handle kernel paging request in mna handler<1> at virtual address 292c3279
current->{mm,active_mm}->context = 00000026
current->{mm,active_mm}->pgd = fc0f0000
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
kswapd0(6): Oops [#1]
PSR: 410010c5 PC: f00799b8 NPC: f00799bc Y: 00000000    Not tainted
                  try_to_remove_one
%G: 00000afc f04fad38  00000000 418010e6  f005d4b0 00010019  f0556000 00010009
%O: f068fd88 001e0528  f04af860 f0270000  f022745c 00000002  f0557b00 f0079920
%L: f068fd88 292c3235  36403332 00000002  00000004 00000000  f01ddc00 f0227400
%I: f04fad38 fc021500  00000000 f01da400  f055e060 f055e060  f0557b78 f0079d78
Caller[f0079d78] try_to_unmap
Caller[f006c09c] shrink_list
Caller[f006caf4] shrink_cache
Caller[f006db78] shrink_zone
Caller[f006de7c] balance_pgdat
Caller[f006e018] kswapd
Caller[f0018830]
Caller[f024b080]
Caller[00000000]
Instruction DUMP: 7fff0e0c  94102131  c0244000 <d2046044> 11074912  9012233c  80a24008  02800008  a6046044

** Likewise.

 ## OLD, but [almost] same as above. No highmem-io yet.
[/sbin/fsck.ext2] fsck.ext2 -a /dev/sda6
/dev/sda6 was not cleanly unmounted, check forced.
Unable to handle kernel paging request in mna handler<1> at virtual address 726563b3
current->{mm,active_mm}->context = 00000026
current->{mm,active_mm}->pgd = fc0f0000
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
kswapd0(6): Oops [#1]
PSR: 410010c5 PC: f007738c NPC: f0077390 Y: 00000000    Not tainted
                  try_to_unmap_one
g0: 00000aac g1: fc023060 g2: 00000000 g3: 414010e0 g4: f005c380 g5: 00030009 g6: f1efc000 g7: 00030009
o0: f055bb78 o1: 001e0578 o2: f037b600 o3: f0261000 o4: f1ed9834 o5: 00000000 sp: f1efdb30 o7: f00772f4
l0: f055bb78 l1: 7265636f l2: 7265ae73 l3: 00000002 l4: 00000004 l5: 00000000 l6: f01d3000 l7: 0000000a
i0: f03c50c0 i1: fc023060 i2: 001d788a i3: f0217e44 i4: f1421d78 i5: f005ce70 fp: f1efdba8 i7: f007774c
Caller[f007774c] try_to_unmap
Caller[f0069da0] shrink_list
Caller[f006a4ec] 
Caller[f006b528]
Caller[f006b7d0]
Caller[f006b948]
Caller[f00189c0]
Caller[f023c01c]
Caller[50028e1c]
Instruction DUMP: 7fff1578  94102153  c0244000 <d2046044> 11074912  9012233c  80a24008  02800008  a6046044

** Same thing here.

 ## Keith's trap table alignment in 2.4

** Done

 ## Atomic 32 bit

** DONE

 ## Rob's patch for gcc-3.3

** 3.3.3 builds fine as of 3-21-04

 ## Eradicate smp_num_cpus
./arch/sparc/kernel/sun4d_smp.c:extern int smp_num_cpus;
./arch/sparc/kernel/sun4d_smp.c:                smp_num_cpus = cpucount + 1;
./arch/sparc/kernel/smp.c:int smp_num_cpus = 1;
./arch/sparc/kernel/sun4m_smp.c:extern int smp_num_cpus;
./arch/sparc/kernel/sun4m_smp.c:                smp_num_cpus = cpucount + 1;
./arch/sparc/kernel/sun4m_smp.c:                register int ncpus = smp_num_cpus;
./arch/mips/ite-boards/generic/irq.c:        for (j=0; j<smp_num_cpus; j++)
./arch/mips/sibyte/sb1250/irq.c:                for (i=0; i<smp_num_cpus; i++) {./arch/i386/kernel/apm.c: *         the code away anyway (smp_num_cpus = 1 in UP)
./arch/alpha/kernel/alpha_ksyms.c:EXPORT_SYMBOL(smp_num_cpus);
./arch/alpha/kernel/smp.c:int smp_num_cpus = 1;         /* Number that came online.  */
./arch/alpha/kernel/smp.c:      smp_num_cpus = cpu_count;
./arch/parisc/kernel/smp.c:int smp_num_cpus = 1;
./arch/parisc/kernel/smp.c:     for (i = 0; i < smp_num_cpus; i++) {
./arch/parisc/kernel/smp.c:     atomic_set(&data.unstarted_count, smp_num_cpus - 1);
./arch/parisc/kernel/smp.c:     atomic_set(&data.unfinished_count, smp_num_cpus
- 1);
./arch/parisc/kernel/smp.c:     smp_num_cpus = cpu_count;
./arch/v850/kernel/irq.c:       for (i=0; i < 1 /*smp_num_cpus*/; i++)
./include/asm-sparc/hardirq.h:  for (i = 0; i < smp_num_cpus; i++)
./include/asm-alpha/smp.h:extern int smp_num_cpus;

** DONE 3-21-04

 ## Georg's blasphemy
From: Georg Chini <georg.chini@triaton-webhosting.com>

I can use mingetty ttyX in inittab and it works
with prom console on the serial port.
Switching between different virtual terminals
is possible.

I have a ultra1 with a vt100 emulator connected
to ttyS0, no keyboard, no monitor.
/proc/cmdline = root=/dev/sda1 ro
                                                                                
Without my additional patch:
mingetty ttyX in inittab gives a login prompt
but keyboard input from vt100 will be ignored
because ttyS0 is never explicitly opened.
                                                                                
With patch:
mingetty ttyX in inittab gives a login prompt
and keyboard input from vt100 works because the
input is sent to the current active tty.

When the system starts up all output is redirected
to ttyS0, so my idea was to accept input from there
as well, assuming there must be some kind of terminal
connected.

-- This has to be either fixed up, or made to output a warning
a-la the infamous "Inconsistent Console".

** I think this is BS, no recent reports. ?

 ## init_thread_union is not aligned.
-- Something is broken in the build.
-- Find and change comments
   -- near __ALIGN in head.S
   -- etrap.S <--- only user process

-- This is fairly severe; gcc 3.3 breaks it even worse.  Maybe use __attribute__
instead of just hoping it'll get aligned right?  Section is wrong too.

** DONE

 ##
Pedro Ramalhais <ramalhais@serrado.net>

> In 2.6.x enabling CONFIG_KALLSYMS is a much easier way
> to accomplish this :)

David, CONFIG_KALLSYMS is already enabled in my .config . How can i do
that "correlation" thing?

-- implement the stupid calls already, dammit. 5 minute job!

** Done.



-- 
Keith M Wesolowski
