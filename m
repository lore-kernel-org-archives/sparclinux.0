From: Kamal Mostafa <kamal@canonical.com>
Date: Thu, 06 Nov 2014 22:35:18 +0000
Subject: [PATCH 3.13 054/162] sparc64: Increase size of boot string to 1024 bytes
Message-Id: <1415313426-9622-55-git-send-email-kamal@canonical.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1415313426-9622-1-git-send-email-kamal@canonical.com>
In-Reply-To: <1415313426-9622-1-git-send-email-kamal@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@lists.ubuntu.com
Cc: Dave Kleikamp <dave.kleikamp@oracle.com>, Bob Picco <bob.picco@oracle.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Kamal Mostafa <kamal@canonical.com>

3.13.11.11 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Kleikamp <dave.kleikamp@oracle.com>

[ Upstream commit 1cef94c36bd4d79b5ae3a3df99ee0d76d6a4a6dc ]

This is the longest boot string that silo supports.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Bob Picco <bob.picco@oracle.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/sparc/prom/bootstr_64.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/prom/bootstr_64.c b/arch/sparc/prom/bootstr_64.c
index ab9ccc6..7149e77 100644
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
1.9.1

