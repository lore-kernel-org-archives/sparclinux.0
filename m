From: David Miller <davem@davemloft.net>
Date: Tue, 20 Apr 2010 07:49:26 +0000
Subject: Re: [PATCH] Fix kmemleak include in arch/sparc/kernel/irq_64.c
Message-Id: <20100420.004926.98891538.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1004200947380.22959@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1004200947380.22959@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Tue, 20 Apr 2010 09:56:35 +0300 (EEST)

> Trying 2.6.34-rc5 on my minimal-config Ultra 1 gave me this error:
> 
>   CC      arch/sparc/kernel/irq_64.o
> arch/sparc/kernel/irq_64.c: In function 'sun4v_build_virq':
> arch/sparc/kernel/irq_64.c:657: error: implicit declaration of function 'kmemleak_not_leak'
> make[1]: *** [arch/sparc/kernel/irq_64.o] Error 1
> 
> Fix it by including kmemleak.h for the inline function.
> 
> Signed-off-by: Meelis Roos <mroos@linux.ee>

Know problem, patch posted here already by Frederic last week, I just
haven't gotten around to pushing to Linus as I wanted to fix these
nasty ftrace crashes first.

