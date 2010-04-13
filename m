From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Tue, 13 Apr 2010 18:59:24 +0000
Subject: [PATCH] sparc: Fix forgotten kmemleak headers inclusion
Message-Id: <1271185164-5958-1-git-send-regression-fweisbec@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

Fix forgotten kmemleak headers inclusion for kmemleak_not_leak()
declaration.

This fixes the following build error:

	arch/sparc/kernel/irq_64.c: In function ‘sun4v_build_virq’:
	arch/sparc/kernel/irq_64.c:657: error: implicit declaration of function ‘kmemleak_not_leak’

Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: David Miller <davem@davemloft.net>
---
 arch/sparc/kernel/irq_64.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 454ce3a..2b04c72 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -22,6 +22,7 @@
 #include <linux/seq_file.h>
 #include <linux/ftrace.h>
 #include <linux/irq.h>
+#include <linux/kmemleak.h>
 
 #include <asm/ptrace.h>
 #include <asm/processor.h>
-- 
1.6.2.3

