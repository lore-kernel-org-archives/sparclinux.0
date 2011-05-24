From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 24 May 2011 07:02:02 +0000
Subject: [PATCH 0/2 v3] sparc32,leon: PCI patches
Message-Id: <4DDB57EA.8020008@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

I have tried to cleanup the patches as Sam/Julian suggested, I have 
added a PCIC_PCI and a LEON_PCI Kconfig setting which depend on PCI and 
(!)SPARC_LEON. Before pci_leon.h was included from pci_32.h, now the pci 
related stuff is declared inside of pci_32.h instead. The LEON host 
controller implementation specific stuff was moved into leon_pci.h in 
the same manner as the AMBA bus implementation on LEON in leon_amba.h.

Thank you for your time,
Daniel

 arch/sparc/Kconfig                  |   17 +
 arch/sparc/include/asm/leon.h       |    3 +
 arch/sparc/include/asm/leon_pci.h   |   21 +
 arch/sparc/include/asm/pci_32.h     |   24 +
 arch/sparc/include/asm/pcic.h       |    2 +-
 arch/sparc/kernel/Makefile          |    4 +-
 arch/sparc/kernel/entry.S           |    4 +-
 arch/sparc/kernel/leon_kernel.c     |   15 +
 arch/sparc/kernel/leon_pci.c        |  253 ++++++++++
 arch/sparc/kernel/leon_pci_grpci2.c |  897 
+++++++++++++++++++++++++++++++++++
 drivers/pci/Makefile                |    1 +
 11 files changed, 1237 insertions(+), 4 deletions(-)

