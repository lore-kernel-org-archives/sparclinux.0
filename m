From: David Miller <davem@davemloft.net>
Date: Sat, 06 Dec 2008 06:22:40 +0000
Subject: [PATCH]: Fix audit link errors on sparc32.
Message-Id: <20081205.222240.57715303.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I just pushed the following build fix to sparc-next-2.6

sparc: Always set AUDIT_ARCH, not just on sparc64.

Without fancy makefile rules it's not straightforward
to prevent both arch/sparc/kernel/audit.o and lib/audit.o
from both being used on sparc32.

Since arch/sparc/kernel/audit.c is identical to lib/audit.c
except some CONFIG_COMPAT protected sections of code, just
use it on sparc32 too as that's the simplest way to fix
this.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index ecb5ff9..c8c7738 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -85,7 +85,7 @@ config HAVE_LATENCYTOP_SUPPORT
 
 config AUDIT_ARCH
 	bool
-	default y if SPARC64
+	default y
 
 config HAVE_SETUP_PER_CPU_AREA
 	def_bool y if SPARC64
-- 
1.5.6.5

