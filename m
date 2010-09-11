From: David Miller <davem@davemloft.net>
Date: Sat, 11 Sep 2010 04:25:44 +0000
Subject: [GIT] Sparc
Message-Id: <20100910.212544.193703159.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


This just kills off those completely bogus BKL uses in
the sparc code that were discussed the other day.

Please pull, thanks a lot!

The following changes since commit 3e6dce76d99b328716b43929b9195adfee1de00c:

  Merge branch 'drm-intel-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/ickle/drm-intel (2010-09-10 18:19:43 -0700)

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (1):
      sparc: Kill all BKL usage.

 arch/sparc/kernel/sys_sparc_32.c |    2 --
 arch/sparc/kernel/unaligned_32.c |    3 +--
 arch/sparc/kernel/windows.c      |    2 --
 3 files changed, 1 insertions(+), 6 deletions(-)
