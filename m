From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 01 Jan 2009 20:03:06 +0000
Subject: [PATCH 3/7] sparc: remove ebus definitions from openprom*.h
Message-Id: <1230840190-31884-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Looks like leftovers from the removal of the special ebus layer.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/openprom_32.h |   11 -----------
 arch/sparc/include/asm/openprom_64.h |   26 --------------------------
 2 files changed, 0 insertions(+), 37 deletions(-)

diff --git a/arch/sparc/include/asm/openprom_32.h b/arch/sparc/include/asm/openprom_32.h
index 875da35..3868057 100644
--- a/arch/sparc/include/asm/openprom_32.h
+++ b/arch/sparc/include/asm/openprom_32.h
@@ -239,17 +239,6 @@ struct linux_prom_pci_assigned_addresses {
 	unsigned int size_lo;
 };
 
-struct linux_prom_ebus_ranges {
-	unsigned int child_phys_hi;
-	unsigned int child_phys_lo;
-
-	unsigned int parent_phys_hi;
-	unsigned int parent_phys_mid;
-	unsigned int parent_phys_lo;
-
-	unsigned int size;
-};
-
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(__SPARC_OPENPROM_H) */
diff --git a/arch/sparc/include/asm/openprom_64.h b/arch/sparc/include/asm/openprom_64.h
index b69e4a8..955d7f6 100644
--- a/arch/sparc/include/asm/openprom_64.h
+++ b/arch/sparc/include/asm/openprom_64.h
@@ -249,32 +249,6 @@ struct linux_prom_pci_intmask {
 	unsigned int interrupt;
 };
 
-struct linux_prom_ebus_ranges {
-	unsigned int child_phys_hi;
-	unsigned int child_phys_lo;
-
-	unsigned int parent_phys_hi;
-	unsigned int parent_phys_mid;
-	unsigned int parent_phys_lo;
-
-	unsigned int size;
-};
-
-struct linux_prom_ebus_intmap {
-	unsigned int phys_hi;
-	unsigned int phys_lo;
-
-	unsigned int interrupt;
-
-	int          cnode;
-	unsigned int cinterrupt;
-};
-
-struct linux_prom_ebus_intmask {
-	unsigned int phys_hi;
-	unsigned int phys_lo;
-	unsigned int interrupt;
-};
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(__SPARC64_OPENPROM_H) */
-- 
1.6.0.2.GIT

