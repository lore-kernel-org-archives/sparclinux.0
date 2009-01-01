From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 01 Jan 2009 22:40:27 +0000
Subject: [PATCH 1/4] sparc: fix warning in userspace header jsflash.h
Message-Id: <1230849630-22482-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings in jsflash.h:

jsflash.h:11: include of <linux/types.h> is preferred over <asm/types.h>
jsflash.h:24: found __[us]{8,16,32,64} type without #include <linux/types.h>

Fixed by changing the include to <linux/types.h>

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/jsflash.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/include/asm/jsflash.h b/arch/sparc/include/asm/jsflash.h
index 3457f29..0717d9e 100644
--- a/arch/sparc/include/asm/jsflash.h
+++ b/arch/sparc/include/asm/jsflash.h
@@ -8,7 +8,7 @@
 #define _SPARC_JSFLASH_H
 
 #ifndef _SPARC_TYPES_H
-#include <asm/types.h>
+#include <linux/types.h>
 #endif
 
 /*
-- 
1.6.0.2.GIT

