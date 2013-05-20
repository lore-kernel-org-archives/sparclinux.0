From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 20 May 2013 23:19:16 +0000
Subject: [PATCH 2/2] sparc/PCI: Use PCI_UNKNOWN for unknown power state
Message-Id: <20130520231916.32416.7318.stgit@bhelgaas-glaptop>
List-Id: <sparclinux.vger.kernel.org>
References: <20130520231909.32416.81752.stgit@bhelgaas-glaptop>
In-Reply-To: <20130520231909.32416.81752.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org

Previously we initialized dev->current_state to 4 (PCI_D3cold), but I think
we wanted PCI_UNKNOWN (5) here based on the comment and the fact that the
generic version of this code, pci_setup_device(), uses PCI_UNKNOWN.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/sparc/kernel/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index baf4366..972892a 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -327,7 +327,7 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 	if ((dev->class >> 8) = PCI_CLASS_STORAGE_IDE)
 		pci_set_master(dev);
 
-	dev->current_state = 4;		/* unknown power state */
+	dev->current_state = PCI_UNKNOWN;	/* unknown power state */
 	dev->error_state = pci_channel_io_normal;
 	dev->dma_mask = 0xffffffff;
 

