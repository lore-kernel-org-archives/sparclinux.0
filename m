From: Meelis Roos <mroos@linux.ee>
Date: Thu, 16 Aug 2012 15:15:24 +0000
Subject: PCI resource allocation problem on Sun Ultra 10
Message-Id: <alpine.SOC.1.00.1208161813240.11061@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org, linux-pci@vger.kernel.org

(resent without typo in sparclinux address - please reply to this one=20
instead)

Hello,

I tried to populate my Sun Ultra 10 with PCI cards. All but the last=20
slot work but the last slot is assigned a non-working BAR. It sees that=20
this area is reserved for Video ROM. Why is there Video ROM placeholder=20
at that address - I see no resource in ATI VGA for it?

Cards are aic7xxx, sym53c895, qla2200 and tg3, in that order. Loading=20
tg3 driver results in

tg3 0000:02:04.0: BAR 0: can't reserve [mem 0x1ff000c0000-0x1ff000cffff]
tg3 0000:02:04.0: Cannot obtain PCI resources, aborting
tg3: probe of 0000:02:04.0 failed with error -16

/proc/iomem, lspci -vvv, prtconf -pv and full dmesg below.

/proc/iomem:
1fc00400000-1fc0040000f : ffb dac
1fc00600000-1fc00600983 : ffb fbc
1ff00000000-1ffffffffff : /pci@1f,0
  1ff00002000-1ff00002fff : aic7xxx
  1ff00020000-1ff000200ff : sym53c8xx
  1ff00022000-1ff00022fff : sym53c8xx
  1ff00080000-1ff00080fff : qla2xxx
  1ff000a0000-1ff000bffff : Video RAM area
  1ff000c0000-1ff000c7fff : Video ROM
  1ff000f0000-1ff000fffff : System ROM
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

