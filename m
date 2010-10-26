From: David Miller <davem@davemloft.net>
Date: Tue, 26 Oct 2010 15:53:38 +0000
Subject: Re: [PATCH] sparc32: make CONFIG_SPARC_LEON depends on !SMP to fix
Message-Id: <20101026.085338.104057457.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1288108303-2712-1-git-send-email-namhyung@gmail.com>
In-Reply-To: <1288108303-2712-1-git-send-email-namhyung@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: namhyung@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@gmail.com>
Date: Wed, 27 Oct 2010 00:51:43 +0900

>   CC      arch/sparc/kernel/irq_32.o
> arch/sparc/kernel/irq_32.c: In function 'request_fast_irq':
> arch/sparc/kernel/irq_32.c:370:25: error: conflicting types for 'trapbase_cpu1'
> arch/sparc/include/asm/leon.h:366:22: note: previous declaration of 'trapbase_cpu1' was here
> arch/sparc/kernel/irq_32.c:370:40: error: conflicting types for 'trapbase_cpu2'
> arch/sparc/include/asm/leon.h:367:22: note: previous declaration of 'trapbase_cpu2' was here
> arch/sparc/kernel/irq_32.c:370:55: error: conflicting types for 'trapbase_cpu3'
> arch/sparc/include/asm/leon.h:368:22: note: previous declaration of 'trapbase_cpu3' was here
> make[3]: *** [arch/sparc/kernel/irq_32.o] Error 1
> make[2]: *** [arch/sparc/kernel] Error 2
> make[1]: *** [sub-make] Error 2
> make: *** [all] Error 2
> 
> Signed-off-by: Namhyung Kim <namhyung@gmail.com>

Great, I'll apply all three of your patches thanks.
