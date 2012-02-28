From: Joe Perches <joe@perches.com>
Date: Tue, 28 Feb 2012 18:49:29 +0000
Subject: [PATCH trivial next 0/9] treewide: Use vsprintf extention %pf
Message-Id: <cover.1330454853.git.joe@perches.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Emit the actual function name when possible

Joe Perches (9):
  sparc: Use vsprintf extention %pf with builtin_return_address
  alpha: Use vsprintf extention %pf with builtin_return_address
  arm: Use vsprintf extention %pf with builtin_return_address
  microblaze: Use vsprintf extention %pf with builtin_return_address
  powerpc: Use vsprintf extention %pf with builtin_return_address
  parisc: Use vsprintf extention %pf with builtin_return_address
  scsi: Use vsprintf extention %pf with builtin_return_address
  staging: ramster: Use vsprintf extention %pf with builtin_return_address
  gadget: Use vsprintf extention %pf with builtin_return_address

 arch/alpha/kernel/pci_iommu.c               |   20 ++++++++++----------
 arch/arm/nwfpe/fpmodule.c                   |    2 +-
 arch/microblaze/mm/pgtable.c                |    2 +-
 arch/powerpc/mm/pgtable_32.c                |    2 +-
 arch/sparc/kernel/ds.c                      |    2 +-
 arch/sparc/mm/srmmu.c                       |    2 +-
 drivers/parisc/superio.c                    |    2 +-
 drivers/scsi/esp_scsi.c                     |    2 +-
 drivers/staging/ramster/cluster/heartbeat.c |    4 ++--
 drivers/usb/gadget/u_serial.c               |    2 +-
 10 files changed, 20 insertions(+), 20 deletions(-)

-- 
1.7.8.111.gad25c.dirty

