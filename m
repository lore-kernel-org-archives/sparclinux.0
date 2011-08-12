From: David Miller <davem@davemloft.net>
Date: Fri, 12 Aug 2011 01:08:46 +0000
Subject: [GIT] Sparc
Message-Id: <20110811.180846.1821152818786929944.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this Sparc bug fix, thanks!

The following changes since commit 068ef739127af1faf6f342b56d41ceea89f76c75:

  Merge branch 'fixes' of master.kernel.org:/home/rmk/linux-2.6-arm (2011-08-10 17:37:17 -0700)

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc.git master

David S. Miller (1):
      sparc: Don't do hypervisor calls on non-sun4v in DS driver.

 arch/sparc/kernel/ds.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)
