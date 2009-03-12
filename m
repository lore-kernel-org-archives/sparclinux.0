From: David Miller <davem@davemloft.net>
Date: Thu, 12 Mar 2009 15:58:54 +0000
Subject: [GIT]: Sparc
Message-Id: <20090312.085854.191829621.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these sparc bug fixes.

Thanks!

The following changes since commit ebdcc81c71937b30e09110c02a1e8a21fa770b6f:
  Linus Torvalds (1):
        Merge branch 'drm-fixes' of git://git.kernel.org/.../airlied/drm-2.6

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Christoph Hellwig (1):
      jsflash: stop defining MAJOR_NR

David S. Miller (1):
      sparc64: Fix lost interrupts on sun4u.

Friedrich Oslage (1):
      sunhme: Fix qfe parent detection.

Roel Kluin (1):
      sparc64: wait_event_interruptible_timeout may return -ERESTARTSYS

 arch/sparc/kernel/irq_64.c  |   29 +++++++++++++++++++----------
 drivers/net/sunhme.c        |    2 --
 drivers/sbus/char/bbc_i2c.c |    2 +-
 drivers/sbus/char/jsflash.c |    3 ---
 4 files changed, 20 insertions(+), 16 deletions(-)
