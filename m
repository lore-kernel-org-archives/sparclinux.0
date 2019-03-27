From: jagdsh.linux@gmail.com
Date: Wed, 27 Mar 2019 16:29:43 +0000
Subject: [PATCH] arch:sparc:kernel/uprobes.c : Remove duplicate header
Message-Id: <1553722125-38957-1-git-send-email-jagdsh.linux@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, paul.burton@mips.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Jagadeesh Pagadala <jagdsh.linux@gmail.com>

From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Remove duplicate header which is included twice.

Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
---
 arch/sparc/kernel/uprobes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/kernel/uprobes.c b/arch/sparc/kernel/uprobes.c
index d852ae5..c44bf5b 100644
--- a/arch/sparc/kernel/uprobes.c
+++ b/arch/sparc/kernel/uprobes.c
@@ -29,7 +29,6 @@
 #include <linux/kdebug.h>
 
 #include <asm/cacheflush.h>
-#include <linux/uaccess.h>
 
 /* Compute the address of the breakpoint instruction and return it.
  *
-- 
1.8.3.1
