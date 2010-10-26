From: Namhyung Kim <namhyung@gmail.com>
Date: Tue, 26 Oct 2010 15:51:43 +0000
Subject: [PATCH] sparc32: make CONFIG_SPARC_LEON depends on !SMP to fix build failure
Message-Id: <1288108303-2712-1-git-send-email-namhyung@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

  CC      arch/sparc/kernel/irq_32.o
arch/sparc/kernel/irq_32.c: In function 'request_fast_irq':
arch/sparc/kernel/irq_32.c:370:25: error: conflicting types for 'trapbase_cpu1'
arch/sparc/include/asm/leon.h:366:22: note: previous declaration of 'trapbase_cpu1' was here
arch/sparc/kernel/irq_32.c:370:40: error: conflicting types for 'trapbase_cpu2'
arch/sparc/include/asm/leon.h:367:22: note: previous declaration of 'trapbase_cpu2' was here
arch/sparc/kernel/irq_32.c:370:55: error: conflicting types for 'trapbase_cpu3'
arch/sparc/include/asm/leon.h:368:22: note: previous declaration of 'trapbase_cpu3' was here
make[3]: *** [arch/sparc/kernel/irq_32.o] Error 1
make[2]: *** [arch/sparc/kernel] Error 2
make[1]: *** [sub-make] Error 2
make: *** [all] Error 2

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 arch/sparc/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 4db8bc0..a6685ba 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -463,7 +463,7 @@ config SERIAL_CONSOLE
 
 config SPARC_LEON
 	bool "Sparc Leon processor family"
-	depends on SPARC32
+	depends on SPARC32 && !SMP
 	---help---
 	  If you say Y here if you are running on a SPARC-LEON processor.
 	  The LEON processor is a synthesizable VHDL model of the
-- 
1.7.0.4

