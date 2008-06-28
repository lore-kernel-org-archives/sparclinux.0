From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 28 Jun 2008 22:02:35 +0000
Subject: [GIT PULL] unify sparc header files
Message-Id: <20080628220235.GA3169@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David.

I have now redone the sparc header unification and in the end I
decided to unify them all so we have only one set of header files
for sparc and sparc64.

The unification is 25 commits on top of:
20c51e668d2443385c1ac0e2b38b70d064a61d21 ("sparc64 Kbuild: apb.h
and bbc.h should not be exported to userspace")
[This drops one commit from Adrian - see below]

I have redone the changelogs to comply with traditional patch
so it does no longer confuse patch (thanks to Andrew).

The patchset basically does the following:
- Copy all sparc64 only files to asm-sparc
- When sparc and sparc64 files were equal use on the sparc version
- Unify a number of almost equal files
- The remaining files were changed so we have a <file>_32.h and <file>_64.h
   for sparc and sparc64. The <file>.h file include the correct version
   depending on the actual target.
- Drop exporting all sparc files to userspace to avoid breaking
  make headers_check. To be reintroduced later (see below)

This was all initiated to kill the use of ALTARCH and in the end I decided
to go the long way to really fix it.
So what I have prepared now if a full unification of the
sparc{,64} header files and the next step is to move them all
to arch/sparc/include/asm

To do so we need proper kbuild support which is present in kbuild-next.git
but not yet upstream.
So what I plan is that:

- You merge this set of commits in sparc-next
- We merge sparc-next.git and kbuild-next.git in the upcoming merge window
  The merge order does not matter - no build breakage
- Move the header files to arch/sparc/include/asm with the necessary fixups
  (And delete the include/asm-saprc{,64} directories).
- Reenable the header export (update the Kbuild file)
I plan to do the latter two steps - and I have prepared a patch already.

We will end up with:
- Unified header files for sparc and sparc64 in a single directory
- Working headers_export for sparc amd sparc64
- The first architecture to utilize the arch/$ARCH/include support in kbuild

When we are this far we should aim at unifying the obvious header file
candidates and Adrian's old patches is a first step here (but they
need to be adjusted a little).

The shortlog:

 sparc: copy exported sparc64 specific header files to asm-sparc
 sparc: Merge asm-sparc{,64}/ioctl.h
 sparc: Merge asm-sparc{,64}/ioctls.h
 sparc: Merge asm-sparc{,64}/param.h
 sparc: Merge asm-sparc{,64}/poll.h
 sparc: Merge asm-sparc{,64}/socket.h
 sparc: Merge asm-sparc{,64}/sockios.h
 sparc: Merge asm-sparc{,64}/fcntl.h
 sparc: Merge asm-sparc{,64}/msgbuf.h
 sparc: Merge asm-sparc{,64}/sembuf.h
 sparc: Merge asm-sparc{,64}/shmbuf.h
 sparc: Merge asm-sparc{,64}/mman.h
 sparc: copy asm-sparc64/fbio.h to asm-sparc
 sparc: Merge asm-sparc{,64}/fbio.h
 sparc: Merge asm-sparc{,64}/resource.h
 sparc: Merge asm-sparc{,64}/setup.h
 sparc: Merge asm-sparc{,64}/termbits.h
 sparc: Merge asm-sparc{,64}/termios.h
 sparc: Merge asm-sparc{,64}/types.h
 sparc: export openprom.h to userspace
 sparc: Merge asm-sparc{,64}/asi.h
 sparc: copy sparc64 specific files to asm-sparc
 sparc: when header files are equal use asm-sparc version
 sparc: merge header files with trivial differences
 sparc: join the remaining header files

The set could hae been done in much smaller steps but I could not
see any benefit of it as they are all simple. The ones that
actually changes something are small anyway.

I have tested that sparc and sparc64 defconfig builds after each
individual patch including a headers_check run.

The patches can be pulled here:

   ssh://master.kernel.org/pub/scm/linux/kernel/git/sam/sparc.git master

