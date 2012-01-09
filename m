From: David Miller <davem@davemloft.net>
Date: Mon, 09 Jan 2012 22:22:20 +0000
Subject: [GIT] Sparc
Message-Id: <20120109.142220.2296949606301841005.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Just some cleanups and removal of unused code from Sam Ravnborg.

Nothing earth shattering.

Please pull, thanks a lot.

The following changes since commit 6b3da11b3c36fdafce3a72e0e90d6c4e99e9aad5:

  Merge branch 'for-3.3' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/percpu (2012-01-09 13:08:28 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next.git master

Sam Ravnborg (7):
      sparc32: drop unused atomic24 support
      sparc32: drop useless preprocessor conditional in atomic_32.h
      apbuart: fix section mismatch warning
      sparc32: support atomic64_t
      sparc32: enable different preemptions models
      sparc32: fix PAGE_SIZE definition
      sparc32: remove unused file: include/asm/pgtsun4.h

 arch/sparc/Kconfig                      |    3 +-
 arch/sparc/include/asm/atomic_32.h      |  104 +-------------------
 arch/sparc/include/asm/page_32.h        |   10 +--
 arch/sparc/include/asm/pgtsun4.h        |  171 -------------------------------
 arch/sparc/include/asm/thread_info_32.h |    2 +-
 arch/sparc/lib/atomic_32.S              |   55 ----------
 arch/sparc/lib/ksyms.c                  |    6 -
 drivers/tty/serial/apbuart.c            |    4 +-
 8 files changed, 8 insertions(+), 347 deletions(-)
 delete mode 100644 arch/sparc/include/asm/pgtsun4.h
