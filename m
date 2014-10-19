From: David Miller <davem@davemloft.net>
Date: Sun, 19 Oct 2014 17:26:58 +0000
Subject: [GIT] Sparc
Message-Id: <20141019.132658.178402001080955021.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Here we have two bug fixes:

1) The current thread's fault_code is not setup properly upon entry to
   do_sparc64_fault() in some paths, leading to spurious SIGBUS.

2) Don't use a zero length array at the end of thread_info on sparc64,
   otherwise end_of_stack() isn't right.

Please pull, thanks!

The following changes since commit 52d589a01d4545ce1dc5c3892bb8c7b55edfe714:

  Merge branch 'for-linus' of git://git.infradead.org/users/vkoul/slave-dma (2014-10-18 18:11:04 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to e2653143d7d79a49f1a961aeae1d82612838b12c:

  sparc64: Do not define thread fpregs save area as zero-length array. (2014-10-18 23:12:33 -0400)

----------------------------------------------------------------
David S. Miller (2):
      sparc64: Fix corrupted thread fault code.
      sparc64: Do not define thread fpregs save area as zero-length array.

 arch/sparc/include/asm/thread_info_64.h | 3 ++-
 arch/sparc/kernel/dtlb_prot.S           | 6 +++---
 arch/sparc/kernel/tsb.S                 | 6 +++---
 3 files changed, 8 insertions(+), 7 deletions(-)
