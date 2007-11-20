From: Cyrill Gorcunov <gorcunov@gmail.com>
Date: Tue, 20 Nov 2007 17:28:33 +0000
Subject: [PATCH] SPARC64: check for possible NULL pointer dereference
Message-Id: <20071120172833.GB7275@cvg>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: LKML <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

From: Cyrill Gorcunov <gorcunov@gmail.com>

This patch adds checking for possible NULL pointer dereference
if of_find_property() failed.

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
I'm not sure about the message being printed in worst case.
Check please.

 arch/sparc64/kernel/pci_sun4v.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/sparc64/kernel/pci_sun4v.c b/arch/sparc64/kernel/pci_sun4v.c
index 8c4875b..e587a37 100644
--- a/arch/sparc64/kernel/pci_sun4v.c
+++ b/arch/sparc64/kernel/pci_sun4v.c
@@ -1022,6 +1022,10 @@ void __init sun4v_pci_init(struct device_node *dp, char *model_name)
 	}
 
 	prop = of_find_property(dp, "reg", NULL);
+	if (!prop) {
+		prom_printf("SUN4V_PCI: Could not find config registers\n");
+		prom_halt();
+	}
 	regs = prop->value;
 
 	devhandle = (regs->phys_addr >> 32UL) & 0x0fffffff;
