From: "C.Newport" <crn@netunix.com>
Date: Sun, 15 Aug 2004 00:57:12 +0000
Subject: Sun4d SMP wierdness
Message-Id: <200408150157.12181.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I am trying to track down why 2.4.27 (or any 2.4 series) does a watchdog 
timeout very early in the boot sequence om Sun4d SMP.

In arch/sparc/kernel/setup.c I put some prom_printfs to narrow it down.

setup.c line 450 
 prom_printf("tp6\n");
	paging_init();
 prom_printf("tp7\n");

tp6 gets printed at boot, tp7 does not.

So - in arch/sparc/mm/init.c line 328 I add another test point 

void __init paging_init(void)
{
 prom_printf("mm/init.c:paging_init %d", sparc_cpu_model);
	switch(sparc_cpu_model) {

OUCH - this never gets printed so somewhere the function call to paging_init
is vanishing into lala-land.

At this point I am stumped - What could be happening ?

Chris Newport

