From: Yinghai Lu <yinghai@kernel.org>
Date: Fri, 24 Feb 2012 10:18:55 +0000
Subject: [PATCH 07/23] PCI, sparc: Register busn_res for root buses
Message-Id: <1330078751-7299-8-git-send-email-yinghai@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1330078751-7299-1-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330078751-7299-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/pci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index bb8bc2e..83881df9 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -703,6 +703,7 @@ struct pci_bus * __devinit pci_scan_one_pbm(struct pci_pbm_info *pbm,
 	}
 	bus->secondary = pbm->pci_first_busno;
 	bus->subordinate = pbm->pci_last_busno;
+	pci_bus_insert_busn_res(bus, pbm->pci_first_busno, pbm->pci_last_busno);
 
 	pci_of_scan_bus(pbm, node, bus);
 	pci_bus_add_devices(bus);
-- 
1.7.7

