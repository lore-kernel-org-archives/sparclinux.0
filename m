From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Tue, 07 Oct 2014 13:12:37 +0000
Subject: [PATCH] sparc64: Increase size of boot string to 1024 bytes
Message-Id: <5433E6C5.9060304@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is the longest boot string that silo supports.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Bob Picco <bob.picco@oracle.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/prom/bootstr_64.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/prom/bootstr_64.c b/arch/sparc/prom/bootstr_64.c
index ab9ccc6..4dac9f7 100644
--- a/arch/sparc/prom/bootstr_64.c
+++ b/arch/sparc/prom/bootstr_64.c
@@ -14,7 +14,11 @@
  *          the .bss section or it will break things.
  */
 
-#define BARG_LEN  256
+/*
+ * We limit BARG_LEN to 1024 rather than use COMMAND_LINE_SIZE because silo
+ * blindly copies however many bytes we tell it from a 1024-byte array.
+ */
+#define BARG_LEN 1024
 struct {
 	int bootstr_len;
 	int bootstr_valid;
-- 
2.1.2

