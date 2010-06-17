From: Dongdong Deng <dongdong.deng@windriver.com>
Date: Thu, 17 Jun 2010 06:58:26 +0000
Subject: [PATCH] sparc64: fix the build error due to smp_kgdb_capture_client()
Message-Id: <1276757906-8514-1-git-send-email-dongdong.deng@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Dongdong Deng <dongdong.deng@windriver.com>
---
 arch/sparc/kernel/ttable.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/ttable.S b/arch/sparc/kernel/ttable.S
index 76d837f..c6dfdaa 100644
--- a/arch/sparc/kernel/ttable.S
+++ b/arch/sparc/kernel/ttable.S
@@ -64,7 +64,7 @@ tl0_irq6:	TRAP_IRQ(smp_call_function_single_client, 6)
 tl0_irq6:	BTRAP(0x46)
 #endif
 tl0_irq7:	TRAP_IRQ(deferred_pcr_work_irq, 7)
-#ifdef CONFIG_KGDB
+#if defined(CONFIG_KGDB) && defined(CONFIG_SMP)
 tl0_irq8:	TRAP_IRQ(smp_kgdb_capture_client, 8)
 #else
 tl0_irq8:	BTRAP(0x48)
-- 
1.6.0.4

