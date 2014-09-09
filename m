From: David Miller <davem@davemloft.net>
Date: Tue, 09 Sep 2014 21:52:46 +0000
Subject: Re: [PATCH] sparc64: sun4v TLB error power off events
Message-Id: <20140909.145246.1554145392641698498.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1410104858-22046-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410104858-22046-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bob.picco@oracle.com>
Date: Tue, 9 Sep 2014 17:12:27 -0400

> I just ran a quick experiment on my T5-2 which is supported hardware. The
> kernel is 3.17-rc3 without any modification from me - well ixgbe. As root mmap
> of /dev/mem at address 0UL. It powered off:

Just out of curiosity what ixgbe patches do you need that aren't
upstream already?

> 4 GNU/Linux
> [root@t5-2 ~]# [31732.360547] SUN4V-DTLB: Error at TPC[fffffc01001cac48], tl 1
> [31732.371659] SUN4V-DTLB: TPC<0xfffffc01001cac48>
> [31732.380652] SUN4V-DTLB: O7[100970]
> [31732.387418] SUN4V-DTLB: O7<0x100970>
> [31732.394548] SUN4V-DTLB: vaddr[fffffc0100028000] ctx[1634] pte[9a00000000000610] error[2]
> 
> Message from syslogd@t5-2 at Sep  9 16:53:25 ...
>  kernel:[31732.360547] SUN4V-DTLB: Error at TPC[fffffc01001cac48], tl 1
> 
> Message from syslogd@t5-2 at Sep  9 16:53:25 ...
>  kernel:[31732.371659] SUN4V-DTLB: TPC<0xfffffc01001cac48>
> 
> Message from syslogd@t5-2 at Sep  9 16:53:25 ...
>  kernel:[31732.380652] SUN4V-DTLB: O7[102014-09-09 20:35:34     SP> NOTICE:  Host is off
> . Some firmware widget we are unaware of?

Hmmm...

Oh I see, if LDOMs are enabled we do ldom_power_off() instead of doing
an OF "exit".

That explains everything.

I seem to remember that for some reason after early boot it got to the
point with LDOMs that you had to stop talking to the OF, and that's
why for all of these interfaces that could be invoked after early
boot, we revector to a ldom_*() routine if ldom_domaining_enabled is
true.

So I don't think there is anything we can do about this, so perhaps we
should just unconditionally avoid using prom_halt() here, and just do
a die_if_kernel() regardless of the trap level.

Also, for the >tl1 case, it would be beneficial to print out the stack
of trap state registers that etraptl1 saves on the stack right after
pt_regs.  The format is traps_64.c's "struct tl1_traplog", and there
is a dump_tl1_traplog() helper there already.

Thanks for looking into this Bob.
