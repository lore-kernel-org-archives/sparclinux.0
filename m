From: Ben Hutchings <ben@decadent.org.uk>
Date: Sun, 13 Nov 2011 07:20:04 +0000
Subject: [PATCH] sparc: sigutil: Include <linux/errno.h>
Message-Id: <1321168804.18929.277.camel@deadeye>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This file introduced in 2.6.32.47 currently fails to compile:

arch/sparc/kernel/sigutil_64.c: In function 'save_fpu_state':
arch/sparc/kernel/sigutil_64.c:25: error: 'EFAULT' undeclared (first use in this function)

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
I assume this works in 3.1 due to indirect inclusion of <linux/errno.h>,
but it doesn't in 2.6.32.  It might be worth applying this in mainline
anyway, to avoid that assumption.

Ben.

 arch/sparc/kernel/sigutil_64.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/sigutil_64.c b/arch/sparc/kernel/sigutil_64.c
index 6edc4e5..06a69b4 100644
--- a/arch/sparc/kernel/sigutil_64.c
+++ b/arch/sparc/kernel/sigutil_64.c
@@ -2,6 +2,7 @@
 #include <linux/types.h>
 #include <linux/thread_info.h>
 #include <linux/uaccess.h>
+#include <linux/errno.h>
 
 #include <asm/sigcontext.h>
 #include <asm/fpumacro.h>
-- 
1.7.7


