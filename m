From: David Miller <davem@davemloft.net>
Date: Sat, 17 May 2014 18:29:43 +0000
Subject: [PATCH] sparc64: Add membar to Niagara2 memcpy code.
Message-Id: <20140517.142943.1796322674669418101.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This is the prevent previous stores from overlapping the block stores
done by the memcpy loop.

Based upon a glibc patch by Jose E. Marchesi

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/lib/NG2memcpy.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/lib/NG2memcpy.S b/arch/sparc/lib/NG2memcpy.S
index 2c20ad6..30eee6e 100644
--- a/arch/sparc/lib/NG2memcpy.S
+++ b/arch/sparc/lib/NG2memcpy.S
@@ -236,6 +236,7 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	 */
 	VISEntryHalf
 
+	membar		#Sync
 	alignaddr	%o1, %g0, %g0
 
 	add		%o1, (64 - 1), %o4
-- 
1.8.1.2

