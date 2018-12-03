From: David Miller <davem@davemloft.net>
Date: Mon, 03 Dec 2018 05:33:11 +0000
Subject: [GIT] Sparc
Message-Id: <20181202.213311.1579839820291849515.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Some implicit switch fallthrough fixes from Stephen Rothwell.

2) Missing of_node_put() in various sparc drivers from
   Yangtao Li.

Please pull, thanks!

The following changes since commit 25e19c1fe421280a47f37c3571aa379e6e67966c:

  Merge tag 'libnvdimm-fixes-4.20-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm (2018-11-18 12:21:09 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to dac097c4546e4c5b16dd303a1e97c1d319c8ab3e:

  drivers/tty: add missing of_node_put() (2018-12-02 20:55:23 -0800)

----------------------------------------------------------------
Sabyasachi Gupta (1):
      arch/sparc: Use kzalloc_node

Stephen Rothwell (3):
      sparc: suppress the implicit-fallthrough warning
      sparc32: suppress an implicit-fallthrough warning
      sparc32: supress another implicit-fallthrough warning

Yangtao Li (3):
      sbus: char: add of_node_put()
      drivers/sbus/char: add of_node_put()
      drivers/tty: add missing of_node_put()

 arch/sparc/kernel/iommu.c       | 3 +--
 arch/sparc/kernel/signal32.c    | 1 +
 arch/sparc/kernel/signal_32.c   | 1 +
 arch/sparc/kernel/signal_64.c   | 1 +
 drivers/sbus/char/display7seg.c | 1 +
 drivers/sbus/char/envctrl.c     | 2 ++
 drivers/tty/serial/suncore.c    | 1 +
 7 files changed, 8 insertions(+), 2 deletions(-)
