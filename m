From: Vince Weaver <vince@deater.net>
Date: Wed, 22 Apr 2009 19:40:42 +0000
Subject: [patch] Niagara1 Perfcounter Accesses
Message-Id: <Pine.LNX.4.64.0904221537190.12401@pianoman.cluster.toy>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Add proper Niagara1 perfcounter accesses.

When trying to track down the hang-on-boot NMI problem on my
T1 system, I noticed that Niagara2 performance counter accesses
were being done, even though I only have a Niagara1 system.
This means "undefined" bits were being written to in the
performance counter register.

This patch does not fix the hang, but it's possibly the right thing
to do anyway.

Signed-off-by: Vince Weaver <vince@deater.net>


diff --git a/arch/sparc/kernel/pcr.c b/arch/sparc/kernel/pcr.c
index 1ae8cdd..bc6c67c 100644
--- a/arch/sparc/kernel/pcr.c
+++ b/arch/sparc/kernel/pcr.c
@@ -72,11 +72,25 @@ static void n2_pcr_write(u64 val)
  		write_pcr(val);
  }

+static void n1_pcr_write(u64 val)
+{
+	unsigned long ret;
+
+	ret = sun4v_niagara_setperf(HV_N2_PERF_SPARC_CTL, val);
+	if (val != HV_EOK)
+		write_pcr(val);
+}
+
  static const struct pcr_ops n2_pcr_ops = {
  	.read	= direct_pcr_read,
  	.write	= n2_pcr_write,
  };

+static const struct pcr_ops n1_pcr_ops = {
+	.read	= direct_pcr_read,
+	.write	= n1_pcr_write,
+};
+
  static unsigned long perf_hsvc_group;
  static unsigned long perf_hsvc_major;
  static unsigned long perf_hsvc_minor;
@@ -126,11 +140,20 @@ int __init pcr_arch_init(void)

  	switch (tlb_type) {
  	case hypervisor:
+	   switch (sun4v_chip_type) {
+	   case SUN4V_CHIP_NIAGARA1:
+	        pcr_ops = &n1_pcr_ops;
+	        pcr_enable = PCR_SUN4U_ENABLE;
+	        break;
+
+	   case SUN4V_CHIP_NIAGARA2:
  		pcr_ops = &n2_pcr_ops;
  		pcr_enable = PCR_N2_ENABLE;
  		picl_shift = 2;
  		break;
-
+	   }
+	   break;
+
  	case cheetah:
  	case cheetah_plus:
  		pcr_ops = &direct_pcr_ops;

