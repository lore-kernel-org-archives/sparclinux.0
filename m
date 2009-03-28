From: David Miller <davem@davemloft.net>
Date: Sat, 28 Mar 2009 01:18:43 +0000
Subject: [GIT]: Sparc
Message-Id: <20090327.181843.208533325.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Two bug fixes for sparc64.

Please pull, thanks a lot!

The following changes since commit 0b4d569de222452bcb55a4a536ade6cf4d8d1e30:
  Linus Torvalds (1):
        i915: fix wrong 'size_t' format string

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (3):
      sparc64: Fix MM refcount check in smp_flush_tlb_pending().
      Merge branch 'master' of /home/davem/src/GIT/linux-2.6/
      sparc64: We need to use compat_sys_ustat() as well.

 arch/sparc/kernel/smp_64.c     |    4 ++--
 arch/sparc/kernel/systbls_64.S |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
