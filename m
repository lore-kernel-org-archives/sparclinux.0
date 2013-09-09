From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 09 Sep 2013 01:00:30 +0000
Subject: sparc32 defconfig build broken due to commit ebd97be63 (PCI: remove ARCH_SUPPORTS_MSI kconfig option
Message-Id: <522D1DAE.5010100@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Hi,

"make ARCH=sparc32 defconfig; make ARCH=sparc32" on the current upstream kernel results in:

In file included from arch/sparc/kernel/pci_msi.c:10:0:
arch/sparc/kernel/pci_impl.h:142:18: error: field 'stc' has incomplete type
arch/sparc/kernel/pci_msi.c: In function 'sparc64_setup_msi_irq':
arch/sparc/kernel/pci_msi.c:131:2: error: implicit declaration of function 'irq_alloc' [-Werror=implicit-function-declaration]
arch/sparc/kernel/pci_msi.c:173:2: error: implicit declaration of function 'irq_free' [-Werror=implicit-function-declaration]
cc1: all warnings being treated as errors
make[2]: *** [arch/sparc/kernel/pci_msi.o] Error 1

Bisect points to commit ebd97be635 (PCI: remove ARCH_SUPPORTS_MSI kconfig option).
After reverting this commit, sparc32:defconfig builds fine.

sparc64 defconfig is unaffected.

Guenter
