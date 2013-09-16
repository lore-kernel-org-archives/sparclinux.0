From: Bob Picco <bpicco@meloft.net>
Date: Mon, 16 Sep 2013 13:46:39 +0000
Subject: [PATCH 4/4] sparc64 kconfig four level page table
Message-Id: <1379339199-9388-5-git-send-email-bpicco@meloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: bob picco <bpicco@meloft.net>

This patch introduces the option to select either three level page table
support or four level page table support.

Signed-off-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/Kconfig |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index a00cbd3..1369dfe 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -264,6 +264,15 @@ config US3_MC
 
 	  If in doubt, say Y, as this information can be very useful.
 
+config SPARC_PGTABLE_LEVEL4
+	bool "Page Table Level"
+	depends on SPARC64 && SMP
+	help
+	  This enables sparc64 to access large physical memory
+	  configuration. For example consider 45 bits of physical address
+	  space (32 Tb).  This option might impact your performance
+	  in small memory configurations.
+
 # Global things across all Sun machines.
 config GENERIC_LOCKBREAK
 	bool
-- 
1.7.10.4

