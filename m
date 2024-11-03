Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB14D15443B;
	Sun,  3 Nov 2024 08:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730621360; cv=none; b=W5BTG1KXBlYJ5Xvy7L+16Dm7JpXtJRghljlKa+xo+tKQGrVDYQoiNz+zhE8nOdjaAQxV2m6zRUmYBfdat+G7aoFKHWWxsC8gsjmnGAG9blfcCIyb+DRbj0sQx96xK8ciN6CJwVquM2euuM+MrQU46x4Pb61mxRBeILeHwe/V+BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730621360; c=relaxed/simple;
	bh=A3qFofE2FTeXXptlGj/GbRLYBog9Av63u4PPiTaJfXE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SXdHTUC7DgAiP1BX0TH6kwLWoF8R6NkvjwLLZtsQfCZPwQELQ0/EozXYbt2GD+YeaqYtAblYHqUSTuqJFmI2JsM/v0nDMnXSe7fowCbcxHG7/dlgwjmKZvb8S1La4l6Pd7JZMU/MXErNHNCQBNe1viH38LINndo4rVg4F7qJQNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Z8nMehOb; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Z8nMehOb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=fjAen
	LhCq8Xk53K+KNMCvNlQm0rmeCRd+Naft/mV0f8=; b=Z8nMehObtHVNsBHL+JKMH
	sE6tULkLao0vvKLdWkBz55udo400qH22K1LCSaBqU3T/vrXE60vW3CrzE/YAfXjb
	uKBp3m7+dBz0Vp6YpPDBauA88jwBJEE2zNnTo7PDHF9ElNIeQpwNN+1rrZfuZmRC
	0fxwNJSzSk3WrVfUGeNm90=
Received: from localhost.localdomain (unknown [111.35.191.191])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCnrQTjLidnai5hAQ--.30987S4;
	Sun, 03 Nov 2024 16:06:12 +0800 (CST)
From: David Wang <00107082@163.com>
To: tglx@linutronix.de,
	richard.henderson@linaro.org,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	guoren@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	mpe@ellerman.id.au,
	paul.walmsley@sifive.com,
	ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	chris@zankel.net,
	jcmvbkbc@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH] kernel/irq/proc: performance: replace seq_printf with seq_put_decimal_ull_width
Date: Sun,  3 Nov 2024 16:05:52 +0800
Message-Id: <20241103080552.4787-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCnrQTjLidnai5hAQ--.30987S4
X-Coremail-Antispam: 1Uf129KBjvAXoWfuF4fJw1rWr4fXFykCw1rWFg_yoW5JrWkJo
	WkuF4IyrykuFyUX34DZrnayFyqqw42q3W3X34q9w4rWFnFqrWkKry2va4xAry3Aw45C34k
	WayaqrW5J390qFWkn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfU8nmRUUUUU
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0heMqmcnKG5ISwAAsm

seq_printf is costy, when stress reading /proc/interrupts, profiling indicates
seq_printf takes about ~47% of show_interrupts samples:

    show_interrupts(94.495% 5166019/5466991)
	seq_printf(47.429% 2450210/5166019)
	    vsnprintf(89.232% 2186366/2450210)
		format_decode(24.005% 524831/2186366)
		number(19.488% 426084/2186366)
		memcpy_orig(3.739% 81753/2186366)
		...
	_raw_spin_unlock_irqrestore(26.643% 1376379/5166019)
	mtree_load(8.059% 416304/5166019)

On a system with n CPUs and m interrupts, there will be n*m decimal
values yielded via seq_printf(.."%10u "..) which is less efficient
than seq_put_decimal_ull_width, stress reading /proc/interrupts
indicates ~30% performance improvement with this patch, and profiling
data shows:

	show_interrupts(92.221% 3609371/3913823)
	    _raw_spin_unlock_irqrestore(39.123% 1412078/3609371)
	    mtree_load(11.942% 431036/3609371)
	    seq_put_decimal_ull_width(11.635% 419958/3609371)
	    seq_printf(9.025% 325754/3609371)
	    ...

