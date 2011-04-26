From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 26 Apr 2011 08:54:16 +0000
Subject: [PATCH 0/2] sparc32,leon: PCI patches
Message-Id: <4DB68838.1020304@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello Dave,

The patches in this series must be applied ontop of the genriq patches 
sent previously.

The patches implement PCI for the LEON architecture. The LEON supports 
different PCI Host controllers, I have tried to collect common parts in 
leon_pci.c and host drivers will be named leon_pci_*.c.

There is no BIOS or bootloader initializing PCI for use in comparison to 
the PCIC-SPARC32 code. LEON rely on the Linux generic resource & IRQ 
code to probe and setup the bus for us, drivers/pci/Makefile is 
dependent on CONFIG_SPARC_LEON in order not to brake PCIC. PCIC can not 
be defined at the same time as the LEON PCI layer, so the CONFIG_PCI 
ifdeffs has been replaced with CONFIG_PCI && !CONFIG_SPARC_LEON.

Thanks,
Daniel

 arch/sparc/Kconfig                  |    7 +
 arch/sparc/include/asm/leon.h       |    3 +
 arch/sparc/include/asm/pci_32.h     |    5 +
 arch/sparc/include/asm/pci_leon.h   |   36 ++
 arch/sparc/include/asm/pcic.h       |    2 +-
 arch/sparc/kernel/Makefile          |    5 +
 arch/sparc/kernel/entry.S           |    2 +-
 arch/sparc/kernel/leon_kernel.c     |   15 +
 arch/sparc/kernel/leon_pci.c        |  237 +++++++++
 arch/sparc/kernel/leon_pci_grpci2.c |  905 
+++++++++++++++++++++++++++++++++++
 drivers/pci/Makefile                |    1 +
 11 files changed, 1216 insertions(+), 2 deletions(-)

