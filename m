From: David Miller <davem@davemloft.net>
Date: Thu, 17 Feb 2011 21:34:42 +0000
Subject: [GIT] Sparc
Message-Id: <20110217.133442.183044409.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Some small fixups:

1) Get perf working again.

2) sparc32 iommu code scans wrong range of bits in bitmap, from Akinobu Mita.

3) sparc32 unaligned access trap handler regression fix, from Daniel Hellstrom.

Please pull, thanks a lot!

The following changes since commit ee715087024b91a6ceb85ba2d02f6c35d354a48c:

  Merge branch 'for-2.6.38' of git://linux-nfs.org/~bfields/linux (2011-02-16 21:53:41 -0800)

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Akinobu Mita (2):
      sparc: use bitmap_set()
      sparc: fix size argument to find_next_zero_bit()

Daniel Hellstrom (1):
      sparc32: unaligned memory access (MNA) trap handler bug

David S. Miller (1):
      sparc64: Fix NMI startup bug which also breaks perf.

 arch/sparc/include/asm/pcr.h   |    2 ++
 arch/sparc/kernel/iommu.c      |    5 ++---
 arch/sparc/kernel/pcr.c        |    2 --
 arch/sparc/kernel/smp_64.c     |    2 ++
 arch/sparc/kernel/una_asm_32.S |    4 ++--
 arch/sparc/lib/bitext.c        |    5 ++---
 6 files changed, 10 insertions(+), 10 deletions(-)
