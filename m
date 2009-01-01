From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 01 Jan 2009 20:03:07 +0000
Subject: [PATCH 4/7] sparc: remove linux_prom_pci_assigned_addresses from openprom_32.h
Message-Id: <1230840190-31884-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

It is not used anywhere in the tree so drop it.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/openprom_32.h |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/include/asm/openprom_32.h b/arch/sparc/include/asm/openprom_32.h
index 3868057..f8b4bf7 100644
--- a/arch/sparc/include/asm/openprom_32.h
+++ b/arch/sparc/include/asm/openprom_32.h
@@ -229,16 +229,6 @@ struct linux_prom_pci_ranges {
 	unsigned int size_lo;
 };
 
-struct linux_prom_pci_assigned_addresses {
-	unsigned int which_io;
-
-	unsigned int phys_hi;
-	unsigned int phys_lo;
-
-	unsigned int size_hi;
-	unsigned int size_lo;
-};
-
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(__SPARC_OPENPROM_H) */
-- 
1.6.0.2.GIT

