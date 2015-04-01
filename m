From: Yinghai Lu <yinghai@kernel.org>
Date: Wed, 01 Apr 2015 02:57:46 +0000
Subject: [PATCH 0/3] PCI/sparc: Fix booting with T5-8
Message-Id: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>
Cc: David Ahern <david.ahern@oracle.com>, linux-pci@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>

Fix regression by commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows to
fit in upstream windows").

That cause bridge bar get clipped wrongly.

The sparc64 dma_addr_t is 32-bit, we can not use it to check if we can
use 64bit bar, introduce pci_bus_addr_t.

sparc ofpci does not parse 64bit mem for root bus, add code to
make sure that we get correct resource for root.

Also there are device 64-bit res does not have pref bit flag, but bridges
do have pref bit set, that cause extra "no compatible window".
Set pref bit for them according to the errata.

Thanks

Yinghai

Yinghai Lu (3):
  PCI: Introduce pci_bus_addr_t
  sparc/PCI: Add mem64 resource parsing for root bus
  PCI: Set pref for mem64 resource of pcie device

 arch/sparc/kernel/pci.c        |  7 ++++-
 arch/sparc/kernel/pci_common.c | 15 ++++++++--
 arch/sparc/kernel/pci_impl.h   |  1 +
 drivers/pci/Kconfig            |  4 +++
 drivers/pci/bus.c              | 10 +++----
 drivers/pci/probe.c            | 62 ++++++++++++++++++++++++++++++++++++++----
 include/linux/pci.h            | 12 ++++++--
 7 files changed, 94 insertions(+), 17 deletions(-)

-- 
1.8.4.5

