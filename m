From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 04:06:43 +0000
Subject: [PATCH] sparc32: Stop warning about sun4/sun4c in SMP Kconfig option.
Message-Id: <20120512.000643.482852627252752627.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 6335849..871de4e 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -150,7 +150,7 @@ source "kernel/Kconfig.freezer"
 menu "Processor type and features"
 
 config SMP
-	bool "Symmetric multi-processing support (does not work on sun4/sun4c)"
+	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
 	  a system with only one CPU, say N. If you have a system with more
-- 
1.7.10

