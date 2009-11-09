From: David Miller <davem@davemloft.net>
Date: Mon, 09 Nov 2009 05:31:38 +0000
Subject: [GIT]: Sparc
Message-Id: <20091108.213138.205827243.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Fix a locking bug pointed out by Thomas Gleixner and clarify some
aspects of our sparc64 barriers.

Please pull, thanks a lot.

The following changes since commit 2e2ec952350f25242f2e0539db16b1e46f9eb01b:
  Linus Torvalds (1):
        Merge branch 'bugfix' of git://git.kernel.org/.../jeremy/xen

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (2):
      sparc64: Add a comment about why we only use certain memory barriers these days.
      sparc: Move of_set_property_mutex acquisition outside of devtree_lock grab.

Roel Kluin (1):
      sparc64: replace parentheses in pmul()

 arch/sparc/include/asm/system_64.h |    4 ++++
 arch/sparc/kernel/prom_common.c    |    4 ++--
 arch/sparc/kernel/visemul.c        |    2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)
