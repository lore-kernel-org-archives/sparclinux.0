From: David Dillow <dave@thedillows.org>
Date: Tue, 17 Feb 2004 04:50:03 +0000
Subject: Non-PCI build broken on sparc64, maybe others
Message-Id: <1076993402.21443.5.camel@ori.thedillows.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

I believe this changeset in Linus's tree:
==== ChangeSet 1.1500.12.4 ====
D 1.1500.12.4 04/02/02 11:04:46-08:00 dsaxena@plexity.net 35779 35702 5/0/1
P ChangeSet
C [PATCH] PCI: Replace pci_pool with generic dma_pool
C
C - Move drivers/pci/pool.c to drivers/base/pool.c
C - Initialize struct device.dma_pools in device_initialize()
C - Remove initialization of struct pci_dev.pools from pci_setup_device()
------------------------------------------------

with key: dsaxena@plexity.net|ChangeSet|20040202190446|51997

breaks builds that do not include PCI support.

If I set CONFIG_PCI=y, it builds. If not, I get:
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x2056c): In function `pool_alloc_page':
: undefined reference to `dma_alloc_coherent'
drivers/built-in.o(.text+0x2060c): In function `pool_free_page':
: undefined reference to `dma_free_coherent'
make: *** [.tmp_vmlinux1] Error 1

while building BK-latest for my Ultra1.

Just a heads up,
Dave
