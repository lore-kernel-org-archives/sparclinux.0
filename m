From: Peter Martini <setpeterm@gmail.com>
Date: Fri, 10 Jun 2005 04:04:59 +0000
Subject: arch/sparc64/kernel/cpu.c
Message-Id: <9f5610f405060921043ec4c55c@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The cpu.c file has a struct cpu_iu_info linux_sparc_chips[] with all
of the ID values for the various processors (and another cpu_fu_info
linux_sparc_fpu[]), but the values for the UltraSPARC IV are missing. 
I used a kernel routine and the assembly instructions from that file
to check the values, and got 0x3e and 0x18.

I haven't delved into too much code yet, but it looks to me like that
routine only runs on one cpu, is that correct?  I know from testing
that depending on which processor is running the code different values
will be produced, and the cpus can be mixed within one system...

FYI, the code I'm looking at is 2.6.11.9.

Regards,
Peter Martini
