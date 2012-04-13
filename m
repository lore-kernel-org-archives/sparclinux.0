From: David Miller <davem@davemloft.net>
Date: Fri, 13 Apr 2012 19:24:55 +0000
Subject: [GIT] Sparc
Message-Id: <20120413.152455.900761231064979707.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these two sparc bug fixes.

With special guest sparc64 assembler hacker, Paul E. McKenney.

Thanks.

The following changes since commit 4166fb64593514ad920b7dbd290e0a934b37d24a:

  Merge tag 'srpt-srq-type' of git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband (2012-04-12 18:51:32 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to 3d3eeb2ef26112a200785e5fca58ec58dd33bf1e:

  sparc64: Eliminate obsolete __handle_softirq() function (2012-04-13 11:58:38 -0700)

----------------------------------------------------------------
David S. Miller (1):
      sparc64: Fix bootup crash on sun4v.

Paul E. McKenney (1):
      sparc64: Eliminate obsolete __handle_softirq() function

 arch/sparc/kernel/ds.c       |    2 +-
 arch/sparc/kernel/rtrap_64.S |    7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)
