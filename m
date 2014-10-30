From: Jiri Slaby <jslaby@suse.cz>
Date: Thu, 30 Oct 2014 23:04:22 +0000
Subject: [patch added to the 3.12 stable tree] sparc64: Increase size of boot string to 1024 bytes
Message-Id: <1414710316-25911-36-git-send-email-jslaby@suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1398671260-9435-50-git-send-email-jslaby@suse.cz>
In-Reply-To: <1398671260-9435-50-git-send-email-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dave Kleikamp <dave.kleikamp@oracle.com>

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

=======
[ Upstream commit 1cef94c36bd4d79b5ae3a3df99ee0d76d6a4a6dc ]

This is the longest boot string that silo supports.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Bob Picco <bob.picco@oracle.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/prom/bootstr_64.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/prom/bootstr_64.c b/arch/sparc/prom/bootstr_64.c
index ab9ccc63b388..7149e77714a4 100644
--- a/arch/sparc/prom/bootstr_64.c
+++ b/arch/sparc/prom/bootstr_64.c
@@ -14,7 +14,10 @@
  *          the .bss section or it will break things.
  */
 
-#define BARG_LEN  256
+/* We limit BARG_LEN to 1024 because this is the size of the
+ * 'barg_out' command line buffer in the SILO bootloader.
+ */
+#define BARG_LEN 1024
 struct {
 	int bootstr_len;
 	int bootstr_valid;
-- 
2.1.2

