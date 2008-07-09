From: Robert Reif <reif@earthlink.net>
Date: Wed, 09 Jul 2008 10:52:50 +0000
Subject: [PATCH] sparc32: fix init.c allnoconfig build error
Message-Id: <48749882.2040700@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070206080105070303060300"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------070206080105070303060300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix allnoconfig build error.

Signed-off-by: Robert Reif <reif@earthlink.net>

--------------070206080105070303060300
Content-Type: text/plain;
 name="init.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="init.diff.txt"

diff --git a/arch/sparc/mm/init.c b/arch/sparc/mm/init.c
index 7794ecb..a938467 100644
--- a/arch/sparc/mm/init.c
+++ b/arch/sparc/mm/init.c
@@ -22,6 +22,7 @@ #include <linux/initrd.h>
 #include <linux/init.h>
 #include <linux/highmem.h>
 #include <linux/bootmem.h>
+#include <linux/pagemap.h>
 
 #include <asm/system.h>
 #include <asm/vac-ops.h>

--------------070206080105070303060300--
