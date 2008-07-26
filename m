From: Roland McGrath <roland@redhat.com>
Date: Sat, 26 Jul 2008 22:12:21 +0000
Subject: sparc64 tracehook
Message-Id: <20080726221221.DCF88154280@magilla.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi!  I said I was leaving it to you now, but here is this anyway.  This
differs from what I posted before only in a couple of decls in syscall.h
that were incompatible with gcc-3.x.  It forks from the upstream-merged
tracehook now, so you can git-pull it directly if you like.

The following changes since commit a048d3aff8b828b6c0fa7ddd90a531248ab4e0f9:
  Linus Torvalds (1):
        Merge branch 'tracing-fixes-for-linus' of git://git.kernel.org/.../tip/linux-2.6-tip

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/frob/linux-2.6-utrace.git sparc64-tracehook

Roland McGrath (5):
      sparc64: tracehook syscall
      sparc64: tracehook: asm/syscall.h
      sparc64: tracehook: TIF_NOTIFY_RESUME
      sparc64: tracehook_signal_handler
      sparc64: tracehook: CONFIG_HAVE_ARCH_TRACEHOOK

 arch/sparc64/Kconfig               |    1 +
 arch/sparc64/kernel/ptrace.c       |   24 +++--------
 arch/sparc64/kernel/rtrap.S        |    6 +-
 arch/sparc64/kernel/signal.c       |    7 +++
 arch/sparc64/kernel/signal32.c     |    2 +
 include/asm-sparc/ptrace_32.h      |    1 +
 include/asm-sparc/ptrace_64.h      |    1 +
 include/asm-sparc/syscall.h        |   79 ++++++++++++++++++++++++++++++++++++
 include/asm-sparc/thread_info_64.h |    8 ++-
 include/asm-sparc64/syscall.h      |    1 +
 10 files changed, 106 insertions(+), 24 deletions(-)
 create mode 100644 include/asm-sparc/syscall.h
 create mode 100644 include/asm-sparc64/syscall.h


Thanks,
Roland
