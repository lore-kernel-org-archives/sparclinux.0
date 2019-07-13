From: David Miller <davem@davemloft.net>
Date: Sat, 13 Jul 2019 06:17:42 +0000
Subject: [GIT] Sparc
Message-Id: <20190712.231742.1744524168822613248.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Just a few small changes:

1) Fix console naming inconsistency with hypervisor consoles, from
   John Paul Adrian Glaubitz

2) Fix userland compilation due to use of u_int, from Masahiro Yamada.

Please pull, thanks a lot.

The following changes since commit 30d1d92a888d03681b927c76a35181b4eed7071f:

  Merge tag 'nds32-for-linux-5.2-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/greentime/linux (2019-06-03 10:23:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 61daf52c4ddd433924687850fa04ed85c0d806dd:

  sparc64: Add missing newline at end of file (2019-07-09 14:53:57 -0700)

----------------------------------------------------------------
Geert Uytterhoeven (1):
      sparc64: Add missing newline at end of file

John Paul Adrian Glaubitz (1):
      sunhv: Fix device naming inconsistency between sunhv_console and sunhv_reg

Krzysztof Kozlowski (1):
      sparc: configs: Remove useless UEVENT_HELPER_PATH

Masahiro Yamada (1):
      sparc: fix unknown type name u_int in uapi header

Thomas Huth (1):
      sparc: Remove redundant copy of the LGPL-2.0

 arch/sparc/configs/sparc32_defconfig     |   1 -
 arch/sparc/configs/sparc64_defconfig     |   1 -
 arch/sparc/include/uapi/asm/openpromio.h |   3 +-
 arch/sparc/lib/COPYING.LIB               | 481 -----------------------------------------------------------------------------
 arch/sparc/lib/NG4clear_page.S           |   2 +-
 drivers/tty/serial/sunhv.c               |   2 +-
 6 files changed, 3 insertions(+), 487 deletions(-)
 delete mode 100644 arch/sparc/lib/COPYING.LIB
