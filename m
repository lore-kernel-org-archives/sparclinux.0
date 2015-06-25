From: David Miller <davem@davemloft.net>
Date: Thu, 25 Jun 2015 13:27:09 +0000
Subject: [GIT] Sparc
Message-Id: <20150625.062709.1965751841318655692.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these sparc perf stack traversal fixes from
David Ahern.

Thanks.

The following changes since commit aefbef10e3ae6e2c6e3c54f906f10b34c73a2c66:

  Merge branch 'akpm' (patches from Andrew) (2015-06-24 20:47:21 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to f01cae4e1a9bc845ee125cdb763ccf18298d3fdc:

  Merge branch 'sparc-perf-stack' (2015-06-25 06:01:10 -0700)

----------------------------------------------------------------
David Ahern (4):
      sparc: perf: Disable pagefaults while walking userspace stacks
      sparc64: Convert BUG_ON to warning
      sparc64: perf: Add sanity checking on addresses in user stack
      sparc64: perf: Use UREG_FP rather than UREG_I6

David S. Miller (1):
      Merge branch 'sparc-perf-stack'

 arch/sparc/include/asm/uaccess_64.h | 22 ++++++++++++++++++++++
 arch/sparc/kernel/perf_event.c      | 24 +++++++++++++++++++++---
 arch/sparc/mm/fault_64.c            |  5 +++--
 3 files changed, 46 insertions(+), 5 deletions(-)
