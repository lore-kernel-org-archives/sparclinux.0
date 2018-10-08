From: David Miller <davem@davemloft.net>
Date: Mon, 08 Oct 2018 06:48:32 +0000
Subject: [GIT] Sparc
Message-Id: <20181007.234832.1963273306260975472.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


I've been moving so haven't had access to my Sparc boxes during this
time.  That's been resolved, and now I can get the patches flowing
again.

1) Minor fallthru comment tweaks from Gustavo A. R. Silva.

2) VLA removal from Kees Cook.

3) Make sparc vdso Makefile match x86, from Masahiro Yamada.

4) Fix clock divider programming in mach64 driver, from Mikulas
   Patocka.

Please pull, thanks a lot!

The following changes since commit c1d84a1b42ef70d8ae601df9cadedc7ed4f1beb1:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-10-06 02:11:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to b7dc10b64f6190a008f05baf697d4d8fa9b8ed51:

  sparc64: fix fall-through annotation (2018-10-07 22:42:02 -0700)

----------------------------------------------------------------
Colin Ian King (1):
      oradax: remove redundant null check before kfree

Gustavo A. R. Silva (2):
      sparc32: fix fall-through annotation
      sparc64: fix fall-through annotation

Kees Cook (1):
      sparc64: viohs: Remove VLA usage

Masahiro Yamada (1):
      sparc: vdso: clean-up vdso Makefile

Mikulas Patocka (1):
      mach64: detect the dot clock divider correctly on sparc

Rob Herring (2):
      sparc: Convert to using %pOFn instead of device_node.name
      sbus: Use of_get_child_by_name helper

 arch/sparc/kernel/auxio_64.c         |  4 ++--
 arch/sparc/kernel/kgdb_32.c          |  2 +-
 arch/sparc/kernel/kgdb_64.c          |  2 +-
 arch/sparc/kernel/power.c            |  4 ++--
 arch/sparc/kernel/prom_32.c          | 26 +++++++++++++-------------
 arch/sparc/kernel/prom_64.c          | 68 ++++++++++++++++++++++++++++++++++----------------------------------
 arch/sparc/kernel/viohs.c            | 12 +++++++++---
 arch/sparc/vdso/Makefile             |  8 +++-----
 drivers/sbus/char/openprom.c         | 11 +----------
 drivers/sbus/char/oradax.c           |  3 +--
 drivers/video/fbdev/aty/atyfb.h      |  3 ++-
 drivers/video/fbdev/aty/atyfb_base.c |  7 ++++---
 drivers/video/fbdev/aty/mach64_ct.c  | 10 +++++-----
 13 files changed, 78 insertions(+), 82 deletions(-)
