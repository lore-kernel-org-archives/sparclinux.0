From: Meelis Roos <mroos@linux.ee>
Date: Tue, 21 Aug 2007 16:21:04 +0000
Subject: Re: oops in sunsab_interrupt
Message-Id: <Pine.SOC.4.64.0708211920060.11695@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0708211359080.24028@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0708211359080.24028@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> atyfb: 3D RAGE PRO (Mach64 GP, PQFP, PCI) [0x4750 rev 0x7c]
> atyfb: 4M SGRAM (1:1), 14.31818 MHz XTAL, 230 MHz PLL, 100 Mhz MCLK, 100 MHz XCLK
> Console: switching to colour frame buffer device 144x56
> atyfb: fb0: ATY Mach64 frame buffer device on PCI
> /pci@1f,0/pci@1,1/ebus@1/su@14,3083f8: Keyboard port at 1fff13083f8, irq 6
> /pci@1f,0/pci@1,1/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8, irq 7

Normally, the lines about serial console detection appear here, so it's 
not serial handoff but detection:

f0061c64: ttyS0 at MMIO 0x1fff1400000 (irq = 5) is a SAB82532 V3.2
Console: ttyS0 (SAB82532)
f0061c64: ttyS1 at MMIO 0x1fff1400040 (irq = 5) is a SAB82532 V3.2


-- 
Meelis Roos (mroos@linux.ee)