The improvement has pratical significance, considering many monitoring
tools would read /proc/interrupts periodically.

seq_put_decimal_ull_width(..," ", v, 10) is equivalent to
seq_printf(.., " %10llu", v), not "%10llu "; Hence there is space
adjustment along.

Signed-off-by: David Wang <00107082@163.com>
---
 arch/alpha/kernel/irq.c     |   8 +--
 arch/arm/kernel/smp.c       |   4 +-
 arch/arm64/kernel/smp.c     |   3 +-
 arch/csky/kernel/smp.c      |   4 +-
 arch/loongarch/kernel/smp.c |   2 +-
 arch/parisc/kernel/irq.c    |  34 ++++++------
 arch/powerpc/kernel/irq.c   |  44 ++++++++--------
 arch/riscv/kernel/smp.c     |   3 +-
 arch/sh/kernel/irq.c        |   4 +-
 arch/sparc/kernel/irq_32.c  |  12 ++---
 arch/sparc/kernel/irq_64.c  |   4 +-
 arch/x86/kernel/irq.c       | 100 ++++++++++++++++++------------------
 arch/xtensa/kernel/irq.c    |   2 +-
 arch/xtensa/kernel/smp.c    |   4 +-
 kernel/irq/proc.c           |   6 ++-
 15 files changed, 120 insertions(+), 114 deletions(-)

diff --git a/arch/alpha/kernel/irq.c b/arch/alpha/kernel/irq.c
index c67047c5d830..0dbb8d3ed647 100644
--- a/arch/alpha/kernel/irq.c
+++ b/arch/alpha/kernel/irq.c
@@ -72,14 +72,14 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	int j;
 
 #ifdef CONFIG_SMP
-	seq_puts(p, "IPI: ");
+	seq_puts(p, "IPI:");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10lu ", cpu_data[j].ipi_count);
+		seq_put_decimal_ull_width(p, " ", cpu_data[j].ipi_count, 10);
 	seq_putc(p, '\n');
 #endif
-	seq_puts(p, "PMI: ");
+	seq_puts(p, "PMI:");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10lu ", per_cpu(irq_pmi_count, j));
+		seq_put_decimal_ull_width(p, " ", per_cpu(irq_pmi_count, j), 10);
 	seq_puts(p, "          Performance Monitoring\n");
 	seq_printf(p, "ERR: %10lu\n", irq_err_count);
 	return 0;
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 3431c0553f45..1b0680477ae1 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -551,10 +551,10 @@ void show_ipi_list(struct seq_file *p, int prec)
 		if (!ipi_desc[i])
 			continue;
 
-		seq_printf(p, "%*s%u: ", prec - 1, "IPI", i);
+		seq_printf(p, "%*s%u:", prec - 1, "IPI", i);
 
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10u ", irq_desc_kstat_cpu(ipi_desc[i], cpu));
+			seq_put_decimal_ull_width(p, " ", irq_desc_kstat_cpu(ipi_desc[i], cpu), 10);
 
 		seq_printf(p, " %s\n", ipi_types[i]);
 	}
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 3b3f6b56e733..35734a30ed8d 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -844,7 +844,8 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
 			   prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10u ", irq_desc_kstat_cpu(ipi_desc[i], cpu));
+			seq_put_decimal_ull_width(p, " ",
+						  irq_desc_kstat_cpu(ipi_desc[i], cpu), 10);
 		seq_printf(p, "      %s\n", ipi_types[i]);
 	}
 
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 92dbbf3e0205..65f399afc3f0 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -112,8 +112,8 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
 			   prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10lu ",
