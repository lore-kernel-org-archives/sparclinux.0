From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Thu, 13 Feb 2014 15:59:18 +0000
Subject: [PATCH] sparc: fix implicit include of slab.h in leon_pci_grpci2.c
Message-Id: <1392307158-6932-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Tejun Heo <tj@kernel.org>

To fix:

arch/sparc/kernel/leon_pci_grpci2.c: In function 'grpci2_of_probe':
arch/sparc/kernel/leon_pci_grpci2.c:720:2: error: implicit declaration of function 'kzalloc' [-Werror=implicit-function-declaration]
arch/sparc/kernel/leon_pci_grpci2.c:720:20: error: assignment makes pointer from integer without a cast [-Werror]
arch/sparc/kernel/leon_pci_grpci2.c:882:2: error: implicit declaration of function 'kfree' [-Werror=implicit-function-declaration]
cc1: all warnings being treated as errors
make[2]: *** [arch/sparc/kernel/leon_pci_grpci2.o] Error 1

According to Stephen, these types of failures are caused by
commit 2bd59d48ebfb ("cgroup: convert to kernfs") which was
being included implicitly via cgroup.h's inclusion of xattr.h
(which has now been removed).

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/sparc/kernel/leon_pci_grpci2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/kernel/leon_pci_grpci2.c b/arch/sparc/kernel/leon_pci_grpci2.c
index 5f0402aab7fb..24d6a4446349 100644
--- a/arch/sparc/kernel/leon_pci_grpci2.c
+++ b/arch/sparc/kernel/leon_pci_grpci2.c
@@ -8,6 +8,7 @@
 #include <linux/of_device.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <asm/io.h>
-- 
1.8.5.2

