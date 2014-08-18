From: David Miller <davem@davemloft.net>
Date: Mon, 18 Aug 2014 17:38:50 +0000
Subject: Re: sparc64 WARNING: at mm/mmap.c:2757 exit_mmap+0x13c/0x160()
Message-Id: <20140818.103850.2072106996313096989.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1408151534480.27263@math.ut.ee>
	<alpine.SOC.1.00.1408181528270.2922@math.ut.ee>
	<20140818173552.GA2126@drone.musicnaut.iki.fi>
In-Reply-To: <20140818173552.GA2126@drone.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: aaro.koskinen@iki.fi
Cc: mroos@linux.ee, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, hughd@google.com, cat.schulze@alice-dsl.net

From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 18 Aug 2014 20:35:52 +0300

> Hi,
> 
> On Mon, Aug 18, 2014 at 03:30:16PM +0300, Meelis Roos wrote:
>> > U1, U2, U5, U10, E220R, E420R later or some other day, whenever I get 
>> > to them physically.
>> 
>> Ultra 5 is bad news with 3.17-rc1: it almost boots up, then aftyer 
>> strarting postfix and ntpd, gets RED state exception and contiunes 
>> looping with it (before it gor RED state only after prom reboot).
> 
> My Ultra 5 is fine with 3.17-rc1 (I'm writing this mail from it),
> also Ultra 10 seems to be OK based on quick test.
> 
> I'm going to run GCC 4.9.1 bootstrap & testsuite on these machines
> maybe next week. Unfortunately due to summer schedules I'm a bit lost
> if there are still some special patches I should try (to get rid
> of $SUBJECT)? If not I'll probably try it with plain 3.17-rc2.

All patches are in 3,17-rc1

