From: David Miller <davem@davemloft.net>
Date: Fri, 04 Sep 2009 12:27:35 +0000
Subject: [GIT]: Sparc
Message-Id: <20090904.052735.120899977.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these two sparc bug fixes.

Thanks!

The following changes since commit 37d0892c5a94e208cf863e3b7bac014edee4346d:
  Ian Kent (1):
        autofs4 - fix missed case when changing to use struct path

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (2):
      sparc64: Kill spurious NMI watchdog triggers by increasing limit to 30 seconds.
      sparc64: Fix bootup with mcount in some configs.

 arch/sparc/kernel/irq_64.c |    2 +-
 arch/sparc/kernel/nmi.c    |    2 +-
 arch/sparc/prom/misc_64.c  |    2 +-
 arch/sparc/prom/printf.c   |    7 +++----
 4 files changed, 6 insertions(+), 7 deletions(-)
