From: David Miller <davem@davemloft.net>
Date: Fri, 26 Oct 2018 23:08:28 +0000
Subject: [GIT] Sparc
Message-Id: <20181026.160828.636318063368651002.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Some more sparc fixups, mostly aimed at getting the allmodconfig build
up and clean again.

Please pull, thanks a lot!

The following changes since commit caf539cd1087f7c36b9c4df271575e9aee49fde5:

  sparc: Fix VDSO build with older binutils. (2018-10-25 10:36:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 6c2fc9cddc1ffdef8ada1dc8404e5affae849953:

  sparc64: Rework xchg() definition to avoid warnings. (2018-10-26 15:39:49 -0700)

----------------------------------------------------------------
David Miller (1):
      sparc64: Make corrupted user stacks more debuggable.

David S. Miller (2):
      sparc64: Export __node_distance.
      sparc64: Rework xchg() definition to avoid warnings.

 arch/sparc/include/asm/cmpxchg_64.h   |  7 ++++++-
 arch/sparc/include/asm/switch_to_64.h |  3 ++-
 arch/sparc/kernel/process_64.c        | 25 +++++++++++++++++++------
 arch/sparc/kernel/rtrap_64.S          |  1 +
 arch/sparc/kernel/signal32.c          | 12 ++++++++++--
 arch/sparc/kernel/signal_64.c         |  6 +++++-
 arch/sparc/mm/init_64.c               |  1 +
 7 files changed, 44 insertions(+), 11 deletions(-)
