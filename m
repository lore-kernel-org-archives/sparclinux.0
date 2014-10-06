From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Mon, 06 Oct 2014 16:06:27 +0000
Subject: [PATCH] sparc64: use COMMAND_LINE_SIZE for boot string
Message-Id: <5432BE03.10405@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

sparc64 defines COMMAND_LINE_SIZE to be 2048, but the boot string is
hard-coded to be 256 bytes long.

based on a patch by Bob Picco

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Bob Picco <bob.picco@oracle.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/prom/bootstr_64.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/prom/bootstr_64.c b/arch/sparc/prom/bootstr_64.c
index ab9ccc6..4b9d73c 100644
--- a/arch/sparc/prom/bootstr_64.c
+++ b/arch/sparc/prom/bootstr_64.c
@@ -8,19 +8,19 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <asm/oplib.h>
+#include <asm/setup.h>
 
 /* WARNING: The boot loader knows that these next three variables come one right
  *          after another in the .data section.  Do not move this stuff into
  *          the .bss section or it will break things.
  */
 
-#define BARG_LEN  256
 struct {
 	int bootstr_len;
 	int bootstr_valid;
-	char bootstr_buf[BARG_LEN];
+	char bootstr_buf[COMMAND_LINE_SIZE];
 } bootstr_info = {
-	.bootstr_len = BARG_LEN,
+	.bootstr_len = COMMAND_LINE_SIZE,
 #ifdef CONFIG_CMDLINE
 	.bootstr_valid = 1,
 	.bootstr_buf = CONFIG_CMDLINE,
@@ -34,7 +34,7 @@ prom_getbootargs(void)
 	if (bootstr_info.bootstr_valid)
 		return bootstr_info.bootstr_buf;
 	prom_getstring(prom_chosen_node, "bootargs",
-		       bootstr_info.bootstr_buf, BARG_LEN);
+		       bootstr_info.bootstr_buf, COMMAND_LINE_SIZE);
 	bootstr_info.bootstr_valid = 1;
 	return bootstr_info.bootstr_buf;
 }
-- 
2.1.2

