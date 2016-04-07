From: Meelis Roos <mroos@linux.ee>
Date: Thu, 07 Apr 2016 08:22:10 +0000
Subject: Bisected: RED State Exception in 4.5 on E420R
Message-Id: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Just got power & cooling back to my computer lab (and I'm back to 
> reporting bugs). I have a bqacklog of things to test but on E420R I got 
> a halt during early bootup:

> [    0.000000] Kernel: Using 5 locked TLB entries for main kernel image.
> [    0.000000] Remapping the kernel... done.
> 
> RED State Exception

Bisected:

commit 1a40b95374f680625318ab61d81958e949e0afe3
Author: Mike Frysinger <vapier@gentoo.org>
Date:   Mon Jan 18 06:32:30 2016 -0500

    sparc: Fix system call tracing register handling.
    
    A system call trace trigger on entry allows the tracing
    process to inspect and potentially change the traced
    process's registers.
    
    Account for that by reloading the %g1 (syscall number)
    and %i0-%i5 (syscall argument) values.  We need to be
    careful to revalidate the range of %g1, and reload the
    system call table entry it corresponds to into %l7.
    
    Reported-by: Mike Frysinger <vapier@gentoo.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>
    Tested-by: Mike Frysinger <vapier@gentoo.org>

:040000 040000 3fa8c484537ffff82dd469dba7a0f2b770cf8505 5a9834a3f5ed8bae7f788bdeb9bee15279618b5c M      arch

Actually this commit juts makes the system hang here, not RED state 
exception. a couple of last bisect targets were like that so if needed, 
I can also bisect where the hang transformed into RED State Exception.

-- 
Meelis Roos (mroos@linux.ee)
