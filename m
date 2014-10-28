From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 28 Oct 2014 03:34:46 +0000
Subject: [PATCH 3.17 144/146] sparc64: Increase size of boot string to 1024 bytes
Message-Id: <20141028033349.710052855@linuxfoundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20141028033343.441992423@linuxfoundation.org>
In-Reply-To: <20141028033343.441992423@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Dave Kleikamp <dave.kleikamp@oracle.com>, Bob Picco <bob.picco@oracle.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

3.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Kleikamp <dave.kleikamp@oracle.com>

[ Upstream commit 1cef94c36bd4d79b5ae3a3df99ee0d76d6a4a6dc ]

This is the longest boot string that silo supports.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Bob Picco <bob.picco@oracle.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sparc/prom/bootstr_64.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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


