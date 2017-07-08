From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Sat, 08 Jul 2017 20:23:43 +0000
Subject: [PATCH 1/2] sparc64: Add a new hypercall CPU_POKE
Message-Id: <1499545424-415240-2-git-send-email-vijay.ac.kumar@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1499545424-415240-1-git-send-email-vijay.ac.kumar@oracle.com>
In-Reply-To: <1499545424-415240-1-git-send-email-vijay.ac.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, sparclinux@vger.kernel.org
Cc: rob.gardner@oracle.com, anthony.yznaga@oracle.com, linux-kernel@vger.kernel.org

This adds a new hypercall CPU_POKE for quickly waking up an idle CPU.
CPU POKE should only be sent to valid  non-local CPUs.

Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/sparc/include/asm/hypervisor.h |   18 ++++++++++++++++++
 arch/sparc/kernel/hvcalls.S         |   11 +++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/hypervisor.h b/arch/sparc/include/asm/hypervisor.h
index 73cb897..3dc9215 100644
--- a/arch/sparc/include/asm/hypervisor.h
+++ b/arch/sparc/include/asm/hypervisor.h
@@ -298,6 +298,24 @@ unsigned long sun4v_cpu_start(unsigned long cpuid,
 unsigned long sun4v_cpu_yield(void);
 #endif
 
+/* cpu_poke()
+ * TRAP:	HV_FAST_TRAP
+ * FUNCTION:	HV_FAST_CPU_POKE
+ * RET0:	status
+ * ERRORS:	ENOCPU		cpuid refers to a CPU that does not exist
+ *		EINVAL		cpuid is current CPU
+ *
+ * Poke CPU cpuid. If the target CPU is currently suspended having
+ * invoked the cpu-yield service, that vCPU will be resumed.
+ * Poke interrupts may only be sent to valid, non-local CPUs.
+ * It is not legal to poke the current vCPU.
+ */
+#define HV_FAST_CPU_POKE                0x13
+
+#ifndef __ASSEMBLY__
+unsigned long sun4v_cpu_poke(unsigned long cpuid);
+#endif
+
 /* cpu_qconf()
  * TRAP:	HV_FAST_TRAP
  * FUNCTION:	HV_FAST_CPU_QCONF
diff --git a/arch/sparc/kernel/hvcalls.S b/arch/sparc/kernel/hvcalls.S
index 4116ee5..e57007f 100644
--- a/arch/sparc/kernel/hvcalls.S
+++ b/arch/sparc/kernel/hvcalls.S
@@ -106,6 +106,17 @@ ENTRY(sun4v_cpu_yield)
 	 nop
 ENDPROC(sun4v_cpu_yield)
 
+	/* %o0: cpuid
+	 *
+	 * returns %o0:	status
+	 */
+ENTRY(sun4v_cpu_poke)
+	mov     HV_FAST_CPU_POKE, %o5
+	ta      HV_FAST_TRAP
+	retl
+	 nop
+ENDPROC(sun4v_cpu_poke)
+
 	/* %o0:	type
 	 * %o1:	queue paddr
 	 * %o2:	num queue entries
-- 
1.7.1

