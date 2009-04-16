From: David Miller <davem@davemloft.net>
Date: Thu, 16 Apr 2009 11:12:56 +0000
Subject: [GIT]: Sparc
Message-Id: <20090416.041256.120784220.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these Sparc updates.

Thanks!

The following changes since commit 3ee8da87ba6151ec91b2b8bbd27633bb248ea0d5:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../tiwai/sound-2.6

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (1):
      sparc64: Fix smp_callin() locking.

Stephen Rothwell (1):
      sparc: asm/atomic.h on 32bit should include asm/system.h for xchg

Stoyan Gaydarov (1):
      sbus: changed ioctls to unlocked

Wei Yongjun (1):
      sparc: remove some pointless conditionals before kfree()

 arch/sparc/include/asm/atomic_32.h |    2 ++
 arch/sparc/kernel/ldc.c            |    6 ++----
 arch/sparc/kernel/smp_64.c         |    4 ++--
 drivers/sbus/char/jsflash.c        |   15 ++++++++++-----
 drivers/sbus/char/uctrl.c          |    7 +++----
 5 files changed, 19 insertions(+), 15 deletions(-)
