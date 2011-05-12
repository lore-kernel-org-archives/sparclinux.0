From: David Miller <davem@davemloft.net>
Date: Thu, 12 May 2011 04:42:50 +0000
Subject: [GIT] Sparc
Message-Id: <20110512.004250.1962490475502866566.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Three sparc32 bug fixes here:

1) Correct unaligned pointer determination in sparc32 checksumming asm
   code, from Tkhai Kirill.

2) Sparc5 bootup busted because of incorrect CPU ID probing, fix from
   Sam Ravnborg.

3) Bad __init markings cause references to freed up memory after bootup,
   also from Sam Ravnborg.

Please pull, thanks a lot!

The following changes since commit 3568bd9720b4a775f28a718fcbb462ce2f386988:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client (2011-05-11 19:13:34 -0700)

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Sam Ravnborg (2):
      sparc32: fix section mismatch warnings in apc, pmc and time_32
      sparc32: fix sparcstation 5 boot

Tkhai Kirill (1):
      sparc32: Fixed unaligned memory copying in function __csum_partial_copy_sparc_generic

 arch/sparc/kernel/apc.c      |    2 +-
 arch/sparc/kernel/pmc.c      |    2 +-
 arch/sparc/kernel/smp_32.c   |   10 +++++++---
 arch/sparc/kernel/time_32.c  |    2 +-
 arch/sparc/lib/checksum_32.S |   12 +++++++++---
 5 files changed, 19 insertions(+), 9 deletions(-)
