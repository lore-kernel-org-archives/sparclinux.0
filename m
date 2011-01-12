From: David Miller <davem@davemloft.net>
Date: Wed, 12 Jan 2011 00:26:59 +0000
Subject: [GIT] Sparc
Message-Id: <20110111.162659.172602331.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


This fixes a bootup regression caused by some recent perf NMI changes.

Please pull, thanks a lot!

The following changes since commit 7bc4a4ce68f8c6d064ea949446852e996526f692:

  Merge branch 'for-linus-merged' of git://oss.sgi.com/xfs/xfs (2011-01-11 11:42:06 -0800)

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (1):
      sparc64: Fix bootup regression due to perf init ordering.

 arch/sparc/kernel/cpu.c |    2 +-
 arch/sparc/kernel/pcr.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
