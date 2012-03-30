From: David Miller <davem@davemloft.net>
Date: Fri, 30 Mar 2012 07:39:47 +0000
Subject: [GIT] Sparc
Message-Id: <20120330.033947.681145423995124443.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


This just fixes build fallout due to recent changes that went
int your tree.

Please pull, thanks a lot.

The following changes since commit 4bde23f8751f388867766b0a62ed1ef8b7e01561:

  Merge tag 'fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2012-03-29 21:30:28 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to 8befc9f23c695395de011ced289c611fada22f35:

  sparc: Fix even more fallout from system.h split. (2012-03-29 22:40:52 -0700)

----------------------------------------------------------------
David S. Miller (1):
      sparc: Fix even more fallout from system.h split.

Stephen Rothwell (1):
      sparc: fix fallout from system.h split

 arch/sparc/include/asm/ptrace.h |    1 +
 arch/sparc/kernel/jump_label.c  |    2 ++
 arch/sparc/kernel/kgdb_64.c     |    1 +
 3 files changed, 4 insertions(+), 0 deletions(-)
