From: David Miller <davem@davemloft.net>
Date: Tue, 15 May 2012 18:37:42 +0000
Subject: [PATCH 1/2] sparc32: Build kernel with -mcpu=v8
Message-Id: <20120515.143742.1000570384829862813.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


With Cypress gone we can generate real hardware integer multiply
and divide instructions at will.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 7e8040b..23f17d1 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -30,7 +30,7 @@ export BITS    := 32
 UTS_MACHINE    := sparc
 
 #KBUILD_CFLAGS += -g -pipe -fcall-used-g5 -fcall-used-g7
-KBUILD_CFLAGS += -m32 -mcpu=v7 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
+KBUILD_CFLAGS += -m32 -mcpu=v8 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
 KBUILD_AFLAGS += -m32 -Wa,-Av8
 
 else
-- 
1.7.10

