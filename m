From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 14 Sep 2010 13:30:27 +0000
Subject: SPARC32 SMP 2.6.36-rc3 build error
Message-Id: <4C8F78F3.7020408@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I have problems linking Linux SPARC32 when SMP is enabled:

  LD      vmlinux
  SYSMAP  System.map
  SYSMAP  .tmp_System.map
  BTFIX   arch/sparc/boot/btfix.S
  AS      arch/sparc/boot/btfix.o
  LD      arch/sparc/boot/image
net/built-in.o: In function `net_rps_action_and_irq_enable':
/home/daniel/linux/linux/linux-2.6/net/core/dev.c:3337: undefined 
reference to `__smp_call_function_single'
make[1]: *** [arch/sparc/boot/image] Error 1
make: *** [zImage] Error 2


It seems that __smp_call_function_single() is missing in smp_32.h for 
SPARC32, for SPARC64 the function is declared in linux/smp.h and 
kernel/smp.c by defining USE_GENERIC_SMP_HELPERS in arch/sparc/Kconfig.

__smp_call_function_single() was introduced in 
e77c8e83dd587f2616d7ff20d23a897891e6e20d:

+#ifdef CONFIG_SMP
+/*
+ * net_rps_action sends any pending IPI's for rps.  This is only called from
+ * softirq and interrupts must be enabled.
+ */
+static void net_rps_action(cpumask_t *mask)
+{
+       int cpu;
+
+       /* Send pending IPI's to kick RPS processing on remote cpus. */
+       for_each_cpu_mask_nr(cpu, *mask) {
+               struct softnet_data *queue = &per_cpu(softnet_data, cpu);
+               if (cpu_online(cpu))
+                       __smp_call_function_single(cpu, &queue->csd, 0);
+       }
+       cpus_clear(*mask);
+}
+#endif


Any ideas what I might have done wrong?

Thanks,
Daniel Hellstrom
