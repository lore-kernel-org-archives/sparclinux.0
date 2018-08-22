From: David Miller <davem@davemloft.net>
Date: Wed, 22 Aug 2018 05:16:12 +0000
Subject: [GIT] Sparc
Message-Id: <20180821.221612.1820997428691874754.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Nothing super serious:

1) Convert sparc32 over to NO_BOOTMEM, from Mike Rapoport.

2) Use dma_noncoherent_ops on sparc32, from Christoph Hellwig

3) Fix kbuild defconfig handling on sparc32, from Masahiro Yamada.

Please pull, thanks a lot.

The following changes since commit 778a33959a8ad4cb1ea2f4c5119f9e1e8b9f9d9b:

  Merge tag 'please-pull-noboot' of git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux (2018-08-20 19:37:09 -0700)

are available in the Git repository at:

  gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to c84ca616b1260949782f408271336f0eda056c61:

  sparc: fix KBUILD_DEFCONFIG for ARCH=sparc32 (2018-08-21 12:41:12 -0700)

----------------------------------------------------------------
Christoph Hellwig (1):
      sparc: use generic dma_noncoherent_ops

David S. Miller (1):
      Merge branch 'sparc32-NO_BOOTMEM'

Masahiro Yamada (1):
      sparc: fix KBUILD_DEFCONFIG for ARCH=sparc32

Mike Rapoport (3):
      sparc: mm/init_32: kill trailing whitespace
      sparc32: switch to NO_BOOTMEM
      sparc32: split ramdisk detection and reservation to a helper function

 arch/sparc/Kconfig                   |   6 ++--
 arch/sparc/Makefile                  |   6 ++--
 arch/sparc/include/asm/dma-mapping.h |   5 ++-
 arch/sparc/kernel/ioport.c           | 193 +++++++++++++++++---------------------------------------------------------------------------------------
 arch/sparc/mm/init_32.c              | 127 ++++++++++++++++++++++++++------------------------------------------
 5 files changed, 88 insertions(+), 249 deletions(-)
