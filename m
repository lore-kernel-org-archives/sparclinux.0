From: Meelis Roos <mroos@linux.ee>
Date: Mon, 19 Jul 2004 14:14:40 +0000
Subject: serial console garbled on U5
Message-Id: <Pine.GSO.4.44.0407191712500.27151-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I compiled 2.6.8-rc2 on my Ultra 5 and booted it using serial console.
It boot up fine and works too but serial console output is seriously
garbled. Like this:

C:FudSBE anrg t000f0000,wyca 001e00c0
                                     AR:Sae C ofgsaea 001e1000
                                                              AR:DM
tc000 2000]

0
C-R:Ruigbs ]so[2 a[]t N[4
C-R:Ruigbs ]so[3 a[]t N[8
C0PM) u unn t3Mz
                C-R:Ruigbs ]so[1 a[]t N[1
C-R:Ruigbs ]so[2 a[]t N[f
C-R:Ruigbs ]so[3 a[]t N[0
C0PM) u unn t3Mz
                bs:[ui][oe][UWpl s][u s][cp ftre epo][lspo][UWC43]

Kernel output is very garbled, userland output is less garbled but
garbled too. This is new.

su0 at 0x000001fff13062f8 (irq = 4,7ea) is a 16550A
su1 at 0x000001fff13083f8 (irq = 9,7e9) is a 16550A
ttyS0 at MMIO 0x1fff1400000 (irq = 7566176) is a SAB82532 V3.2
ttyS1 at MMIO 0x1fff1400040 (irq = 7566176) is a SAB82532 V3.2
Console: ttyS0 (SAB82532)


-- 
Meelis Roos (mroos@linux.ee)

