From: Meelis Roos <mroos@ut.ee>
Date: Thu, 27 May 2004 13:25:21 +0000
Subject: Re: 2.6.6 SMP on UE2 hangs consistently
Message-Id: <Pine.GSO.4.44.0405271615180.16974-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0405211944150.9554-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0405211944150.9554-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> I have a Ultra Enterprise 2 for testing: dual 168 MHz US I, 1G RAM, 1 9G
> disk, onboard hme nic, sbus cg6 framebuffer & type 5 keyboard for debugging.
>
> 2.6 SMP kernel (2.6.6+BK snapshot as of May 21 2004) hangs at random
> places:

Turning on spinlock debugging (after it became compilable) didn't show
anything additional.

But I have one more information bit: it might not be hung completely at
all! I left yesterdays 2.6.7-rc1+BK+spinlock patch running after "hang"
and sometimes (once an hour?) it displays the following lines on PROM
console:

NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, resetting
Happy Status 03030000 TX[000003ff:00000301]
eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.

The machine is not pingable.

Additionally, the keyboard has problems even when it does not hang - I
gaet random garbage and the key lights do not turn on (caps, num etc).
So it looks like I have just onboard hme and keyboard hosed.

Any ideas now?

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/

