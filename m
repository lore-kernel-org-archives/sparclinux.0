From: David Miller <davem@davemloft.net>
Date: Fri, 06 Feb 2009 08:55:59 +0000
Subject: Re: hang on panic, can not return to OBP
Message-Id: <20090206.005559.51169752.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0902051204550.17957@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0902051204550.17957@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 5 Feb 2009 16:07:14 +0200 (EET)

> First, why tell the user to press Stop-A or break at all? Is it because 
> we can extract information from Break-T, Break-P etc? Otherwise the 
> panic code could drop to prom itself?

You might want to hit SysRQ-something to extract information,
remount root read-only, unmount all partitions, force another
sync, etc. before dropping to the prom.

> I tried the following patch and that did not work - probably because of 
> the same reason that Break did not work (interrupts off?). Seems the 
> local_irq_enable() is not enough - but what could help here? Is 
> prom_halt() the right thing? ... Kad a look of waht Stop-A does, tried 
> also the second patch... but if it would have worked, Stop-A wouldb 
> prpbaly also have.
> 
> This patch is of course not even close to merging, it's just a hack to 
> try it out.

What kind of console are you on?

For serial consoles, you have to send BREAK twice.

For traditional type4/5 serial keyboards, Stop-A should work.

For USB keyboard nothing is going to work, sorry.

PROM console will also not work for fetching input and
breaking into the firmware.
