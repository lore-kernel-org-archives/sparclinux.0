From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Sat, 21 May 2016 12:10:19 +0000
Subject: [PATCH 0258/1529] Fix typo
Message-Id: <20160521121019.13530-1-andrea.gelmini@gelma.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/sparc/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 51aa6e8..47a394b 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -1121,7 +1121,7 @@ fpsave_magic:
 	retl
 	 std	%f30, [%o0 + 0x78]
 
-	/* Thanks for Theo Deraadt and the authors of the Sprite/netbsd/openbsd
+	/* Thanks for Theo Theo de Raadt and the authors of the Sprite/netbsd/openbsd
 	 * code for pointing out this possible deadlock, while we save state
 	 * above we could trap on the fsr store so our low level fpu trap
 	 * code has to know how to deal with this.
-- 
2.8.2.534.g1f66975

