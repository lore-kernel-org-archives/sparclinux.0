From: David Miller <davem@davemloft.net>
Date: Wed, 25 Feb 2009 07:15:15 +0000
Subject: [GIT]: Sparc
Message-Id: <20090224.231515.26547714.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this crash fix.

Thanks!

The following changes since commit 694593e3374a67d95ece6a275a1f181644c2c4d8:
  Linus Torvalds (1):
        Merge branch 'proc-linus' of git://git.kernel.org/.../adobriyan/proc

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (1):
      sparc64: Fix crashes in jbusmc_print_dimm()

 arch/sparc/kernel/chmc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
