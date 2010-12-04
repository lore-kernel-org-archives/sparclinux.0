From: Julian Calaby <julian.calaby@gmail.com>
Date: Sat, 04 Dec 2010 03:55:24 +0000
Subject: [RFC 0/8] prom/console cleanups
Message-Id: <4CF9BBAC.4070407@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Dave,

After having a good poke around in the patches you sent to address the PROM call regressions, I saw a few places where some files could be cleaned up and dropped.

These haven't even been compile tested as I currently lack the equipment - hence the RFC tags, however they're a few obvious changes and moving some code so they *should* be safe. ..... er scratch that. Test them, please?

Oh, and I hope this doesn't increase your workload any =)

Thanks,

Julian Calaby

Julian Calaby (8):
  sparc: prom: Sanitize return value from prom_nbputchar()
  sparc: prom: Use the return value from prom_nbputchar()
  sparc: prom: Use n instead of len to decrement buf
  sparc: prom: Remove unused definition of prom_stdin
  sparc: prom: Merge console_*.c into printf.c
  sparc: oplib: Remove prom_console_write_buf() definition
  sparc: prom: Make prom_console_write_buf() static
  sparc: prom: Update DaveM's email address

 arch/sparc/include/asm/oplib_32.h |    3 --
 arch/sparc/include/asm/oplib_64.h |    3 --
 arch/sparc/prom/Makefile          |    1 -
 arch/sparc/prom/console_32.c      |   56 ----------------------------
 arch/sparc/prom/console_64.c      |   48 ------------------------
 arch/sparc/prom/printf.c          |   73 +++++++++++++++++++++++++++++++++++--
 6 files changed, 70 insertions(+), 114 deletions(-)
 delete mode 100644 arch/sparc/prom/console_32.c
 delete mode 100644 arch/sparc/prom/console_64.c
