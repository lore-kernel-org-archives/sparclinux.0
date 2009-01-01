From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 01 Jan 2009 22:40:28 +0000
Subject: [PATCH 2/4] sparc: fix warnings in userspace header byteorder.h
Message-Id: <1230849630-22482-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings in byteorder.h:

byteorder.h:4: include of <linux/types.h> is preferred over <asm/types.h>
byteorder.h:9: leaks CONFIG_SPARC32 to userspace where it is not valid
byteorder.h:13: leaks CONFIG_SPARC64 to userspace where it is not valid
byteorder.h:14: found __[us]{8,16,32,64} type without #include <linux/types.h>
byteorder.h:47: leaks CONFIG_SPARC64 to userspace where it is not valid

- changed to use include <linux/types.h> as suggested
- use preprocessor defined symbols to distingush between 32 and 64 bit

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/byteorder.h |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/include/asm/byteorder.h b/arch/sparc/include/asm/byteorder.h
index 5a70f13..738414b 100644
--- a/arch/sparc/include/asm/byteorder.h
+++ b/arch/sparc/include/asm/byteorder.h
@@ -1,16 +1,12 @@
 #ifndef _SPARC_BYTEORDER_H
 #define _SPARC_BYTEORDER_H
 
-#include <asm/types.h>
+#include <linux/types.h>
 #include <asm/asi.h>
 
 #define __BIG_ENDIAN
 
-#ifdef CONFIG_SPARC32
-#define __SWAB_64_THRU_32__
-#endif
-
-#ifdef CONFIG_SPARC64
+#if defined(__sparc__) && defined(__arch64__)
 static inline __u16 __arch_swab16p(const __u16 *addr)
 {
 	__u16 ret;
@@ -44,7 +40,9 @@ static inline __u64 __arch_swab64p(const __u64 *addr)
 }
 #define __arch_swab64p __arch_swab64p
 
-#endif /* CONFIG_SPARC64 */
+#else
+#define __SWAB_64_THRU_32__
+#endif /* defined(__sparc__) && defined(__arch64__) */
 
 #include <linux/byteorder.h>
 
-- 
1.6.0.2.GIT

