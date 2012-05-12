From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 22:20:57 +0000
Subject: [PATCH] sparc32: Pass -mcpu=v7 explicitly to gcc.
Message-Id: <20120512.182057.119046891010844835.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


We should be agnostic to what gcc happens to be generating by default.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index eddcfb3..cd2afcc 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -30,7 +30,7 @@ export BITS    := 32
 UTS_MACHINE    := sparc
 
 #KBUILD_CFLAGS += -g -pipe -fcall-used-g5 -fcall-used-g7
-KBUILD_CFLAGS += -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
+KBUILD_CFLAGS += -m32 -mcpu=v7 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
 KBUILD_AFLAGS += -m32 -Wa,-Av8
 
 #LDFLAGS_vmlinux = -N -Ttext 0xf0004000
-- 
1.7.10