-				per_cpu_ptr(&ipi_data, cpu)->stats[i]);
+			seq_put_decimal_ull_width(p, " ",
+						  per_cpu_ptr(&ipi_data, cpu)->stats[i], 10);
 		seq_printf(p, " %s\n", ipi_names[i]);
 	}
 
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 9afc2d8b3414..86664adfb3cf 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -82,7 +82,7 @@ void show_ipi_list(struct seq_file *p, int prec)
 	for (i = 0; i < NR_IPI; i++) {
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i, prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10u ", per_cpu(irq_stat, cpu).ipi_irqs[i]);
+			seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, cpu).ipi_irqs[i], 10);
 		seq_printf(p, " LoongArch  %d  %s\n", i + 1, ipi_types[i]);
 	}
 }
diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index dff66be65d29..b060d7e6da46 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -133,40 +133,42 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	int j;
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
-	seq_printf(p, "%*s: ", prec, "STK");
+	seq_printf(p, "%*s:", prec, "STK");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->kernel_stack_usage);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->kernel_stack_usage, 10);
 	seq_puts(p, "  Kernel stack usage\n");
 # ifdef CONFIG_IRQSTACKS
-	seq_printf(p, "%*s: ", prec, "IST");
+	seq_printf(p, "%*s:", prec, "IST");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_stack_usage);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->irq_stack_usage, 10);
 	seq_puts(p, "  Interrupt stack usage\n");
 # endif
 #endif
 #ifdef CONFIG_SMP
 	if (num_online_cpus() > 1) {
-		seq_printf(p, "%*s: ", prec, "RES");
+		seq_printf(p, "%*s:", prec, "RES");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", irq_stats(j)->irq_resched_count);
+			seq_put_decimal_ull_width(p, " ",
+						  irq_stats(j)->irq_resched_count, 10);
 		seq_puts(p, "  Rescheduling interrupts\n");
-		seq_printf(p, "%*s: ", prec, "CAL");
+		seq_printf(p, "%*s:", prec, "CAL");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", irq_stats(j)->irq_call_count);
+			seq_put_decimal_ull_width(p, " ",
+						  irq_stats(j)->irq_call_count, 10);
 		seq_puts(p, "  Function call interrupts\n");
 	}
 #endif
-	seq_printf(p, "%*s: ", prec, "UAH");
+	seq_printf(p, "%*s:", prec, "UAH");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_unaligned_count);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->irq_unaligned_count, 10);
 	seq_puts(p, "  Unaligned access handler traps\n");
-	seq_printf(p, "%*s: ", prec, "FPA");
+	seq_printf(p, "%*s:", prec, "FPA");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_fpassist_count);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->irq_fpassist_count, 10);
 	seq_puts(p, "  Floating point assist traps\n");
-	seq_printf(p, "%*s: ", prec, "TLB");
+	seq_printf(p, "%*s:", prec, "TLB");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_tlb_count);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->irq_tlb_count, 10);
 	seq_puts(p, "  TLB shootdowns\n");
 	return 0;
 }
@@ -195,10 +197,10 @@ int show_interrupts(struct seq_file *p, void *v)
 		action = desc->action;
 		if (!action)
 			goto skip;
-		seq_printf(p, "%3d: ", i);
+		seq_printf(p, "%3d:", i);
 
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", irq_desc_kstat_cpu(desc, j));
+			seq_put_decimal_ull_width(p, " ", irq_desc_kstat_cpu(desc, j), 10);
 
 		seq_printf(p, " %14s", irq_desc_get_chip(desc)->name);
 #ifndef PARISC_IRQ_CR16_COUNTS
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 2e1600a8bbbb..a0e8b998c9b5 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -89,69 +89,69 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 
 #if defined(CONFIG_PPC32) && defined(CONFIG_TAU_INT)
 	if (tau_initialized) {
-		seq_printf(p, "%*s: ", prec, "TAU");
+		seq_printf(p, "%*s:", prec, "TAU");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", tau_interrupts(j));
+			seq_put_decimal_ull_width(p, " ", tau_interrupts(j), 10);
 		seq_puts(p, "  PowerPC             Thermal Assist (cpu temp)\n");
 	}
 #endif /* CONFIG_PPC32 && CONFIG_TAU_INT */
 
