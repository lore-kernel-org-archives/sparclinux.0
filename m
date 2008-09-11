From: David Miller <davem@davemloft.net>
Date: Thu, 11 Sep 2008 10:25:57 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <20080911.032557.184080426.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 11 Sep 2008 12:25:52 +0300 (EEST)

> clocksource: mult[28000] shift[16]
> clockevent: mult[66666666] shift[32]
> Console: colour dummy device 80x25
> console handover: boot [earlyprom0] -> real [tty0]
> 
> (hard hang here)
> 
> Here after these lines was the Wacky INO message earlier.

Well, do you have sunzilog and sunzilog console support built into
this kernel?

Just making sure :)

Anyways, you can get more messages with this patch:

diff --git a/arch/sparc64/kernel/setup.c b/arch/sparc64/kernel/setup.c
index c8b03a4..2c50796 100644
--- a/arch/sparc64/kernel/setup.c
+++ b/arch/sparc64/kernel/setup.c
@@ -82,7 +82,7 @@ unsigned long cmdline_memory_size = 0;
 static struct console prom_early_console = {
 	.name =		"earlyprom",
 	.write =	prom_console_write,
-	.flags =	CON_PRINTBUFFER | CON_BOOT | CON_ANYTIME,
+	.flags =	CON_PRINTBUFFER | CON_ANYTIME,
 	.index =	-1,
 };
 
