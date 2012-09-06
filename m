From: Meelis Roos <mroos@linux.ee>
Date: Thu, 06 Sep 2012 14:41:13 +0000
Subject: PCI Radeon RV100 detection hang on sparc64
Message-Id: <alpine.SOC.1.00.1209061032360.371@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org

This is with initialyy unmodified 3.6.0-rc4-00101-g0809095 kernel in 
Ultra 10 (clean, without my "Video RAM" hack that I talked in other 
sparclinux posts). When I saw that Sun XVR-100 was detected fine by the 
kernel, I compiled radeon drm driver with modesetting enabled and tried 
it:

[drm] radeon defaulting to kernel modesetting.
[drm] radeon kernel modesetting enabled.
PCI: Enabling device: (0000:02:02.0), cmd 82
[drm] initializing kernel modesetting (RV100 0x1002:0x5159 0x1002:0x0908).
[drm] register mmio base: 0x10000000
[drm] register mmio size: 32768
[drm:radeon_device_init] *ERROR* Unable to find PCI I/O BAR

And here the machine hangs. Debugging printk-s reveal that it does not 
find any active I/O port resources and then continues into initializing 
the card. Down in igp_read_bios_from_vram() it successfully ioremaps 
memory region 0 (vram_basef08000000 and size@000) and tries to read 
2 bytes from there and hangs on reading bios[0].

With radeon.modeset=0, it boots and I collected the following info:

02:02.0 VGA compatible controller: Advanced Micro Devices [AMD] nee ATI RV100 QY [Radeon 7000/VE] (prog-if 00 [VGA controller])
        Subsystem: Advanced Micro Devices [AMD] nee ATI XVR-100 (supplied by Sun)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0 (2000ns min)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at 08000000 (32-bit, prefetchable) [sizedM]
        Region 1: I/O ports at 0400 [disabled] [size%6]
        Region 2: Memory at 10000000 (32-bit, non-prefetchable) [size2K]
        Region 3: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) [size=1]
        Region 4: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) [size=1]
        Region 5: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) [size=1]
        Expansion ROM at 10020000 [disabled] [size8K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

# cat /proc/iomem 
1fc00400000-1fc0040000f : ffb dac
1fc00600000-1fc00600983 : ffb fbc
1ff00000000-1ffffffffff : /pci@1f,0
  1ff00002000-1ff00002fff : aic7xxx
  1ff000a0000-1ff000bffff : Video RAM area
  1ff000f0000-1ff000fffff : System ROM
  1ff11000000-1ff11ffffff : atyfb
  1ff12040000-1ff1204ffff : tg3
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


-- 
Meelis Roos (mroos@linux.ee)
