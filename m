From: David Miller <davem@davemloft.net>
Date: Wed, 12 Jul 2017 04:05:54 +0000
Subject: [GIT] Sparc
Message-Id: <20170711.210554.1600862716843784839.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Fix symbol version generation for assembler on sparc, from
   Nagarathnam Muthusamy.

2) Fix compound page handling in gup_huge_pmd(), from Nitin Gupta.

Please pull, thanks a lot!

The following changes since commit 5faab9e0f03c4eef97886b45436015e107f79f5f:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2017-06-10 11:09:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc 

for you to fetch changes up to dbd2667a4fb9ce4f547982b07cd69dda127c47ea:

  sparc64: Fix gup_huge_pmd (2017-06-25 15:23:57 -0400)

----------------------------------------------------------------
David S. Miller (1):
      Merge branch 'sparc-Suppressing-version-generation-failed-warnings-in-sparc'

Nagarathnam Muthusamy (3):
      Adding asm-prototypes.h for genksyms to generate crc
      sed regex in Makefile.build requires line break between exported symbols
      Adding the type of exported symbols

Nitin Gupta (1):
      sparc64: Fix gup_huge_pmd

 arch/sparc/include/asm/asm-prototypes.h | 24 ++++++++++++++++++++++++
 arch/sparc/lib/atomic_64.S              | 44 ++++++++++++++++++++++++++------------------
 arch/sparc/lib/checksum_64.S            |  1 +
 arch/sparc/lib/csum_copy.S              |  1 +
 arch/sparc/lib/memscan_64.S             |  2 ++
 arch/sparc/lib/memset.S                 |  1 +
 arch/sparc/mm/gup.c                     |  4 ++--
 7 files changed, 57 insertions(+), 20 deletions(-)
 create mode 100644 arch/sparc/include/asm/asm-prototypes.h
