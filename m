From: David Miller <davem@davemloft.net>
Date: Mon, 19 Apr 2010 08:31:49 +0000
Subject: [PATCH] sparc64: Fix PREEMPT_ACTIVE value.
Message-Id: <20100419.013149.102562663.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


It currently overlaps the NMI bit.

Signed-off-by: David S. Miller <davem@davemloft.net>
---

I noticed this while auditing some other things.

 arch/sparc/include/asm/thread_info_64.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
index 9e2d944..4827a3a 100644
--- a/arch/sparc/include/asm/thread_info_64.h
+++ b/arch/sparc/include/asm/thread_info_64.h
@@ -111,7 +111,7 @@ struct thread_info {
 #define THREAD_SHIFT PAGE_SHIFT
 #endif /* PAGE_SHIFT = 13 */
 
-#define PREEMPT_ACTIVE		0x4000000
+#define PREEMPT_ACTIVE		0x10000000
 
 /*
  * macros/functions for gaining access to the thread information structure
-- 
1.7.0.4

