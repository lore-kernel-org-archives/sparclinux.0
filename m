From: David Miller <davem@davemloft.net>
Date: Thu, 03 Oct 2013 03:52:06 +0000
Subject: [GIT] Sparc
Message-Id: <20131002.235206.2101296729379094715.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Couple small bug fixes:

1) strlcpy in ldom_reboot() is still not quite right, use sprintf
   instead from Kees Cook.

2) Generic hugetlb interface pte checks should use the widest return
   type, otherwise high bits can get chopped off.

3) Fix build with PCI MSI enabled on 32-bit sparc.

Please pull, thanks a lot!

The following changes since commit c31eeaced22ce8bd61268a3c595d542bb38c0a4f:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2013-10-01 12:58:48 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to a988fb806d72d4e3a0edbeaece3f2f1172ce44b8:

  sparc: fix MSI build failure on Sparc32 (2013-10-02 20:02:35 -0400)

----------------------------------------------------------------
David Miller (1):
      mm: Fix generic hugetlb pte check return type.

Kees Cook (1):
      sparc: fix ldom_reboot buffer overflow harder

Michael Opdenacker (1):
      sparc: remove deprecated IRQF_DISABLED

Thomas Petazzoni (1):
      sparc: fix MSI build failure on Sparc32

 arch/sparc/Kconfig                 | 7 ++++++-
 arch/sparc/include/asm/floppy_64.h | 2 +-
 arch/sparc/kernel/Makefile         | 3 ++-
 arch/sparc/kernel/ds.c             | 5 ++---
 arch/sparc/kernel/ldc.c            | 4 ++--
 include/asm-generic/hugetlb.h      | 4 ++--
 6 files changed, 15 insertions(+), 10 deletions(-)
