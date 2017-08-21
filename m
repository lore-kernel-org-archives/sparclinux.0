From: David Miller <davem@davemloft.net>
Date: Mon, 21 Aug 2017 21:01:15 +0000
Subject: [GIT] Sparc
Message-Id: <20170821.140115.1959731292155939618.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Just a couple small fixes, two of which have to do with gcc-7:

1) Don't clobber kernel fixed registers in __multi4 libgcc helper.

2) Fix a new uninitialized variable warning on sparc32 with gcc-7,
   from Thomas Petazzoni.

3) Adjust pmd_t initializer on sparc32 to make gcc happy.

4) If ATU isn't avoid, don't bark in the logs.  From Tushar Dave.

Please pull, thanks a lot.

The following changes since commit 26273939ace935dd7553b31d279eab30b40f7b9a:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2017-08-10 10:30:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc 

for you to fetch changes up to 2dc77533f1e495788d73ffa4bee4323b2646d2bb:

  sparc: kernel/pcic: silence gcc 7.x warning in pcibios_fixup_bus() (2017-08-21 13:57:22 -0700)

----------------------------------------------------------------
David S. Miller (1):
      sparc64: Don't clibber fixed registers in __multi4.

Thomas Petazzoni (1):
      sparc: kernel/pcic: silence gcc 7.x warning in pcibios_fixup_bus()

Tushar Dave (1):
      sparc64: remove unnecessary log message

Zi Yan (1):
      mm: add pmd_t initializer __pmd() to work around a GCC bug.

 arch/sparc/include/asm/page_32.h |  2 ++
 arch/sparc/kernel/pci_sun4v.c    |  2 --
 arch/sparc/kernel/pcic.c         |  2 +-
 arch/sparc/lib/multi3.S          | 24 ++++++++++++------------
 4 files changed, 15 insertions(+), 15 deletions(-)
