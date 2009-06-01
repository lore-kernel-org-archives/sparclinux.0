From: David Miller <davem@davemloft.net>
Date: Mon, 01 Jun 2009 10:26:16 +0000
Subject: [GIT]: Sparc
Message-Id: <20090601.032616.120144677.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Two small sparc fixes, please pull, thanks!

The following changes since commit 3218911f839b6c85acbf872ad264ea69aa4d89ad:
  Linus Torvalds (1):
        Merge git://git.infradead.org/~dwmw2/mtd-2.6.30

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (2):
      sparc64: Fix SET_PERSONALITY to not clip bits outside of PER_MASK.
      sparc64: Fix section attribute warnings.

 arch/sparc/include/asm/elf_64.h      |    5 +++--
 arch/sparc/lib/csum_copy_from_user.S |    2 +-
 arch/sparc/lib/csum_copy_to_user.S   |    2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)
