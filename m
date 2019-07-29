From: Denis Efremov <efremov@linux.com>
Date: Mon, 29 Jul 2019 10:13:56 +0000
Subject: [PATCH v2 0/5] PCI: Convert pci_resource_to_user() to a weak function
Message-Id: <20190729101401.28068-1-efremov@linux.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Denis Efremov <efremov@linux.com>, "David S. Miller" <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Michal Simek <monstr@monstr.eu>, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org

Architectures currently define HAVE_ARCH_PCI_RESOURCE_TO_USER if they want
to provide their own pci_resource_to_user() implementation. This could be
simplified if we make the generic version a weak function. Thus,
architecture specific versions will automatically override the generic one.

Changes in v2:
1. Removed __weak from pci_resource_to_user() declaration
2. Fixed typo s/spark/sparc/g

Denis Efremov (5):
  PCI: Convert pci_resource_to_user to a weak function
  microblaze/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
  mips/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
  powerpc/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
  sparc/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER

 arch/microblaze/include/asm/pci.h |  2 --
 arch/mips/include/asm/pci.h       |  1 -
 arch/powerpc/include/asm/pci.h    |  2 --
 arch/sparc/include/asm/pci.h      |  2 --
 drivers/pci/pci.c                 |  8 ++++++++
 include/linux/pci.h               | 12 ------------
 6 files changed, 8 insertions(+), 19 deletions(-)

-- 
2.21.0
