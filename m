From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 02 Oct 2008 21:20:59 +0000
Subject: clock_tick printing in cpuinfo
Message-Id: <20081002212059.GA13635@orion.carnet.hr>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This is just a triviality...

The cpu_data clock_tick variable is an unsigned long which seems to
correspond to the frequency of the CPU, but it is being printed in cpuinfo
as a zero-padded hexadecimal. I checked x86, x86_64, alpha, and all of them
print a normal decimal number of Hertz.

So, the attached trivial patch would seem like a good idea to make sparc64
cpuinfo output just a wee bit easier on the eyes :)

Maybe there is userland software that absolutely depends on the old format,
which would preclude applying this patch? That would be pretty strange, but
I suppose it's possible... Googling found me
https://ssl.drqueue.org/project/changeset/2027 but that is an open-source
program where this "regression" could be easily fixed (also they could
probably simplify their string handling).

Also while looking at this, I happened to notice that sparc(32) code is
a bit inconsistent with the same matter. arch/sparc/kernel/setup.c has
code that prints the fixed CPU0ClkTck without SMP, however
arch/sparc/kernel/smp.c's functions smp_bogo() or smp_info() never bother
printing the clock_tick for SMP CPUs. The patch could be very simple, but
I wouldn't have any theoretical way to test it so I didn't try.

-- 
     2. That which causes joy or happiness.

--DocE+STaALJfprDB
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="sparc-clock-tick.diff"

--- arch/sparc64/kernel/setup.c	2008-10-02 22:36:06.000000000 +0200
+++ arch/sparc64/kernel/setup.c	2008-10-02 22:36:06.000000000 +0200
@@ -359,7 +359,7 @@
 		   "D$ parity tl1\t: %u\n"
 		   "I$ parity tl1\t: %u\n"
 #ifndef CONFIG_SMP
-		   "Cpu0ClkTck\t: %016lx\n"
+		   "cpu0 clock tick [Hz]\t: %ld\n"
 #endif
 		   ,
 		   sparc_cpu_type,
--- arch/sparc64/kernel/smp.c	2008-10-02 22:36:11.000000000 +0200
+++ arch/sparc64/kernel/smp.c	2008-10-02 22:36:11.000000000 +0200
@@ -76,7 +76,7 @@
 	
 	for_each_online_cpu(i)
 		seq_printf(m,
-			   "Cpu%dClkTck\t: %016lx\n",
+			   "cpu%d clock tick [Hz]\t: %ld\n",
 			   i, cpu_data(i).clock_tick);
 }
 

--DocE+STaALJfprDB--
