From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 01 Jan 2009 20:03:09 +0000
Subject: [PATCH 6/7] sparc64: delete unused linux_prom64_ranges from openprom_64.h
Message-Id: <1230840190-31884-6-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

It was not used over the whole tree - so drop it.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/openprom_64.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/openprom_64.h b/arch/sparc/include/asm/openprom_64.h
index db3711e..8148900 100644
--- a/arch/sparc/include/asm/openprom_64.h
+++ b/arch/sparc/include/asm/openprom_64.h
@@ -203,12 +203,6 @@ struct linux_prom_ranges {
 	unsigned int or_size;
 };
 
-struct linux_prom64_ranges {
-	unsigned long ot_child_base;		/* Bus feels this */
-	unsigned long ot_parent_base;		/* CPU looks from here */
-	unsigned long or_size;
-};
-
 /* Ranges and reg properties are a bit different for PCI. */
 struct linux_prom_pci_registers {
 	unsigned int phys_hi;
-- 
1.6.0.2.GIT

