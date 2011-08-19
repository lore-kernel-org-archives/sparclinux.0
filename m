From: David Miller <davem@davemloft.net>
Date: Fri, 19 Aug 2011 04:54:22 +0000
Subject: [GIT] Sparc
Message-Id: <20110818.215422.291743606960028861.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this array bounds fix from Ian Campbell.

Thanks!

The following changes since commit 5c80c71b9a0ec518b4b58d2a61de01a04f4a4453:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mason/btrfs-unstable (2011-08-18 14:20:00 -0700)

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc.git master

Ian Campbell (1):
      sparc: fix array bounds error setting up PCIC NMI trap

 arch/sparc/kernel/pcic.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
