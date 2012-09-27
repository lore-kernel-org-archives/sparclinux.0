From: David Miller <davem@davemloft.net>
Date: Thu, 27 Sep 2012 21:32:03 +0000
Subject: [PATCH] sparc64: Fix comment type in NG4 copy from user.
Message-Id: <20120927.173203.141050116559010991.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Noticed by Greg Onufer.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/lib/NG4copy_from_user.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/lib/NG4copy_from_user.S b/arch/sparc/lib/NG4copy_from_user.S
index c8e9830..fd9f903 100644
--- a/arch/sparc/lib/NG4copy_from_user.S
+++ b/arch/sparc/lib/NG4copy_from_user.S
@@ -1,4 +1,4 @@
-/* NG4copy_from_user.S: Niagara-2 optimized copy from userspace.
+/* NG4copy_from_user.S: Niagara-4 optimized copy from userspace.
  *
  * Copyright (C) 2012 David S. Miller (davem@davemloft.net)
  */
-- 
1.7.10.4

