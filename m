From: David Miller <davem@davemloft.net>
Date: Mon, 30 Apr 2018 20:12:22 +0000
Subject: [GIT] Sparc
Message-Id: <20180430.161222.657632197850615574.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get the following fixes:

1) Fixup license text for oradax driver, from Rob Gardner.

2) Release device object with put_device() instead of straight
   kfree(), from Arvind Yadav.

Thanks!

The following changes since commit 17dec0a949153d9ac00760ba2f5b78cb583e995f:

  Merge branch 'userns-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace (2018-04-03 19:15:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 00ad691ab140b54ab9f5de5e74cb994f552e8124:

  sparc: vio: use put_device() instead of kfree() (2018-04-30 16:09:34 -0400)

----------------------------------------------------------------
Arvind Yadav (1):
      sparc: vio: use put_device() instead of kfree()

Rob Gardner (1):
      sparc64: Fix mistake in oradax license text

 arch/sparc/include/uapi/asm/oradax.h | 2 +-
 arch/sparc/kernel/vio.c              | 2 +-
 drivers/sbus/char/oradax.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
