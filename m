From: Meelis Roos <mroos@linux.ee>
Date: Sun, 29 Jul 2007 16:32:47 +0000
Subject: Re: ioctl32 warning on framebuffer
Message-Id: <Pine.SOC.4.64.0707291925500.6943@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0707272220560.1678@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0707272220560.1678@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > ioctl32(Xorg:1892): Unknown cmd fd(6) cmd(40584606){t:'F';sz:88} arg(ffdabb4c) on /dev/fb0 
> > ioctl32(Xorg:1892): Unknown cmd fd(6) cmd(40184600){t:'F';sz:24} arg(ffdabb54) on /dev/fb0
> 
> Please give this patch a try:

The warnings are gone but I do not know whether X actually work since 
the box is headless in a rack and X runs only by accident (it rised its 
head again when I enabled atyfb compilation). Trying to run X by hand 
now gives

Fatal server error:
xf86MapPciMem: Could not mmap PCI memory [base=0xe2000000,hostbase=0xe2000000,size 00] (Inappropriate ioctl for device)
but this could be because OF may have disabled the device (OF thinks 
there is no monitor since the ID pins in VGA connector have appearantly broken - 
but no visible brokenness).

lspci tells
01:02.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro 215GP (rev 5c) (prog-if 00 [VGA])
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 13
        Region 0: Memory at 1ffe1000000 (32-bit, non-prefetchable) [sizeM]
        Region 1: I/O ports at <unassigned> [disabled]
        Region 2: Memory at 1ffe2000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <ignored> [disabled]

so the memory regions are at 1ffe1000000, not e2000000 - but maybe this 
is remapped automatically?

So, the warnings are gone but I don't know whether this could have 
broken X or not.

-- 
Meelis Roos (mroos@linux.ee)