lspci -vvv:
00:01.0 PCI bridge: Oracle/SUN Simba Advanced PCI Bridge (rev 13) (prog-if =
00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 1: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Bus: primary=00, secondary=02, subordinate=FF, sec-latencyd
	I/O behind bridge: 00000000-00000fff
	Memory behind bridge: 00000000-000fffff
	Prefetchable memory behind bridge: 00000000-000fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- <SERR- <PERR-
	[virtual] Expansion ROM at fffffe0100000000 [disabled] [size=3D1]
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort+ >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

00:01.1 PCI bridge: Oracle/SUN Simba Advanced PCI Bridge (rev 13) (prog-if =
00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Region 0: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 1: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Bus: primary=00, secondary=01, subordinate=01, sec-latencyd
	I/O behind bridge: 00000000-00000fff
	Memory behind bridge: 00000000-000fffff
	Prefetchable memory behind bridge: 00000000-000fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- <SERR- <PERR-
	[virtual] Expansion ROM at fffffe0100000000 [disabled] [size=3D1]
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort+ >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

01:01.0 Bridge: Oracle/SUN EBUS (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (2500ns min, 6250ns max)
	Region 0: Memory at fffffe0100000000 (32-bit, non-prefetchable) [size=3D1]
	Region 1: Memory at fffffe0100000000 (32-bit, non-prefetchable) [size=3D1]
	Region 2: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 3: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 4: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 5: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Expansion ROM at fffffe0100000000 [disabled] [size=3D1]

01:01.1 Ethernet controller: Oracle/SUN Happy Meal 10/100 Ethernet [hme] (r=
ev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (2500ns min, 1250ns max)
	Interrupt: pin ? routed to IRQ 12
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size(K]
	Region 1: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 2: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 3: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 4: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 5: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Expansion ROM at fffffe0100000000 [disabled] [size=3D1]
	Kernel driver in use: hme

01:02.0 VGA compatible controller: Advanced Micro Devices [AMD] nee ATI 3D =
Rage Pro 215GP (rev 5c) (prog-if 00 [VGA controller])
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 13
	Region 0: Memory at e1000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at fffffe0100000000 [disabled] [size=3D1]
	Region 2: Memory at e2000000 (32-bit, non-prefetchable) [size=3D4K]
	Region 3: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 4: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 5: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Expansion ROM at fffffe0100000000 [disabled] [size=3D1]
	Kernel driver in use: atyfb

01:03.0 IDE interface: Silicon Image, Inc. PCI0646 (rev 03) (prog-if 8f [Ma=
ster SecP SecO PriP PriO])
	Subsystem: Silicon Image, Inc. PCI0646
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 14
	Region 0: I/O ports at c00000 [size=3D8]
	Region 1: I/O ports at c00008 [size=3D4]
	Region 2: I/O ports at c00010 [size=3D8]
	Region 3: I/O ports at c00018 [size=3D4]
	Region 4: I/O ports at c00020 [size=16]
	Region 5: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	[virtual] Expansion ROM at fffffe0100000000 [disabled] [size=3D1]
	Kernel driver in use: pata_cmd64x

02:01.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 128 (2000ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at fffffe0100000000 [disabled] [size=3D1]
	Region 1: Memory at 00002000 (32-bit, non-prefetchable) [size%6]
	Region 2: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 3: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 4: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 5: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Expansion ROM at 00010000 [disabled] [sizedK]
	Kernel driver in use: aic7xxx

02:02.0 SCSI storage controller: LSI Logic / Symbios Logic 53c895 (rev 02)
	Subsystem: Intraserver Technology Inc Device 1100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (7500ns min, 16000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at 0400 [size%6]
	Region 1: Memory at 00020000 (32-bit, non-prefetchable) [size%6]
	Region 2: Memory at 00022000 (32-bit, non-prefetchable) [size=3D4K]
	Region 3: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 4: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 5: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Expansion ROM at 00040000 [disabled] [size%6K]
	Kernel driver in use: sym53c8xx

02:03.0 SCSI storage controller: QLogic Corp. QLA2200 64-bit Fibre Channel =
Adapter (rev 05)
	Subsystem: QLogic Corp. QLA2200
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (16000ns min), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at 0800 [size%6]
	Region 1: Memory at 00080000 (32-bit, non-prefetchable) [size=3D4K]
	Region 2: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 3: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 4: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 5: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Expansion ROM at 000a0000 [disabled] [size=128K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: qla2xxx

02:04.0 Ethernet controller: Fujitsu Limited. Device 11a2 (rev 02)
	Subsystem: Fujitsu Limited. Device 11a2
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at 000c0000 (64-bit, non-prefetchable) [sizedK]
	Region 2: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 3: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 4: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Region 5: [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable) =
[size=3D1]
	Expansion ROM at fffffe0100000000 [disabled] [size=3D1]
	Capabilities: [40] PCI-X non-bridge device
		Command: DPERE- ERO+ RBCQ2 OST=3D1
		Status: Dev=FF:1f.1 64bit+ 133MHz+ SCD- USC- DC=3Dsimple DMMRBC 48 DMOST=
=3D1 DMCRS=16 RSCEM- 266MHz- 533MHz-
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D3col=
d-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [50] Vital Product Data
		Unknown small resource type 00, will not decode more.
	Capabilities: [58] MSI: Enable- Count=3D1/8 Maskable- 64bit+
		Address: d80abf93d96291d0  Data: 0000


prtconf -pv:
System Configuration:  Sun Microsystems  sun4u
Memory size: 1024 Megabytes
System Peripherals (PROM Nodes):

Node 0xf0029970
    .node:  f0029970
    energystar-v2: =20
    reset-reason: 'S-POR'
    idprom:  01800800.209e82fd.00000000.9e82fda9.00000000.00000000.00000000=
.00000000
    interrupt-map:  0000003c.00000000.00000000.f005f9c0.80000033
    interrupt-map-mask:  0000003e.00000000.00000000
    #interrupt-cells:  00000001
    #address-cells:  00000002
    breakpoint-trap:  0000007f
    #size-cells:  00000002
    model: 'SUNW,375-0066'
    name: 'SUNW,Ultra-5_10'
    clock-frequency:  068e7780
    banner-name: 'Sun Ultra 5/10 UPA/PCI (UltraSPARC-IIi 440MHz)'
    device_type: 'upa'

    Node 0xf002cbb4
        .node:  f002cbb4
        name: 'packages'

        Node 0xf0033d38
            .node:  f0033d38
            iso6429-1983-colors: =20
            name: 'terminal-emulator'

        Node 0xf0036a74
            .node:  f0036a74
            disk-write-fix: =20
            name: 'deblocker'

        Node 0xf0037150
            .node:  f0037150
            name: 'obp-tftp'

        Node 0xf0041f10
            .node:  f0041f10
            name: 'disk-label'

        Node 0xf005b3ac
            .node:  f005b3ac
            name: 'SUNW,builtin-drivers'

        Node 0xf00693c4
            .node:  f00693c4
            name: 'sun-keyboard'

    Node 0xf002cc24
        .node:  f002cc24
        stdout:  fff9bdc8
        stdin:  fff9b4c8
        mmu:  fffe8438
        memory:  fffe8638
        bootargs:  00
        bootpath: '/pci@1f,0/pci@1/scsi@1/disk@0,0:a'
        stdout-#lines:  ffffffff
        name: 'chosen'

    Node 0xf002cc90
        .node:  f002cc90
        version: 'OBP 3.31.0 2001/07/25 20:36'
        model: 'SUNW,3.31'
        decode-complete: =20
        aligned-allocator: =20
        relative-addressing: =20
        name: 'openprom'

        Node 0xf002cd20
            .node:  f002cd20
            name: 'client-services'

    Node 0xf002cdc8
        .node:  f002cdc8
        tpe-link-test?: 'true'
        scsi-initiator-id: '7'
        keyboard-click?: 'false'
        keymap: =20
        ttyb-rts-dtr-off: 'false'
        ttyb-ignore-cd: 'true'
        ttya-rts-dtr-off: 'false'
        ttya-ignore-cd: 'true'
        ttyb-mode: '9600,8,n,1,-'
        ttya-mode: '9600,8,n,1,-'
        pcia-probe-list: '1,2,3,4'
        pcib-probe-list: '1,2,3'
        mfg-mode: 'off'
        diag-level: 'max'
        #power-cycles: '281'
        system-board-serial#: =20
        system-board-date: =20
        fcode-debug?: 'false'
        output-device: 'screen'
        input-device: 'keyboard'
        load-base: '16384'
        boot-command: 'boot'
        auto-boot?: 'true'
        watchdog-reboot?: 'false'
        diag-file: =20
        diag-device: 'net'
        boot-file: =20
        boot-device: 'scsidisk'
        local-mac-address?: 'false'
        ansi-terminal?: 'true'
        screen-#columns: '80'
        screen-#rows: '34'
        silent-mode?: 'false'
        use-nvramrc?: 'true'
        nvramrc:  64657661.6c696173.20736373.69646973.6b202f70.63694031.662=
c302f.70636940.312f7363.73694031.2f646973.6b40302c.300a
        security-mode: 'none'
        security-password: =20
        security-#badlogins: '0'
        oem-logo: =20
        oem-logo?: 'false'
        oem-banner: =20
        oem-banner?: 'false'
        hardware-revision: 'UUUUUUUUUUUUUUU'
        last-hardware-update: 'UUUUUUU'
        diag-switch?: 'false'
        name: 'options'

    Node 0xf002ce38
        .node:  f002ce38
        screen: '/SUNW,ffb@1e,0'
        scsidisk: '/pci@1f,0/pci@1/scsi@1/disk@0,0'
        net: '/pci@1f,0/pci@1,1/network@1,1'
        cdrom: '/pci@1f,0/pci@1,1/ide@3/cdrom@2,0:f'
        disk: '/pci@1f,0/pci@1,1/ide@3/disk@0,0'
        disk3: '/pci@1f,0/pci@1,1/ide@3/disk@3,0'
        disk2: '/pci@1f,0/pci@1,1/ide@3/disk@2,0'
        disk1: '/pci@1f,0/pci@1,1/ide@3/disk@1,0'
        disk0: '/pci@1f,0/pci@1,1/ide@3/disk@0,0'
        ide: '/pci@1f,0/pci@1,1/ide@3'
        floppy: '/pci@1f,0/pci@1,1/ebus@1/fdthree'
        ttyb: '/pci@1f,0/pci@1,1/ebus@1/se:b'
        ttya: '/pci@1f,0/pci@1,1/ebus@1/se:a'
        keyboard!: '/pci@1f,0/pci@1,1/ebus@1/su@14,3083f8:forcemode'
        keyboard: '/pci@1f,0/pci@1,1/ebus@1/su@14,3083f8'
        mouse: '/pci@1f,0/pci@1,1/ebus@1/su@14,3062f8'
        name: 'aliases'

    Node 0xf004ca70
        .node:  f004ca70
        reg:  00000000.00000000.00000000.10000000.00000000.20000000.0000000=
0.10000000.00000000.10000000.00000000.10000000.00000000.30000000.00000000.1=
0000000
        available:  00000000.3ff0c000.00000000.00008000.00000000.3feee000.0=
0000000.00010000.00000000.00000000.00000000.3feea000
        name: 'memory'

    Node 0xf004d050
        .node:  f004d050
        translations:  00000000.fffe0000.00000000.00010000.80000000.3ff700b=
6.00000000.fffd8000.00000000.00008000.80000000.3ff600b6.00000000.fffc4000.0=
0000000.00010000.800001fe.0000008e.00000000.fffc2000.00000000.00002000.8000=
01fe.0100008e.00000000.fffbe000.00000000.00004000.80000000.3ff5c0b6.0000000=
0.fffbc000.00000000.00002000.800001ff.f100008e.00000000.fffba000.00000000.0=
0002000.800001ff.f100008e.00000000.fffb8000.00000000.00002000.800001ff.f172=
408e.00000000.fffb6000.00000000.00002000.800001ff.f172608e.00000000.fffb400=
0.00000000.00002000.800001ff.f172808e.00000000.fffb2000.00000000.00002000.8=
00001ff.f172a08e.00000000.fffb0000.00000000.00002000.800001ff.f172c08e.0000=
0000.fffae000.00000000.00002000.800001ff.f172e08e.00000000.fffac000.0000000=
0.00002000.800001ff.f130808e.00000000.fffaa000.00000000.00002000.80000000.3=
fefe0b6.00000000.fffa8000.00000000.00002000.80000000.3ff580b6.00000000.fffa=
6000.00000000.00002000.800001ff.f130208e.00000000.fffa4000.00000000.0000200=
0.800001ff.f170
 608e.00000000.fffa2000.00000000.00002000.800001ff.f172008e.00000000.fffa00=
00.00000000.00002000.800001ff.f130208e.00000000.fff9e000.00000000.00002000.=
800001ff.f140008e.00000000.fff9a000.00000000.00002000.80000000.3ff500b6.000=
00000.fff7e000.00000000.0000c000.80000000.3ff3a0b6.00000000.fff0a000.000000=
00.00002000.800001fc.0061008e.00000000.f00ac000.00000000.00002000.80000000.=
3ff180b6.00000000.f00aa000.00000000.00002000.80000000.3ff1a0b6.00000000.f00=
a8000.00000000.00002000.80000000.3ff1c0b6.00000000.f00a6000.00000000.000020=
00.80000000.3ff1e0b6.00000000.f00a4000.00000000.00002000.80000000.3ff200b6.=
00000000.f00a2000.00000000.00002000.80000000.3ff220b6.00000000.f00a0000.000=
00000.00002000.80000000.3ff240b6.00000000.f009e000.00000000.00002000.800000=
00.3ff260b6.00000000.f009c000.00000000.00002000.80000000.3ff280b6.00000000.=
f009a000.00000000.00002000.80000000.3ff2a0b6.00000000.f0098000.00000000.000=
02000.80000000.3ff2c0b6.00000000.f0096000.00000000.00002000.80000000.3ff2e0=
b6.00000000.f00
 94000.00000000.00002000.80000000.3ff300b6.00000000.f0092000.00000000.00002=
000.80000000.3ff320b6.00000000.f0090000.00000000.00002000.80000000.3ff340b6=
.00000000.f008e000.00000000.00002000.80000000.3ff360b6.00000000.f008c000.00=
000000.00002000.80000000.3ff380b6.00000000.f0088000.00000000.00004000.80000=
000.3ff520b6.00000000.f0086000.00000000.00002000.80000000.3ff460b6.00000000=
.f0084000.00000000.00002000.80000000.3ff4a0b6.00000000.f0082000.00000000.00=
002000.80000000.3ff4c0b6.00000000.f0080000.00000000.00002000.80000000.3ff4e=
0b6.00000000.f0000000.00000000.00080000.80000000.3ff800b6.00000000.40000000=
.00000000.04000000.80000000.00400036.00000000.00002000.00000000.00bfe000.80=
000000.00002036
        existing:  00000000.00000000.00000800.00000000.fffff800.00000000.00=
000800.00000000
        available:  fffff800.00000000.000007fc.00000000.00000001.00000000.0=
00007ff.00000000.00000000.ffff0000.00000000.0000e000.00000000.00000000.0000=
0000.f0000000.00000000.fff9c000.00000000.00002000.00000000.fff8a000.0000000=
0.00010000.00000000.fff0c000.00000000.00072000.00000000.fff00000.00000000.0=
000a000.00000000.f0800000.00000000.0e800000
        page-size:  00002000
        name: 'virtual-memory'

    Node 0xf005f9c0
        .node:  f005f9c0
        bus-range:  00000000.00000002
        available:  82000000.00000000.000d0000.00000000.fff30000.81000000.0=
0000000.00000900.00000000.00fff700
        virtual-dma:  c0000000.20000000
        #virtual-dma-size-cells:  00000001
        #virtual-dma-addr-cells:  00000001
        latency-timer: =20
        address:  fffc4000.fffc2000
        button-interrupt: =20
        no-streaming-cache: =20
        clock-frequency:  03ef1480
        upa-portid:  0000001f
        66mhz-capable: =20
        interrupts:  000007f0.000007ee.000007ef.000007e5
        ranges:  00000000.00000000.00000000.000001fe.01000000.00000000.0100=
0000.01000000.00000000.00000000.000001fe.02000000.00000000.01000000.0200000=
0.00000000.00000000.000001ff.00000000.00000001.00000000.03000000.00000000.0=
0000000.000001ff.00000000.00000001.00000000
        reg:  000001fe.00000000.00000000.00010000.000001fe.01000000.0000000=
0.00000100
        model: 'SUNW,sabre'
        compatible:  70636931.3038652c.61303030.00706369.636c6173.732c3000
        bus-parity-generated: =20
        #size-cells:  00000002
        #address-cells:  00000003
        device_type: 'pci'
        name: 'pci'

        Node 0xf00601b4
            .node:  f00601b4
            bus-range:  00000001.00000001
            scsi-initiator-id:  00000007
            compatible:  70636931.3038652c.35303030.2e313300.70636931.30386=
52c.35303030.00706369.636c6173.732c3036.30343030.00706369.636c6173.732c3036=
.303400
            66mhz-capable: =20
            fast-back-to-back: =20
            devsel-speed:  00000001
            class-code:  00060400
            revision-id:  00000013
            device-id:  00005000
            vendor-id:  0000108e
            interrupt-map:  00010800.00000000.00000000.00000001.f005f9c0.00=
000021.00011000.00000000.00000000.00000001.f005f9c0.0000000f.00011800.00000=
000.00000000.00000001.f005f9c0.00000020
            interrupt-map-mask:  00fff800.00000000.00000000.00000007
            #interrupt-cells:  00000001
            slot-names:  00000000
            no-probe-list: '0'
            clock-frequency:  01f78a40
            model: 'SUNW,simba'
            #address-cells:  00000003
            #size-cells:  00000002
            reg:  00000900.00000000.00000000.00000000.00000000
            device_type: 'pci'
            name: 'pci'

            Node 0xf0061504
                .node:  f0061504
                fast-back-to-back: =20
                devsel-speed:  00000001
                class-code:  00068000
                max-latency:  00000019
                min-grant:  0000000a
                revision-id:  00000001
                device-id:  00001000
                vendor-id:  0000108e
                interrupt-map:  00000014.003043bc.00000001.f005f9c0.0000002=
2.00000014.00200000.00000001.f005f9c0.00000023.00000014.00200000.00000002.f=
005f9c0.00000024.00000014.00724000.00000001.f005f9c0.00000025.00000014.0030=
23f0.00000001.f005f9c0.00000027.00000014.003083f8.00000001.f005f9c0.0000002=
9.00000014.003062f8.00000001.f005f9c0.0000002a.00000014.00400000.00000001.f=
005f9c0.0000002b
                interrupt-map-mask:  0000001f.00ffffff.00000003
                #interrupt-cells:  00000001
                ranges:  00000010.00000000.82010810.00000000.f0000000.01000=
000.00000014.00000000.82010814.00000000.f1000000.00800000
                reg:  00010800.00000000.00000000.00000000.00000000.82010810=
.00000000.f0000000.00000000.01000000.82010814.00000000.f1000000.00000000.00=
800000
                #size-cells:  00000001
                #address-cells:  00000002
                name: 'ebus'

                Node 0xf0061a40
                    .node:  f0061a40
                    address:  fffb6000.fffb4000.fffb2000.fffb0000.fffaf000
                    reg:  00000014.00726000.00000004.00000014.00728000.0000=
0004.00000014.0072a000.00000004.00000014.0072c000.00000004.00000014.0072f00=
0.00000004
                    name: 'auxio'

                Node 0xf0061b00
                    .node:  f0061b00
                    address:  fffb8000
                    button: =20
                    interrupts:  00000001
                    reg:  00000014.00724000.00000004
                    name: 'power'

                Node 0xf0061bd0
                    .node:  f0061bd0
                    freq-syn: 'MC12430'
                    reg:  00000014.00504000.00000003
                    name: 'SUNW,pll'

                Node 0xf0061c64
                    .node:  f0061c64
                    port-b-ignore-cd: =20
                    port-a-ignore-cd: =20
                    interrupts:  00000001
                    reg:  00000014.00400000.00000080
                    device_type: 'serial'
                    name: 'se'

                Node 0xf0063594
                    .node:  f0063594
                    reg:  00000014.003083f8.00000008
                    interrupts:  00000001
                    port-a-ignore-cd: =20
                    keyboard: =20
                    device_type: 'serial'
                    name: 'su'

                Node 0xf0064df4
                    .node:  f0064df4
                    interrupts:  00000001
                    port-a-ignore-cd: =20
                    mouse: =20
                    reg:  00000014.003062f8.00000008
                    device_type: 'serial'
                    name: 'su'

                Node 0xf0064f10
                    .node:  f0064f10
                    interrupts:  00000001
                    reg:  00000014.003043bc.00000010.00000014.0030015c.0000=
0002.00000014.00700000.00000010
                    name: 'ecpp'

                Node 0xf0065010
                    .node:  f0065010
                    manual: =20
                    unit:  00000000
                    address:  fffa63f0.fffa4000.fffa2000
                    device_type: 'block'
                    interrupts:  00000001
                    reg:  00000014.003023f0.00000008.00000014.00706000.0000=
0010.00000014.00720000.00000004
                    name: 'fdthree'

                Node 0xf0066af4
                    .node:  f0066af4
                    address:  fffba000
                    reg:  00000014.00000000.00002000
                    model: 'mk48t59'
                    name: 'eeprom'

                Node 0xf0066bdc
                    .node:  f0066bdc
                    version:  4f425020.332e3331.2e302032.3030312f.30372f32.=
35203230.3a333600.504f5354.20332e31.2e302032.3030302f.30362f32.37203133.3a3=
53600
                    model: 'SUNW,370-3697'
                    reg:  00000010.00000000.00100000
                    name: 'flashprom'

                Node 0xf0066c98
                    .node:  f0066c98
                    model: 'SUNW,CS4231h'
                    aux2: 'none'
                    aux1: 'cdrom'
                    interrupts:  00000001.00000002
                    dma-model: 'eb2dma'
                    reg:  00000014.00200000.00000100.00000014.00702000.0000=
0010.00000014.00704000.00000010.00000014.00722000.00000004
                    name: 'SUNW,CS4231'

            Node 0xf0075a80
                .node:  f0075a80
                assigned-addresses:  82010910.00000000.e0000000.00000000.00=
007020
                hm-rev:  000000c1
                device_type: 'network'
                interrupts:  00000001
                address-bits:  00000030
                max-frame-size:  00004000
                reg:  00010900.00000000.00000000.00000000.00000000.02010910=
.00000000.00000000.00000000.00007020
                compatible: 'SUNW,hme'
                name: 'network'
                fast-back-to-back: =20
                devsel-speed:  00000001
                class-code:  00020000
                max-latency:  00000005
                min-grant:  0000000a
                revision-id:  00000001
                device-id:  00001001
                vendor-id:  0000108e

            Node 0xf007d248
                .node:  f007d248
                assigned-addresses:  82011010.00000000.e1000000.00000000.01=
000000.82011018.00000000.e2000000.00000000.00001000
                aty,fcode: '1.60'
                aty,card#: '109-41900-00'
                aty,rom#: '113-41901-104'
                model: 'ATY,GT-C'
                name: 'SUNW,m64B'
                pgx_version: '@(#)pgx24.fth 1.8 01/05/15 '
                reg:  00011000.00000000.00000000.00000000.00000000.02011010=
.00000000.00000000.00000000.01000000.02011018.00000000.00000000.00000000.00=
001000
                character-set: 'ISO8859-1'
                device_type: 'display'
                linebytes:  00000480
                depth:  00000008
                height:  00000384
                width:  00000480
                fb-memory:  00000004
                aty,flags:  00000002
                aty,status:  00000000
                fast-back-to-back: =20
                devsel-speed:  00000001
                class-code:  00030000
                interrupts:  00000001
                max-latency:  00000000
                min-grant:  00000008
                revision-id:  0000005c
                device-id:  00004750
                vendor-id:  00001002

            Node 0xf0085fc8
                .node:  f0085fc8
                assigned-addresses:  81011810.00000000.00c00000.00000000.00=
000008.81011814.00000000.00c00008.00000000.00000004.81011818.00000000.00c00=
010.00000000.00000008.8101181c.00000000.00c00018.00000000.00000004.81011820=
.00000000.00c00020.00000000.00000010
                reg:  00011800.00000000.00000000.00000000.00000000.01011810=
.00000000.00000000.00000000.00000008.01011814.00000000.00000000.00000000.00=
000004.01011818.00000000.00000000.00000000.00000008.0101181c.00000000.00000=
000.00000000.00000004.01011820.00000000.00000000.00000000.00000010
                compatible:  70636931.3039352c.3634362e.31303935.2e363436.2=
e330070.63693130.39352c36.34362e31.3039352e.36343600.70636931.3039352c.3634=
3600.70636931.3039352c.3634362e.33007063.69313039.352c3634.36007063.69636c6=
1.73732c30.31303138.66007063.69636c61.73732c30.31303100
                #address-cells:  00000002
                device_type: 'ide'
                name: 'ide'
                fast-back-to-back: =20
                devsel-speed:  00000001
                class-code:  0001018a
                interrupts:  00000001
                max-latency:  00000004
                min-grant:  00000002
                subsystem-vendor-id:  00001095
                subsystem-id:  00000646
                revision-id:  00000003
                device-id:  00000646
                vendor-id:  00001095

                Node 0xf0088b68
                    .node:  f0088b68
                    device_type: 'block'
                    name: 'disk'
                    compatible: 'ide-disk'

                Node 0xf0089214
                    .node:  f0089214
                    device_type: 'block'
                    name: 'cdrom'
                    compatible: 'ide-cdrom'

        Node 0xf006079c
            .node:  f006079c
            bus-range:  00000002.00000002
            scsi-initiator-id:  00000007
            compatible:  70636931.3038652c.35303030.2e313300.70636931.30386=
52c.35303030.00706369.636c6173.732c3036.30343030.00706369.636c6173.732c3036=
.303400
            66mhz-capable: =20
            fast-back-to-back: =20
            devsel-speed:  00000001
            class-code:  00060400
            revision-id:  00000013
            device-id:  00005000
            vendor-id:  0000108e
            interrupt-map:  00020800.00000000.00000000.00000001.f005f9c0.00=
000010.00020800.00000000.00000000.00000002.f005f9c0.00000011.00020800.00000=
000.00000000.00000003.f005f9c0.00000012.00020800.00000000.00000000.00000004=
.f005f9c0.00000013.00021000.00000000.00000000.00000001.f005f9c0.00000014.00=
021000.00000000.00000000.00000002.f005f9c0.00000015.00021000.00000000.00000=
000.00000003.f005f9c0.00000016.00021000.00000000.00000000.00000004.f005f9c0=
.00000017.00021800.00000000.00000000.00000001.f005f9c0.00000018.00021800.00=
000000.00000000.00000002.f005f9c0.00000019.00021800.00000000.00000000.00000=
003.f005f9c0.0000001a.00021800.00000000.00000000.00000004.f005f9c0.0000001b=
.00022000.00000000.00000000.00000001.f005f9c0.0000001c.00022000.00000000.00=
000000.00000002.f005f9c0.0000001d.00022000.00000000.00000000.00000003.f005f=
9c0.0000001e.00022000.00000000.00000000.00000004.f005f9c0.0000001f
            interrupt-map-mask:  00fff800.00000000.00000000.00000007
            #interrupt-cells:  00000001
            slot-names:  0000001e.70636961.20736c6f.74203100.70636961.20736=
c6f.74203200.70636961.20736c6f.74203300.70636961.20736c6f.74203400
            no-probe-list: '0'
            clock-frequency:  01f78a40
            model: 'SUNW,simba'
            #address-cells:  00000003
            #size-cells:  00000002
            reg:  00000800.00000000.00000000.00000000.00000000
            device_type: 'pci'
            name: 'pci'

            Node 0xf0089c1c
                .node:  f0089c1c
                assigned-addresses:  82020814.00000000.00002000.00000000.00=
000100.82020830.00000000.00010000.00000000.00010000
                scsi-initiator-id:  00000007
                wide: =20
                name: 'scsi'
                compatible:  41445054.2c414841.2d323934.30555700.41445054.2=
c414841.2d323934.30550070.63693930.30342c38.31373800.73637369.00
                product: 'AHA-2940U/UW'
                model: 'ADPT,AIC-7881'
                device_type: 'scsi-2'
                status: 'okay'
                power-consumption:  00000000.00000000.007270e0.007270e0.000=
00000.00000000.007b98a0.007b98a0
                reg:  00020800.00000000.00000000.00000000.00000000.02020814=
.00000000.00000000.00000000.00000100.02020830.00000000.00000000.00000000.00=
010000
                version: 'v1.04'
                fcode-rom-offset:  00000000
                fast-back-to-back: =20
                devsel-speed:  00000001
                class-code:  00010000
                interrupts:  00000001
                max-latency:  00000008
                min-grant:  00000008
                revision-id:  00000000
                device-id:  00008178
                vendor-id:  00009004

                Node 0xf009bfc8
                    .node:  f009bfc8
                    device_type: 'block'
                    name: 'disk'

                Node 0xf009c9ec
                    .node:  f009c9ec
                    device_type: 'byte'
                    name: 'tape'

            Node 0xf009d5c0
                .node:  f009d5c0
                assigned-addresses:  81021010.00000000.00000400.00000000.00=
000100.82021014.00000000.00020000.00000000.00000100.82021018.00000000.00022=
000.00000000.00001000.82021030.00000000.00040000.00000000.00040000
                compatible:  70636931.3365392c.63007063.69313030.302c6300.6=
9747370.7300
                model: 'ITI-61xx'
                wide: =20
                clock-frequency:  02625a00
                reg:  00021000.00000000.00000000.00000000.00000000.01021010=
.00000000.00000000.00000000.00000100.02021014.00000000.00000000.00000000.00=
000100.02021018.00000000.00000000.00000000.00001000.02021030.00000000.00000=
000.00000000.00040000
                name: 'IntraServer-Ultra2,scsi'
                device_type: 'scsi-2'
                arc-identifier: 'NCRC810'
                has-fcode: ' '
                version: '1.0.8'
                fcode-rom-offset:  00000000
                devsel-speed:  00000001
                class-code:  00010000
                interrupts:  00000001
                max-latency:  00000040
                min-grant:  0000001e
                subsystem-vendor-id:  000013e9
                subsystem-id:  00001100
                revision-id:  00000002
                device-id:  0000000c
                vendor-id:  00001000

                Node 0xf00a22cc
                    .node:  f00a22cc
                    compatible: 'sd'
                    device_type: 'block'
                    name: 'disk'

                Node 0xf00a2e28
                    .node:  f00a2e28
                    compatible: 'st'
                    device_type: 'byte'
                    name: 'tape'

            Node 0xf00a3c6c
                .node:  f00a3c6c
                assigned-addresses:  81021810.00000000.00000800.00000000.00=
000100.82021814.00000000.00080000.00000000.00001000.82021830.00000000.000a0=
000.00000000.00020000
                power-consumption:  00000000.007270e0
                reg:  00021800.00000000.00000000.00000000.00000000.01021810=
.00000000.00000000.00000000.00000100.02021814.00000000.00000000.00000000.00=
001000.02021830.00000000.00000000.00000000.00020000
                compatible:  70636931.3037372c.32323030.2e313037.372e322e.3=
5007063.69313037.372c3232.30302e31.3037372e.32007063.69313037.372c3200.7063=
6931.3037372c.32323030.2e350070.63693130.37372c32.32303000.70636963.6c61737=
3.2c303130.30303000.70636963.6c617373.2c303130.3000
                name: 'scsi'
                66mhz-capable: =20
                fast-back-to-back: =20
                devsel-speed:  00000001
                class-code:  00010000
                interrupts:  00000001
                max-latency:  00000000
                min-grant:  00000040
                subsystem-vendor-id:  00001077
                subsystem-id:  00000002
                revision-id:  00000005
                device-id:  00002200
                vendor-id:  00001077

            Node 0xf00a3fc4
                .node:  f00a3fc4
                assigned-addresses:  83022010.00000000.000c0000.00000000.00=
010000
                local-mac-address:  00e000a9.096a
                fjgiga-rev:  000000c2
                product-name: 'FJSV,pgsb'
                device_type: 'network'
                address-bits:  00000030
                max-frame-size:  00004000
                reg:  00022000.00000000.00000000.00000000.00000000.03022010=
.00000000.00000000.00000000.00010000
                model: 'Broadcom,BCM5703S'
                compatible: 'fjgi'
                name: 'FJSV,pgsb'
                media-type: '1000BASE-SX'
                fcode-rom-offset:  00000000
                66mhz-capable: =20
                fast-back-to-back: =20
                devsel-speed:  00000001
                class-code:  00020000
                interrupts:  00000001
                max-latency:  00000000
                min-grant:  00000040
                subsystem-vendor-id:  000010cf
                subsystem-id:  000011a2
                revision-id:  00000002
                device-id:  000011a2
                vendor-id:  000010cf

    Node 0xf006d5ec
        .node:  f006d5ec
        manufacturer#:  00000017
        implementation#:  00000012
        mask#:  00000091
        sparc-version:  00000009
        ecache-associativity:  00000001
        ecache-line-size:  00000040
        ecache-size:  00200000
        #dtlb-entries:  00000040
        dcache-associativity:  00000001
        dcache-line-size:  00000020
        dcache-size:  00004000
        #itlb-entries:  00000040
        icache-associativity:  00000002
        icache-line-size:  00000020
        icache-size:  00004000
        upa-portid:  00000000
        clock-frequency:  1a39de00
        reg:  000001c0.00000000.00000000.00000008
        device_type: 'cpu'
        name: 'SUNW,UltraSPARC-IIi'

    Node 0xf006dee0
        .node:  f006dee0
        character-set: 'ISO8859-1'
        address:  febc0000
        ihandle:  fff9b758
        reg:  000001fc.00000000.00000000.00000400.000001fc.00400000.0000000=
0.00200000.000001fc.00600000.00000000.00200000.000001fc.01000000.00000000.0=
0400000.000001fc.01400000.00000000.00400000.000001fc.01800000.00000000.0040=
0000.000001fc.01c00000.00000000.00400000.000001fc.02000000.00000000.0100000=
0.000001fc.03000000.00000000.01000000.000001fc.04000000.00000000.00400000.0=
00001fc.04400000.00000000.00400000.000001fc.04800000.00000000.00400000.0000=
01fc.04c00000.00000000.00400000.000001fc.05000000.00000000.01000000.000001f=
c.06000000.00000000.02000000.000001fc.09000000.00000000.00800000.000001fc.0=
9800000.00000000.00800000.000001fc.0a000000.00000000.01000000.000001fc.0b00=
0000.00000000.00800000.000001fc.0b800000.00000000.00800000.000001fc.0c00000=
0.00000000.00400000.000001fc.0c800000.00000000.00800000.000001fc.0d000000.0=
0000000.00800000.000001fc.0d800000.00000000.00800000
        fbc_reg_id:  3241906d
        ramdac_rev:  00000001
        fcode_version: '@(#)ffb2p.fth 2.6 97/10/02'
        model: 'SUNW,501-4788'
        board_type:  00000033
        upa-interrupt-slave: =20
        interrupts:  00000005
        upa-portid:  0000001e
        monitor_mode:  00000000
        v_freq:  0000004c
        height:  00000384
        width:  00000480
        edid_data:  00000000.00000000.00000000.00000000.00000000.00000000.0=
0000000.00000000.00000000.00000000.00000000.00000000.00000000.00000000.0000=
0000.00000000.00000000.00000000.00000000.00000000.00000000.00000000.0000000=
0.00000000.00000000.00000000.00000000.00000000.00000000.00000000.00000000.0=
0000000
        no_edid_blks:  00000000
        device_type: 'display'
        name: 'SUNW,ffb'

dmesg:
PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:36'
PROMLIB: Root node compatible:=20
Initializing cgroup subsys cpu
Linux version 3.6.0-rc1-00355-gddf343f (mroos@u10) (gcc version 4.6.3 (Debi=
an 4.6.3-8) ) #37 Thu Aug 16 03:28:04 EEST 2012
debug: ignoring loglevel setting.
bootconsole [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 08:00:20:9e:82:fd
Kernel: Using 2 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /pci@1f,0/pci@1,1/ebus@1/se@14,400000:a
PROM: Built device tree with 56350 bytes of memory.
Top of RAM: 0x3ff14000, Total RAM: 0x3ff02000
Memory hole size: 0MB
[0000010000000000-fffff8003f800000] page_structs=131072 node=3D0 entry=3D0/=
8192
[0000010000000000-fffff8003f400000] page_structs=131072 node=3D0 entry=3D1/=
8192
Zone ranges:
  Normal   [mem 0x00000000-0x3ff13fff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x00000000-0x3fee9fff]
  node   0: [mem 0x3feee000-0x3fefdfff]
  node   0: [mem 0x3ff0c000-0x3ff13fff]
On node 0 totalpages: 130945
  Normal zone: 1024 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 129921 pages, LIFO batch:15
Booting Linux...
CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
CPU CAPS: [vis]
pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
pcpu-alloc: [0] 0=20
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129921
Kernel command line: root=3D/dev/sda4 ro debug ignore_loglevel
PID hash table entries: 4096 (order: 2, 32768 bytes)
Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
Memory: 1032112k available (3584k kernel code, 1288k data, 160k init) [ffff=
f80000000000,000000003ff14000]
SLUB: Genslabs=16, HWalign2, Order=3D0-3, MinObjects=3D0, CPUs=3D1, Nodes=
=3D1
NR_IRQS:255
clocksource: mult[245d174] shift[24]
clockevent: mult[70a3d70a] shift[32]
Console: colour dummy device 80x25
console [tty0] enabled, bootconsole disabled
Calibrating delay using timer specific routine.. 880.86 BogoMIPS (lpjD04317)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
NET: Registered protocol family 16
/pci@1f,0: PCI IO[1fe02000000] MEM[1ff00000000]
/pci@1f,0: SABRE PCI Bus Module ver[0:0]
PCI: Scanning PBM /pci@1f,0
sabre f005f9c0: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1fe02000000-0x1fe02ffffff] (bus a=
ddress [0x0000-0xffffff])
pci_bus 0000:00: root bus resource [mem 0x1ff00000000-0x1ffffffffff] (bus a=
ddress [0x00000000-0xffffffff])
pci_bus 0000:00: busn_res: [bus 00-02] is inserted under domain [bus 00-ff]
pci_bus 0000:00: root bus resource [bus 00-02]
pci_bus 0000:01: busn_res: [bus 01] is inserted under [bus 00-02]
pci_bus 0000:02: busn_res: [bus 02] is inserted under [bus 00-02]
pci 0000:02:04.0: PME# supported from D3hot
bio: create slab <bio-0> at 0
vgaarb: device added: PCI:0000:01:02.0,decodes=3Dio+mem,owns=3Dnone,locks=
=3Dnone
vgaarb: loaded
vgaarb: bridge control possible 0000:01:02.0
SCSI subsystem initialized
/pci@1f,0/pci@1,1/ebus@1/eeprom@14,0: Mostek regs at 0x1fff1000000
AUXIO: Found device at /pci@1f,0/pci@1,1/ebus@1/auxio@14,726000
Switching to clocksource tick
NET: Registered protocol family 2
TCP established hash table entries: 32768 (order: 6, 524288 bytes)
TCP bind hash table entries: 32768 (order: 5, 262144 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP: reno registered
UDP hash table entries: 512 (order: 1, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 1, 16384 bytes)
NET: Registered protocol family 1
PCI: CLS 64 bytes, default 64
power: Control reg at 1fff1724000
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
msgmni has been set to 2015
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
start plist test
end plist test
PCI: Enabling device: (0000:01:02.0), cmd 82
atyfb: 3D RAGE PRO (Mach64 GP, PQFP, PCI) [0x4750 rev 0x7c]
atyfb: 4M SGRAM (1:1), 14.31818 MHz XTAL, 230 MHz PLL, 100 Mhz MCLK, 100 MH=
z XCLK
Console: switching to colour frame buffer device 80x30
atyfb: fb0: ATY Mach64 frame buffer device on PCI
/SUNW,ffb@1e,0: FFB at 000001fc00000000, type 51, DAC pnum[236e] rev[10] ma=
nuf_rev[1]
/pci@1f,0/pci@1,1/ebus@1/su@14,3083f8: Keyboard port at 1fff13083f8, irq 6
/pci@1f,0/pci@1,1/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8, irq 7
f0061c64: ttyS0 at MMIO 0x1fff1400000 (irq =3D 5) is a SAB82532 V3.2
Console: ttyS0 (SAB82532)
console [ttyS0] enabled
f0061c64: ttyS1 at MMIO 0x1fff1400040 (irq =3D 5) is a SAB82532 V3.2
[sched_delayed] sched: RT throttling activated
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=3D7, 16/253 SCBs

PCI: Enabling device: (0000:01:01.1), cmd 2
sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@davemloft.net)
eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:9e:82:fd
scsi 0:0:0:0: Direct-Access     QUANTUM  ATLAS IV 18 WLS  0909 PQ: 0 ANSI: 3
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
scsi target0:0:0: Beginning Domain Validation
mousedev: PS/2 mouse device common for all mice
rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t59 as rtc0
TCP: cubic registered
NET: Registered protocol family 17
Key type dns_resolver registered
registered taskstats version 1
rtc-m48t59 rtc-m48t59.0: setting system clock to 2012-08-16 11:20:41 UTC (1=
345116041)
scsi target0:0:0: wide asynchronous
scsi target0:0:0: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, offset 8)
scsi target0:0:0: Domain Validation skipping write tests
scsi target0:0:0: Ending Domain Validation
input: Sun Mouse as /devices/root/f005f9c0/f00601b4/f0061504/f0064df4/serio=
1/input/input0
sd 0:0:0:0: [sda] 35885168 512-byte logical blocks: (18.3 GB/17.1 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: e3 00 10 08
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO a=
nd FUA
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
EXT3-fs (sda4): error: couldn't mount because of unsupported optional featu=
res (240)
EXT2-fs (sda4): error: couldn't mount because of unsupported optional featu=
res (240)
EXT4-fs (sda4): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext4 filesystem) readonly on device 8:4.
/pci@1f,0/pci@1,1/ebus@1/flashprom@10,0: OBP Flash, RD 1fff0000000[100000] =
WR 1fff0000000[100000]
PCI: Enabling device: (0000:02:02.0), cmd 3
sym0: <895> rev 0x2 at pci 0000:02:02.0 irq 16
sym0: No NVRAM, ID 7, Fast-40, LVD, parity checking
sym0: SCSI BUS has been reset.
scsi1 : sym-2.2.3
libata version 3.00 loaded.
qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 8.04.00.03-=
k.
PCI: Enabling device: (0000:02:03.0), cmd 3
qla2xxx [0000:02:03.0]-001d: : Found an ISP2200 irq 17 iobase 0x000001ff000=
80000.
scsi3 : pata_cmd64x
scsi4 : pata_cmd64x
ata1: PATA max MWDMA2 cmd 0x1fe02c00000 ctl 0x1fe02c00008 bmdma 0x1fe02c000=
20 irq 14
ata2: PATA max MWDMA2 cmd 0x1fe02c00010 ctl 0x1fe02c00018 bmdma 0x1fe02c000=
28 irq 14
pata_cmd64x: active 10 recovery 10 setup 3.
pata_cmd64x: active 10 recovery 10 setup 3.
pata_cmd64x: active 10 recovery 10 setup 3.
pata_cmd64x: active 10 recovery 10 setup 3.
scsi2 : qla2xxx
qla2xxx [0000:02:03.0]-505f:2: Link is operational (1 Gbps).
qla2xxx [0000:02:03.0]-00fb:2: QLogic QLA22xx - .
qla2xxx [0000:02:03.0]-00fc:2: ISP2200: PCI (33 MHz) @ 0000:02:03.0 hdma- h=
ost#=3D2 fw=3D2.02.08 TP.
tg3.c:v3.124 (March 21, 2012)
PCI: Enabling device: (0000:02:04.0), cmd 2
tg3 0000:02:04.0: BAR 0: can't reserve [mem 0x1ff000c0000-0x1ff000cffff]
tg3 0000:02:04.0: Cannot obtain PCI resources, aborting
tg3: probe of 0000:02:04.0 failed with error -16
scsi 2:0:0:0: Direct-Access     SUN      T300             0302 PQ: 0 ANSI: 3
sd 2:0:0:0: [sdb] 564133888 512-byte logical blocks: (288 GB/269 GiB)
sd 2:0:0:0: [sdb] Write Protect is off
sd 2:0:0:0: [sdb] Mode Sense: 6f 00 00 08
sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
 sdb: sdb1
sd 2:0:0:0: [sdb] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 2:0:0:0: Attached scsi generic sg1 type 0
Adding 1052248k swap on /dev/sda2.  Priority:-1 extents:1 across:1052248k=20
EXT4-fs (sda4): re-mounted. Opts: (null)
EXT4-fs (sda4): re-mounted. Opts: errors=3Dremount-ro
loop: module loaded
NET: Registered protocol family 10
eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.


--=20
Meelis Roos (mroos@linux.ee)
