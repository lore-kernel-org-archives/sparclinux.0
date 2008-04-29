From: "Huang Weiyi" <hwy@cn.fujitsu.com>
Date: Tue, 29 Apr 2008 09:53:27 +0000
Subject: remove duplicated include
Message-Id: <004101c8a9de$df49f8e0$df8da70a@hwysdesktop>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Remove dulicated include file <asm/timer.h> in arch/sparc64/kernel/smp.c.

Signed-off-by: Huang Weiyi <hwy@cn.fujitsu.com>

--- a/arch/sparc64/kernel/smp.c 2008-04-29 15:34:08.000000000 +0800
+++ b/arch/sparc64/kernel/smp.c 2008-04-29 15:34:13.000000000 +0800
@@ -38,7 +38,6 @@
 #include <asm/pgtable.h>
 #include <asm/oplib.h>
 #include <asm/uaccess.h>
-#include <asm/timer.h>
 #include <asm/starfire.h>
 #include <asm/tlb.h>
 #include <asm/sections.h>


