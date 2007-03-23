From: Robert Reif <reif@earthlink.net>
Date: Fri, 23 Mar 2007 21:42:14 +0000
Subject: sparc32 SMP debugging advice needed
Message-Id: <460449B6.7010308@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I'm trying to get a git rc4 SMP kernel working on an ss20 and am running
into a few problems.

An SMP kernel boots and runs fine using debian etch and a single
CPU.  However I do get this in kern.log:

Mar 23 10:59:53 ss20 kernel: Kernel command line: root=/dev/sda2 ro
Mar 23 10:59:53 ss20 kernel: PID hash table entries: 1024 (order: 10, 
4096 bytes)
Mar 23 10:59:53 ss20 kernel: start_kernel(): bug: interrupts were 
enabled early
Mar 23 10:59:53 ss20 kernel: Console: colour dummy device 80x25

It looks like something similar was fixed a while back on sparc64 but
I don't know if this is related.  I'm recompiling a kernel with more
debugging turned on to see what happens.

I get a hang when booting the same kernel with 2 CPUs at:

Begin: Loading essential drivers... ...

Nothing interesting before that.

Any advice on how to approach fixing these issues?  I can test patches.

