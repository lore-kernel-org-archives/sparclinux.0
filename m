From: Meelis Roos <mroos@linux.ee>
Date: Wed, 22 Oct 2014 23:22:36 +0000
Subject: Re: unaligned accesses in SLAB etc.
Message-Id: <alpine.LRH.2.11.1410230221360.28745@adalberg.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20141019.003209.2286339581794609198.davem@davemloft.net> <alpine.LRH.2.11.1410191006430.32417@adalberg.ut.ee> <20141020.145746.428441452740929005.davem@davemloft.net> <20141022.163949.1761351331649936601.davem@davemloft.net>
In-Reply-To: <20141022.163949.1761351331649936601.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

> Whilst I don't have access to my reproducer machine until tomorrow in
> order to test this myself, I wanted to toss this patch your way so you
> could get a head start on me.

Unfortunately it fails earlier during the boot:

[   25.232318] clocksource: mult[53555555] shift[24]
[   25.288559] clockevent: mult[3126e98] shift[32]
[   25.342813] Console: colour dummy device 80x25
[   25.395990] console [tty0] enabled
[   25.436726] bootconsole [earlyprom0] disabled
ERROR: Last Trap: Memory Address not Aligned

ok

-- 
Meelis Roos (mroos@linux.ee)
