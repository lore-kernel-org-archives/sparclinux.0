From: David Miller <davem@davemloft.net>
Date: Mon, 19 Jan 2009 03:11:38 +0000
Subject: Re: config for v880
Message-Id: <20090118.191138.219656360.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200901160946.41267.nick.leippe@whitecanyon.com>
In-Reply-To: <200901160946.41267.nick.leippe@whitecanyon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Nicholas Leippe <nick.leippe@whitecanyon.com>
Date: Sun, 18 Jan 2009 16:21:21 -0700

> So far, I've had it hang at various different points.
> 
> One of which is at:
> 
> ...
> console handover: boot [earlyprom0] -> real [tty0]

When this happens you won't be able to see the crash
message because it is being output in between dropping
the early PROM console and enabling the serial or
framebuffer console.

With the patch below (or something like it, it's very easy
to apply this patch by hand if the one below doesn't work
for you) you are more likely to see the crash message.

> another (which was on a 480r, not sure if same prob on 880) was:
> 
> ...
> rtc0 = alarms up to one no, 114 bytes nvram
> 
> notice the "no" instead of "month" for example.

This doesn't really indicate much.

Anyways, here is the patch for the other case so you can
try to fetch some more logging info:

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
 
