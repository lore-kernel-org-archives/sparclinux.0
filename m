From: Allen Pais <allen.pais@oracle.com>
Date: Mon, 23 Dec 2013 06:27:51 +0000
Subject: [PATCH 1/1] sparc64: allow forced irq threading
Message-Id: <1387779351-18409-1-git-send-email-allen.pais@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, bigeasy@linutronix.de, Allen Pais <allen.pais@oracle.com>

Forced irq threading is a prerequisite for RT.
The following patch enables this on the sparc architecture.

Signed-off-by: Allen Pais <allen.pais@oracle.com>
---
 arch/sparc/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 554995d..aae5aa9 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -27,6 +27,7 @@ config SPARC
 	select HAVE_DMA_API_DEBUG
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_GENERIC_HARDIRQS
+	select IRQ_FORCED_THREADING
 	select GENERIC_IRQ_SHOW
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select USE_GENERIC_SMP_HELPERS if SMP
-- 
1.7.10.4

