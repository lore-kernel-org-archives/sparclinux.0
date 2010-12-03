From: David Miller <davem@davemloft.net>
Date: Fri, 03 Dec 2010 18:40:45 +0000
Subject: [PATCH 1/9] sparc64: Delete prom_puts() unused.
Message-Id: <20101203.104045.200361218.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/prom/console_64.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/prom/console_64.c b/arch/sparc/prom/console_64.c
index 10322dc..de67fc7 100644
--- a/arch/sparc/prom/console_64.c
+++ b/arch/sparc/prom/console_64.c
@@ -81,19 +81,3 @@ prom_putchar(char c)
 {
 	prom_nbputchar(c);
 }
-
-void
-prom_puts(const char *s, int len)
-{
-	unsigned long args[7];
-
-	args[0] = (unsigned long) "write";
-	args[1] = 3;
-	args[2] = 1;
-	args[3] = (unsigned int) prom_stdout;
-	args[4] = (unsigned long) s;
-	args[5] = len;
-	args[6] = (unsigned long) -1;
-
-	p1275_cmd_direct(args);
-}
-- 
1.7.3.2

