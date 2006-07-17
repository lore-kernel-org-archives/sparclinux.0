From: David Miller <davem@davemloft.net>
Date: Mon, 17 Jul 2006 22:52:55 +0000
Subject: Re: 2.6.18-rc1 fails to boot on E250
Message-Id: <20060717.155255.34757970.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060714.165308.83620688.davem@davemloft.net>
In-Reply-To: <20060714.165308.83620688.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Marc Zyngier <maz@misterjones.org>
Date: Mon, 17 Jul 2006 14:33:59 +0200

> Then, we still have a problem with sunsab, as ports are registered in
> a different order from what we had in 2.6.15 :
> 
> [    7.949257] ttyS0 at MMIO 0x1fff1400000 (irq = 7790816) is a SAB82532 V3.2
> [    7.949508] Console: ttyS0 (SAB82532)
> [   11.662182] ttyS1 at MMIO 0x1fff1400040 (irq = 7790816) is a SAB82532 V3.2
> [   11.743901] ttyS2 at MMIO 0x1fff1200000 (irq = 7790560) is a SAB82532 V3.2
> [   11.826468] ttyS3 at MMIO 0x1fff1200040 (irq = 7790560) is a SAB82532 V3.2
> 
> Would have to swap between 0x1fff1400000 and 0x1fff1400040. I'll try
> to come up with a patch if I can spare some time tonight.
> 
> Finally, it looks like the box silently hangs as soon as it reaches
> user-mode. Irk...

Good spotting, your followup patch is correct.

I hooked up a serial console line to my ultra60 and will try
to work this out.  I think the problem is not related to
interrupts this time.
