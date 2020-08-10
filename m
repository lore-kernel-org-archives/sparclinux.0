From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 10 Aug 2020 09:23:48 +0000
Subject: Re: [sparc64] enabling CONFIG_PROVE_LOCKING makes kernel unable to build
Message-Id: <CADxRZqy+PcHrMu1a6VZp_SNEybVUax88eqO09Sbq7v3yjivVKw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqybxFr5reVmYM2_h+KUzqL3PU5Qo9nrZSieQPYq+gWWCg@mail.gmail.com>
 <20200804133438.GK2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200804133438.GK2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sparc kernel list <sparclinux@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>

On Tue, Aug 4, 2020 at 4:34 PM <peterz@infradead.org> wrote:
>
> On Tue, Aug 04, 2020 at 04:17:16PM +0300, Anatoly Pugachev wrote:
> > Hello!
> >
> > Linus git master sources:
> >
> > $ git desc
> > v5.8-2483-gc0842fbc1b18
> >
>
> Ooh, it looks like that series wasn't cut back far enough :/
>
> 859247d39fb0 ("seqlock: lockdep assert non-preemptibility on seqcount_t
> write") does indeed also introduce problems.
>
> I've been working on untangling the header mess for the full series and
> the below patch is what I currently have.
>
> ---
> Subject: seqlock,headers: Untangle the spaghetti monster
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu Jul 30 13:20:47 CEST 2020
>
> By using lockdep_assert_*() from seqlock.h, the spaghetti monster
> attacked.

Thanks Peter!

It doesn't apply cleanly over master git, but it least makes kernel
compilable / bootable on sparc64:

linux-2.6$ git desc
v5.8-11991-gfc80c51fd4b2

linux-2.6$ patch -p1 < ~/headers.patch
patching file arch/ia64/include/asm/smp.h
patching file arch/ia64/include/asm/xtp.h
patching file arch/ia64/kernel/iosapic.c
patching file arch/ia64/kernel/irq.c
patching file arch/ia64/kernel/process.c
Hunk #1 succeeded at 47 (offset -1 lines).
patching file arch/ia64/kernel/sal.c
patching file arch/ia64/kernel/setup.c
patching file arch/ia64/kernel/smp.c
Hunk #1 succeeded at 45 (offset -1 lines).
patching file arch/parisc/include/asm/timex.h
patching file arch/sh/include/asm/io.h
patching file arch/sh/kernel/machvec.c
patching file arch/sparc/include/asm/timer_64.h
patching file arch/sparc/include/asm/vvar.h
patching file arch/sparc/kernel/vdso.c
patching file arch/x86/include/asm/fixmap.h
patching file arch/x86/kernel/apic/apic_noop.c
patching file arch/x86/kernel/apic/hw_nmi.c
patching file arch/x86/kernel/apic/probe_64.c
patching file arch/x86/kernel/cpu/amd.c
patching file arch/x86/kernel/cpu/common.c
patching file arch/x86/kernel/cpu/hygon.c
patching file arch/x86/kernel/cpu/intel.c
patching file arch/x86/kernel/jailhouse.c
patching file arch/x86/kernel/tsc_msr.c
patching file arch/x86/mm/init_32.c
patching file arch/x86/xen/apic.c
patching file arch/x86/xen/smp_hvm.c
patching file arch/x86/xen/suspend_pv.c
patching file include/linux/dynamic_queue_limits.h
patching file include/linux/hrtimer.h
patching file include/linux/ktime.h
patching file include/linux/lockdep.h
patching file include/linux/mutex.h
patching file include/linux/sched.h
patching file include/linux/seqlock.h
Hunk #1 FAILED at 19.
1 out of 1 hunk FAILED -- saving rejects to file include/linux/seqlock.h.rej
patching file include/linux/time.h
patching file include/linux/videodev2.h
patching file include/linux/ww_mutex.h
mator@ttip:~/linux-2.6$ make -j arch/sparc
  UPD     include/config/kernel.release
  UPD     include/generated/utsrelease.h
  CALL    scripts/atomic/check-atomics.sh
  CC      arch/sparc/kernel/asm-offsets.s
  CALL    scripts/checksyscalls.sh
<stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
  CC      arch/sparc/math-emu/math_64.o
  CC      arch/sparc/net/bpf_jit_comp_64.o
  CC      arch/sparc/mm/tlb.o
  CC      arch/sparc/mm/tsb.o
  CC      arch/sparc/vdso/vclock_gettime.o
  CC      arch/sparc/mm/fault_64.o
  CC      arch/sparc/mm/init_64.o
  CC      arch/sparc/mm/hugetlbpage.o
  CC      arch/sparc/vdso/vma.o
  CC      arch/sparc/vdso/vdso32/vclock_gettime.o
  CC      arch/sparc/crypto/aes_glue.o
  CC      arch/sparc/crypto/des_glue.o
  CC      arch/sparc/crypto/camellia_glue.o
  CC [M]  arch/sparc/crypto/sha1_glue.o
  CC [M]  arch/sparc/crypto/sha256_glue.o
  CC [M]  arch/sparc/crypto/sha512_glue.o
  CC [M]  arch/sparc/crypto/md5_glue.o
  CC [M]  arch/sparc/crypto/crc32c_glue.o
  VDSO    arch/sparc/vdso/vdso64.so.dbg
  CC      arch/sparc/kernel/traps_64.o
  CC      arch/sparc/kernel/irq_64.o
  CC      arch/sparc/kernel/process_64.o
  CC      arch/sparc/kernel/process.o
  CC      arch/sparc/kernel/signal_64.o
  CC      arch/sparc/kernel/sigutil_64.o
  OBJCOPY arch/sparc/vdso/vdso64.so
  CC      arch/sparc/kernel/setup_64.o
  CC      arch/sparc/kernel/idprom.o
  CC      arch/sparc/kernel/sys_sparc_64.o
  VDSO2C  arch/sparc/vdso/vdso-image-64.c
  CC      arch/sparc/kernel/time_64.o
  CC      arch/sparc/kernel/cpu.o
  CC      arch/sparc/kernel/vdso.o
  CC      arch/sparc/vdso/vdso-image-64.o
  CC      arch/sparc/kernel/ptrace_64.o
  CC      arch/sparc/kernel/unaligned_64.o
  CC      arch/sparc/kernel/prom_common.o
  CC      arch/sparc/kernel/prom_64.o
  CC      arch/sparc/kernel/of_device_common.o
  CC      arch/sparc/kernel/of_device_64.o
  CC      arch/sparc/kernel/prom_irqtrans.o
  CC      arch/sparc/kernel/reboot.o
  CC      arch/sparc/kernel/sysfs.o
  CC      arch/sparc/kernel/iommu.o
  CC      arch/sparc/kernel/iommu-common.o
  CC      arch/sparc/kernel/central.o
  CC      arch/sparc/kernel/starfire.o
  CC      arch/sparc/kernel/power.o
  CC      arch/sparc/kernel/sbus.o
  CC      arch/sparc/kernel/ebus.o
  CC      arch/sparc/kernel/visemul.o
  CC      arch/sparc/kernel/hvapi.o
  CC      arch/sparc/kernel/sstate.o
  CC      arch/sparc/kernel/mdesc.o
  CC      arch/sparc/kernel/adi_64.o
  CC      arch/sparc/kernel/pcr.o
  VDSO    arch/sparc/vdso/vdso32.so.dbg
  CC      arch/sparc/kernel/nmi.o
  CC      arch/sparc/kernel/cpumap.o
  CC      arch/sparc/kernel/smp_64.o
  CC      arch/sparc/kernel/auxio_64.o
  CC      arch/sparc/kernel/module.o
  OBJCOPY arch/sparc/vdso/vdso32.so
  CC      arch/sparc/kernel/kgdb_64.o
  CC      arch/sparc/kernel/ftrace.o
  VDSO2C  arch/sparc/vdso/vdso-image-32.c
  CC      arch/sparc/kernel/btext.o
  CC      arch/sparc/kernel/stacktrace.o
  CC      arch/sparc/vdso/vdso-image-32.o
  CC      arch/sparc/kernel/sys_sparc32.o
  CC      arch/sparc/kernel/signal32.o
  CC      arch/sparc/kernel/kprobes.o
  CC      arch/sparc/kernel/ldc.o
  CC      arch/sparc/kernel/vio.o
  CC      arch/sparc/kernel/viohs.o
  CC      arch/sparc/kernel/ds.o
  CC      arch/sparc/kernel/audit.o
  CC      arch/sparc/kernel/compat_audit.o
  CC      arch/sparc/kernel/perf_event.o
  CC      arch/sparc/kernel/jump_label.o
  CC [M]  arch/sparc/kernel/chmc.o
  AR      arch/sparc/vdso/built-in.a
  LD [M]  arch/sparc/crypto/sha1-sparc64.o
  LD [M]  arch/sparc/crypto/md5-sparc64.o
  LD [M]  arch/sparc/crypto/sha256-sparc64.o
  LD [M]  arch/sparc/crypto/crc32c-sparc64.o
  LD [M]  arch/sparc/crypto/sha512-sparc64.o
  AR      arch/sparc/crypto/built-in.a
  AR      arch/sparc/net/built-in.a
  AR      arch/sparc/kernel/built-in.a
  AR      arch/sparc/mm/built-in.a
  AR      arch/sparc/math-emu/built-in.a
  AR      arch/sparc/built-in.a

...
$ reboot
...
$ uname -a
Linux ttip 5.8.0-11991-gfc80c51fd4b2-dirty #23 SMP Mon Aug 10 12:17:12
MSK 2020 sparc64 GNU/Linux
