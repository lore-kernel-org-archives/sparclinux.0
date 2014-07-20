From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 Jul 2014 11:39:01 +0000
Subject: [PATCH 4/6] sparc64: drop unused SLOW_DOWN_IO definitions
Message-Id: <1405856343-3762-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

They are no longer used.
All hits in the kernel are essential unused code or comments

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/io_64.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index 7db75eb..6df9743 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -9,10 +9,6 @@
 #include <asm/asi.h>
 #include <asm-generic/pci_iomap.h>
 
-/* PC crapola... */
-#define __SLOW_DOWN_IO	do { } while (0)
-#define SLOW_DOWN_IO	do { } while (0)
-
 /* BIO layer definitions. */
 extern unsigned long kern_base, kern_size;
 
-- 
1.9.3

