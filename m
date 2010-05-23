From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Sun, 23 May 2010 20:02:09 +0000
Subject: [PATCH 182/199] arch/sparc/lib/muldi3.S: Checkpatch cleanup
Message-Id: <1274644930-26600-25-git-send-email-andrea.gelmini@gelma.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

arch/sparc/lib/muldi3.S:75: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/sparc/lib/muldi3.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/lib/muldi3.S b/arch/sparc/lib/muldi3.S
index 7f17872..ec55789 100644
--- a/arch/sparc/lib/muldi3.S
+++ b/arch/sparc/lib/muldi3.S
@@ -72,5 +72,5 @@ __muldi3:
 	add  %l0, %o0, %l0
 	mov  %l2, %i0
 	add  %l2, %l0, %i0
-	ret 
+	ret
 	restore  %g0, %l3, %o1
-- 
1.7.1.251.gf80a2

