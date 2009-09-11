From: David Miller <davem@davemloft.net>
Date: Fri, 11 Sep 2009 22:40:46 +0000
Subject: Re: blackbird errata workaround
Message-Id: <20090911.154046.141241617.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090911223849.GA3160@orion.carnet.hr>
In-Reply-To: <20090911223849.GA3160@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Sat, 12 Sep 2009 00:38:50 +0200

> Just a small glitch:
> 
> % grep -r smp_percpu_timer_interrupt arch/sparc/ -B2 -A2
> arch/sparc/kernel/syscalls.S-
> arch/sparc/kernel/syscalls.S-   /* Blackbird errata workaround.  See commentary in
> arch/sparc/kernel/syscalls.S:    * smp.c:smp_percpu_timer_interrupt() for more
> arch/sparc/kernel/syscalls.S-    * information.
> arch/sparc/kernel/syscalls.S-    */
> --
> arch/sparc/include/asm/system_64.h-
> arch/sparc/include/asm/system_64.h-/* Blackbird errata workaround.  See commentary in
> arch/sparc/include/asm/system_64.h: * arch/sparc64/kernel/smp.c:smp_percpu_timer_interrupt()
> arch/sparc/include/asm/system_64.h- * for more information.
> arch/sparc/include/asm/system_64.h- */
> 
> It looks like that information is now in tick_add_compare() in
> arch/sparc/kernel/time_64.c so these two references should be updated.

Yep, I happen to read that comment recently too.

I'll fix it up, thanks.
