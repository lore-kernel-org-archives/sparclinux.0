From: David Miller <davem@davemloft.net>
Date: Thu, 20 Oct 2011 09:48:09 +0000
Subject: [GIT] Sparc
Message-Id: <20111020.054809.1247226868115473832.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Two signal fixes to mirror that done on x86, and make PCI ROM mapping
work on sparc64.

Please pull, thanks a lot.

The following changes since commit 486cf46f3f9be5f2a966016c1a8fe01e32cde09e:

  mm: fix race between mremap and removing migration entry (2011-10-19 23:42:58 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

Daniel Hellstrom (1):
      sparc32,leon: SRMMU MMU Table probe fix

David S. Miller (1):
      sparc: Avoid calling sigprocmask()

Kjetil Oftedal (1):
      sparc: Add alignment flag to PCI expansion resources

Matt Fleming (1):
      sparc: Use set_current_blocked()

 arch/sparc/include/asm/pgtsrmmu.h |    2 +-
 arch/sparc/kernel/pci.c           |    3 ++-
 arch/sparc/kernel/signal32.c      |   21 +++++++--------------
 arch/sparc/kernel/signal_32.c     |   32 +++++++++++++-------------------
 arch/sparc/kernel/signal_64.c     |   32 +++++++++++++-------------------
 arch/sparc/mm/leon_mm.c           |    2 +-
 6 files changed, 37 insertions(+), 55 deletions(-)
