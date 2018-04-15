From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 15 Apr 2018 15:56:21 +0000
Subject: [RFC PATCH 0/3] Dealing with the aliases of SI_USER
Message-Id: <87604sa2fu.fsf_-_@xmission.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
        <20180412172051.GK16141@n2100.armlinux.org.uk>
        <CA+55aFwjZqd8J0=veki1g+quQg8amEG4NnMe-h7HFksn=F=x_Q@mail.gmail.com>
        <20180413094211.GN16141@n2100.armlinux.org.uk>
        <CA+55aFwoThxqUeAZSsMhf--ODyhGkmOENH5R6=4+CuaopFx9eA@mail.gmail.com>
        <20180413170827.GB16308@e103592.cambridge.arm.com>
        <20180413175407.GO16141@n2100.armlinux.org.uk>
        <CA+55aFyya6B9_aq8ZSrZT-S-BGbpbDgFvDff5z8upDirpcoiHA@mail.gmail.com>
        <20180413184522.GD16308@e103592.cambridge.arm.com>
        <CA+55aFwMUQbALx60b3JDrTcWVSBS7imS+zCYEMz8NOs=6rE6+A@mail.gmail.com>
        <20180415131206.GR16141@n2100.armlinux.org.uk>
In-Reply-To: <20180415131206.GR16141@n2100.armlinux.org.uk> (Russell King's
        message of "Sun, 15 Apr 2018 14:12:06 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dmitry V. Levin" <ldv@altlinux.org>, sparclinux <sparclinux@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, linux-arch@vger.kernel.org


Linus,

Would you consider the patchset below for -rc2?

Dealing with the aliases of SI_USER has been a challenge as we have had
a b0rked ABI in some cases since 2.5.

So far no one except myself has suggested that changing the si_code of
from 0 to something else for those problematic aliases of SI_USER is
going to be a problem.  So it looks like just fixing the issue is a real
possibility.

Fixing the cases that do kill(SIGFPE, ...) because at least test cases
care seems important.

The best fixes to backport appear to be the real architecture fixes that
remove the aliases for SI_USER as those are deep fixes that
fundamentally fix the problems, and are also very small changes.

I am not yet brave enough to merge architectural fixes like that without
arch maintainers buy-in.   Getting at least an ack if nothing else takes
a little bit of time.

Still we have a arm fix upthread and David Miller has given his nod
to a sparc fix that uses FPE_FLTUNK.  So it appears real architecture
fixes are progressing.  Further I have looked and that leaves only
powerpc, parisc, ia64, and alpha.   The new si_code FPE_FLTUNK appears
to address most of those, and there is an untested patch for parisc.

So real progress appears possible.

The generic code can do better, and that is what this rfc patchset is
about.  It ensures siginfo is fully initialized and uses copy_to_user
to copy siginfo to userspace.  This takes siginfo_layout out of
the picture and so for non-compat non-signalfd siginfos the status
quo returns to what it was before I introduced siginfo_layout (AKA
regressions go bye-bye).

I believe given the issues these changes are a candiate for -rc2.
Otherwise I will keep these changes for the next merge window.

Eric W. Biederman (3):
      signal: Ensure every siginfo we send has all bits initialized
      signal: Reduce copy_siginfo_to_user to just copy_to_user
      signal: Stop special casing TRAP_FIXME and FPE_FIXME in siginfo_layout

 arch/alpha/kernel/osf_sys.c               |  1 +
 arch/alpha/kernel/signal.c                |  2 +
 arch/alpha/kernel/traps.c                 |  5 ++
 arch/alpha/mm/fault.c                     |  2 +
 arch/arc/mm/fault.c                       |  2 +
 arch/arm/kernel/ptrace.c                  |  1 +
 arch/arm/kernel/swp_emulate.c             |  1 +
 arch/arm/kernel/traps.c                   |  5 ++
 arch/arm/mm/alignment.c                   |  1 +
 arch/arm/mm/fault.c                       |  5 ++
 arch/arm/vfp/vfpmodule.c                  |  3 +-
 arch/arm64/kernel/fpsimd.c                |  2 +-
 arch/arm64/kernel/sys_compat.c            |  1 +
 arch/arm64/kernel/traps.c                 |  1 +
 arch/arm64/mm/fault.c                     | 18 ++++--
 arch/c6x/kernel/traps.c                   |  1 +
 arch/hexagon/kernel/traps.c               |  1 +
 arch/hexagon/mm/vm_fault.c                |  1 +
 arch/ia64/kernel/brl_emu.c                |  1 +
 arch/ia64/kernel/signal.c                 |  2 +
 arch/ia64/kernel/traps.c                  | 27 ++++++++-
 arch/ia64/kernel/unaligned.c              |  1 +
 arch/ia64/mm/fault.c                      |  4 +-
 arch/m68k/kernel/traps.c                  |  2 +
 arch/microblaze/kernel/exceptions.c       |  1 +
 arch/microblaze/mm/fault.c                |  4 +-
 arch/mips/mm/fault.c                      |  1 +
 arch/nds32/kernel/traps.c                 |  6 +-
 arch/nds32/mm/fault.c                     |  1 +
 arch/nios2/kernel/traps.c                 |  1 +
 arch/openrisc/kernel/traps.c              |  5 +-
 arch/openrisc/mm/fault.c                  |  1 +
 arch/parisc/kernel/ptrace.c               |  1 +
 arch/parisc/kernel/traps.c                |  2 +
 arch/parisc/kernel/unaligned.c            |  1 +
 arch/parisc/math-emu/driver.c             |  1 +
 arch/parisc/mm/fault.c                    |  1 +
 arch/powerpc/kernel/process.c             |  1 +
 arch/powerpc/kernel/traps.c               |  3 +-
 arch/powerpc/mm/fault.c                   |  1 +
 arch/powerpc/platforms/cell/spufs/fault.c |  2 +-
 arch/riscv/kernel/traps.c                 |  1 +
 arch/s390/kernel/traps.c                  |  5 +-
 arch/s390/mm/fault.c                      |  2 +
 arch/sh/kernel/hw_breakpoint.c            |  1 +
 arch/sh/kernel/traps_32.c                 |  2 +
 arch/sh/math-emu/math.c                   |  1 +
 arch/sh/mm/fault.c                        |  1 +
 arch/sparc/kernel/process_64.c            |  1 +
 arch/sparc/kernel/sys_sparc_32.c          |  1 +
 arch/sparc/kernel/traps_32.c              | 10 ++++
 arch/sparc/kernel/traps_64.c              | 14 +++++
 arch/sparc/kernel/unaligned_32.c          |  1 +
 arch/sparc/mm/fault_32.c                  |  1 +
 arch/sparc/mm/fault_64.c                  |  1 +
 arch/um/kernel/trap.c                     |  2 +
 arch/unicore32/kernel/fpu-ucf64.c         |  2 +-
 arch/unicore32/mm/fault.c                 |  3 +
 arch/x86/entry/vsyscall/vsyscall_64.c     |  2 +-
 arch/x86/kernel/ptrace.c                  |  2 +-
 arch/x86/kernel/traps.c                   |  3 +
 arch/x86/kernel/umip.c                    |  1 +
 arch/x86/kvm/mmu.c                        |  1 +
 arch/x86/mm/fault.c                       |  1 +
 arch/xtensa/kernel/traps.c                |  1 +
 arch/xtensa/mm/fault.c                    |  1 +
 include/linux/ptrace.h                    |  1 -
 include/linux/tracehook.h                 |  1 +
 kernel/signal.c                           | 93 +------------------------------
 virt/kvm/arm/mmu.c                        |  1 +
 70 files changed, 165 insertions(+), 115 deletions(-)

Eric
