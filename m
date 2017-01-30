From: David Miller <davem@davemloft.net>
Date: Mon, 30 Jan 2017 22:37:02 +0000
Subject: [GIT] Sparc
Message-Id: <20170130.173702.1470935262918086278.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Several small bug fixes and tidies, along with a fix for non-resumable
memory errors triggered by userspace.

Please pull, thanks a lot!

The following changes since commit ba6d973f78eb62ffebb32f6ef3334fc9a3b33d22:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2016-12-20 15:48:34 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 54791b276b4000b307339f269d3bf7db877d536f:

  Merge branch 'sparc64-non-resumable-user-error-recovery' (2017-01-30 14:28:22 -0800)

----------------------------------------------------------------
David S. Miller (1):
      Merge branch 'sparc64-non-resumable-user-error-recovery'

Liam R. Howlett (2):
      sparc64: Zero pages on allocation for mondo and error queues.
      sparc64: Handle PIO & MEM non-resumable errors.

Mike Kravetz (1):
      sparc: use symbolic names for tsb indexing

Tom Hromatka (1):
      sparc: Fixed typo in sstate.c. Replaced panicing with panicking

 arch/sparc/include/asm/mmu_context_64.h |  8 ++++----
 arch/sparc/kernel/irq_64.c              |  2 +-
 arch/sparc/kernel/sstate.c              |  6 +++---
 arch/sparc/kernel/traps_64.c            | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 8 deletions(-)
