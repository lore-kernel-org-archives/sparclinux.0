From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Mon, 29 Mar 2004 21:07:39 +0000
Subject: Re: Need help getting 2.6.5-BK to boot
Message-Id: <20040329210739.GA25872@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040329201135.GC30251@artsapartment.org>
In-Reply-To: <20040329201135.GC30251@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Mar 29, 2004 at 02:11:35PM -0600, Art Haas wrote:

> I'm trying to get my 2.6.5-BK kernel to boot, and am having a few
> problems, most likely self-induced. I've been able to compile the
> kernel (using the latest Debian GCC-3.3 package), and it boots
> up, but things don't work correctly. First, I never see anything
> on my display past the first few lines that get printed out after

> CONFIG_FB=y
> # CONFIG_FB_BW2 is not set
> # CONFIG_FB_CG3 is not set
> CONFIG_FB_CG6=y

You have a framebuffer...

> # CONFIG_MDA_CONSOLE is not set
> CONFIG_PROM_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE=m

...but no console.  Say Y instead of M here.

> kernel: XFree86(293): Kernel bad trap [#1]
> kernel: PSR: 40401084 PC: 501a20c8 NPC: 501a20cc Y: 00000000    Not tainted
> kernel: PC: <0x501a20c8>
> kernel: %%G: 00000000 00000002  00000000 00000fb8  50019000 00000000  ff000000 50015638
> kernel: %%O: 501a2094 00023584  000aeb04 000fc5a4  efe80330 00000000  efff9690 501a20a0
> kernel: RPC: <0x501a20a0>
> kernel: %%L: 40001085 501c5d60  501c5d64 00000040  00000080 f0010a04  00000000 50238c2c
> kernel: %%I: 00000000 00000006  efff9758 000fc5a4  efe80330 00000000  efff96f8 000aeb04

I don't know what to make of this.  According to this the trap occurs
in userland.  Under the circumstances, the process should be killed
and life goes on.  I suspect the output you're seeing is bogus; kregs
never gets filled in by that code path.  What do you get with this
patch?

=== arch/sparc/kernel/entry.S 1.24 vs edited ==--- 1.24/arch/sparc/kernel/entry.S	Sat Mar 27 22:20:04 2004
+++ edited/arch/sparc/kernel/entry.S	Mon Mar 29 13:03:23 2004
@@ -288,10 +288,9 @@
 	wr	%l0, PSR_ET, %psr
 	WRITE_PAUSE
 
-	mov	%l7, %o0		! trap number
-	mov	%l0, %o1		! psr
+	add	%sp, STACKFRAME_SZ, %o0	! pt_regs
 	call	do_hw_interrupt
-	 mov	%l1, %o2		! pc
+	 mov	%l7, %o1		! trap number
 
 	RESTORE_ALL
 	
=== arch/sparc/kernel/traps.c 1.10 vs edited ==--- 1.10/arch/sparc/kernel/traps.c	Sun Feb 22 11:15:54 2004
+++ edited/arch/sparc/kernel/traps.c	Mon Mar 29 13:06:04 2004
@@ -131,23 +131,23 @@
 	do_exit(SIGSEGV);
 }
 
-void do_hw_interrupt(unsigned long type, unsigned long psr, unsigned long pc)
+void do_hw_interrupt(struct pt_regs *regs, unsigned long type)
 {
 	siginfo_t info;
 
 	if(type < 0x80) {
 		/* Sun OS's puke from bad traps, Linux survives! */
 		printk("Unimplemented Sparc TRAP, type = %02lx\n", type);
-		die_if_kernel("Whee... Hello Mr. Penguin", current->thread.kregs);
+		die_if_kernel("Whee... Hello Mr. Penguin", regs);
 	}	
 
-	if(psr & PSR_PS)
-		die_if_kernel("Kernel bad trap", current->thread.kregs);
+	if(regs->psr & PSR_PS)
+		die_if_kernel("Kernel bad trap", regs);
 
 	info.si_signo = SIGILL;
 	info.si_errno = 0;
 	info.si_code = ILL_ILLTRP;
-	info.si_addr = (void *)pc;
+	info.si_addr = (void *)regs->pc;
 	info.si_trapno = type - 0x80;
 	force_sig_info(SIGILL, &info, current);
 }


> should go away. One thing I notice is the different output that
> show up for the ttyS? devices - in the 2.6 kernel the first
> two are 'zs2' and 'zs3' and then 'ttyS0' and 'ttyS1' appear.
> In 2.4 there are four 'ttyS?' devices.

Cosmetic change only.

-- 
Keith M Wesolowski
