From: David Miller <davem@davemloft.net>
Date: Fri, 16 Dec 2011 20:22:29 +0000
Subject: [GIT] Sparc
Message-Id: <20111216.152229.161655308008211539.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Bootup on 32-bit fails because gcc started to emit tail calls more
   aggressively, so we need to accept 13-bit signed immediation
   relocations into 'restore' instructions.

2) Kill unused variable in bbc_i2c and module_platform_driver()
conversion from Axel Lin.

3) Use kmemdup(), from Thomas Meyer.

Please pull, thanks a lot!

The following changes since commit 2cfab8d74ebfbe06ce2947117945c4f45a5915ec:

  Merge branch 'drm-intel-fixes' of git://people.freedesktop.org/~keithp/linux (2011-12-16 11:27:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

Axel Lin (2):
      bbc_i2c: Remove unneeded err variable
      sbus: convert drivers/sbus/char/* to use module_platform_driver()

David S. Miller (1):
      sparc32: Be less strict in matching %lo part of relocation.

Thomas Meyer (1):
      sparc: Use kmemdup rather than duplicating its implementation

 arch/sparc/kernel/ds.c          |    6 ++----
 arch/sparc/kernel/prom_common.c |    4 +---
 arch/sparc/mm/btfixup.c         |    3 +--
 drivers/sbus/char/bbc_i2c.c     |   27 +++++----------------------
 drivers/sbus/char/display7seg.c |   13 +------------
 drivers/sbus/char/envctrl.c     |   12 +-----------
 drivers/sbus/char/flash.c       |   12 +-----------
 drivers/sbus/char/uctrl.c       |   12 +-----------
 8 files changed, 13 insertions(+), 76 deletions(-)
