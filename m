From: David Miller <davem@davemloft.net>
Date: Thu, 05 Aug 2010 00:21:18 +0000
Subject: [GIT] Sparc
Message-Id: <20100804.172118.242112071.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Convert BKL --> mutex in SBUS drivers, from Arnd Bergmann.

2) Should use GFP_KERNEL in sparc32 SBUS init code, from Julia
   Lawall.

3) MAINTAINERS tweak

Please pull, thanks a lot!

The following changes since commit 3cfc2c42c1cbc8e238bb9c0612c0df4565e3a8b4:

  Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial (2010-08-04 15:31:02 -0700)

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Arnd Bergmann (1):
      sbus: autoconvert trivial BKL users to private mutex

David S. Miller (1):
      MAINTAINERS: Add trailing slash to SBUS path.

Julia Lawall (1):
      arch/sparc/mm: Use GFP_KERNEL

 MAINTAINERS                     |    2 +-
 arch/sparc/mm/iommu.c           |    2 +-
 drivers/sbus/char/display7seg.c |    8 ++++----
 drivers/sbus/char/envctrl.c     |    2 --
 drivers/sbus/char/flash.c       |   15 ++++++++-------
 drivers/sbus/char/openprom.c    |   15 ++++++++-------
 drivers/sbus/char/uctrl.c       |    7 ++++---
 7 files changed, 26 insertions(+), 25 deletions(-)
