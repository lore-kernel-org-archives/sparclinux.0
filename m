From: Meelis Roos <mroos@linux.ee>
Date: Fri, 17 Aug 2012 07:19:40 +0000
Subject: Re: PCI resource allocation problem on Sun Ultra 10
Message-Id: <alpine.SOC.1.00.1208170001370.93@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1208161813240.11061@math.ut.ee> <20120816.132557.173944271888805402.davem@davemloft.net>
In-Reply-To: <20120816.132557.173944271888805402.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-pci@vger.kernel.org

> > I tried to populate my Sun Ultra 10 with PCI cards. All but the last 
> > slot work but the last slot is assigned a non-working BAR. It sees that 
> > this area is reserved for Video ROM. Why is there Video ROM placeholder 
> > at that address - I see no resource in ATI VGA for it?
> 
> It's not a "placeholder", it's absolutely necessary because this range
> is implicitly decoded by any VGA capable device in the system.
>
> Therefore no device should ever be allocated that part of the address
> space.
> 
> If OBP is allocating this range to non-VGA devices, it's buggy, and is
> risking multiple devices responding at the same time to an I/O space
> access.

There are 2 different onboard grpahics "cards" on U5/U10 mainboard, PGX 
that is ATI Mach 64 with 2M SGRAM and PGX24 that has 4M SGRAM. I have 
the latter. And these do not seem to need this reservation.

Maybe Sun does not support legacy VGA cards in PCI slots (only 
PCI-assigned areas)?

The onboard PCI VGA is on PCIB, slots are on PCIA bus. So this code 
protects against PCI VGA cards that have ROM and decode in on c0000 even 
after being set up on PCI, OK.

PCI address assignment section from Sun Ultra 10 service manual tells
0x4000.0000 - 0x7FFF.FFFF, 1 Gbyte, PCI bus A memory space (PCI slots 
 APB ASIC register(equals 0xc))
0x40.0000 - 0x7f.ffff, 4 Mbytes, PCI bus A I/O space (PCI slots)

I can not correlate these to any number I saw in OBP and Linux 
assignments... there is only
assigned-addresses:  83022010.00000000.000c0000.00000000.00010000
and that has c0000. 

And a magic section C.3.3.1 telling
PCI bus A has all the PCI slots and the address is programmable by the 
OpenBoot Prom (OBP).

Any idea how I can change the slots address assignment from OBP? The 
setting are result of "set-defaults" plus changing boot device to 
Adaptec scsi and maybe changing console.

http://developers.sun.com/solaris/developer/support/driver/wps/pci/html/Device_Prop.doc.html 
talks about what assigned-addresses and regs mean but that's not that. 
Neither does "OpenBoot 4.x Command Reference Manual" help here.

As a test, I removed the Video ROM reservation and tg3 of course started 
working since there was no VGA on that bus. What should I do to cause 
some problem without Video ROM area - try different old PCI graphics 
cards in slots 2 and 3?

On what other PCI Sun that could be a problem? I could probably test it 
:)

-- 
Meelis Roos (mroos@linux.ee)