-	seq_printf(p, "%*s: ", prec, "LOC");
+	seq_printf(p, "%*s:", prec, "LOC");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).timer_irqs_event);
+		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).timer_irqs_event, 10);
         seq_printf(p, "  Local timer interrupts for timer event device\n");
 
-	seq_printf(p, "%*s: ", prec, "BCT");
+	seq_printf(p, "%*s:", prec, "BCT");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).broadcast_irqs_event);
+		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).broadcast_irqs_event, 10);
 	seq_printf(p, "  Broadcast timer interrupts for timer event device\n");
 
-	seq_printf(p, "%*s: ", prec, "LOC");
+	seq_printf(p, "%*s:", prec, "LOC");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).timer_irqs_others);
+		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).timer_irqs_others, 10);
         seq_printf(p, "  Local timer interrupts for others\n");
 
-	seq_printf(p, "%*s: ", prec, "SPU");
+	seq_printf(p, "%*s:", prec, "SPU");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).spurious_irqs);
+		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).spurious_irqs, 10);
 	seq_printf(p, "  Spurious interrupts\n");
 
-	seq_printf(p, "%*s: ", prec, "PMI");
+	seq_printf(p, "%*s:", prec, "PMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).pmu_irqs);
+		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).pmu_irqs, 10);
 	seq_printf(p, "  Performance monitoring interrupts\n");
 
-	seq_printf(p, "%*s: ", prec, "MCE");
+	seq_printf(p, "%*s:", prec, "MCE");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).mce_exceptions);
+		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).mce_exceptions, 10);
 	seq_printf(p, "  Machine check exceptions\n");
 
 #ifdef CONFIG_PPC_BOOK3S_64
 	if (cpu_has_feature(CPU_FTR_HVMODE)) {
-		seq_printf(p, "%*s: ", prec, "HMI");
+		seq_printf(p, "%*s:", prec, "HMI");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", paca_ptrs[j]->hmi_irqs);
+			seq_put_decimal_ull_width(p, " ", paca_ptrs[j]->hmi_irqs, 10);
 		seq_printf(p, "  Hypervisor Maintenance Interrupts\n");
 	}
 #endif
 
-	seq_printf(p, "%*s: ", prec, "NMI");
+	seq_printf(p, "%*s:", prec, "NMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).sreset_irqs);
+		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).sreset_irqs, 10);
 	seq_printf(p, "  System Reset interrupts\n");
 
 #ifdef CONFIG_PPC_WATCHDOG
-	seq_printf(p, "%*s: ", prec, "WDG");
+	seq_printf(p, "%*s:", prec, "WDG");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).soft_nmi_irqs);
+		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).soft_nmi_irqs, 10);
 	seq_printf(p, "  Watchdog soft-NMI interrupts\n");
 #endif
 
 #ifdef CONFIG_PPC_DOORBELL
 	if (cpu_has_feature(CPU_FTR_DBELL)) {
-		seq_printf(p, "%*s: ", prec, "DBL");
+		seq_printf(p, "%*s:", prec, "DBL");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", per_cpu(irq_stat, j).doorbell_irqs);
+			seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).doorbell_irqs, 10);
 		seq_printf(p, "  Doorbell interrupts\n");
 	}
 #endif
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index c180a647a30e..f1e9c3db094c 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -226,7 +226,8 @@ void show_ipi_stats(struct seq_file *p, int prec)
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
 			   prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10u ", irq_desc_kstat_cpu(ipi_desc[i], cpu));
+			seq_put_decimal_ull_width(p, " ",
+						  irq_desc_kstat_cpu(ipi_desc[i], cpu), 10);
 		seq_printf(p, " %s\n", ipi_names[i]);
 	}
 }
diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index 4e6835de54cf..9022d8af9d68 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -43,9 +43,9 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	int j;
 
