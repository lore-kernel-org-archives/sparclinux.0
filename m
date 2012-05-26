From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 May 2012 14:40:47 +0000
Subject: [PATCH 0/4] remove additional LEON dependencies
Message-Id: <20120526144047.GA6819@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Took a closer look at the remaining references in
arch/kernel/sparc to CONFIG_SPARC_LEON.

It turned out to be easier than anticipated to allow multi
platfrom support in the remaining bits.

This is on top of the previous batch sent earlier today.

With this patch I can build a kernel with LEON selected
and it boots on my ss5 :-)

	Sam

Sam Ravnborg (4):
      sparc32: refactor cpu_idle()
      sparc32,leon: always include leon_pmc in build
      sparc32,leon: always support leon in ioport
      sparc32: support leon + sun in dma_make_coherent()

 arch/sparc/include/asm/dma-mapping.h |    9 +++++++--
 arch/sparc/kernel/Makefile           |    2 +-
 arch/sparc/kernel/ioport.c           |   23 ++++++-----------------
 arch/sparc/kernel/leon_pmc.c         |   15 +++++++++------
 arch/sparc/kernel/process_32.c       |   28 ++--------------------------
 5 files changed, 25 insertions(+), 52 deletions(-)
