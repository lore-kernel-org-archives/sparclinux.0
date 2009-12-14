From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Mon, 14 Dec 2009 20:25:56 +0000
Subject: Re: RCU detected CPU 0 stall after panic on sparc64
Message-Id: <20091214202556.GC6679@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.0912121049030.26625@math.ut.ee> <20091212.014002.173528710.davem@davemloft.net>
In-Reply-To: <20091212.014002.173528710.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mroos@linux.ee, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Sat, Dec 12, 2009 at 01:40:02AM -0800, David Miller wrote:
> From: Meelis Roos <mroos@linux.ee>
> Date: Sat, 12 Dec 2009 10:54:19 +0200 (EET)
> 
> > I tried 2.6.32 git gaad3bf0 on a SMP sparc64 machine (Ultra Enterprise 
> > 250). For some reason my disks were not found (not important in this 
> > bugreport) and this resulted in panic (cannnot mount root). However, the 
> > machine kept going and got the below messages (RCU detected CPU 0 stall 
> > (t00 jiffies)) from timer interrupts.
> > 
> > This seems to be like a bug in RCU vs panic.
> 
> It's normal actually.  A panic() just loops forever and the cpu never
> goes through an RCU grace period again as a result, and this triggers
> the debugging timer that detects this condition.
> 
> Probably the panic() code should disable that assertion check.

Hmmm...  At first glance, it looks like RCU should put a notifier onto
the panic_notifier_list to disable this check.  Or is there some global
variable that I can check?

							Thanx, Paul
