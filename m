From: David Miller <davem@davemloft.net>
Date: Thu, 10 May 2012 20:52:44 +0000
Subject: [GIT] Sparc
Message-Id: <20120510.165244.1634080676100822022.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this sparc64 bug fix, thanks!

The following changes since commit bc46f9375a286d05f84a9464efc2b7f1f5614ff4:

  Merge tag 'nfs-for-3.4-5' of git://git.linux-nfs.org/projects/trondmy/linux-nfs (2012-05-10 10:05:19 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to a5a737e090e25981e99d69f01400e3a80356581c:

  sparc64: Do not clobber %g2 in xcall_fetch_glob_regs(). (2012-05-10 11:00:46 -0700)

----------------------------------------------------------------
David S. Miller (1):
      sparc64: Do not clobber %g2 in xcall_fetch_glob_regs().

 arch/sparc/kernel/central.c |    2 +-
 arch/sparc/mm/ultra.S       |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)