-	seq_printf(p, "%*s: ", prec, "NMI");
+	seq_printf(p, "%*s:", prec, "NMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat.__nmi_count, j));
+		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat.__nmi_count, j), 10);
 	seq_printf(p, "  Non-maskable interrupts\n");
 
 	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count));
diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index 8605dd710f3c..5210991429d5 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -199,18 +199,18 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	int j;
 
 #ifdef CONFIG_SMP
-	seq_printf(p, "RES: ");
+	seq_printf(p, "RES:");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", cpu_data(j).irq_resched_count);
+		seq_put_decimal_ull_width(p, " ", cpu_data(j).irq_resched_count, 10);
 	seq_printf(p, "     IPI rescheduling interrupts\n");
-	seq_printf(p, "CAL: ");
+	seq_printf(p, "CAL:");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", cpu_data(j).irq_call_count);
+		seq_put_decimal_ull_width(p, " ", cpu_data(j).irq_call_count, 10);
 	seq_printf(p, "     IPI function call interrupts\n");
 #endif
-	seq_printf(p, "NMI: ");
+	seq_printf(p, "NMI:");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", cpu_data(j).counter);
+		seq_put_decimal_ull_width(p, " ", cpu_data(j).counter, 10);
 	seq_printf(p, "     Non-maskable interrupts\n");
 	return 0;
 }
diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 01ee800efde3..9ab6e79b617b 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -304,9 +304,9 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	int j;
 
-	seq_printf(p, "NMI: ");
+	seq_printf(p, "NMI:");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", cpu_data(j).__nmi_count);
+		seq_put_decimal_ull_width(p, " ", cpu_data(j).__nmi_count, 10);
 	seq_printf(p, "     Non-maskable interrupts\n");
 	return 0;
 }
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 385e3a5fc304..66cc8f001bd0 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -62,103 +62,103 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	int j;
 
-	seq_printf(p, "%*s: ", prec, "NMI");
+	seq_printf(p, "%*s:", prec, "NMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->__nmi_count);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->__nmi_count, 10);
 	seq_puts(p, "  Non-maskable interrupts\n");
 #ifdef CONFIG_X86_LOCAL_APIC
-	seq_printf(p, "%*s: ", prec, "LOC");
+	seq_printf(p, "%*s:", prec, "LOC");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->apic_timer_irqs);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->apic_timer_irqs, 10);
 	seq_puts(p, "  Local timer interrupts\n");
 
-	seq_printf(p, "%*s: ", prec, "SPU");
+	seq_printf(p, "%*s:", prec, "SPU");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_spurious_count);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->irq_spurious_count, 10);
 	seq_puts(p, "  Spurious interrupts\n");
-	seq_printf(p, "%*s: ", prec, "PMI");
+	seq_printf(p, "%*s:", prec, "PMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->apic_perf_irqs);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->apic_perf_irqs, 10);
 	seq_puts(p, "  Performance monitoring interrupts\n");
-	seq_printf(p, "%*s: ", prec, "IWI");
+	seq_printf(p, "%*s:", prec, "IWI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->apic_irq_work_irqs);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->apic_irq_work_irqs, 10);
 	seq_puts(p, "  IRQ work interrupts\n");
-	seq_printf(p, "%*s: ", prec, "RTR");
+	seq_printf(p, "%*s:", prec, "RTR");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->icr_read_retry_count);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->icr_read_retry_count, 10);
 	seq_puts(p, "  APIC ICR read retries\n");
 	if (x86_platform_ipi_callback) {
-		seq_printf(p, "%*s: ", prec, "PLT");
+		seq_printf(p, "%*s:", prec, "PLT");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", irq_stats(j)->x86_platform_ipis);
+			seq_put_decimal_ull_width(p, " ", irq_stats(j)->x86_platform_ipis, 10);
 		seq_puts(p, "  Platform interrupts\n");
 	}
 #endif
 #ifdef CONFIG_SMP
-	seq_printf(p, "%*s: ", prec, "RES");
+	seq_printf(p, "%*s:", prec, "RES");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_resched_count);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->irq_resched_count, 10);
 	seq_puts(p, "  Rescheduling interrupts\n");
