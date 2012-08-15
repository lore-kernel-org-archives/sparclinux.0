From: David Miller <davem@davemloft.net>
Date: Wed, 15 Aug 2012 07:44:57 +0000
Subject: 
Message-Id: <20120815.004457.1075503861038108671.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these two bug fixes.

Thanks!

The following changes since commit 1a9b4993b70fb1884716902774dc9025b457760d:

  Merge branch 'upstream' of git://git.linux-mips.org/pub/scm/ralf/upstream-linus (2012-08-01 16:47:15 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to 2856cc2e4d0852c3ddaae9dcb19cb9396512eb08:

  sparc64: Be less verbose during vmemmap population. (2012-08-15 00:37:29 -0700)

----------------------------------------------------------------
David S. Miller (1):
      sparc64: Be less verbose during vmemmap population.

Jiri Kosina (1):
      sparc64: do not clobber personality flags in sys_sparc64_personality()

 arch/sparc/kernel/sys_sparc_64.c | 10 +++++-----
 arch/sparc/mm/init_64.c          | 28 +++++++++++++++++++++++-----
 2 files changed, 28 insertions(+), 10 deletions(-)
