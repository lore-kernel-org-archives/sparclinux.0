From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 May 2014 21:25:56 +0000
Subject: [PATCH 18/34] sparc64: fix sparse warning in prom_64.c
Message-Id: <1400275572-17424-18-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1399157559-19901-18-git-send-email-sam@ravnborg.org>
In-Reply-To: <1399157559-19901-18-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warning:
prom_64.c:376:6: warning: symbol 'arch_find_n_match_cpu_physical_id' was not declared. Should it be static?

Add missing include to pick up prototype.
Rearrange includes to use the inverse christmas tree structure.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/prom_64.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index 9a690d3..20cc5d8 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -15,11 +15,12 @@
  *      2 of the License, or (at your option) any later version.
  */
 
+#include <linux/memblock.h>
 #include <linux/kernel.h>
-#include <linux/types.h>
 #include <linux/string.h>
+#include <linux/types.h>
+#include <linux/cpu.h>
 #include <linux/mm.h>
-#include <linux/memblock.h>
 #include <linux/of.h>
 
 #include <asm/prom.h>
-- 
1.9.0

