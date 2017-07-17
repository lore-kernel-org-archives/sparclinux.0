From: David Miller <davem@davemloft.net>
Date: Mon, 17 Jul 2017 20:57:48 +0000
Subject: [GIT] Sparc
Message-Id: <20170717.135748.2024029115923543493.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these two sparc fixes:

1) Fix DMA regression in 4.13 merge window, only certain chips can
   do 64-bit DMA.  From Dave Dushar.

2) Correct cpu cross-call algorithm to correctly detect stalled or
   stuck remote cpus, from Jane Chu.

Thanks!

The following changes since commit 3b06b1a7448ee4e8e51dae3938774735404e51fb:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc (2017-07-11 21:34:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 9d53caec84c7c5700e7c1ed744ea584fff55f9ac:

  sparc64: Measure receiver forward progress to avoid send mondo timeout (2017-07-14 11:18:02 -0700)

----------------------------------------------------------------
Jane Chu (1):
      sparc64: Measure receiver forward progress to avoid send mondo timeout

Tushar Dave (1):
      SPARC64: Fix sun4v DMA panic

 arch/sparc/include/asm/trap_block.h |   1 +
 arch/sparc/kernel/pci_sun4v.c       |  12 ++++----
 arch/sparc/kernel/smp_64.c          | 185 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------
 arch/sparc/kernel/sun4v_ivec.S      |  15 ++++++++++
 arch/sparc/kernel/traps_64.c        |   1 +
 5 files changed, 139 insertions(+), 75 deletions(-)
