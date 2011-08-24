From: David Miller <davem@davemloft.net>
Date: Wed, 24 Aug 2011 06:34:12 +0000
Subject: [GIT] Sparc
Message-Id: <20110823.233412.1348896296603900179.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this signal handling, and array bounds bug fix.

Thanks!

The following changes since commit 5c80c71b9a0ec518b4b58d2a61de01a04f4a4453:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mason/btrfs-unstable (2011-08-18 14:20:00 -0700)

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc.git master

David S. Miller (1):
      sparc: Allow handling signals when stack is corrupted.

Ian Campbell (1):
      sparc: fix array bounds error setting up PCIC NMI trap

 arch/sparc/include/asm/sigcontext.h |   14 +++
 arch/sparc/kernel/Makefile          |    1 +
 arch/sparc/kernel/pcic.c            |    4 +-
 arch/sparc/kernel/signal32.c        |  184 ++++++++++++++++++++---------------
 arch/sparc/kernel/signal_32.c       |  172 +++++++++++++++------------------
 arch/sparc/kernel/signal_64.c       |  108 +++++++++------------
 arch/sparc/kernel/sigutil.h         |    9 ++
 arch/sparc/kernel/sigutil_32.c      |  120 +++++++++++++++++++++++
 arch/sparc/kernel/sigutil_64.c      |   93 ++++++++++++++++++
 9 files changed, 470 insertions(+), 235 deletions(-)
 create mode 100644 arch/sparc/kernel/sigutil.h
 create mode 100644 arch/sparc/kernel/sigutil_32.c
 create mode 100644 arch/sparc/kernel/sigutil_64.c
