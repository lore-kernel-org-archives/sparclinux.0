From: David Ahern <david.ahern@oracle.com>
Date: Tue, 31 Mar 2015 19:49:46 +0000
Subject: sparc: deadlock using perf with sched tracepoints and user callstacks
Message-Id: <551AFA5A.1000908@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I am hitting a deadlock with 'perf sched record -g':

[ 8138.140030] ------------[ cut here ]------------
[ 8138.159054] WARNING: CPU: 758 PID: 12488 at 
/opt/dahern/linux.git/arch/sparc/kernel/nmi.c:80 perfctr_irq+0x1f8/0x2b4()
[ 8138.203152] Watchdog detected hard LOCKUP on cpu 758
[ 8138.222874] Modules linked in: ipt_REJECT nf_reject_ipv4 
nf_conntrack_ipv4 nf_defrag_ipv4 iptable_filter ip_tables ip6t_REJECT 
nf_reject_ipv6 xt_tcpudp nf_conntrack_ipv6 nf_defrag_ipv6 xt_state 
nf_conntrack ip6table_filter ip6_tables x_tables ipv6 cdc_ether usbnet 
mii ixgbe mdio igb i2c_algo_bit i2c_core ptp crc32c_sparc64 
camellia_sparc64 des_sparc64 des_generic md5_sparc64 sha512_sparc64 
sha1_sparc64 uio_pdrv_genirq uio usb_storage mpt3sas scsi_transport_sas 
raid_class sha256_sparc64 aes_sparc64 sunvnet sunvdc
[ 8138.410969] CPU: 758 PID: 12488 Comm: perf Not tainted 4.0.0-rc6+ #6
[ 8138.437146] Call Trace:
[ 8138.447193]  [000000000045cdd4] warn_slowpath_common+0x7c/0xa0
[ 8138.471238]  [000000000045ce90] warn_slowpath_fmt+0x30/0x40
[ 8138.494189]  [0000000000983e38] perfctr_irq+0x1f8/0x2b4
[ 8138.515716]  [00000000004209f4] tl0_irq15+0x14/0x20
[ 8138.535791]  [00000000009839ec] _raw_spin_trylock_bh+0x68/0x108
[ 8138.560180]  [0000000000980018] __schedule+0xcc/0x710
[ 8138.580981]  [00000000009806dc] preempt_schedule_common+0x10/0x3c
[ 8138.606082]  [000000000098077c] _cond_resched+0x34/0x44
[ 8138.627603]  [0000000000565990] kmem_cache_alloc_node+0x24/0x1a0
[ 8138.652345]  [0000000000450b60] tsb_grow+0xac/0x488
[ 8138.672429]  [0000000000985040] do_sparc64_fault+0x4dc/0x6e4
[ 8138.695736]  [0000000000407c2c] sparc64_realfault_common+0x10/0x20
[ 8138.721202]  [00000000006f2e24] NG4copy_from_user+0xa4/0x3c0
[ 8138.744510]  [000000000044f900] perf_callchain_user+0x5c/0x6c
[ 8138.768182]  [0000000000517b5c] perf_callchain+0x16c/0x19c
[ 8138.790774]  [0000000000515f84] perf_prepare_sample+0x68/0x218
[ 8138.814801] ---[ end trace 42ca6294b1ff7573 ]---

The scheduler tracepoints can be hit with the run queue lock taken. Per 
the above while walking the userspace callchains page faults can cause 
paths where __schedule gets called again. The deadlock happens because 
it wants the runqueue lock again.

For PowerPC (b59a1bfcc2406ea75346977ad016cfe909a762ac) the solution was 
to disable pagefaults while walking userspace stacks. That does not work 
for sparc; rather that change results in process terminating due to a 
SIGBUS:

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 86eebfa3b158..ebe0287e7542 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -21,7 +21,7 @@

  #include <asm/stacktrace.h>
  #include <asm/cpudata.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
  #include <linux/atomic.h>
  #include <asm/nmi.h>
  #include <asm/pcr.h>
@@ -1832,8 +1832,11 @@ perf_callchain_user(struct perf_callchain_entry 
*entry, struct pt_regs *regs)
                 return;

         flushw_user();
+
+       pagefault_disable();
         if (test_thread_flag(TIF_32BIT))
                 perf_callchain_user_32(entry, regs);
         else
                 perf_callchain_user_64(entry, regs);
+       pagefault_enable();
  }


Perhaps its the pending PTO but I have not been able to find a solution. 
Any ideas? How do I avoid page faults on sparc? (i.e., if page is not 
present just terminate walking the stack)

David

