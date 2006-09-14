From: Rick Jones <rick.jones2@hp.com>
Date: Thu, 14 Sep 2006 20:17:15 +0000
Subject: NIC interrupt assignments under UltraSPARC-T1
Message-Id: <4509B8CB.2070103@hp.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

 From time to time I "play" with netperf on different systems.  I happen 
to have occasion to play with a T2000.  Under Solaris 10 I am able to 
coerce the interrupts of the different core GbEs to be on different 
cores rather than strands of the same core.

Under a 2.6.15 kernel (Ubuntu Dapper) it would appear that the old 
standby of "echo affinity mask to the /proc/irq/mumble" I've used with 
Linux on other (non-SPARC) hardware doesn't "work" - no matter how I 
change the mask for a NIC, running a netperf TCP_RR test seems to show 
the interrupts happening on the same strand.

Is it indeed not possible to alter the interrupt assignments or have I 
(as I'm wont to do) missed something quasi-obvious?

It has been suggested that I should be poking around in 
arch/sparc64/kernel/irq.c and i've looked there, I'm still a bit lost as 
I've not learned the heirarchy of the code in that area.  With my 
netperf stuff I've had the good fortune to not have to go any deeper 
than getting a call to sched_setaffinity() right...  I have noticed that 
down in that file everything seems to be assuming a specific "CPU" 
rather than a set of them (mask)

thanks,

rick jones
http://www.netperf.org/
