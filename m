From: Kamal Mostafa <kamal@canonical.com>
Date: Fri, 31 Oct 2014 20:53:32 +0000
Subject: [3.13.y.z extended stable] Patch "sparc64: Increase size of boot string to 1024 bytes" has been adde
Message-Id: <1414788812-9541-1-git-send-email-kamal@canonical.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1414788806-8595-1-git-send-email-kamal@canonical.com>
In-Reply-To: <1414788806-8595-1-git-send-email-kamal@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is a note to let you know that I have just added a patch titled

    sparc64: Increase size of boot string to 1024 bytes

to the linux-3.13.y-queue branch of the 3.13.y.z extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.13.y-queue

This patch is scheduled to be released in version 3.13.11.11.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.13.y.z tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Kamal

------

From 07ddd13795fdf9df079583c3f5c7051f4453b2ae Mon Sep 17 00:00:00 2001
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Tue, 7 Oct 2014 08:12:37 -0500
Subject: sparc64: Increase size of boot string to 1024 bytes

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

