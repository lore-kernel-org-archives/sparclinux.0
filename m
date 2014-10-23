From: David Miller <davem@davemloft.net>
Date: Thu, 23 Oct 2014 17:02:58 +0000
Subject: Re: unaligned accesses in SLAB etc.
Message-Id: <20141023.130258.548864295965807596.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20141020.145746.428441452740929005.davem@davemloft.net>
	<20141022.163949.1761351331649936601.davem@davemloft.net>
	<alpine.LRH.2.11.1410230221360.28745@adalberg.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1410230221360.28745@adalberg.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 23 Oct 2014 02:22:36 +0300 (EEST)

>> Whilst I don't have access to my reproducer machine until tomorrow in
>> order to test this myself, I wanted to toss this patch your way so you
>> could get a head start on me.
> 
> Unfortunately it fails earlier during the boot:
> 
> [   25.232318] clocksource: mult[53555555] shift[24]
> [   25.288559] clockevent: mult[3126e98] shift[32]
> [   25.342813] Console: colour dummy device 80x25
> [   25.395990] console [tty0] enabled
> [   25.436726] bootconsole [earlyprom0] disabled
> ERROR: Last Trap: Memory Address not Aligned
> 
> ok

I can reproduce and I know what the problem is, fixed patch coming up
shortly.

Thanks for all of your help so far!
