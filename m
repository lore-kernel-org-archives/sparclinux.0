From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 May 2012 06:02:44 +0000
Subject: [PATCH 1/8] sparc64: renamed ttable.S to ttable_64.S
Message-Id: <1337493771-18535-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

To allow us to add ttable_32.S

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/head_64.S                 |    2 +-
 arch/sparc/kernel/{ttable.S => ttable_64.S} |    0
 2 files changed, 1 insertions(+), 1 deletions(-)
 rename arch/sparc/kernel/{ttable.S => ttable_64.S} (100%)

diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index 0d810c2..b42ddbf 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -906,7 +906,7 @@ swapper_4m_tsb:
 	 * error and will instead write junk into the relocation and
 	 * you'll have an unbootable kernel.
 	 */
-#include "ttable.S"
+#include "ttable_64.S"
 
 ! 0x0000000000428000
 
diff --git a/arch/sparc/kernel/ttable.S b/arch/sparc/kernel/ttable_64.S
similarity index 100%
rename from arch/sparc/kernel/ttable.S
rename to arch/sparc/kernel/ttable_64.S
-- 
1.6.0.6

