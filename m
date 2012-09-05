From: Meelis Roos <mroos@linux.ee>
Date: Wed, 05 Sep 2012 14:21:32 +0000
Subject: Re: PCI resource allocation problem on Sun Ultra 10
Message-Id: <alpine.SOC.1.00.1208241617540.6161@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1208161813240.11061@math.ut.ee> <20120816.132557.173944271888805402.davem@davemloft.net> <alpine.SOC.1.00.1208170001370.93@math.ut.ee> <20120817.002443.1165562804832527200.davem@davemloft.net>
In-Reply-To: <20120817.002443.1165562804832527200.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-pci@vger.kernel.org

> > There are 2 different onboard grpahics "cards" on U5/U10 mainboard, PGX 
> > that is ATI Mach 64 with 2M SGRAM and PGX24 that has 4M SGRAM. I have 
> > the latter. And these do not seem to need this reservation.
> 
> Any VGA capable device can silently decode the VGA region.
> 
> It is unconditionally reserved on x86 and other platforms as well.
> 
> > Maybe Sun does not support legacy VGA cards in PCI slots (only 
> > PCI-assigned areas)?
> 
> It doesn't matter if the video card is "PCI assigned", if the chip is
> put into VGA mode (which both MACH64 and PGX24 fully support) it will
> start responding to accesses to the VGA region.

OK, I did some tests. Removed Video ROM reservation and put different 
VGA cards into slots 2 and 3 (2 PC VGA cards in many combinations, 1 PC 
and 1 Sun, 2 different Sun F-code ROM cards: mach64 and radeon). What 
happens is that tg3 BARs change if there is a VGA on bus, like this:

1fc00400000-1fc0040000f : ffb dac
1fc00600000-1fc00600983 : ffb fbc
1ff00000000-1ffffffffff : /pci@1f,0
  1ff00002000-1ff00002fff : aic7xxx
  1ff000a0000-1ff000bffff : Video RAM area
  1ff000f0000-1ff000fffff : System ROM
  1ff01000000-1ff01ffffff : atyfb
  1ff02040000-1ff0204ffff : tg3
  1ffc0000000-1ffdfffffff : IOMMU
  1ffe0000000-1ffe000701f : sunhme
  1ffe1000000-1ffe1ffffff : atyfb
  1fff1000000-1fff1001fff : eeprom
  1fff1200000-1fff120000f : cs4231
  1fff13062f8-1fff13062ff : su
  1fff13083f8-1fff13083ff : su
  1fff1400000-1fff140003f : sab
  1fff1400040-1fff140007f : sab
  1fff1702000-1fff170200f : cs4231_pdma
  1fff1704000-1fff170400f : cs4231_cdma
  1fff1724000-1fff1724003 : power
  1fff1726000-1fff1726003 : auxio

So OBP seems to know what it is doing. On U10. I can also test on E220R, 
E250, E450, E3500, V240, Blade 100. I suspect anything newer has not 
gotten worse in this sense...

-- 
Meelis Roos (mroos@linux.ee)
