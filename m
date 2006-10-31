From: Meelis Roos <mroos@linux.ee>
Date: Tue, 31 Oct 2006 15:40:35 +0000
Subject: serial port registration messages
Message-Id: <Pine.SOC.4.61.0610311728060.27442@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

In current 2.6.19-rc on sparc64 dmesg tells

/pci@1f,0/pci@1,1/ebus@1/su@14,3083f8: Keyboard port at 1fff13083f8, irq 6
/pci@1f,0/pci@1,1/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8, irq 7
f0061c64: ttyS0 at MMIO 0x1fff1400000 (irq = 5) is a SAB82532 V3.2
f0061c64: ttyS1 at MMIO 0x1fff1400040 (irq = 5) is a SAB82532 V3.2

And in Jurij's 2.6.18 Debian kernel package on sparc32 (the fixed one) 
tells

/iommu@0,10000000/sbus@0,10001000/cgsix@2,0: CGsix [TGX+ sparc] at 0:40000000
/iommu@0,10000000/sbus@0,10001000/cgsix@3,0: CGsix [TGX+ sparc] at 0:50000000
ffd31c10: ttyS0 at MMIO 0x71100000 (irq = 44) is a zs
ffd31c10: ttyS1 at MMIO 0x71100004 (irq = 44) is a zs
ffd31cf0: Keyboard at MMIO 71000000 (irq = 44) is a zs
ffd31cf0: Mouse at MMIO 71000004 (irq = 44) is a zs

I understand this is a fallout of the recent fixes of openprom names 
(the same bus_id patch?), but this is somewhat confusing (like, WTF).

Maybe we should just increase the buffer size (too)?

-- 
Meelis Roos (mroos@linux.ee)
