From: Eric Brower <ebrower@usa.net>
Date: Mon, 08 Mar 2004 00:58:22 +0000
Subject: Re: auto poweroff - keyboard dependency?
Message-Id: <404BC52E.60502@usa.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Janos Sziliczi wrote:

> Hi All,
> 
> I've compiled a 2.4.25 kernel.
> When I'd typed the 'halt' command as root, the Linux shutdowned and the
> machine turned off automatically (no 'power-off' needed on PROM prompt).

This tends to hit the list once every few weeks.

In both sparc and sparc64 the kernel will not power-off systems that are 
running with a serial console-- instead they are dropped to OBP (2.2.x 
did not act this way).  I believe Pete was going to remove this "safety 
measure" in sparc a while back but I don't believe it has been done.

If you are running a sparc kernel, remove the check for !serial_console

   if (auxio_power_register && !serial_console)

in arch/sparc/kernel/process.c.  In sparc64, remove the check

   if (!serial_console)

in arch/sparc64/kernel/power.c.

I have a sysctl patch for sparc that allows selection of power-off at 
halt for serial console systems.  Pete did not like this too much, but I 
believe it is a fair trade-off IFF anyone believes the safety measure 
should be preserved.  The sparc64 arch could benefit from the same.

If you aren't up to recompiling a kernel, depending upon version you 
might be able to type 'power-off' at OBP.  Some versions allow this, 
some require a keyboard with power button to be present.  Of coure, you 
could always reach over and flip the switch, too, if it is not miles away.

E


