From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2008 21:49:10 +0000
Subject: [PATCH 11/16]: sparc64: Fix sparse warnings in pci_sun4v.c
Message-Id: <20080912.144910.123751085.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Fix sparse warnings in pci_sun4v.c

'err' variable shadowing in pci_sun4v_probe()

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/pci_sun4v.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc64/kernel/pci_sun4v.c b/arch/sparc64/kernel/pci_sun4v.c
index 97a77bc..e86c73e 100644
--- a/arch/sparc64/kernel/pci_sun4v.c
+++ b/arch/sparc64/kernel/pci_sun4v.c
@@ -942,9 +942,9 @@ static int __devinit pci_sun4v_probe(struct of_device *op,
 	dp = op->node;
 
 	if (!hvapi_negotiated++) {
-		int err = sun4v_hvapi_register(HV_GRP_PCI,
-					       vpci_major,
-					       &vpci_minor);
+		err = sun4v_hvapi_register(HV_GRP_PCI,
+					   vpci_major,
+					   &vpci_minor);
 
 		if (err) {
 			printk(KERN_ERR PFX "Could not register hvapi, "
-- 
1.5.6.5.GIT