-	seq_printf(p, "%*s: ", prec, "CAL");
+	seq_printf(p, "%*s:", prec, "CAL");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_call_count);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->irq_call_count, 10);
 	seq_puts(p, "  Function call interrupts\n");
-	seq_printf(p, "%*s: ", prec, "TLB");
+	seq_printf(p, "%*s:", prec, "TLB");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_tlb_count);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->irq_tlb_count, 10);
 	seq_puts(p, "  TLB shootdowns\n");
 #endif
 #ifdef CONFIG_X86_THERMAL_VECTOR
-	seq_printf(p, "%*s: ", prec, "TRM");
+	seq_printf(p, "%*s:", prec, "TRM");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_thermal_count);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->irq_thermal_count, 10);
 	seq_puts(p, "  Thermal event interrupts\n");
 #endif
 #ifdef CONFIG_X86_MCE_THRESHOLD
-	seq_printf(p, "%*s: ", prec, "THR");
+	seq_printf(p, "%*s:", prec, "THR");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_threshold_count);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->irq_threshold_count, 10);
 	seq_puts(p, "  Threshold APIC interrupts\n");
 #endif
 #ifdef CONFIG_X86_MCE_AMD
-	seq_printf(p, "%*s: ", prec, "DFR");
+	seq_printf(p, "%*s:", prec, "DFR");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_deferred_error_count);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->irq_deferred_error_count, 10);
 	seq_puts(p, "  Deferred Error APIC interrupts\n");
 #endif
 #ifdef CONFIG_X86_MCE
-	seq_printf(p, "%*s: ", prec, "MCE");
+	seq_printf(p, "%*s:", prec, "MCE");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(mce_exception_count, j));
+		seq_put_decimal_ull_width(p, " ", per_cpu(mce_exception_count, j), 10);
 	seq_puts(p, "  Machine check exceptions\n");
-	seq_printf(p, "%*s: ", prec, "MCP");
+	seq_printf(p, "%*s:", prec, "MCP");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(mce_poll_count, j));
+		seq_put_decimal_ull_width(p, " ", per_cpu(mce_poll_count, j), 10);
 	seq_puts(p, "  Machine check polls\n");
 #endif
 #ifdef CONFIG_X86_HV_CALLBACK_VECTOR
 	if (test_bit(HYPERVISOR_CALLBACK_VECTOR, system_vectors)) {
-		seq_printf(p, "%*s: ", prec, "HYP");
+		seq_printf(p, "%*s:", prec, "HYP");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ",
-				   irq_stats(j)->irq_hv_callback_count);
+			seq_put_decimal_ull_width(p, " ",
+						  irq_stats(j)->irq_hv_callback_count, 10);
 		seq_puts(p, "  Hypervisor callback interrupts\n");
 	}
 #endif
 #if IS_ENABLED(CONFIG_HYPERV)
 	if (test_bit(HYPERV_REENLIGHTENMENT_VECTOR, system_vectors)) {
-		seq_printf(p, "%*s: ", prec, "HRE");
+		seq_printf(p, "%*s:", prec, "HRE");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ",
-				   irq_stats(j)->irq_hv_reenlightenment_count);
+			seq_put_decimal_ull_width(p, " ",
+						  irq_stats(j)->irq_hv_reenlightenment_count, 10);
 		seq_puts(p, "  Hyper-V reenlightenment interrupts\n");
 	}
 	if (test_bit(HYPERV_STIMER0_VECTOR, system_vectors)) {
-		seq_printf(p, "%*s: ", prec, "HVS");
+		seq_printf(p, "%*s:", prec, "HVS");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ",
-				   irq_stats(j)->hyperv_stimer0_count);
+			seq_put_decimal_ull_width(p, " ",
+						  irq_stats(j)->hyperv_stimer0_count, 10);
 		seq_puts(p, "  Hyper-V stimer0 interrupts\n");
 	}
 #endif
