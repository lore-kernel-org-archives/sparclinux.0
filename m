From: David Miller <davem@davemloft.net>
Date: Fri, 09 May 2008 00:05:45 +0000
Subject: [GIT]: Sparc
Message-Id: <20080508.170545.193703278.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this sparc signal stack handling bug fix.

Thanks!

The following changes since commit 1e38c126c9252b612697e34f43b1b3371c8ee31d:
  David S. Miller (1):
        sparc: Fix fork/clone/vfork system call restart.

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (1):
      sparc: Fix SA_ONSTACK signal handling.

 arch/sparc/kernel/signal.c     |   20 +++++++++++++++++---
 arch/sparc64/kernel/signal.c   |   21 +++++++++++++++++----
 arch/sparc64/kernel/signal32.c |   18 +++++++++++++++++-
 3 files changed, 51 insertions(+), 8 deletions(-)
