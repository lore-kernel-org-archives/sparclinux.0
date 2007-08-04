From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Sat, 04 Aug 2007 20:30:05 +0000
Subject: [PATCH] sparc: fix fallout from O_CLOEXEC changes
Message-Id: <20070804203005.GA7668@martell.zuzino.mipt.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Just "#define O_CLOEXEC" is OK, because asm-generic/fcntl.h will check if it's
already defined.

Loads of "struct flock inside parameter list" warnings and
"O_WRONLY undefined" errors.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/asm-sparc/fcntl.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/asm-sparc/fcntl.h
+++ b/include/asm-sparc/fcntl.h
@@ -32,5 +32,6 @@
 #define __ARCH_FLOCK_PAD	short __unused;
 #define __ARCH_FLOCK64_PAD	short __unused;
 
+#include <asm-generic/fcntl.h>
 
 #endif

