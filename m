From: David Miller <davem@davemloft.net>
Date: Fri, 28 Sep 2012 20:14:06 +0000
Subject: [PATCH] sparc64: Fix trailing whitespace in NG4 memcpy.
Message-Id: <20120928.161406.41172325171375660.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---

I noticed this while integrating this memcpy into glibc.

 arch/sparc/lib/NG4memcpy.S |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/lib/NG4memcpy.S b/arch/sparc/lib/NG4memcpy.S
index 6f4b526..9cf2ee0 100644
--- a/arch/sparc/lib/NG4memcpy.S
+++ b/arch/sparc/lib/NG4memcpy.S
@@ -113,7 +113,7 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	and		%g1, 0x7, %g1
 	brz,pt		%g1, 51f
 	 sub		%o2, %g1, %o2
-	
+
 1:	EX_LD(LOAD(ldub, %o1 + 0x00, %g2))
 	add		%o1, 1, %o1
 	subcc		%g1, 1, %g1
@@ -143,7 +143,7 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	and		%g1, 0x3f, %g1
 	brz,pt		%g1, .Llarge_aligned
 	 sub		%o2, %g1, %o2
-	
+
 1:	EX_LD(LOAD(ldx, %o1 + 0x00, %g2))
 	add		%o1, 8, %o1
 	subcc		%g1, 8, %g1
@@ -287,7 +287,7 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	and		%g1, 0x7, %g1
 	brz,pt		%g1, 2f
 	 sub		%o2, %g1, %o2
-	
+
 1:	EX_LD(LOAD(ldub, %o1 + 0x00, %g2))
 	add		%o1, 1, %o1
 	subcc		%g1, 1, %g1
-- 
1.7.10.4

