From: David Miller <davem@davemloft.net>
Date: Wed, 14 Oct 2009 21:14:02 +0000
Subject: [GIT]: Sparc
Message-Id: <20091014.141402.203929406.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these sparc bug fixes, thanks!

The following changes since commit 36a07902c2134649c4af7f07980413ffb1a56085:
  Linus Torvalds (1):
        Merge branch 'upstream-linus' of git://git.kernel.org/.../jgarzik/libata-dev

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (3):
      sparc64: Fix niagara2 perf IRQ bits.
      sparc64: Fix D-cache flushing on swapin from SW devices.
      sparc64: Set IRQF_DISABLED on LDC channel IRQs.

Thomas Gleixner (1):
      watchdog: Fix rio watchdog probe function

 arch/sparc/kernel/ldc.c        |    4 ++--
 arch/sparc/kernel/perf_event.c |    2 +-
 arch/sparc/mm/init_64.c        |    2 +-
 drivers/watchdog/riowd.c       |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)
