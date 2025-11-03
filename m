Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF4C2AF1D
	for <sparclinux@vger.kernel.org>; Mon,  3 Nov 2025 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182950; cv=none; b=ST9CV+wzVZpBRPfeh+TkAkIXR74w/WlZCi6HLTbA3W0MqmSiwe7+PLI5Q3zquJB7j44+Pwp+plAH8zBlSZGysete3vza2Z5h74qjDxZDSa/K0TVeUy8z4x0XfDm+/IBiW65Ysb4x+lb6g+Oh+zTCDK6R5JNvFhOk9/NdMeJZty0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182950; c=relaxed/simple;
	bh=44G8a2GZzhRVVeSk/JXNVi2F15GUoM86tidJD8Upqmw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DdENAAEVse+cbdsGFRdcTS/0RGntPYc/Y5kazCBgoYDfsKPgPtRXnPwZ4LmLIx1N74hcxqzXgfZJizH33iYkDcV10qksys1OUfJmxRunzHvANyFrpAIP9YavuY/pv31xVUsNjGf1IDGxuBD9qljLyCdNCO+iuOp0FoqxP3SedSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c8t5t0MX; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c8t5t0MX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762182945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yb/esUj6GdeeXz6LGdJzr7wPyPWeC/HrbBBzW4T/hI8=;
	b=c8t5t0MXglY5hVMNgnUBmjcnGV+L4mO68v/BHNrmFIt9VotkN+ER7iG/2SBB8QrkJX53mx
	TR5Z9lvDzGHiKcY4KfzMKoKfFwQM/s5O9IJHA46cI1lA0RYDPRrDZzLs2kQJCf7UeDM5xJ
	tU3/LOyYpvyfVsT6sP4v6KiaKXyDsVg=
From: Dawei Li <dawei.li@linux.dev>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dawei.li@linux.dev,
	set_pte_at@outlook.com,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH] sparc/smp: Remove on-stack cpumask var
Date: Mon,  3 Nov 2025 23:15:33 +0800
Message-Id: <20251103151533.175240-1-dawei.li@linux.dev>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Dawei Li <dawei.li@shingroup.cn>

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

- Change prototype of sparc32_ipi_ops::cross_call() so that it takes
  const cpumask * arg and all its callers accordingly.

- As for all cross_call() implementations, divide cpumask_test_cpu() call
  into several sub calls to avoid on-stack cpumask var.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
Signed-off-by: Dawei Li <dawei.li@linux.dev>
---
 arch/sparc/include/asm/smp_32.h | 12 ++++++------
 arch/sparc/kernel/kernel.h      | 11 +++++++++++
 arch/sparc/kernel/leon_smp.c    | 11 ++++-------
 arch/sparc/kernel/sun4d_smp.c   | 10 ++++------
 arch/sparc/kernel/sun4m_smp.c   | 10 ++++------
 5 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/arch/sparc/include/asm/smp_32.h b/arch/sparc/include/asm/smp_32.h
