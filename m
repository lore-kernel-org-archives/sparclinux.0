From: David Miller <davem@davemloft.net>
Date: Fri, 17 Aug 2012 07:24:43 +0000
Subject: Re: PCI resource allocation problem on Sun Ultra 10
Message-Id: <20120817.002443.1165562804832527200.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1208161813240.11061@math.ut.ee>
	<20120816.132557.173944271888805402.davem@davemloft.net>
	<alpine.SOC.1.00.1208170001370.93@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1208170001370.93@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: sparclinux@vger.kernel.org, linux-pci@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Fri, 17 Aug 2012 10:19:40 +0300 (EEST)

> There are 2 different onboard grpahics "cards" on U5/U10 mainboard, PGX 
> that is ATI Mach 64 with 2M SGRAM and PGX24 that has 4M SGRAM. I have 
> the latter. And these do not seem to need this reservation.

Any VGA capable device can silently decode the VGA region.

It is unconditionally reserved on x86 and other platforms as well.

> Maybe Sun does not support legacy VGA cards in PCI slots (only 
> PCI-assigned areas)?

It doesn't matter if the video card is "PCI assigned", if the chip is
put into VGA mode (which both MACH64 and PGX24 fully support) it will
start responding to accesses to the VGA region.