Note that the commit: 878e7a6e498bec55f10a163197c41554fb078416
("sparc: remove CONFIG_SUN4") is not included.
I did not include it as this was independent of my work
and I did not like to Sign-off something I really had not looked at.
So please apply this commit by other means.

Patches will follow.

	Sam

Diffstat:

Note:
406 files changed, 1986 insertions(+), 26505 deletions(-)
This is wrong - we do not end up with 26505 less lines.
Seems that git diff forget to add lines for copied files.


git diff --stat -C -M -B HEAD~25..HEAD

 arch/sparc/kernel/entry.S                          |    1 +
 arch/sparc64/kernel/sys_sparc.c                    |    6 +-
 arch/sparc64/kernel/sys_sparc32.c                  |    4 +-
 include/asm-sparc/Kbuild                           |   15 +-
 include/{asm-sparc64 => asm-sparc}/agp.h           |    0 
 include/{asm-sparc64 => asm-sparc}/apb.h           |    0 
 include/asm-sparc/asi.h                            |  153 +-
 include/asm-sparc/atomic.h                         |  173 +--
 include/asm-sparc/{atomic.h => atomic_32.h}        |    0 
 .../atomic.h => asm-sparc/atomic_64.h}             |    0 
 include/asm-sparc/auxio.h                          |   97 +-
 include/asm-sparc/{auxio.h => auxio_32.h}          |    0 
 .../{asm-sparc64/auxio.h => asm-sparc/auxio_64.h}  |    0 
 include/{asm-sparc64 => asm-sparc}/backoff.h       |    0 
 include/{asm-sparc64 => asm-sparc}/bbc.h           |    0 
 include/asm-sparc/bitops.h                         |  119 +-
 include/asm-sparc/{bitops.h => bitops_32.h}        |    0 
 .../bitops.h => asm-sparc/bitops_64.h}             |    0 
 include/asm-sparc/cacheflush.h                     |   93 +-
 .../asm-sparc/{cacheflush.h => cacheflush_32.h}    |    0 
 .../cacheflush.h => asm-sparc/cacheflush_64.h}     |    0 
 include/{asm-sparc64 => asm-sparc}/chafsr.h        |    0 
 include/asm-sparc/checksum.h                       |  249 +--
 include/asm-sparc/{checksum.h => checksum_32.h}    |    0 
 .../checksum.h => asm-sparc/checksum_64.h}         |    0 
 include/{asm-sparc64 => asm-sparc}/chmctrl.h       |    0 
 include/{asm-sparc64 => asm-sparc}/cmt.h           |    0 
 include/{asm-sparc64 => asm-sparc}/compat.h        |    0 
 include/{asm-sparc64 => asm-sparc}/compat_signal.h |    0 
 include/asm-sparc/cpudata.h                        |   35 +-
 include/asm-sparc/{cpudata.h => cpudata_32.h}      |    0 
 .../cpudata.h => asm-sparc/cpudata_64.h}           |    0 
 include/{asm-sparc64 => asm-sparc}/dcr.h           |    0 
 include/{asm-sparc64 => asm-sparc}/dcu.h           |    0 
 include/asm-sparc/delay.h                          |   42 +-
 include/asm-sparc/{delay.h => delay_32.h}          |    0 
 include/asm-sparc/delay_64.h                       |   17 +
 include/{asm-sparc64 => asm-sparc}/display7seg.h   |    0 
 include/asm-sparc/dma-mapping.h                    |   17 +-
 include/asm-sparc/dma-mapping_32.h                 |   11 +
 .../dma-mapping.h => asm-sparc/dma-mapping_64.h}   |    0 
 include/asm-sparc/dma.h                            |  296 +--
 include/asm-sparc/{dma.h => dma_32.h}              |    0 
 include/{asm-sparc64/dma.h => asm-sparc/dma_64.h}  |    0 
 include/asm-sparc/ebus.h                           |  107 +-
 include/asm-sparc/{ebus.h => ebus_32.h}            |    0 
 .../{asm-sparc64/ebus.h => asm-sparc/ebus_64.h}    |    0 
 include/asm-sparc/elf.h                            |  153 +-
 include/asm-sparc/{elf.h => elf_32.h}              |    0 
 include/{asm-sparc64/elf.h => asm-sparc/elf_64.h}  |    0 
 include/{asm-sparc64 => asm-sparc}/envctrl.h       |    0 
 include/{asm-sparc64 => asm-sparc}/estate.h        |    0 
 include/asm-sparc/fbio.h                           |   37 +-
 include/asm-sparc/fcntl.h                          |    4 +
 include/{asm-sparc64 => asm-sparc}/fhc.h           |    0 
 include/asm-sparc/floppy.h                         |  396 +---
 include/asm-sparc/{floppy.h => floppy_32.h}        |    0 
 .../floppy.h => asm-sparc/floppy_64.h}             |    0 
 include/{asm-sparc64 => asm-sparc}/fpumacro.h      |    0 
 include/asm-sparc/futex.h                          |   12 +-
 include/asm-sparc/futex_32.h                       |    6 +
 .../{asm-sparc64/futex.h => asm-sparc/futex_64.h}  |    0 
 include/asm-sparc/hardirq.h                        |   31 +-
 include/asm-sparc/{hardirq.h => hardirq_32.h}      |    0 
 .../hardirq.h => asm-sparc/hardirq_64.h}           |    0 
 include/asm-sparc/head.h                           |  110 +-
 include/asm-sparc/{head.h => head_32.h}            |    0 
 .../{asm-sparc64/head.h => asm-sparc/head_64.h}    |    0 
 include/{asm-sparc64 => asm-sparc}/hugetlb.h       |    0 
 include/{asm-sparc64 => asm-sparc}/hvtramp.h       |    0 
 include/{asm-sparc64 => asm-sparc}/hypervisor.h    |    0 
 include/asm-sparc/ide.h                            |  103 +-
 include/asm-sparc/{ide.h => ide_32.h}              |    0 
 include/{asm-sparc64/ide.h => asm-sparc/ide_64.h}  |    0 
 include/asm-sparc/idprom.h                         |    2 +-
 include/{asm-sparc64 => asm-sparc}/intr_queue.h    |    0 
 include/asm-sparc/io.h                             |  333 +---
 include/asm-sparc/{io.h => io_32.h}                |    0 
 include/{asm-sparc64/io.h => asm-sparc/io_64.h}    |    0 
 include/asm-sparc/ioctls.h                         |    4 +-
 include/asm-sparc/iommu.h                          |  129 +-
 include/asm-sparc/{iommu.h => iommu_32.h}          |    0 
 .../{asm-sparc64/iommu.h => asm-sparc/iommu_64.h}  |    0 
 include/asm-sparc/ipcbuf.h                         |   39 +-
 include/asm-sparc/{ipcbuf.h => ipcbuf_32.h}        |    0 
 .../ipcbuf.h => asm-sparc/ipcbuf_64.h}             |    0 
 include/asm-sparc/irq.h                            |   21 +-
 include/asm-sparc/irq_32.h                         |   15 +
 include/{asm-sparc64/irq.h => asm-sparc/irq_64.h}  |    0 
 include/asm-sparc/irqflags.h                       |   47 +-
 include/asm-sparc/{irqflags.h => irqflags_32.h}    |    0 
 .../irqflags.h => asm-sparc/irqflags_64.h}         |    0 
 include/asm-sparc/kdebug.h                         |   81 +-
 include/asm-sparc/{kdebug.h => kdebug_32.h}        |    0 
 include/asm-sparc/kdebug_64.h                      |   19 +
 include/asm-sparc/kmap_types.h                     |    4 +
 include/{asm-sparc64 => asm-sparc}/kprobes.h       |    0 
 include/{asm-sparc64 => asm-sparc}/ldc.h           |    0 
 include/asm-sparc/lmb.h                            |   10 +
 include/{asm-sparc64 => asm-sparc}/lsu.h           |    0 
 include/asm-sparc/mc146818rtc.h                    |   37 +-
 .../asm-sparc/{mc146818rtc.h => mc146818rtc_32.h}  |    0 
 .../mc146818rtc.h => asm-sparc/mc146818rtc_64.h}   |    0 
 include/{asm-sparc64 => asm-sparc}/mdesc.h         |    0 
 include/asm-sparc/mmu.h                            |   13 +-
 include/asm-sparc/mmu_32.h                         |    7 +
 include/{asm-sparc64/mmu.h => asm-sparc/mmu_64.h}  |    0 
 include/asm-sparc/mmu_context.h                    |   50 +-
 .../asm-sparc/{mmu_context.h => mmu_context_32.h}  |    0 
 .../mmu_context.h => asm-sparc/mmu_context_64.h}   |    0 
 include/{asm-sparc64 => asm-sparc}/mmzone.h        |    0 
 include/asm-sparc/module.h                         |   15 +-
 include/asm-sparc/module_32.h                      |    7 +
 include/asm-sparc/module_64.h                      |    7 +
 include/asm-sparc/mostek.h                         |  179 +--
 include/asm-sparc/{mostek.h => mostek_32.h}        |    0 
 .../mostek.h => asm-sparc/mostek_64.h}             |    0 
 include/asm-sparc/msgbuf.h                         |   23 +-
 include/asm-sparc/namei.h                          |   21 +-
 include/asm-sparc/namei_32.h                       |   13 +
 include/asm-sparc/namei_64.h                       |   13 +
 include/{asm-sparc64 => asm-sparc}/ns87303.h       |    0 
 include/asm-sparc/of_platform.h                    |   32 +-
 .../asm-sparc/{of_platform.h => of_platform_32.h}  |    0 
 .../of_platform.h => asm-sparc/of_platform_64.h}   |    0 
 include/asm-sparc/openprom.h                       |  265 +--
 include/asm-sparc/openprom_32.h                    |  255 ++
 .../openprom.h => asm-sparc/openprom_64.h}         |    0 
 include/asm-sparc/oplib.h                          |  280 +--
 include/asm-sparc/{oplib.h => oplib_32.h}          |    0 
 .../{asm-sparc64/oplib.h => asm-sparc/oplib_64.h}  |    0 
 include/asm-sparc/page.h                           |  171 +--
 include/asm-sparc/{page.h => page_32.h}            |    0 
 .../{asm-sparc64/page.h => asm-sparc/page_64.h}    |    0 
 include/{asm-sparc64 => asm-sparc}/parport.h       |    0 
 include/asm-sparc/pci.h                            |  178 +--
 include/asm-sparc/{pci.h => pci_32.h}              |    0 
 include/{asm-sparc64/pci.h => asm-sparc/pci_64.h}  |    0 
 include/asm-sparc/percpu.h                         |   14 +-
 include/asm-sparc/percpu_32.h                      |    6 +
 .../percpu.h => asm-sparc/percpu_64.h}             |    0 
 include/asm-sparc/pgalloc.h                        |   76 +-
 include/asm-sparc/{pgalloc.h => pgalloc_32.h}      |    0 
 .../pgalloc.h => asm-sparc/pgalloc_64.h}           |    0 
 include/asm-sparc/pgtable.h                        |  483 +----
 include/asm-sparc/pgtable_32.h                     |  480 ++++
 .../pgtable.h => asm-sparc/pgtable_64.h}           |    0 
 include/{asm-sparc64 => asm-sparc}/pil.h           |    0 
 include/asm-sparc/posix_types.h                    |  126 +-
 .../asm-sparc/{posix_types.h => posix_types_32.h}  |    0 
 .../posix_types.h => asm-sparc/posix_types_64.h}   |    0 
 include/asm-sparc/processor.h                      |  136 +-
 include/asm-sparc/{processor.h => processor_32.h}  |    0 
 .../processor.h => asm-sparc/processor_64.h}       |    0 
 include/{asm-sparc64 => asm-sparc}/psrcompat.h     |    0 
 include/{asm-sparc64 => asm-sparc}/pstate.h        |    0 
 include/asm-sparc/ptrace.h                         |  183 +--
 include/asm-sparc/{ptrace.h => ptrace_32.h}        |    0 
 .../ptrace.h => asm-sparc/ptrace_64.h}             |    0 
 include/asm-sparc/reboot.h                         |    6 +
 include/asm-sparc/reg.h                            |   87 +-
 include/asm-sparc/{reg.h => reg_32.h}              |    0 
 include/{asm-sparc64/reg.h => asm-sparc/reg_64.h}  |    0 
 include/asm-sparc/resource.h                       |    6 +-
 include/{asm-sparc64 => asm-sparc}/rwsem-const.h   |    0 
 include/{asm-sparc64 => asm-sparc}/rwsem.h         |    0 
 include/asm-sparc/sbus.h                           |  161 +-
 include/asm-sparc/{sbus.h => sbus_32.h}            |    0 
 .../{asm-sparc64/sbus.h => asm-sparc/sbus_64.h}    |    0 
 include/asm-sparc/scatterlist.h                    |   34 +-
 .../asm-sparc/{scatterlist.h => scatterlist_32.h}  |    0 
 .../scatterlist.h => asm-sparc/scatterlist_64.h}   |    0 
 include/{asm-sparc64 => asm-sparc}/scratchpad.h    |    0 
 include/{asm-sparc64 => asm-sparc}/seccomp.h       |    0 
 include/asm-sparc/sections.h                       |   12 +-
 include/asm-sparc/sections_32.h                    |    6 +
 include/asm-sparc/sections_64.h                    |    9 +
 include/asm-sparc/sembuf.h                         |   12 +-
 include/asm-sparc/setup.h                          |    6 +-
 include/{asm-sparc64 => asm-sparc}/sfafsr.h        |    0 
 include/asm-sparc/sfp-machine.h                    |  220 +--
 .../asm-sparc/{sfp-machine.h => sfp-machine_32.h}  |    0 
 .../sfp-machine.h => asm-sparc/sfp-machine_64.h}   |    0 
 include/asm-sparc/shmbuf.h                         |   14 +-
 include/asm-sparc/shmparam.h                       |   19 +-
 include/asm-sparc/shmparam_32.h                    |   11 +
 include/asm-sparc/shmparam_64.h                    |   10 +
 include/asm-sparc/sigcontext.h                     |   70 +-
 .../asm-sparc/{sigcontext.h => sigcontext_32.h}    |    0 
 .../sigcontext.h => asm-sparc/sigcontext_64.h}     |    0 
 include/asm-sparc/siginfo.h                        |   25 +-
 include/asm-sparc/siginfo_32.h                     |   17 +
 .../siginfo.h => asm-sparc/siginfo_64.h}           |    0 
 include/asm-sparc/signal.h                         |  215 +--
 include/asm-sparc/{signal.h => signal_32.h}        |    0 
 .../signal.h => asm-sparc/signal_64.h}             |    0 
 include/asm-sparc/smp.h                            |  181 +--
 include/asm-sparc/{smp.h => smp_32.h}              |    0 
 include/{asm-sparc64/smp.h => asm-sparc/smp_64.h}  |    0 
 include/asm-sparc/sparsemem.h                      |   12 +
 include/asm-sparc/spinlock.h                       |  200 +--
 include/asm-sparc/{spinlock.h => spinlock_32.h}    |    0 
 .../spinlock.h => asm-sparc/spinlock_64.h}         |    0 
 include/asm-sparc/spinlock_types.h                 |    2 +-
 include/{asm-sparc64 => asm-sparc}/spitfire.h      |    0 
 include/asm-sparc/sstate.h                         |   13 +
 include/asm-sparc/stacktrace.h                     |    6 +
 include/{asm-sparc64 => asm-sparc}/starfire.h      |    0 
 include/asm-sparc/stat.h                           |   84 +-
 include/asm-sparc/{stat.h => stat_32.h}            |    0 
 .../{asm-sparc64/stat.h => asm-sparc/stat_64.h}    |    0 
 include/asm-sparc/statfs.h                         |   12 +-
 include/asm-sparc/statfs_32.h                      |    6 +
 .../statfs.h => asm-sparc/statfs_64.h}             |    0 
 include/asm-sparc/string.h                         |  213 +--
 include/asm-sparc/{string.h => string_32.h}        |    0 
 .../string.h => asm-sparc/string_64.h}             |    0 
 include/asm-sparc/syscalls.h                       |   13 +
 include/asm-sparc/system.h                         |  296 +--
 include/asm-sparc/{system.h => system_32.h}        |    0 
 .../system.h => asm-sparc/system_64.h}             |    0 
 include/asm-sparc/termbits.h                       |    5 +
 include/asm-sparc/termios.h                        |   79 +-
 include/asm-sparc/thread_info.h                    |  159 +-
 .../asm-sparc/{thread_info.h => thread_info_32.h}  |    0 
 .../thread_info.h => asm-sparc/thread_info_64.h}   |    0 
 include/asm-sparc/timer.h                          |  115 +-
 include/asm-sparc/{timer.h => timer_32.h}          |    0 
 .../{asm-sparc64/timer.h => asm-sparc/timer_64.h}  |    0 
 include/asm-sparc/timex.h                          |   21 +-
 include/asm-sparc/timex_32.h                       |   15 +
 include/asm-sparc/timex_64.h                       |   19 +
 include/asm-sparc/tlb.h                            |   32 +-
 include/asm-sparc/{tlb.h => tlb_32.h}              |    0 
 include/{asm-sparc64/tlb.h => asm-sparc/tlb_64.h}  |    0 
 include/asm-sparc/tlbflush.h                       |   68 +-
 include/asm-sparc/{tlbflush.h => tlbflush_32.h}    |    0 
 .../tlbflush.h => asm-sparc/tlbflush_64.h}         |    0 
 include/asm-sparc/topology.h                       |   14 +-
 include/asm-sparc/topology_32.h                    |    6 +
 .../topology.h => asm-sparc/topology_64.h}         |    0 
 include/{asm-sparc64 => asm-sparc}/tsb.h           |    0 
 include/{asm-sparc64 => asm-sparc}/ttable.h        |    0 
 include/asm-sparc/types.h                          |   32 +-
 include/asm-sparc/uaccess.h                        |  344 +---
 include/asm-sparc/{uaccess.h => uaccess_32.h}      |    0 
 .../uaccess.h => asm-sparc/uaccess_64.h}           |    0 
 include/{asm-sparc64 => asm-sparc}/uctx.h          |    0 
 include/asm-sparc/unistd.h                         |  386 +---
 include/asm-sparc/{unistd.h => unistd_32.h}        |    0 
 .../unistd.h => asm-sparc/unistd_64.h}             |    0 
 include/{asm-sparc64 => asm-sparc}/upa.h           |    0 
 include/{asm-sparc64 => asm-sparc}/utrap.h         |    0 
 include/asm-sparc/vaddrs.h                         |    5 -
 include/{asm-sparc64 => asm-sparc}/vio.h           |    0 
 include/{asm-sparc64 => asm-sparc}/visasm.h        |    0 
 include/{asm-sparc64 => asm-sparc}/watchdog.h      |    0 
 include/asm-sparc/xor.h                            |  277 +--
 include/asm-sparc/{xor.h => xor_32.h}              |    0 
 include/{asm-sparc64/xor.h => asm-sparc/xor_64.h}  |    0 
 include/asm-sparc64/Kbuild                         |   22 +-
 include/asm-sparc64/agp.h                          |   21 +-
 include/asm-sparc64/apb.h                          |   37 +-
 include/asm-sparc64/asi.h                          |  161 +--
 include/asm-sparc64/atomic.h                       |  129 +-
 include/asm-sparc64/auxio.h                        |  101 +-
 include/asm-sparc64/backoff.h                      |   32 +-
 include/asm-sparc64/bbc.h                          |  226 +--
 include/asm-sparc64/bitops.h                       |  108 +-
 include/asm-sparc64/cacheflush.h                   |   77 +-
 include/asm-sparc64/chafsr.h                       |  242 +--
 include/asm-sparc64/checksum.h                     |  168 +--
 include/asm-sparc64/chmctrl.h                      |  184 +--
 include/asm-sparc64/cmt.h                          |   60 +-
 include/asm-sparc64/compat.h                       |  244 +--
 include/asm-sparc64/compat_signal.h                |   30 +-
 include/asm-sparc64/cpudata.h                      |  241 +--
 include/asm-sparc64/dcr.h                          |   15 +-
 include/asm-sparc64/dcu.h                          |   28 +-
 include/asm-sparc64/delay.h                        |   18 +-
 include/asm-sparc64/display7seg.h                  |   80 +-
 include/asm-sparc64/dma-mapping.h                  |  155 +-
 include/asm-sparc64/dma.h                          |  206 +--
 include/asm-sparc64/ebus.h                         |   95 +-
 include/asm-sparc64/elf.h                          |  218 +--
 include/asm-sparc64/envctrl.h                      |  104 +-
 include/asm-sparc64/estate.h                       |   50 +-
 include/asm-sparc64/fbio.h                         |  331 +---
 include/asm-sparc64/fcntl.h                        |   36 +-
 include/asm-sparc64/fhc.h                          |  122 +-
 include/asm-sparc64/floppy.h                       |  783 +------
 include/asm-sparc64/fpumacro.h                     |   34 +-
 include/asm-sparc64/futex.h                        |  111 +-
 include/asm-sparc64/hardirq.h                      |   20 +-
 include/asm-sparc64/head.h                         |   77 +-
 include/asm-sparc64/hugetlb.h                      |   85 +-
 include/asm-sparc64/hvtramp.h                      |   38 +-
 include/asm-sparc64/hw_irq.h                       |    5 +-
 include/asm-sparc64/hypervisor.h                   | 2946 +-------------------
 include/asm-sparc64/ide.h                          |  119 +-
 include/asm-sparc64/idprom.h                       |   26 +-
 include/asm-sparc64/intr_queue.h                   |   16 +-
 include/asm-sparc64/io.h                           |  512 +----
 include/asm-sparc64/ioctl.h                        |   68 +-
 include/asm-sparc64/ioctls.h                       |  137 +-
 include/asm-sparc64/iommu.h                        |   63 +-
 include/asm-sparc64/ipcbuf.h                       |   29 +-
 include/asm-sparc64/irq.h                          |   94 +-
 include/asm-sparc64/irq_regs.h                     |    2 +-
 include/asm-sparc64/irqflags.h                     |   90 +-
 include/asm-sparc64/kdebug.h                       |   20 +-
 include/asm-sparc64/kmap_types.h                   |   26 +-
 include/asm-sparc64/kprobes.h                      |   50 +-
 include/asm-sparc64/kvm.h                          |    7 +-
 include/asm-sparc64/ldc.h                          |  139 +-
 include/asm-sparc64/linkage.h                      |    7 +-
 include/asm-sparc64/lmb.h                          |   11 +-
 include/asm-sparc64/lsu.h                          |   20 +-
 include/asm-sparc64/mc146818rtc.h                  |   35 +-
 include/asm-sparc64/mdesc.h                        |   79 +-
 include/asm-sparc64/mman.h                         |   32 +-
 include/asm-sparc64/mmu.h                          |  128 +-
 include/asm-sparc64/mmu_context.h                  |  156 +-
 include/asm-sparc64/mmzone.h                       |   18 +-
 include/asm-sparc64/module.h                       |    8 +-
 include/asm-sparc64/mostek.h                       |  144 +-
 include/asm-sparc64/msgbuf.h                       |   28 +-
 include/asm-sparc64/mutex.h                        |   10 +-
 include/asm-sparc64/namei.h                        |   14 +-
 include/asm-sparc64/ns87303.h                      |  119 +-
 include/asm-sparc64/of_platform.h                  |   26 +-
 include/asm-sparc64/openprom.h                     |  281 +--
 include/asm-sparc64/oplib.h                        |  323 +---
 include/asm-sparc64/page.h                         |  143 +-
 include/asm-sparc64/param.h                        |   24 +-
 include/asm-sparc64/parport.h                      |  247 +--
 include/asm-sparc64/pci.h                          |  210 +--
 include/asm-sparc64/percpu.h                       |   29 +-
 include/asm-sparc64/pgalloc.h                      |   82 +-
 include/asm-sparc64/pgtable.h                      |  782 +------
 include/asm-sparc64/pil.h                          |   22 +-
 include/asm-sparc64/poll.h                         |   13 +-
 include/asm-sparc64/posix_types.h                  |  123 +-
 include/asm-sparc64/processor.h                    |  238 +--
 include/asm-sparc64/psrcompat.h                    |   46 +-
 include/asm-sparc64/pstate.h                       |   92 +-
 include/asm-sparc64/ptrace.h                       |  347 +---
 include/asm-sparc64/reboot.h                       |    7 +-
 include/asm-sparc64/reg.h                          |   57 +-
 include/asm-sparc64/resource.h                     |   20 +-
 include/asm-sparc64/rtc.h                          |   27 +-
 include/asm-sparc64/rwsem-const.h                  |   13 +-
 include/asm-sparc64/rwsem.h                        |   85 +-
 include/asm-sparc64/sbus.h                         |  191 +--
 include/asm-sparc64/scatterlist.h                  |   28 +-
 include/asm-sparc64/scratchpad.h                   |   15 +-
 include/asm-sparc64/seccomp.h                      |   22 +-
 include/asm-sparc64/sections.h                     |   10 +-
 include/asm-sparc64/semaphore.h                    |    2 +-
 include/asm-sparc64/sembuf.h                       |   23 +-
 include/asm-sparc64/setup.h                        |   11 +-
 include/asm-sparc64/sfafsr.h                       |   83 +-
 include/asm-sparc64/sfp-machine.h                  |   94 +-
 include/asm-sparc64/shmbuf.h                       |   39 +-
 include/asm-sparc64/shmparam.h                     |   11 +-
 include/asm-sparc64/sigcontext.h                   |   88 +-
 include/asm-sparc64/siginfo.h                      |   33 +-
 include/asm-sparc64/signal.h                       |  195 +--
 include/asm-sparc64/smp.h                          |   65 +-
 include/asm-sparc64/socket.h                       |   58 +-
 include/asm-sparc64/sockios.h                      |   15 +-
 include/asm-sparc64/sparsemem.h                    |   13 +-
 include/asm-sparc64/spinlock.h                     |  251 +--
 include/asm-sparc64/spinlock_types.h               |   21 +-
 include/asm-sparc64/spitfire.h                     |  343 +---
 include/asm-sparc64/sstate.h                       |   14 +-
 include/asm-sparc64/stacktrace.h                   |    7 +-
 include/asm-sparc64/starfire.h                     |   22 +-
 include/asm-sparc64/stat.h                         |   48 +-
 include/asm-sparc64/statfs.h                       |   55 +-
 include/asm-sparc64/string.h                       |   84 +-
 include/asm-sparc64/sunbpp.h                       |   81 +-
 include/asm-sparc64/syscalls.h                     |   14 +-
 include/asm-sparc64/system.h                       |  356 +---
 include/asm-sparc64/termbits.h                     |  261 +--
 include/asm-sparc64/termios.h                      |  187 +--
 include/asm-sparc64/thread_info.h                  |  278 +--
 include/asm-sparc64/timer.h                        |   31 +-
 include/asm-sparc64/timex.h                        |   20 +-
 include/asm-sparc64/tlb.h                          |  112 +-
 include/asm-sparc64/tlbflush.h                     |   45 +-
 include/asm-sparc64/topology.h                     |   87 +-
 include/asm-sparc64/tsb.h                          |  284 +--
 include/asm-sparc64/ttable.h                       |  659 +-----
 include/asm-sparc64/types.h                        |   35 +-
 include/asm-sparc64/uaccess.h                      |  274 +--
 include/asm-sparc64/uctx.h                         |   72 +-
 include/asm-sparc64/unaligned.h                    |   11 +-
 include/asm-sparc64/unistd.h                       |  374 +---
 include/asm-sparc64/upa.h                          |  110 +-
 include/asm-sparc64/utrap.h                        |   52 +-
 include/asm-sparc64/vga.h                          |   34 +-
 include/asm-sparc64/vio.h                          |  407 +---
 include/asm-sparc64/visasm.h                       |   63 +-
 include/asm-sparc64/watchdog.h                     |   32 +-
 include/asm-sparc64/xor.h                          |   71 +-
 406 files changed, 1986 insertions(+), 26505 deletions(-)

