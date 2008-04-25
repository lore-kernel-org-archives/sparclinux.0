From: David Miller <davem@davemloft.net>
Date: Fri, 25 Apr 2008 10:25:11 +0000
Subject: [GIT]: Sparc
Message-Id: <20080425.032511.194165274.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull, to get these two sparc bug fixes.

Thanks!

The following changes since commit b69d3987f4360a5e7e9e55465b3cdd0cc204b79e:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../x86/linux-2.6-x86-fixes

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (2):
      [SPARC64]: Fix args to 64-bit sys_semctl() via sys_ipc().
      [SPARC64]: Wrap SMP IPIs with irq_enter()/irq_exit().

 arch/sparc64/kernel/smp.c       |   27 ++++++++++++++++++++++-----
 arch/sparc64/kernel/sys_sparc.c |    4 ++--
 2 files changed, 24 insertions(+), 7 deletions(-)
