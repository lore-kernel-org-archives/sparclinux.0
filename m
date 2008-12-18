From: David Miller <davem@davemloft.net>
Date: Thu, 18 Dec 2008 03:46:46 +0000
Subject: Re: kernel crashes on Sun Fire 480R with cassini network driver
Message-Id: <20081217.194646.25300922.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080923133152.GC17211@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20080923133152.GC17211@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Fri, 24 Oct 2008 17:24:33 +0200

> Hello all,
> 
> On Mon, Sep 29, 2008 at 10:19:54AM +0200, Hermann Lauer wrote:
> > > while trying to run vanilla linux-2.6.26.5 or the debian etchnhalf kernel
> > > (2.6.24.x) I noticed the cassini network driver for the builtin gigabit
> > > network is unstable and brings the kernel down on a dualprocessor sparc
> > > SunFire 480R with a Hardware FATAL RESET.
> > 
> > I now noticed that even a few pings are possible with the cassini
> > network driver if you configure it statically, but then the machine again 
> > crashes with the known: 
> > ERROR: System Hardware FATAL RESET from  CPU0 CPU2
> 
> tried 2.6.27.2 today, but this hangs already at loading the kernel.
> Output is attached. Please tell me what else I can provide.

Unfortunately, "-p" doesn't do anything any more and the kernel
is stopping or crashing during the part of the boot between
when the early prom console is disabled and the real console is
setup.

The way to debug this is to manually get rid of the CON_BOOT flag
in the early prom console structure, like the following patch.

If you reboot with this it will print more information so we can
try and diagnose this further.

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
 