@@ -167,28 +167,28 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	seq_printf(p, "%*s: %10u\n", prec, "MIS", atomic_read(&irq_mis_count));
 #endif
 #if IS_ENABLED(CONFIG_KVM)
-	seq_printf(p, "%*s: ", prec, "PIN");
+	seq_printf(p, "%*s:", prec, "PIN");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->kvm_posted_intr_ipis);
+		seq_put_decimal_ull_width(p, " ", irq_stats(j)->kvm_posted_intr_ipis, 10);
 	seq_puts(p, "  Posted-interrupt notification event\n");
 
-	seq_printf(p, "%*s: ", prec, "NPI");
+	seq_printf(p, "%*s:", prec, "NPI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ",
-			   irq_stats(j)->kvm_posted_intr_nested_ipis);
+		seq_put_decimal_ull_width(p, " ",
+					  irq_stats(j)->kvm_posted_intr_nested_ipis, 10);
 	seq_puts(p, "  Nested posted-interrupt event\n");
 
-	seq_printf(p, "%*s: ", prec, "PIW");
+	seq_printf(p, "%*s:", prec, "PIW");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ",
-			   irq_stats(j)->kvm_posted_intr_wakeup_ipis);
+		seq_put_decimal_ull_width(p, " ",
+					  irq_stats(j)->kvm_posted_intr_wakeup_ipis, 10);
 	seq_puts(p, "  Posted-interrupt wakeup event\n");
 #endif
 #ifdef CONFIG_X86_POSTED_MSI
-	seq_printf(p, "%*s: ", prec, "PMN");
+	seq_printf(p, "%*s:", prec, "PMN");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ",
-			   irq_stats(j)->posted_msi_notification_count);
+		seq_put_decimal_ull_width(p, " ",
+					  irq_stats(j)->posted_msi_notification_count, 10);
 	seq_puts(p, "  Posted MSI notification event\n");
 #endif
 	return 0;
diff --git a/arch/xtensa/kernel/irq.c b/arch/xtensa/kernel/irq.c
index b1e410f6b5ab..c4f46989f9b7 100644
--- a/arch/xtensa/kernel/irq.c
+++ b/arch/xtensa/kernel/irq.c
@@ -58,7 +58,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 #if XTENSA_FAKE_NMI
 	seq_printf(p, "%*s:", prec, "NMI");
 	for_each_online_cpu(cpu)
-		seq_printf(p, " %10lu", per_cpu(nmi_count, cpu));
+		seq_put_decimal_ull_width(p, " ", per_cpu(nmi_count, cpu), 10);
 	seq_puts(p, "   Non-maskable interrupts\n");
 #endif
 	return 0;
diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index 94a23f100726..71ec9eced8b9 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -453,8 +453,8 @@ void show_ipi_list(struct seq_file *p, int prec)
 	for (i = 0; i < IPI_MAX; ++i) {
 		seq_printf(p, "%*s:", prec, ipi_text[i].short_text);
 		for_each_online_cpu(cpu)
-			seq_printf(p, " %10lu",
-					per_cpu(ipi_data, cpu).ipi_count[i]);
+			seq_put_decimal_ull_width(p, " ",
+						  per_cpu(ipi_data, cpu).ipi_count[i], 10);
 		seq_printf(p, "   %s\n", ipi_text[i].long_text);
 	}
 }
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 9081ada81c3d..988ce781e813 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -494,9 +494,11 @@ int show_interrupts(struct seq_file *p, void *v)
 	if (!desc->action || irq_desc_is_chained(desc) || !desc->kstat_irqs)
 		goto outsparse;
 
-	seq_printf(p, "%*d: ", prec, i);
+	seq_printf(p, "%*d:", prec, i);
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, j) : 0);
+		seq_put_decimal_ull_width(p, " ",
+					  desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, j) : 0,
+					  10);
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	if (desc->irq_data.chip) {
-- 
2.39.2