index 9c6ed98fbaf1..cba3dd83e45d 100644
--- a/arch/sparc/include/asm/smp_32.h
+++ b/arch/sparc/include/asm/smp_32.h
@@ -54,7 +54,7 @@ void smp_bogo(struct seq_file *);
 void smp_info(struct seq_file *);
 
 struct sparc32_ipi_ops {
-	void (*cross_call)(void *func, cpumask_t mask, unsigned long arg1,
+	void (*cross_call)(void *func, const cpumask_t *mask, unsigned long arg1,
 			   unsigned long arg2, unsigned long arg3,
 			   unsigned long arg4);
 	void (*resched)(int cpu);
@@ -65,29 +65,29 @@ extern const struct sparc32_ipi_ops *sparc32_ipi_ops;
 
 static inline void xc0(void *func)
 {
-	sparc32_ipi_ops->cross_call(func, *cpu_online_mask, 0, 0, 0, 0);
+	sparc32_ipi_ops->cross_call(func, cpu_online_mask, 0, 0, 0, 0);
 }
 
 static inline void xc1(void *func, unsigned long arg1)
 {
-	sparc32_ipi_ops->cross_call(func, *cpu_online_mask, arg1, 0, 0, 0);
+	sparc32_ipi_ops->cross_call(func, cpu_online_mask, arg1, 0, 0, 0);
 }
 static inline void xc2(void *func, unsigned long arg1, unsigned long arg2)
 {
-	sparc32_ipi_ops->cross_call(func, *cpu_online_mask, arg1, arg2, 0, 0);
+	sparc32_ipi_ops->cross_call(func, cpu_online_mask, arg1, arg2, 0, 0);
 }
 
 static inline void xc3(void *func, unsigned long arg1, unsigned long arg2,
 		       unsigned long arg3)
 {
-	sparc32_ipi_ops->cross_call(func, *cpu_online_mask,
+	sparc32_ipi_ops->cross_call(func, cpu_online_mask,
 				    arg1, arg2, arg3, 0);
 }
 
 static inline void xc4(void *func, unsigned long arg1, unsigned long arg2,
 		       unsigned long arg3, unsigned long arg4)
 {
-	sparc32_ipi_ops->cross_call(func, *cpu_online_mask,
+	sparc32_ipi_ops->cross_call(func, cpu_online_mask,
 				    arg1, arg2, arg3, arg4);
 }
 
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 8328a3b78a44..7010a691b0e1 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -4,6 +4,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/ftrace.h>
+#include <linux/smp.h>
 
 #include <asm/traps.h>
 #include <asm/head.h>
@@ -79,6 +80,16 @@ int sparc32_classify_syscall(unsigned int syscall);
 #endif
 
 #ifdef CONFIG_SPARC32
+
+#ifdef CONFIG_SMP
+static inline bool cpu_for_ipi(const cpumask_t *mask, unsigned int cpu)
+{
+	return cpumask_test_cpu(cpu, mask) &&
+	       cpumask_test_cpu(cpu, cpu_online_mask) &&
+	       cpu != smp_processor_id();
+}
+#endif /* CONFIG_SMP */
+
 /* setup_32.c */
 struct linux_romvec;
 void sparc32_start_kernel(struct linux_romvec *rp);
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 1ee393abc463..291884c8d82a 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -372,7 +372,7 @@ static struct smp_funcall {
 static DEFINE_SPINLOCK(cross_call_lock);
 
 /* Cross calls must be serialized, at least currently. */
-static void leon_cross_call(void *func, cpumask_t mask, unsigned long arg1,
+static void leon_cross_call(void *func, const cpumask_t *mask, unsigned long arg1,
 			    unsigned long arg2, unsigned long arg3,
 			    unsigned long arg4)
 {
@@ -403,14 +403,11 @@ static void leon_cross_call(void *func, cpumask_t mask, unsigned long arg1,
 		{
 			register int i;
 
-			cpumask_clear_cpu(smp_processor_id(), &mask);
-			cpumask_and(&mask, cpu_online_mask, &mask);
 			for (i = 0; i <= high; i++) {
-				if (cpumask_test_cpu(i, &mask)) {
+				if (cpu_for_ipi(mask, i)) {
 					ccall_info.processors_in[i] = 0;
 					ccall_info.processors_out[i] = 0;
 					leon_send_ipi(i, LEON3_IRQ_CROSS_CALL);
-
 				}
 			}
 		}
@@ -420,7 +417,7 @@ static void leon_cross_call(void *func, cpumask_t mask, unsigned long arg1,
 
 			i = 0;
 			do {
-				if (!cpumask_test_cpu(i, &mask))
+				if (!cpu_for_ipi(mask, i))
 					continue;
 
 				while (!ccall_info.processors_in[i])
@@ -429,7 +426,7 @@ static void leon_cross_call(void *func, cpumask_t mask, unsigned long arg1,
 
 			i = 0;
 			do {
-				if (!cpumask_test_cpu(i, &mask))
+				if (!cpu_for_ipi(mask, i))
 					continue;
 
 				while (!ccall_info.processors_out[i])
diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index 9a62a5cf3337..7dc57ca05728 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -281,7 +281,7 @@ static struct smp_funcall {
 static DEFINE_SPINLOCK(cross_call_lock);
 
 /* Cross calls must be serialized, at least currently. */
-static void sun4d_cross_call(void *func, cpumask_t mask, unsigned long arg1,
+static void sun4d_cross_call(void *func, const cpumask_t *mask, unsigned long arg1,
 			     unsigned long arg2, unsigned long arg3,
 			     unsigned long arg4)
 {
@@ -315,10 +315,8 @@ static void sun4d_cross_call(void *func, cpumask_t mask, unsigned long arg1,
 		{
 			register int i;
 
-			cpumask_clear_cpu(smp_processor_id(), &mask);
-			cpumask_and(&mask, cpu_online_mask, &mask);
 			for (i = 0; i <= high; i++) {
-				if (cpumask_test_cpu(i, &mask)) {
+				if (cpu_for_ipi(mask, i)) {
 					ccall_info.processors_in[i] = 0;
 					ccall_info.processors_out[i] = 0;
 					sun4d_send_ipi(i, IRQ_CROSS_CALL);
@@ -331,7 +329,7 @@ static void sun4d_cross_call(void *func, cpumask_t mask, unsigned long arg1,
 
 			i = 0;
 			do {
-				if (!cpumask_test_cpu(i, &mask))
+				if (!cpu_for_ipi(mask, i))
 					continue;
 				while (!ccall_info.processors_in[i])
 					barrier();
@@ -339,7 +337,7 @@ static void sun4d_cross_call(void *func, cpumask_t mask, unsigned long arg1,
 
 			i = 0;
 			do {
-				if (!cpumask_test_cpu(i, &mask))
+				if (!cpu_for_ipi(mask, i))
 					continue;
 				while (!ccall_info.processors_out[i])
 					barrier();
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index 056df034e79e..3f43f64e3489 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -170,7 +170,7 @@ static struct smp_funcall {
 static DEFINE_SPINLOCK(cross_call_lock);
 
 /* Cross calls must be serialized, at least currently. */
-static void sun4m_cross_call(void *func, cpumask_t mask, unsigned long arg1,
+static void sun4m_cross_call(void *func, const cpumask_t *mask, unsigned long arg1,
 			     unsigned long arg2, unsigned long arg3,
 			     unsigned long arg4)
 {
@@ -191,10 +191,8 @@ static void sun4m_cross_call(void *func, cpumask_t mask, unsigned long arg1,
 		{
 			register int i;
 
-			cpumask_clear_cpu(smp_processor_id(), &mask);
-			cpumask_and(&mask, cpu_online_mask, &mask);
 			for (i = 0; i < ncpus; i++) {
-				if (cpumask_test_cpu(i, &mask)) {
+				if (cpu_for_ipi(mask, i)) {
 					ccall_info.processors_in[i] = 0;
 					ccall_info.processors_out[i] = 0;
 					sun4m_send_ipi(i, IRQ_CROSS_CALL);
@@ -210,7 +208,7 @@ static void sun4m_cross_call(void *func, cpumask_t mask, unsigned long arg1,
 
 			i = 0;
 			do {
-				if (!cpumask_test_cpu(i, &mask))
+				if (!cpu_for_ipi(mask, i))
 					continue;
 				while (!ccall_info.processors_in[i])
 					barrier();
@@ -218,7 +216,7 @@ static void sun4m_cross_call(void *func, cpumask_t mask, unsigned long arg1,
 
 			i = 0;
 			do {
-				if (!cpumask_test_cpu(i, &mask))
+				if (!cpu_for_ipi(mask, i))
 					continue;
 				while (!ccall_info.processors_out[i])
 					barrier();
-- 
2.25.1

