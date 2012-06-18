From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 18 Jun 2012 18:17:10 +0000
Subject: [PATCH] sparc/PCI: remove unused pcibios_assign_resource() definition
Message-Id: <20120618181709.6135.2703.stgit@bhelgaas.mtv.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-pci@vger.kernel.org

pcibios_assign_resource() isn't used anywhere; remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/sparc/kernel/pcic.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index ded3f60..46ba849 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -884,11 +884,6 @@ void __init sun4m_pci_init_IRQ(void)
 	sparc_config.load_profile_irq = pcic_load_profile_irq;
 }
 
-int pcibios_assign_resource(struct pci_dev *pdev, int resource)
-{
-	return -ENXIO;
-}
-
 /*
  * This probably belongs here rather than ioport.c because
  * we do not want this crud linked into SBus kernels.

