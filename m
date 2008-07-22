From: Roland McGrath <roland@redhat.com>
Date: Tue, 22 Jul 2008 04:44:58 +0000
Subject: sparc tracehook
Message-Id: <20080722044458.82E251541A5@magilla.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi!  I did a fresh rebase of the sparc64 tracehook patches, added another
one, and fiddled a little.  I'd like to hand off worrying about the
patches, fixing them and eventually merging them to you now.

The patch adding asm/syscall.h doesn't depend on anything else.
So you could put that in your arch tree whenever you like.

The others have to come after the tracehook series not yet merged.

Except for one caveat, I think these are probably right, but I leave it to
you to decide and fix up sparc64.

The one caveat you'll notice when you compile and see the must_check
warning for calling tracehook_report_syscall_entry.  This is a recent new
arch requirement.  It needs to make the syscall not happen, ideally without
changing the user-visible (user_regset) bits that indicate what the
incoming syscall number is.  It looks like this requires assembly changes.
It should jump around the call, but go into exit tracing normally.

BTW, I've found in other arch code that it's nicer to have separate entry
and exit tracing calls from the assembly, because there really is no
overlap between the paths left.


The following changes since commit 8a7f9d74b22ba929ca70e71943dc15f030018710:
  Roland McGrath (1):
        /proc/PID/syscall

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
