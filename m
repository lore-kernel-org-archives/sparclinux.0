From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 26 Oct 2010 17:50:36 +0000
Subject: LEON SMP
Message-Id: <4CC714EC.2050001@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Thanks for applying the patch.

I don't know if I have introduced myself before.. I'm working at 
Aeroflex Gaisler as a software engineer on the LEON{2,3,4} architectures.

I saw the discussion about LEON previously on the list, and I feel that 
I should say something short about LEON and SMP. We are of course very 
thankfull for being in the Linux kernel tree.

There are multiple multi-core designs of LEON in FPGAs and ASICs. For 
example the dual-core LEON4 200MHz eAsic that Sam mentioned, and a new 
chip GR712 is being tested at the fab as we speak. More chips are in the 
design phase. The LEON4 architecture was released earlier this year, it 
is aiming more on SMP than the LEON3, even though the LEON3 can do SMP 
as well. The LEON4 has for example L2 cache and wider buses. Of course 
all LEONs are SPARCv8 compatible.

I have been working with a new quad-core LEON4 design since 
mid-september, we have made some changes to the LEON port of Linux port 
which we would like to submit. Some of them are not in a clean state 
yet, so there are some work still before I will try to post them here. 
Now to the question...

The LEON do not have internal timers as some CPUs does, it has 
one/multiple General Purpose TIMERs on the Processor Local Bus. On 
single-CPU/SMP systems the first Timer is used for System Clock, and on 
SMP systems timer two is also used to generate a simultaneous IRQ on all 
CPUs for profiling etc. (leon_percpu_timer_interrupt()). On the 
quad-core SMP system I discovered that since the per-cpu timer is 
generated at the same frequency (and almost simultaneously) as the 
System Clock Timer. I have made a patch that uses only one Timer for SMP 
systems, the Timer generates a per-cpu tick as before, however on CPU0 
the handler_irq() is also called after profiling has been done, this is 
to handle the System Clock Tick. I seems to work successfully, and it 
saves me HZ interrupts per second and a Timer instance. What is you 
opinion about that? Is it possible to use the same timer for System 
Clock and for per-cpu profiling etc.?

Best Regards,
Daniel Hellstrom

