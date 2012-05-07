From: Yinghai Lu <yinghai@kernel.org>
Date: Mon, 07 May 2012 20:30:01 +0000
Subject: [PATCH 16/21] sparc/PCI: register busn_res for root buses
Message-Id: <1336422606-4244-17-git-send-email-yinghai@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1336422606-4244-1-git-send-email-yinghai@kernel.org>
In-Reply-To: <1336422606-4244-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, sparclinux@vger.kernel.org

Add the host bridge bus number aperture to the resource list.
Like the MMIO and I/O port apertures, this is used when assigning
resources to hot-added devices or in the case of conflicts.

[bhelgaas: write changelog]
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/pci.c      |    8 +++++---
 arch/sparc/kernel/pci_impl.h |    1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index c85bfd7..74e4bf3 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -535,7 +535,7 @@ static void __devinit of_scan_pci_bridge(struct pci_pbm_info *pbm,
 	}
 
 	bus->primary = dev->bus->number;
-	bus->busn_res.end = busrange[1];
+	pci_bus_insert_busn_res(bus, busrange[0], busrange[1]);
 	bus->bridge_ctl = 0;
 
 	/* parse ranges property, or cook one up by hand for Simba */
@@ -685,6 +685,10 @@ struct pci_bus * __devinit pci_scan_one_pbm(struct pci_pbm_info *pbm,
 				pbm->io_space.start);
 	pci_add_resource_offset(&resources, &pbm->mem_space,
 				pbm->mem_space.start);
+	pbm->busn.start = pbm->pci_first_busno;
+	pbm->busn.end	= pbm->pci_last_busn;
+	pbm->busn.flags	= IORESOURCE_BUS;
+	pci_add_resource(&resources, &pbm->busn);
 	bus = pci_create_root_bus(parent, pbm->pci_first_busno, pbm->pci_ops,
 				  pbm, &resources);
 	if (!bus) {
@@ -693,8 +697,6 @@ struct pci_bus * __devinit pci_scan_one_pbm(struct pci_pbm_info *pbm,
 		pci_free_resource_list(&resources);
 		return NULL;
 	}
-	bus->busn_res.start = pbm->pci_first_busno;
-	bus->busn_res.end = pbm->pci_last_busno;
 
 	pci_of_scan_bus(pbm, node, bus);
 	pci_bus_add_devices(bus);
diff --git a/arch/sparc/kernel/pci_impl.h b/arch/sparc/kernel/pci_impl.h
index 6beb60d..918a203 100644
--- a/arch/sparc/kernel/pci_impl.h
+++ b/arch/sparc/kernel/pci_impl.h
@@ -97,6 +97,7 @@ struct pci_pbm_info {
 	/* PBM I/O and Memory space resources. */
 	struct resource			io_space;
 	struct resource			mem_space;
+	struct resource			busn;
 
 	/* Base of PCI Config space, can be per-PBM or shared. */
 	unsigned long			config_space;
-- 
1.7.7

