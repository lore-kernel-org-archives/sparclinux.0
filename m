From: Elad Lahav <elahav@uwaterloo.ca>
Date: Wed, 17 Sep 2008 18:45:58 +0000
Subject: Re: Processor IDs on the Niagara
Message-Id: <48D15066.4070509@uwaterloo.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <48CADADA.7050604@uwaterloo.ca>
In-Reply-To: <48CADADA.7050604@uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>>> Niagara T1 is a single "package", with 8 "cores".
>> Exactly my point. So why isn't there a single physical package ID for all CPUs under /sys/devices/system/cpu/cpuX/topology/physical_package_id ?
> 
> I misspoke here, this is not how I use the topology.

Just in case you decide to fix the physical_package_id numbers, here's a possible patch. 
It uses the serial number of the processor to distinguish between physical CPUs, and 
assigns an ID based on the number of distinct serial numbers found.
The only caveat (I know of) is that it increases the size of cpu_data beyond 2 cache lines 
(not sure if that means much in practice, though).

--Elad

diff -r -u linux-2.6.26.5-org/arch/sparc64/kernel/mdesc.c 
linux-2.6.26.5/arch/sparc64/kernel/mdesc.c
--- linux-2.6.26.5-org/arch/sparc64/kernel/mdesc.c      2008-09-08 13:40:20.000000000 -0400
+++ linux-2.6.26.5/arch/sparc64/kernel/mdesc.c  2008-09-17 14:17:32.000000000 -0400
@@ -762,10 +762,44 @@
         get_one_mondo_bits(val, &tb->nonresum_qmask, 2);
  }

+static void set_phys_proc_id(struct mdesc_handle *hp, u64 mp, int cpuid,
+                             int* new_phys_id)
+{
+       const u64 *sernum = mdesc_get_property(hp, mp, "serial#", NULL);
+       int i;
+
+       cpu_data(cpuid).phys_proc_id = -1;
+
+       if (sernum = NULL) {
+               printk(KERN_INFO "CPU %d: no serial# property\n", cpuid);
+               return;
+       }
+
+       cpu_data(cpuid).serial_num = *sernum;
+
+#ifdef CONFIG_SMP
+       for_each_cpu_mask(i, cpu_present_map) {
+               if (cpu_data(i).serial_num = *sernum) {
+                       cpu_data(cpuid).phys_proc_id = cpu_data(i).phys_proc_id;
+                       break;
+               }
+       }
+
+       if (cpu_data(cpuid).phys_proc_id = -1)
+               cpu_data(cpuid).phys_proc_id = (*new_phys_id)++;
+#else
+       cpu_data(cpuid).phys_proc_id = new_phys_id;
+#endif
+       printk(KERN_INFO "CPU %d: serial#=%lu phys_proc_id=%d\n", cpuid,
+              cpu_data(cpuid).serial_num,
+              cpu_data(cpuid).phys_proc_id);
+}
+
  void __cpuinit mdesc_fill_in_cpu_data(cpumask_t mask)
  {
         struct mdesc_handle *hp = mdesc_grab();
         u64 mp;
+       int phys_id = 0;

         ncpus_probed = 0;
         mdesc_for_each_node_by_name(hp, mp, "cpu") {
@@ -825,6 +859,8 @@
                         }
                 }

+               set_phys_proc_id(hp, mp, cpuid, &phys_id);
+
  #ifdef CONFIG_SMP
                 cpu_set(cpuid, cpu_present_map);
  #endif
diff -r -u linux-2.6.26.5-org/include/asm-sparc64/cpudata.h 
linux-2.6.26.5/include/asm-sparc64/cpudata.h
--- linux-2.6.26.5-org/include/asm-sparc64/cpudata.h    2008-09-08 13:40:20.000000000 -0400
+++ linux-2.6.26.5/include/asm-sparc64/cpudata.h        2008-09-17 13:32:22.000000000 -0400
@@ -32,6 +32,10 @@
         unsigned int    ecache_line_size;
         int             core_id;
         int             proc_id;
+
+       /* Dcache line 3, rarely used */
+       u64             serial_num;
+       int             phys_proc_id;
  } cpuinfo_sparc;

  DECLARE_PER_CPU(cpuinfo_sparc, __cpu_data);
diff -r -u linux-2.6.26.5-org/include/asm-sparc64/topology.h 
linux-2.6.26.5/include/asm-sparc64/topology.h
--- linux-2.6.26.5-org/include/asm-sparc64/topology.h   2008-09-08 13:40:20.000000000 -0400
+++ linux-2.6.26.5/include/asm-sparc64/topology.h       2008-09-17 13:31:42.000000000 -0400
@@ -73,7 +73,7 @@
  #endif /* !(CONFIG_NUMA) */

  #ifdef CONFIG_SMP
-#define topology_physical_package_id(cpu)      (cpu_data(cpu).proc_id)
+#define topology_physical_package_id(cpu)      (cpu_data(cpu).phys_proc_id)
  #define topology_core_id(cpu)                  (cpu_data(cpu).core_id)
  #define topology_core_siblings(cpu)            (cpu_core_map[cpu])
  #define topology_thread_siblings(cpu)          (per_cpu(cpu_sibling_map, cpu))
