From: Joe Perches <joe@perches.com>
Date: Tue, 20 Nov 2007 01:47:58 +0000
Subject: [PATCH 06/59] arch/sparc: Add missing "space"
Message-Id: <afdfa525934b9dada1a5b7b459486d923dc0e780.1195454434.git.joe@perches.com>
List-Id: <sparclinux.vger.kernel.org>
References: 1234567
 <1195523331-15303-1-git-send-email-joe@perches.com>
 <1195523331-15303-2-git-send-email-joe@perches.com>
 <1195523331-15303-3-git-send-email-joe@perches.com>
 <1195523331-15303-4-git-send-email-joe@perches.com>
 <1195523331-15303-5-git-send-email-joe@perches.com>
 <1195523331-15303-6-git-send-email-joe@perches.com>
In-Reply-To: <1195523331-15303-6-git-send-email-joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: "William L. Irwin" <wli@holomorphy.com>, sparclinux@vger.kernel.org


Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/sparc/kernel/pcic.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index f2d432e..396718b 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -329,7 +329,7 @@ int __init pcic_probe(void)
 	pcic->pcic_res_cfg_addr.name = "pcic_cfg_addr";
 	if ((pcic->pcic_config_space_addr  	    ioremap(regs[2].phys_addr, regs[2].reg_size * 2)) = 0) {
-		prom_printf("PCIC: Error, cannot map" 
+		prom_printf("PCIC: Error, cannot map " 
 			    "PCI Configuration Space Address.\n");
 		prom_halt();
 	}
@@ -341,7 +341,7 @@ int __init pcic_probe(void)
 	pcic->pcic_res_cfg_data.name = "pcic_cfg_data";
 	if ((pcic->pcic_config_space_data  	    ioremap(regs[3].phys_addr, regs[3].reg_size * 2)) = 0) {
-		prom_printf("PCIC: Error, cannot map" 
+		prom_printf("PCIC: Error, cannot map " 
 			    "PCI Configuration Space Data.\n");
 		prom_halt();
 	}
@@ -518,8 +518,8 @@ static void pcic_map_pci_device(struct linux_pcic *pcic,
 				 * board in a PCI slot. We must remap it
 				 * under 64K but it is not done yet. XXX
 				 */
-				printk("PCIC: Skipping I/O space at 0x%lx,"
-				    "this will Oops if a driver attaches;"
+				printk("PCIC: Skipping I/O space at 0x%lx, "
+				    "this will Oops if a driver attaches "
 				    "device '%s' at %02x:%02x)\n", address,
 				    namebuf, dev->bus->number, dev->devfn);
 			}
-- 
1.5.3.5.652.gf192c

