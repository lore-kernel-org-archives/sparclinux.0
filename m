From: Romain Francoise <romain@orebokech.com>
Date: Sun, 04 Apr 2004 19:17:49 +0000
Subject: [PATCH] 2.6.5 build fails on sparc64 in hugetlbpage.c
Message-Id: <87r7v3ft7m.fsf@orebokech.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Stock 2.6.5 does not compile on sparc64 because of akpm's change to
export hugetlb_total_pages: arch/sparc64/mm/hugetlbpage.c does not
include linux/module.h so EXPORT_SYMBOL prints out warnings, and since
sparc64 Makefiles have -Werror, the build fails.  Including module.h
fixes it.

Please apply,

diff -urN a/arch/sparc64/mm/hugetlbpage.c b/arch/sparc64/mm/hugetlbpage.c
--- a/arch/sparc64/mm/hugetlbpage.c	2004-04-04 21:03:15.000000000 +0200
+++ b/arch/sparc64/mm/hugetlbpage.c	2004-04-04 21:07:13.000000000 +0200
@@ -13,6 +13,7 @@
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
+#include <linux/module.h>
 
 #include <asm/mman.h>
 #include <asm/pgalloc.h>

-- 
Romain Francoise <romain@orebokech.com> | I know, you love the song but
it's a miracle -- http://orebokech.com/ | not the singer.
