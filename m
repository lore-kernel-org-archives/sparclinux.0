From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Thu, 31 May 2012 18:33:35 +0000
Subject: [PATCH] silo: include stddef.h in stringops.h
Message-Id: <1338489215-2047-1-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I recompiled toolchain/glibc/everything from scratch against Linux 3.4
headers and silo won't compile anymore:

	file.c:60:5: error: 'NULL' undeclared here (not in a function)
	fs/ext2.c:401:7: error: 'NULL' undeclared (first use in this function)
	fs/isofs.c:57:45: error: 'NULL' undeclared (first use in this function)
	etc.

Fix by including stddef.h.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 include/stringops.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/stringops.h b/include/stringops.h
index 9973485..4fca34f 100644
--- a/include/stringops.h
+++ b/include/stringops.h
@@ -2,6 +2,7 @@
 #define __STRINGOPS_H
 
 #include <silo.h>
+#include <stddef.h>
 
 /* common */
 #ifndef __SIZE_TYPE__
-- 
1.7.2.5

