From: David Miller <davem@davemloft.net>
Date: Thu, 24 Dec 2015 17:16:07 +0000
Subject: [GIT] Sparc
Message-Id: <20151224.121607.687935147425469983.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get the following sparc bug fixes:

1) Finally make perf stack backtraces stable on sparc, several
   problems (mostly due to the context in which the user copies
   from the stack are done) contributed to this.

   From Rob Gardner.

2) Export ADI capability if the cpu supports it.

3) Hook up userfaultfd system call.

4) When faults happen during user copies we really have to
   clean up and restore the FPU state fully.   Also from
   Rob Gardner.

Please pull, thanks a lot!

The following changes since commit 73796d8bf27372e26c2b79881947304c14c2d353:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2015-12-17 14:05:22 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 079317a65d05ce52b69b7d47fe1fb419d40a4395:

  tty/serial: Skip 'NULL' char after console break when sysrq enabled (2015-12-24 12:13:37 -0500)

----------------------------------------------------------------
Aya Mahfouz (1):
      tty: serial: constify sunhv_ops structs

Khalid Aziz (1):
      sparc64: Add ADI capability to cpu capabilities

Mike Kravetz (1):
      sparc: Hook up userfaultfd system call

Rob Gardner (4):
      sparc64: Don't set %pil in rtrap_nmi too early
      sparc64: Ensure perf can access user stacks
      sparc64: Perf should save/restore fault info
      sparc64: fix FP corruption in user copy functions

Vijay Kumar (1):
      tty/serial: Skip 'NULL' char after console break when sysrq enabled

 arch/sparc/include/asm/elf_64.h      |   1 +
 arch/sparc/include/uapi/asm/unistd.h |   3 ++-
 arch/sparc/kernel/head_64.S          |  13 ++++++++++++
 arch/sparc/kernel/perf_event.c       |  11 ++++++++++
 arch/sparc/kernel/rtrap_64.S         |   8 ++++++-
 arch/sparc/kernel/setup_64.c         |   9 ++++----
 arch/sparc/kernel/systbls_32.S       |   2 +-
 arch/sparc/kernel/systbls_64.S       |   4 ++--
 arch/sparc/lib/NG2copy_from_user.S   |   8 +++++++
 arch/sparc/lib/NG2copy_to_user.S     |   8 +++++++
 arch/sparc/lib/NG2memcpy.S           | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------
 arch/sparc/lib/NG4copy_from_user.S   |   8 +++++++
 arch/sparc/lib/NG4copy_to_user.S     |   8 +++++++
 arch/sparc/lib/NG4memcpy.S           |  40 ++++++++++++++++++++---------------
 arch/sparc/lib/U1copy_from_user.S    |   8 +++++++
 arch/sparc/lib/U1copy_to_user.S      |   8 +++++++
 arch/sparc/lib/U1memcpy.S            |  48 ++++++++++++++++++++++++------------------
 arch/sparc/lib/U3copy_from_user.S    |   8 +++++++
 arch/sparc/lib/U3copy_to_user.S      |   8 +++++++
 arch/sparc/lib/U3memcpy.S            |  86 +++++++++++++++++++++++++++++++++++++++-----------------------------------
 drivers/tty/serial/sunhv.c           |  12 ++++++-----
 21 files changed, 271 insertions(+), 148 deletions(-)
