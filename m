From: Allen Pais <allen.pais@oracle.com>
Date: Mon, 16 Dec 2013 04:19:31 +0000
Subject: [PATCH 1/3] sparc64: use generic rwsem spinlocks rt
Message-Id: <1387166853-10782-2-git-send-email-allen.pais@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1387166853-10782-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1387166853-10782-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, bigeasy@linutronix.de, Allen Pais <allen.pais@oracle.com>


Signed-off-by: Allen Pais <allen.pais@oracle.com>
---
 arch/sparc/Kconfig |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 6787bd3..554995d 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -179,12 +179,10 @@ config NR_CPUS
 source kernel/Kconfig.hz
 
 config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y if SPARC32
+	def_bool PREEMPT_RT_FULL
 
 config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default y if SPARC64
+	def_bool !RWSEM_GENERIC_SPINLOCK && !PREEMPT_RT_FULL
 
 config GENERIC_HWEIGHT
 	bool
-- 
1.7.10.4

