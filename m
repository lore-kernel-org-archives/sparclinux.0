From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 10 Jun 2005 04:18:06 +0000
Subject: Re: arch/sparc64/kernel/cpu.c
Message-Id: <20050609.211806.41636310.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <9f5610f405060921043ec4c55c@mail.gmail.com>
In-Reply-To: <9f5610f405060921043ec4c55c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Peter Martini <setpeterm@gmail.com>
Subject: arch/sparc64/kernel/cpu.c
Date: Fri, 10 Jun 2005 00:04:59 -0400

> The cpu.c file has a struct cpu_iu_info linux_sparc_chips[] with all
> of the ID values for the various processors (and another cpu_fu_info
> linux_sparc_fpu[]), but the values for the UltraSPARC IV are missing. 
> I used a kernel routine and the assembly instructions from that file
> to check the values, and got 0x3e and 0x18.

Current 2.6.x sources have entries for the UltraSPARC-IV
in arch/sparc64/kernel/cpu.c:

  { 0x3e, 0x18, 0, "UltraSparc IV integrated FPU"},
 ...
  { 0x3e, 0x18, "TI UltraSparc IV (Jaguar)"},
 ...

> I haven't delved into too much code yet, but it looks to me like that
> routine only runs on one cpu, is that correct?  I know from testing
> that depending on which processor is running the code different values
> will be produced, and the cpus can be mixed within one system...

It runs on the boot processor.

Mixing UltraSPARC cpu types isn't actually supported.  Even
Solaris does not support this.  Initially this is what was
intended, but it simply is not very feasible.
