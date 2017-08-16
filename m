From: Tushar Dave <tushar.n.dave@oracle.com>
Date: Wed, 16 Aug 2017 18:09:10 +0000
Subject: [PATCH] sparc64: remove unnecessary log message
Message-Id: <1502906950-20710-1-git-send-email-tushar.n.dave@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

There is no need to log message if ATU hvapi couldn't get register.
Unlike PCI hvapi, ATU hvapi registration failure is not hard error.
Even if ATU hvapi registration fails (on system with ATU or without
ATU) system continues with legacy IOMMU. So only log message when
ATU hvapi successfully get registered.

Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
---
 arch/sparc/kernel/pci_sun4v.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index f10e2f7..9ebebf1 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -1266,8 +1266,6 @@ static int pci_sun4v_probe(struct platform_device *op)
 			 * ATU group, but ATU hcalls won't be available.
 			 */
 			hv_atu = false;
-			pr_err(PFX "Could not register hvapi ATU err=%d\n",
-			       err);
 		} else {
 			pr_info(PFX "Registered hvapi ATU major[%lu] minor[%lu]\n",
 				vatu_major, vatu_minor);
-- 
1.9.1

