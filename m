From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Thu, 01 Mar 2012 08:30:30 +0000
Subject: [PATCH 3/3] CPU hotplug, arch/sparc: Fix CPU hotplug callback registration
Message-Id: <4F4F30D6.3000707@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <87ehtf3lqh.fsf@rustcorp.com.au> <20120227155338.7b5110cd.akpm@linux-foundation.org> <20120228084359.GJ21106@elte.hu> <20120228132719.f375071a.akpm@linux-foundation.org> <4F4DBB26.2060907@linux.vnet.ibm.com> <20120229091732.GA11505@elte.hu> <4F4E083A.2080304@linux.vnet.ibm.com> <4F4F2F7F.5040207@linux.vnet.ibm.com>
In-Reply-To: <4F4F2F7F.5040207@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: sparclinux@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Nick Piggin <npiggin@kernel.dk>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Gortmaker <paul.gortmaker@windriver.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Arjan van de Ven <arjan.van.de.ven@intel.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <a.p.zijlstra@chello.nl>


Restructure CPU hotplug setup and callback registration in topology_init
so as to be race-free.

---

 arch/sparc/kernel/sysfs.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/sysfs.c b/arch/sparc/kernel/sysfs.c
index 654e8aa..22cb881 100644
--- a/arch/sparc/kernel/sysfs.c
+++ b/arch/sparc/kernel/sysfs.c
@@ -300,16 +300,14 @@ static int __init topology_init(void)
 
 	check_mmu_stats();
 
-	register_cpu_notifier(&sysfs_cpu_nb);
-
 	for_each_possible_cpu(cpu) {
 		struct cpu *c = &per_cpu(cpu_devices, cpu);
 
 		register_cpu(c, cpu);
-		if (cpu_online(cpu))
-			register_cpu_online(cpu);
 	}
 
+	register_allcpu_notifier(&sysfs_cpu_nb, true, NULL);
+
 	return 0;
 }
 


