From: Pravin Shedge <pravin.shedge4linux@gmail.com>
Date: Mon, 11 Dec 2017 20:46:56 +0000
Subject: [PATCH 45/45] arch/sparc: remove duplicate includes
Message-Id: <1513024496-9108-1-git-send-email-pravin.shedge4linux@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, eric.saint.etienne@oracle.com, allen.pais@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: pravin.shedge4linux@gmail.com

These duplicate includes have been found with scripts/checkincludes.pl but
they have been removed manually to avoid removing false positives.

Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
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
2.7.4

