From: David Miller <davem@davemloft.net>
Date: Sun, 11 May 2008 09:28:19 +0000
Subject: [GIT]: Sparc
Message-Id: <20080511.022819.13047794.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Bug fixes for sparc:

1) sparc32 referencing PT_DTRACE which it has no reason to

2) ptrace() detach broken, because the wrong value is being
   used by userspace headers, fix by translating if we see
   the value userland actually uses.   That value doesn't
   conflict with other ptrace() request numbers we care about
   so this is OK.

3) Provide a state akin to ->orig_eax on x86 that allows the debugger
   to control syscall restart properly.

   This, along with the matching gdb patch, kills about 40 or so gdb
   testsuite failures on 32-bit and 64-bit sparc.

   As a result M68K is now the only user of ptrace_signal_deliver(),
   it's broken the same exact way sparc was, and thus needs similar
   fixes.

4) Tidy Sparc video driver open-firmware interface usage, from Robert
   Reif.

Please pull, thanks a lot!

The following changes since commit dc5dc7e6d71ca9fd1ea01a1418150af3b2937489:
  David S. Miller (1):
        sparc: Fix SA_ONSTACK signal handling.

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (3):
      sparc32: Don't twiddle PT_DTRACE in exec.
      sparc: Fix ptrace() detach.
      sparc: Fix debugger syscall restart interactions.

Robert Reif (1):
      sparc video: remove open boot prom code

 arch/sparc/kernel/entry.S       |    2 +
 arch/sparc/kernel/process.c     |    5 ---
 arch/sparc/kernel/ptrace.c      |    6 ++-
 arch/sparc/kernel/rtrap.S       |   11 +++++--
 arch/sparc/kernel/signal.c      |   64 +++++++++++++++++----------------------
 arch/sparc64/kernel/etrap.S     |    7 ++--
 arch/sparc64/kernel/ptrace.c    |   16 +++++++---
 arch/sparc64/kernel/rtrap.S     |    1 +
 arch/sparc64/kernel/signal.c    |   60 +++++++++++++-----------------------
 arch/sparc64/kernel/signal32.c  |   26 ++++++++++-----
 drivers/video/bw2.c             |    6 +--
 drivers/video/cg14.c            |    5 +--
 drivers/video/cg3.c             |    6 +--
 drivers/video/cg6.c             |    4 +-
 drivers/video/ffb.c             |    5 +--
 drivers/video/leo.c             |    5 +--
 drivers/video/p9100.c           |    5 +--
 drivers/video/sbuslib.c         |    9 +++--
 drivers/video/sbuslib.h         |    5 ++-
 drivers/video/sunxvr2500.c      |    3 +-
 drivers/video/sunxvr500.c       |    3 +-
 drivers/video/tcx.c             |    5 +--
 include/asm-sparc/psr.h         |    1 +
 include/asm-sparc/ptrace.h      |   11 +++++++
 include/asm-sparc/signal.h      |    8 +----
 include/asm-sparc64/psrcompat.h |    2 +
 include/asm-sparc64/pstate.h    |    1 +
 include/asm-sparc64/ptrace.h    |   11 +++----
 include/asm-sparc64/signal.h    |    8 +----
 include/asm-sparc64/ttable.h    |    7 ++--
 30 files changed, 149 insertions(+), 159 deletions(-)
