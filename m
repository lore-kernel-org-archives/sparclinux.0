From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 19 Aug 2004 22:28:54 +0000
Subject: Re: Sun4d SMP - retests - patch was not required
Message-Id: <20040819222854.GC11200@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200408192322.43126.crn@netunix.com>
In-Reply-To: <200408192322.43126.crn@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Aug 19, 2004 at 11:22:43PM +0100, C.Newport wrote:
> I have done some more tests and found a surprise.
> booting with -p causes the lockup at 
> ioremap: done with statics switching to malloc.
> This happens reliably, every time. Is this a clue ?.
> Booting without -p boots reliably, which led me to suspect 
> that my earlier tests may have been misleading.
> Sure enough - reverting to the SMP kernel without the Pasi
> spin_lock_bh patch does the same so it seems we probably 
> do not need this.

*VERY* interesting. Now that we know it's -p ruining it, we need to
know why it's -p doing it. Perhaps the PROM doesn't expect something
we're doing to the cpu.


On Thu, Aug 19, 2004 at 11:22:43PM +0100, C.Newport wrote:
> More test results :-
> Run top from serial console - OK
> telnet in and tar -tf a kernel tarball - this sometimes completes
> but always screws the keyboard input of the serial console.
> If it does not complete it hangs, Load average goes to 1.0.
> Another telnet - can kill the top session but serial kbd input is
> still broken - kill the serial console root shell and all is well again.
> Cannot kill the hung tar process.
> Could this mean that interrupts might be getting
> misrouted to the wrong CPU or process ?.

Yes, though we're really going to have to do more intense diagnostics
(targeted printk'ing out of various bits of state etc.) to discover
what's really happening with interrupts. Checking detailed dumps of
interrupt routing state etc. vs. 2.2.x sound like a good first shot.


-- wli
