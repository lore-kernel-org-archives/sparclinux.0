From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 29 Dec 2008 23:56:37 +0000
Subject: Unification continued
Message-Id: <20081229235637.GA19210@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Dave.

This is the set of outstanding patches that is ready but not
yet applied to sparc-next.
You can ignore all older patches from me as they are included here.

Note: the long long patchset is not ready yet - so it is not included.

There is a few trivial cleanup patches - the rest is the
continued unification.
Focus right now is on headers exported to user space.

There is only three exported headers in need for unification now:
siginfo.h, openprom.h and reg.h

Looking at the ptrace bits it looks like there is a
possibility to reuse the native sparc32 implmentation for the
compat implementation in sparc64..
But I did not pursue that and mention it mainly so
you can say if this may not fly.

Most of the unification is trivial/mechanical
and is build tested at least with defconfig
for sparc32 and sparc64 on my box.
Please review before applying (as usual).

	Sam


Sam Ravnborg (11):
      sparc: delete unused config symbols
      sparc: unify ipcbuf.h
      sparc: unify posix_types.h
      sparc32: drop __old_kernel_stat
      sparc32: use proper types in struct stat
      sparc: unify stat.h
      sparc64: prepare signal_64 for unification
      sparc: unify signal.h
      sparc: add '32' suffix to reg_window, sigcontext, __siginfo_t
      sparc: unify sigcontext.h
      sparc: unify ptrace.h

 arch/sparc/Kconfig                                 |   28 ---
 arch/sparc/include/asm/Kbuild                      |   12 --
 arch/sparc/include/asm/{ipcbuf_64.h => ipcbuf.h}   |   10 +-
 arch/sparc/include/asm/ipcbuf_32.h                 |   31 ---
 .../asm/{posix_types_64.h => posix_types.h}        |   47 ++++-
 arch/sparc/include/asm/posix_types_32.h            |  118 -----------
 arch/sparc/include/asm/processor_32.h              |    2 +-
 arch/sparc/include/asm/{ptrace_64.h => ptrace.h}   |  138 +++++++++++---
 arch/sparc/include/asm/ptrace_32.h                 |  186 ------------------
 .../include/asm/{sigcontext_64.h => sigcontext.h}  |   31 ++-
 arch/sparc/include/asm/sigcontext_32.h             |   62 ------
 arch/sparc/include/asm/{signal_64.h => signal.h}   |   40 +++--
 arch/sparc/include/asm/signal_32.h                 |  207 --------------------
 arch/sparc/include/asm/stat.h                      |  115 ++++++++++-
 arch/sparc/include/asm/stat_32.h                   |   76 -------
 arch/sparc/include/asm/stat_64.h                   |   47 -----
 arch/sparc/include/asm/thread_info_32.h            |    2 +-
 arch/sparc/kernel/kgdb_32.c                        |   12 +-
 arch/sparc/kernel/muldiv.c                         |    8 +-
 arch/sparc/kernel/process_32.c                     |   16 +-
 arch/sparc/kernel/signal_32.c                      |    6 +-
 arch/sparc/kernel/traps_32.c                       |    4 +-
 arch/sparc/kernel/unaligned_32.c                   |   12 +-
 arch/sparc/kernel/windows.c                        |    6 +-
 24 files changed, 350 insertions(+), 866 deletions(-)
