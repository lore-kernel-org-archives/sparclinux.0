From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Wed, 25 May 2005 20:46:12 +0000
Subject: NR_CPUS and kernel 2.4.30 for sparc64
Message-Id: <4294E414.80003@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I built a kernel 2.4.30 with SMP and number of cpus set to 2, but This 
kernel actevated only one cpu. A quick look at the smp.c file 
(arch/sparc64/kernel/smp.c) revealed a root of this:

In the smp_boot_cpus() function there are lines:

	for (i = 0; i < NR_CPUS; i++) {
		if (i = boot_cpu_id)
			continue;

		if ((cpucount + 1) = max_cpus)
			goto ignorecpu;
            ...

The first condition eliminates the first cpu from the list of found ones 
(I assume the first is a boot cpu). The second condition eliminates the 
last cpu. So on dual smp machine if the first cpu (number 0) is the boot 
cpu and NR_CPUS is set to 2 no other cpu is found.

I think the second condition and goto should be removed, but please 
advice in case I do not understand something with SMP initialization.

Regards,
Krzysztof Helt

