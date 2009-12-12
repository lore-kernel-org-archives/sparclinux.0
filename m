From: David Miller <davem@davemloft.net>
Date: Sat, 12 Dec 2009 09:40:02 +0000
Subject: Re: RCU detected CPU 0 stall after panic on sparc64
Message-Id: <20091212.014002.173528710.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.0912121049030.26625@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.0912121049030.26625@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sat, 12 Dec 2009 10:54:19 +0200 (EET)

> I tried 2.6.32 git gaad3bf0 on a SMP sparc64 machine (Ultra Enterprise 
> 250). For some reason my disks were not found (not important in this 
> bugreport) and this resulted in panic (cannnot mount root). However, the 
> machine kept going and got the below messages (RCU detected CPU 0 stall 
> (t00 jiffies)) from timer interrupts.
> 
> This seems to be like a bug in RCU vs panic.

It's normal actually.  A panic() just loops forever and the cpu never
goes through an RCU grace period again as a result, and this triggers
the debugging timer that detects this condition.

Probably the panic() code should disable that assertion check.
