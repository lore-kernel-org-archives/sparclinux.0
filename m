From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 05 Jan 2011 21:02:17 +0000
Subject: [PATCH 0/4] sparc: drop SBUS ifdefs
Message-Id: <20110105210217.GA22415@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Kristoffer Glembo noticed that SBUS is always defined for SPARC.
So I went out and dropped all #ifdef SBUS that were
present in SPARC only code.

This touches:
- arch/sparc
- drivers/net
- sound/sparc

But despite this I expect we can add all this to sparc.git.
If you prefer I can submit the patches via the usual channels.

Build tested on sparc64 & sparc.

Patches are on top of sparc-next as of yesterday.

	Sam

Sam Ravnborg (4):
      sparc: drop ifdef CONFIG_SBUS in arch/sparc - SBUS is always defined
      sunhme: cleanup conditional on CONFIG_SBUS
      cs4231: cleanup conditional on CONFIG_SBUS
      sound,sparc: drop SBUS dependency

 arch/sparc/kernel/ioport.c        |    4 ----
 arch/sparc/kernel/prom_irqtrans.c |    5 -----
 arch/sparc/mm/io-unit.c           |    4 ----
 arch/sparc/mm/iommu.c             |    4 ----
 drivers/net/sunhme.c              |    9 +--------
 sound/sparc/Kconfig               |    2 --
 sound/sparc/cs4231.c              |   13 -------------
 7 files changed, 1 insertions(+), 40 deletions(-)
