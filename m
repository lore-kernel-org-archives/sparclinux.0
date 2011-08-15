From: David Miller <davem@davemloft.net>
Date: Mon, 15 Aug 2011 22:47:23 +0000
Subject: [GIT] Sparc
Message-Id: <20110815.154723.78978175770791283.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these sparc changes, thanks!

1) sparc32 unlock needs to use inline asm to avoid compiler
   reordering.  From Mikael Pettersson.

2) Sparc should use the C based recordmcount, thanks to Steven Rostedt
   for the tip.

The following changes since commit 2f6a123821a7feaba7cee787ef0f21d2354d1730:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-for-linus (2011-08-15 08:46:11 -0700)

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc.git master

David S. Miller (1):
      sparc64: Set HAVE_C_RECORDMCOUNT

Mikael Pettersson (2):
      sparc64: remove unnecessary macros from spinlock_64.h
      sparc32: unbreak arch_write_unlock()

 arch/sparc/Kconfig                   |    1 +
 arch/sparc/include/asm/spinlock_32.h |   11 +++++++++--
 arch/sparc/include/asm/spinlock_64.h |    6 ------
 3 files changed, 10 insertions(+), 8 deletions(-)
