From: "Hong H. Pham" <hong.pham@windriver.com>
Date: Fri, 22 May 2009 21:55:16 +0000
Subject: Re: [PATCH v2] sparc64: fix and optimize irq distribution
Message-Id: <4A171F44.6090608@windriver.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050609070503030800020707"
List-Id: <sparclinux.vger.kernel.org>
References: <1242233551-3369-1-git-send-email-hong.pham@windriver.com>
In-Reply-To: <1242233551-3369-1-git-send-email-hong.pham@windriver.com>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------050609070503030800020707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David Miller wrote:
> There is absolutely no connection between virtual cpu numbers
> and the hierarchy in which they sit in the cores and higher
> level hierarchy of the processor.  So you can't just say
> (cpu_id / 4) is the core number or anything like that.
> 
> You must use the machine description to determine this kind of
> information, just as we do in arch/sparc/kernel/mdesc.c to figure out
> the CPU scheduler grouping maps.  (see mark_proc_ids() and
> mark_core_ids())

Thanks for pointing me in this direction.  mark_proc_ids() and
mark_core_ids() sets the core_id and proc_id members in the per
cpu __cpu_data.  Looks like I can use cpu_data() to figure out
the CPU distribution.

As a side note, here's a dump of cpu_data() on a 2 way T5440.
There's a hole between 48 and 71.

[714162.134215] Brought up 96 CPUs
[714162.135440] CPU 0: node=0 core_id=1 proc_id=0
[714162.135452] CPU 1: node=0 core_id=1 proc_id=0
[714162.135464] CPU 2: node=0 core_id=1 proc_id=0
[714162.135475] CPU 3: node=0 core_id=1 proc_id=0
[714162.135487] CPU 4: node=0 core_id=1 proc_id=1
[714162.135498] CPU 5: node=0 core_id=1 proc_id=1
[714162.135509] CPU 6: node=0 core_id=1 proc_id=1
[714162.135521] CPU 7: node=0 core_id=1 proc_id=1
[714162.135532] CPU 8: node=0 core_id=2 proc_id=2
[714162.135544] CPU 9: node=0 core_id=2 proc_id=2
[714162.135555] CPU 10: node=0 core_id=2 proc_id=2
...
[714162.135961] CPU 45: node=0 core_id=6 proc_id=11
[714162.135973] CPU 46: node=0 core_id=6 proc_id=11
[714162.135984] CPU 47: node=0 core_id=6 proc_id=11
[714162.135996] CPU 72: node=1 core_id=7 proc_id=12
[714162.136008] CPU 73: node=1 core_id=7 proc_id=12
[714162.136019] CPU 74: node=1 core_id=7 proc_id=12
[714162.136031] CPU 75: node=1 core_id=7 proc_id=12
[714162.136043] CPU 76: node=1 core_id=7 proc_id=13
...
[714162.136554] CPU 119: node=1 core_id=12 proc_id=23

Regards,
Hong

--------------050609070503030800020707
Content-Type: text/x-patch;
 name="dump_cpu_data.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dump_cpu_data.patch"

diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 54906aa..7fa909f 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1353,8 +1353,20 @@ void __cpu_die(unsigned int cpu)
 }
 #endif
 
+static void dump_cpu_data(void)
+{
+	int i;
+
+	for_each_online_cpu(i) {
+		printk(KERN_DEBUG "CPU %i: node=%i core_id=%i proc_id=%i\n",
+		       i, cpu_to_node(i),
+		       cpu_data(i).core_id, cpu_data(i).proc_id);
+	}
+}
+
 void __init smp_cpus_done(unsigned int max_cpus)
 {
+	dump_cpu_data();
 }
 
 void smp_send_reschedule(int cpu)

--------------050609070503030800020707--
