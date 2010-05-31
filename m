From: Meelis Roos <mroos@linux.ee>
Date: Mon, 31 May 2010 13:20:44 +0000
Subject: 2.6.35-rc1: duplicate pci slot name warnings on Sun E250
Message-Id: <alpine.SOC.1.00.1005311610470.12642@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I tried 2.6.35-rc1 on Sun E250 (lspci below) and it gives warnings about 
registering pci slot names in sysfs:
sysfs: cannot create duplicate filename '/devices/root/f006d1b0/pci0000:00/0000:00:03.0/slot'
These happen for 4 PCI devies out of 5 - graphics card does not give 
this warning but onboard devices do.

ls -ld /sys/bus/pci/devices/0000\:00\:0*/slot
lrwxrwxrwx 1 root root 0 May 31 16:20 /sys/bus/pci/devices/0000:00:01.0/slot -> ../../../../../bus/pci/slots/PCI Slot 2
lrwxrwxrwx 1 root root 0 May 31 16:20 /sys/bus/pci/devices/0000:00:01.1/slot -> ../../../../../bus/pci/slots/PCI Slot 2
lrwxrwxrwx 1 root root 0 May 31 16:20 /sys/bus/pci/devices/0000:00:03.0/slot -> ../../../../../bus/pci/slots/PCI Slot 1
lrwxrwxrwx 1 root root 0 May 31 16:20 /sys/bus/pci/devices/0000:00:03.1/slot -> ../../../../../bus/pci/slots/PCI Slot 1

prtconf -pv is also below for OF properties but it doesn't seem there 
are any slot names there - don't know where the overlapping names come 
from

00:01.0 Bridge: Sun Microsystems Computer Corp. EBUS (rev 01)
	Physical Slot: PCI Slot 2
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 10 (2500ns min, 6250ns max)
	Region 0: Memory at fffffe0080000000 (32-bit, non-prefetchable) [size=1]
	Region 1: Memory at fffffe0080000000 (32-bit, non-prefetchable) [size=1]
	Region 2: [virtual] Memory at fffffe0080000000 (32-bit, non-prefetchable) [size=1]
	Region 3: [virtual] Memory at fffffe0080000000 (32-bit, non-prefetchable) [size=1]
	Region 4: [virtual] Memory at fffffe0080000000 (32-bit, non-prefetchable) [size=1]
	Region 5: [virtual] Memory at fffffe0080000000 (32-bit, non-prefetchable) [size=1]
	[virtual] Expansion ROM at fffffe0080000000 [disabled] [size=1]

00:01.1 Ethernet controller: Sun Microsystems Computer Corp. Happy Meal 10/100 Ethernet [hme] (rev 01)
	Physical Slot: PCI Slot 2
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 10 (2500ns min, 1250ns max)
	Interrupt: pin ? routed to IRQ 12
	Region 0: Memory at 00008000 (32-bit, non-prefetchable) [size(K]
	Region 1: [virtual] Memory at fffffe0080000000 (32-bit, non-prefetchable) [size=1]
	Region 2: [virtual] Memory at fffffe0080000000 (32-bit, non-prefetchable) [size=1]
	Region 3: [virtual] Memory at fffffe0080000000 (32-bit, non-prefetchable) [size=1]
	Region 4: [virtual] Memory at fffffe0080000000 (32-bit, non-prefetchable) [size=1]
	Region 5: [virtual] Memory at fffffe0080000000 (32-bit, non-prefetchable) [size=1]
	[virtual] Expansion ROM at fffffe0080000000 [disabled] [size=1]
	Kernel driver in use: hme

00:03.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 14)
	Physical Slot: PCI Slot 1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 17 (4250ns min, 16000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 13
	Region 0: I/O ports at 0400 [size%6]
	Region 1: Memory at 00010000 (32-bit, non-prefetchable) [size%6]
	Region 2: Memory at 00012000 (32-bit, non-prefetchable) [size=4K]
	Region 3: [virtual] Memory at fffffe0080000000 (32-bit, non-prefetchable) [size=1]
	Region 4: [virtual] Memory at fffffe0080000000 (32-bit, non-prefetchable) [size=1]
	Region 5: [virtual] Memory at fffffe0080000000 (32-bit, non-prefetchable) [size=1]
	[virtual] Expansion ROM at fffffe0080000000 [disabled] [size=1]
	Kernel driver in use: sym53c8xx

00:03.1 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 14)
	Physical Slot: PCI Slot 1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 17 (4250ns min, 16000ns max), Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 14
	Region 0: I/O ports at 0800 [size%6]
	Region 1: Memory at 00014000 (32-bit, non-prefetchable) [size%6]
	Region 2: Memory at 00016000 (32-bit, non-prefetchable) [size=4K]
	Region 3: [virtual] Memory at fffffe0080000000 (32-bit, non-prefetchable) [size=1]
	Region 4: [virtual] Memory at fffffe0080000000 (32-bit, non-prefetchable) [size=1]
	Region 5: [virtual] Memory at fffffe0080000000 (32-bit, non-prefetchable) [size=1]
	[virtual] Expansion ROM at fffffe0080000000 [disabled] [size=1]
	Kernel driver in use: sym53c8xx

00:05.0 Display controller: 3DLabs Permedia II 2D+3D (rev 01)
	Subsystem: Tech-Source Device 0006
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 15
	Region 0: Memory at 00020000 (32-bit, non-prefetchable) [disabled] [size8K]
	Region 1: Memory at 00800000 (32-bit, non-prefetchable) [disabled] [size=8M]
	Region 2: Memory at 01000000 (32-bit, non-prefetchable) [disabled] [size=8M]
	Region 3: [virtual] Memory at fffffe0080000000 (32-bit, non-prefetchable) [size=1]
	Region 4: [virtual] Memory at fffffe0080000000 (32-bit, non-prefetchable) [size=1]
	Region 5: [virtual] Memory at fffffe0080000000 (32-bit, non-prefetchable) [size=1]
	Expansion ROM at 01800000 [disabled] [sizedK]
	Capabilities: [4c] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-


System Configuration:  Sun Microsystems  sun4u
Memory size: 1280 Megabytes
System Peripherals (PROM Nodes):

Node 0xf002a490
    .node:  f002a490
    reset-reason: 'S-POR'
    model: 'SUNW,501-4681'
    idprom:  01800800.20b04ef6.00000000.b04ef6a9.00000000.00000000.00000000.00000000
    interrupt-map:  0000003c.00000000.00000000.f006d1b0.80000033.0000003a.00000000.00000000.f006d1b0.80000034
    interrupt-map-mask:  0000003e.00000000.00000000
    #interrupt-cells:  00000001
    #address-cells:  00000002
    compatible: 'sun4u'
    builtin-io-device-port:  0000001f
    device-probe-order: '1b,0,4,9,'
    breakpoint-trap:  0000007f
    #size-cells:  00000002
    name: 'SUNW,Ultra-250'
    clock-frequency:  04ed64aa
    banner-name: 'Sun (TM) Enterprise 250 (2 X UltraSPARC-II 248MHz)'
    device_type: 'upa'

    Node 0xf002d8d4
        .node:  f002d8d4
        name: 'packages'

        Node 0xf0034e48
            .node:  f0034e48
            iso6429-1983-colors:  
            name: 'terminal-emulator'

        Node 0xf0037b84
            .node:  f0037b84
            disk-write-fix:  
            name: 'deblocker'

        Node 0xf0038260
            .node:  f0038260
            name: 'obp-tftp'

        Node 0xf00430e4
            .node:  f00430e4
            name: 'disk-label'

        Node 0xf0065258
            .node:  f0065258
            name: 'SUNW,builtin-drivers'

        Node 0xf007bd98
            .node:  f007bd98
            name: 'sun-keyboard'

    Node 0xf002d944
        .node:  f002d944
        stdin:  fff79760
        stdout:  fff79d00
        mmu:  fffe8438
        memory:  fffe8638
        bootargs:  00
        bootpath: '/pci@1f,4000/scsi@3/disk@0,0:a'
        stdout-#lines:  ffffffff
        name: 'chosen'

    Node 0xf002d9b0
        .node:  f002d9b0
        version: 'OBP 3.30.0 2003/11/11 10:37'
        model: 'SUNW,3.30'
        decode-complete:  
        aligned-allocator:  
        relative-addressing:  
        name: 'openprom'

        Node 0xf002da40
            .node:  f002da40
            name: 'client-services'

    Node 0xf002dae8
        .node:  f002dae8
        tpe-link-test?: 'true'
        scsi-initiator-id: '7'
        keyboard-click?: 'false'
        keymap:  
        .reboot-flag: 'false'
        .reboot-posc: '0'
        .reboot-posl: '0'
        .reboot-cmd: 'boot'
        ttyb-rts-dtr-off: 'false'
        ttyb-ignore-cd: 'true'
        ttya-rts-dtr-off: 'false'
        ttya-ignore-cd: 'true'
        ttyb-mode: '9600,8,n,1,-'
        ttya-mode: '9600,8,n,1,-'
        pci-slot-skip-list: 'none'
        pci0-probe-list: '1,3,2,4,5,'
        upa-port-skip-list: 'none'
        diag-level: 'min'
        diag-script: 'normal'
        diag-targets: 'none'
        diag-trigger: 'power-reset'
        diag-continue?: 'false'
        diag-passes: '1'
        diag-verbosity: 'tests'
        env-monitor: 'enabled'
        .asr-disable-list:  
        .asr-status: '18437736870358094097'
        .post-status: '18437736870358094097'
        .post-address: '18446744073441849064'
        .post-flag: '0'
        .rsc-status: '0'
        .obp-flags: '0'
        .obp-state: '6'
        .obp-status: '0'
        mfg-options: 'server'
        #power-cycles: '85'
        system-board-serial#: '5014681033542'
        system-board-date: '375fb059'
        fcode-debug?: 'false'
        output-device: 'ttya'
        input-device: 'ttya'
        load-base: '16384'
        boot-command: 'boot'
        auto-boot?: 'false'
        auto-boot-on-error?: 'false'
        watchdog-reboot?: 'false'
        diag-file:  
        diag-device: 'net'
        boot-file:  
        boot-device: 'disk'
        local-mac-address?: 'false'
        ansi-terminal?: 'true'
        screen-#columns: '80'
        screen-#rows: '34'
        silent-mode?: 'false'
        use-nvramrc?: 'false'
        nvramrc:  32332076.616c7565.20766964.656f2d6d.6f64650a.0a
        security-mode: 'none'
        security-password:  
        security-#badlogins: '0'
        oem-logo:  
        oem-logo?: 'false'
        oem-banner:  
        oem-banner?: 'false'
        hardware-revision:  
        last-hardware-update:  
        .upa-noprobe-mask: '0'
        diag-switch?: 'false'
        name: 'options'

    Node 0xf002db58
        .node:  f002db58
        screen: '/pci@1f,4000/TSI,gfxp@5'
        disk5: '/pci@1f,4000/scsi@3/disk@c,0'
        disk4: '/pci@1f,4000/scsi@3/disk@b,0'
        disk3: '/pci@1f,4000/scsi@3/disk@a,0'
        disk2: '/pci@1f,4000/scsi@3/disk@9,0'
        disk1: '/pci@1f,4000/scsi@3/disk@8,0'
        disk0: '/pci@1f,4000/scsi@3/disk@0,0'
        disk: '/pci@1f,4000/scsi@3/disk@0,0'
        scsi: '/pci@1f,4000/scsi@3'
        cdrom: '/pci@1f,4000/scsi@3/disk@6,0:f'
        tape: '/pci@1f,4000/scsi@3/tape@4,0'
        pcia: '/pci@1f,2000'
        pcib: '/pci@1f,4000'
        pci0: '/pci@1f,4000'
        flash: '/pci@1f,4000/ebus@1/flashprom@10,0'
        nvram: '/pci@1f,4000/ebus@1/eeprom@14,0'
        parallel: '/pci@1f,4000/ebus@1/ecpp@14,3043bc'
        net: '/pci@1f,4000/network@1,1'
        ebus: '/pci@1f,4000/ebus@1'
        i2c: '/pci@1f,4000/ebus@1/SUNW,envctrltwo'
        floppy: '/pci@1f,4000/ebus@1/fdthree'
        tty: '/pci@1f,4000/ebus@1/se@14,400000'
        ttya: '/pci@1f,4000/ebus@1/se@14,400000:a'
        ttyb: '/pci@1f,4000/ebus@1/se@14,400000:b'
        rscctl: '/pci@1f,4000/ebus@1/se@14,200000:sspctl'
        rsc: '/pci@1f,4000/ebus@1/se@14,200000:ssp'
        ttyc: '/pci@1f,4000/ebus@1/se@14,200000:ssp'
        ttyd: '/pci@1f,4000/ebus@1/se@14,200000:sspctl'
        keyboard!: '/pci@1f,4000/ebus@1/su@14,3083f8:forcemode'
        keyboard: '/pci@1f,4000/ebus@1/su@14,3083f8'
        mouse: '/pci@1f,4000/ebus@1/su@14,3062f8'
        name: 'aliases'

    Node 0xf0051ca0
        .node:  f0051ca0
        reg:  00000000.00000000.00000000.20000000.00000000.20000000.00000000.20000000.00000000.40000000.00000000.10000000
        #size-cells:  00000002
        available:  00000000.4fea6000.00000000.00018000.00000000.4fe00000.00000000.00096000.00000000.00000000.00000000.4fdfe000
        name: 'memory'

    Node 0xf0052280
        .node:  f0052280
        translations:  00000000.fffe0000.00000000.00010000.80000000.4fef00b6.00000000.fffd4000.00000000.0000c000.80000000.4fedc0b6.00000000.fffce000.00000000.00002000.800001fe.0000208e.00000000.fffcc000.00000000.00002000.800001fe.0180008e.00000000.fffbe000.00000000.0000e000.800001fe.0000008e.00000000.fffbc000.00000000.00002000.800001fe.0000408e.00000000.fffba000.00000000.00002000.800001fe.0100008e.00000000.fffac000.00000000.0000e000.800001fe.0000008e.00000000.fffa8000.00000000.00004000.80000000.4fed80b6.00000000.fffa6000.00000000.00002000.800001fe.0000008e.00000000.fffa4000.00000000.00002000.800001fe.0000008e.00000000.fffa2000.00000000.00002000.800001fe.0000008e.00000000.fffa0000.00000000.00002000.800001ff.f100008e.00000000.fff9e000.00000000.00002000.800001ff.f100008e.00000000.fff9c000.00000000.00002000.800001ff.f150008e.00000000.fff9a000.00000000.00002000.800001ff.f172608e.00000000.fff98000.00000000.00002000.800001ff.f172808e.00000000.fff96000.00000000.00002000.800001ff.f172
 a08e.00000000.fff94000.00000000.00002000.800001ff.f172c08e.00000000.fff92000.00000000.00002000.800001ff.f172e08e.00000000.fff90000.00000000.00002000.800001ff.f130808e.00000000.fff8c000.00000000.00004000.80000000.4fed20b6.00000000.fff8a000.00000000.00002000.80000000.4fdfe0b6.00000000.fff88000.00000000.00002000.80000000.4fed00b6.00000000.fff86000.00000000.00002000.800001ff.f130208e.00000000.fff84000.00000000.00002000.800001ff.f170608e.00000000.fff82000.00000000.00002000.800001ff.f172008e.00000000.fff80000.00000000.00002000.800001ff.f130208e.00000000.fff7e000.00000000.00002000.800001ff.f130208e.00000000.fff7c000.00000000.00002000.800001ff.f120008e.00000000.fff7a000.00000000.00002000.800001ff.f140008e.00000000.fff76000.00000000.00004000.80000000.4fecc0b6.00000000.fff72000.00000000.00002000.80000000.4fec80b6.00000000.ffef8000.00000000.00008000.80000000.4fec00b6.00000000.f0000000.00000000.00100000.80000000.4ff000b6.00000000.40000000.00000000.04000000.80000000.00400036.00000000.000
 02000.00000000.00bfe000.80000000.00002036
        existing:  00000000.00000000.00000800.00000000.fffff800.00000000.00000800.00000000
        available:  fffff800.00000000.000007fc.00000000.00000001.00000000.000007ff.00000000.00000000.ffff0000.00000000.0000e000.00000000.00000000.00000000.f0000000.00000000.fff74000.00000000.00002000.00000000.fff00000.00000000.00072000.00000000.f0800000.00000000.0e800000
        page-size:  00002000
        name: 'virtual-memory'

    Node 0xf00579e8
        .node:  f00579e8
        name: 'associations'

        Node 0xf00a5128
            .node:  f00a5128
            disk-slot5: '/pci@1f,4000/scsi@3/disk@c'
            disk-slot4: '/pci@1f,4000/scsi@3/disk@b'
            disk-slot3: '/pci@1f,4000/scsi@3/disk@a'
            disk-slot2: '/pci@1f,4000/scsi@3/disk@9'
            disk-slot1: '/pci@1f,4000/scsi@3/disk@8'
            disk-slot0: '/pci@1f,4000/scsi@3/disk@0'
            name: 'slot2disk'

        Node 0xf00a5334
            .node:  f00a5334
            pci-slot#3: '/pci@1f,2000/*@1,*'
            pci-slot#2: '/pci@1f,4000/*@2,*'
            pci-slot#1: '/pci@1f,4000/*@4,*'
            pci-slot#0: '/pci@1f,4000/*@5,*'
            cpu-a2: '/*@1,0'
            cpu-a1: '/*@0,0'
            name: 'slot2dev'

    Node 0xf006d1b0
        .node:  f006d1b0
        slot-names:  0000001f.4d6f7468.6572626f.61726400.50434920.536c6f74.2032004d.6f746865.72626f61.72640050.43492053.6c6f7420.31005043.4920536c.6f742030.00
        available:  82000000.00000000.01810000.00000000.7e7f0000.81000000.00000000.00000900.00000000.0000f700
        bus-range:  00000000.00000000
        scsi-initiator-id:  00000007
        version#:  00000004
        implementation#:  00000000
        address:  fffbc000.fffba000.fffac000
        interrupt-map:  00000800.00000000.00000000.00000002.f006d1b0.00000021.00001000.00000000.00000000.00000001.f006d1b0.00000010.00001000.00000000.00000000.00000002.f006d1b0.00000011.00001000.00000000.00000000.00000003.f006d1b0.00000012.00001000.00000000.00000000.00000004.f006d1b0.00000013.00001800.00000000.00000000.00000001.f006d1b0.00000020.00001900.00000000.00000000.00000001.f006d1b0.00000026.00002000.00000000.00000000.00000001.f006d1b0.00000018.00002000.00000000.00000000.00000002.f006d1b0.00000019.00002000.00000000.00000000.00000003.f006d1b0.0000001a.00002000.00000000.00000000.00000004.f006d1b0.0000001b.00002800.00000000.00000000.00000001.f006d1b0.0000001c.00002800.00000000.00000000.00000002.f006d1b0.0000001d.00002800.00000000.00000000.00000003.f006d1b0.0000001e.00002800.00000000.00000000.00000004.f006d1b0.0000001f
        interrupt-map-mask:  00fff800.00000000.00000000.00000007
        #interrupt-cells:  00000001
        #upa-interrupt-proxies:  00000002
        clock-frequency:  01f78a40
        upa-portid:  0000001f
        interrupts:  000007f1.000007ee.000007ef.000007e5.000007e8.000007f2
        ranges:  00000000.00000000.00000000.000001fe.01000000.00000000.00800000.01000000.00000000.00000000.000001fe.02010000.00000000.00010000.02000000.00000000.00000000.000001ff.80000000.00000000.80000000.03000000.00000000.00000000.000001ff.80000000.00000000.80000000
        reg:  000001fe.00004000.00000000.00002000.000001fe.01000000.00000000.00000100.000001fe.00000000.00000000.0000d000
        no-probe-list: '0'
        latency-timer:  00000040
        model: 'SUNW,psycho'
        compatible:  70636931.3038652c.38303030.00706369.636c6173.732c3036.30303030.00
        thermal-interrupt:  
        bus-parity-generated:  
        #size-cells:  00000002
        #address-cells:  00000003
        device_type: 'pci'
        name: 'pci'

        Node 0xf006f858
            .node:  f006f858
            fru: 'motherboard'
            latency-timer:  0000000a
            fast-back-to-back:  
            devsel-speed:  00000001
            class-code:  00068000
            max-latency:  00000019
            min-grant:  0000000a
            revision-id:  00000001
            device-id:  00001000
            vendor-id:  0000108e
            ranges:  00000010.00000000.82000810.00000000.70000000.01000000.00000014.00000000.82000814.00000000.71000000.00800000
            reg:  00000800.00000000.00000000.00000000.00000000.82000810.00000000.70000000.00000000.01000000.82000814.00000000.71000000.00000000.00800000
            #size-cells:  00000001
            #address-cells:  00000002
            name: 'ebus'

            Node 0xf006fddc
                .node:  f006fddc
                address:  fff9a000.fff98000.fff96000.fff94000.fff93000
                reg:  00000014.00726000.00000004.00000014.00728000.00000004.00000014.0072a000.00000004.00000014.0072c000.00000004.00000014.0072f000.00000004
                name: 'auxio'

            Node 0xf006fe9c
                .node:  f006fe9c
                reg:  00000014.00724000.00000004
                name: 'power'

            Node 0xf006ff2c
                .node:  f006ff2c
                freq-syn: 'MC12439'
                reg:  00000014.00504000.00000003
                name: 'SUNW,pll'

            Node 0xf006ffc0
                .node:  f006ffc0
                address:  fff9c000
                model: 'SUNW,sc-mp'
                reg:  00000014.00500000.00000008
                name: 'sc'

            Node 0xf0070074
                .node:  f0070074
                fru: 'motherboard'
                port-b-ignore-cd:  
                port-a-ignore-cd:  
                interrupts:  0000002b
                reg:  00000014.00400000.00000080
                device_type: 'serial'
                name: 'se'

            Node 0xf0071b18
                .node:  f0071b18
                ssp-console-modes: '115200,8,n,1,-'
                ssp-control-modes: '115200,8,n,1,-'
                interrupt-priorities:  0000000c
                ssp-control:  00000001
                ssp-console:  00000000
                fru: 'motherboard'
                selftest-override:  00000000
                interrupts:  00000023
                reg:  00000014.00200000.00000080
                device_type: 'serial'
                name: 'se'

            Node 0xf00735e8
                .node:  f00735e8
                fru: 'motherboard'
                reg:  00000014.003083f8.00000008
                interrupts:  00000029
                port-a-ignore-cd:  
                keyboard:  
                device_type: 'serial'
                name: 'su'

            Node 0xf0074e80
                .node:  f0074e80
                fru: 'motherboard'
                interrupts:  0000002a
                port-a-ignore-cd:  
                mouse:  
                reg:  00000014.003062f8.00000008
                device_type: 'serial'
                name: 'su'

            Node 0xf0074f9c
                .node:  f0074f9c
                fru: 'motherboard'
                interrupts:  00000022
                reg:  00000014.003043bc.00000010.00000014.00300398.00000002.00000014.00700000.00000010
                name: 'ecpp'

            Node 0xf0076a48
                .node:  f0076a48
                watchdog-enable:  
                fru: 'motherboard'
                address:  fff9e000
                reg:  00000014.00000000.00002000
                model: 'mk48t59'
                name: 'eeprom'

            Node 0xf0076b30
                .node:  f0076b30
                compatible:  69323866.30303874.32006932.38663030.3800
                version:  4f425020.332e3330.2e302032.3030332f.31312f31.31203130.3a333700.504f5354.20362e31.2e302032.3030332f.31312f31.31203130.3a343900
                model: 'SUNW,525-1718'
                reg:  00000010.00000000.00100000.00000010.00000000.00100000
                name: 'flashprom'

            Node 0xf0079b0c
                .node:  f0079b0c
                cpu-temp-factors:  96969696.96969696.96969696.96969696.96969696.96969696.96949290.8f8e8d8c.8a888786.85848382.81807f7e.7d7c7b7a.79797878.77767574.73727170.706f6f6e.6e6e6d6d.6c6b6a6a.69696867.66656564.64646363.62626161.60605f5f.5e5e5d5d.5c5c5b5b.5b5a5a5a.59595858.57575656.55555454.53535252.52515150.5050504f.4f4f4e4e.4e4d4d4d.4c4c4c4b.4b4b4a4a.4a494949.48484847.47474646.46464545.45444444.44434343.43424242.42414141.4040403f.3f3f3e3e.3e3d3d3d.3d3c3c3c.3c3b3b3b.3a3a3a39.39393838.38383737.37373636.36353535.34343433.33333332.32323131.31303030.2f2f2f2e.2e2e2d2d.2d2c2c2c.2b2b2b2a.2a2a2929.2928
                cpu-fan-speeds:  ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.ffffffff.fffff0f0.f0ebebeb.ebe6e6e6.e6e1e1e1.e1dcdcdc.d7d7d7d2.d2d2cdcd.cdc8c8c8.c8c3c3c3.c3bebebe.b9b9b9b4.b4b4afaf.afafaaaa.aaaaa5a5.a5a0a0a0.9b9b9b96.96969691.91918c8c.8c878787.8282827d.7d7d7878.78787878.7373736e.6e6e6969.6964
                thermisters:  0000009e.00000000.00000000.0000003f.00000044.00000000.00000000.43505530.00000000.9e000000.01000000.00000000.3f000000.44000000.00000000.00435055.31000000.009e0000.00020000.00050000.00370000.003c0000.b6d00001.86a04d42.30000000.009e0000.00030000.00050000.00370000.003c0000.b6d00001.86a04d42.31000000.00940000.00000000.00050000.00370000.003c0000.b6d00001.86a05044.42000000.00940000.00030000.00050000.00370000.003c0000.b6d00001.86a05343.534900
                fru: 'motherboard, power_supply, fan, CPU'
                interrupt-priorities:  00000009.00000009
                interrupts:  00000028.00000025
                reg:  00000014.00600000.00000004
                compatible: 'SUNW,envctrltwo'
                name: 'SUNW,envctrltwo'

        Node 0xf00865e4
            .node:  f00865e4
            fru: 'motherboard'
            latency-timer:  0000000a
            assigned-addresses:  82000910.00000000.00008000.00000000.00007020
            hm-rev:  000000c1
            device_type: 'network'
            interrupts:  00000021
            address-bits:  00000030
            max-frame-size:  00004000
            reg:  00000900.00000000.00000000.00000000.00000000.02000910.00000000.00000000.00000000.00007020
            compatible: 'SUNW,hme'
            name: 'network'
            fast-back-to-back:  
            devsel-speed:  00000001
            class-code:  00020000
            max-latency:  00000005
            min-grant:  0000000a
            revision-id:  00000001
            device-id:  00001001
            vendor-id:  0000108e

        Node 0xf008e5f0
            .node:  f008e5f0
            target6-scsi-options:  000005f8
            target5-scsi-options:  000005f8
            target4-scsi-options:  000005f8
            target3-scsi-options:  000005f8
            target2-scsi-options:  000005f8
            target1-scsi-options:  000005f8
            latency-timer:  00000011
            assigned-addresses:  81001810.00000000.00000400.00000000.00000100.82001814.00000000.00010000.00000000.00000100.82001818.00000000.00012000.00000000.00001000
            device_type: 'scsi-2'
            fru: 'motherboard'
            clock-frequency:  02625a00
            reg:  00001800.00000000.00000000.00000000.00000000.01001810.00000000.00000000.00000000.00000100.02001814.00000000.00000000.00000000.00000100.02001818.00000000.00000000.00000000.00001000
            model: 'Symbios,53C875'
            compatible:  70636931.3030302c.6600676c.6d007063.69636c61.73732c30.30313030.3000
            name: 'scsi'
            devsel-speed:  00000001
            class-code:  00010000
            interrupts:  00000020
            max-latency:  00000040
            min-grant:  00000011
            revision-id:  00000014
            device-id:  0000000f
            vendor-id:  00001000

            Node 0xf0093504
                .node:  f0093504
                device_type: 'block'
                compatible: 'sd'
                name: 'disk'

            Node 0xf0094c48
                .node:  f0094c48
                device_type: 'byte'
                compatible: 'st'
                name: 'tape'

        Node 0xf00959f4
            .node:  f00959f4
            latency-timer:  00000011
            assigned-addresses:  81001910.00000000.00000800.00000000.00000100.82001914.00000000.00014000.00000000.00000100.82001918.00000000.00016000.00000000.00001000
            device_type: 'scsi-2'
            fru: 'motherboard'
            clock-frequency:  02625a00
            reg:  00001900.00000000.00000000.00000000.00000000.01001910.00000000.00000000.00000000.00000100.02001914.00000000.00000000.00000000.00000100.02001918.00000000.00000000.00000000.00001000
            model: 'Symbios,53C875'
            compatible:  70636931.3030302c.6600676c.6d007063.69636c61.73732c30.30313030.3000
            name: 'scsi'
            devsel-speed:  00000001
            class-code:  00010000
            interrupts:  00000026
            max-latency:  00000040
            min-grant:  00000011
            revision-id:  00000014
            device-id:  0000000f
            vendor-id:  00001000

            Node 0xf009a908
                .node:  f009a908
                device_type: 'block'
                compatible: 'sd'
                name: 'disk'

            Node 0xf009c04c
                .node:  f009c04c
                device_type: 'byte'
                compatible: 'st'
                name: 'tape'

        Node 0xf009cdf8
            .node:  f009cdf8
            latency-timer:  00000040
            assigned-addresses:  82002810.00000000.00020000.00000000.00020000.82002814.00000000.00800000.00000000.00800000.82002818.00000000.01000000.00000000.00800000.82002830.00000000.01800000.00000000.00010000
            prom-revision: '1.13 00/04/20 TSI'
            reg:  00002800.00000000.00000000.00000000.00000000.02002810.00000000.00000000.00000000.00020000.02002814.00000000.00000000.00000000.00800000.02002818.00000000.00000000.00000000.00800000.02002830.00000000.00000000.00000000.00010000
            device_type: 'display'
            model: 'GFXP'
            name: 'TSI,gfxp'
            fcode-rom-offset:  00000000
            fast-back-to-back:  
            devsel-speed:  00000001
            class-code:  00038000
            interrupts:  00000001
            max-latency:  000000c0
            min-grant:  000000c0
            subsystem-vendor-id:  00001227
            subsystem-id:  00000006
            revision-id:  00000001
            device-id:  00000009
            vendor-id:  00003d3d

    Node 0xf006dfa4
        .node:  f006dfa4
        slot-names:  00000010.50434920.536c6f74.203300
        available:  82800000.00000000.00001000.00000000.7ffff000.81800000.00000000.00000400.00000000.0000fc00
        bus-range:  00000080.00000080
        scsi-initiator-id:  00000007
        clock-frequency:  03ef1480
        version#:  00000004
        implementation#:  00000000
        address:  fffce000.fffcc000.fffbe000
        interrupt-map:  00800800.00000000.00000000.00000001.f006d1b0.00000000.00800800.00000000.00000000.00000002.f006d1b0.00000001.00800800.00000000.00000000.00000003.f006d1b0.00000002.00800800.00000000.00000000.00000004.f006d1b0.00000003
        interrupt-map-mask:  00fff800.00000000.00000000.00000007
        #interrupt-cells:  00000001
        upa-portid:  0000001f
        66mhz-capable:  
        interrupts:  000007f0.000007ee.000007ef.000007e5.000007e8.000007f2
        ranges:  00800000.00000000.00000000.000001fe.01000000.00000000.00800000.01000000.00000000.00000000.000001fe.02000000.00000000.00010000.02000000.00000000.00000000.000001ff.00000000.00000000.80000000.03000000.00000000.00000000.000001ff.00000000.00000000.80000000
        reg:  000001fe.00002000.00000000.00002000.000001fe.01800000.00000000.00000100.000001fe.00000000.00000000.0000d000
        no-probe-list: '0'
        latency-timer:  00000040
        model: 'SUNW,psycho'
        compatible:  70636931.3038652c.38303030.00706369.636c6173.732c3036.30303030.00
        thermal-interrupt:  
        bus-parity-generated:  
        #size-cells:  00000002
        #address-cells:  00000003
        device_type: 'pci'
        name: 'pci'

    Node 0xf006f560
        .node:  f006f560
        address:  fffa7c00.fffa5860.fffa3060
        interrupts:  000007ec.000007ed
        reg:  000001fe.00001c00.00000000.00000020.000001fe.00001860.00000000.00000010.000001fe.00001060.00000000.00000010
        name: 'counter-timer'

    Node 0xf0081bbc
        .node:  f0081bbc
        selftest-override:  ffffffff
        device_type: 'system-service-processor'
        name: 'rsc'

    Node 0xf0084374
        .node:  f0084374
        ranges:  00000000.00000000.00000000.00000000.00000000.80000000
        reg:  000001c0.00000000.00000000.00000fff
        #size-cells:  00000002
        fru: 'motherboard'
        device_type: 'memory-controller'
        name: 'mc'

        Node 0xf0084528
            .node:  f0084528
            reg:  00000000.00000000.00000000.20000000
            #size-cells:  00000002
            fru: 'motherboard'
            device_type: 'memory-bank'
            name: 'bank'

            Node 0xf008467c
                .node:  f008467c
                socket-name: 'U0701'
                reg:  00000000.00000000.00000000.08000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf00847c4
                .node:  f00847c4
                socket-name: 'U0801'
                reg:  00000000.00000001.00000000.08000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf008490c
                .node:  f008490c
                socket-name: 'U0901'
                reg:  00000000.00000002.00000000.08000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0084a54
                .node:  f0084a54
                socket-name: 'U1001'
                reg:  00000000.00000003.00000000.08000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

        Node 0xf0084bf4
            .node:  f0084bf4
            reg:  00000000.20000000.00000000.20000000
            #size-cells:  00000002
            fru: 'motherboard'
            device_type: 'memory-bank'
            name: 'bank'

            Node 0xf0084d48
                .node:  f0084d48
                socket-name: 'U0702'
                reg:  00000000.00000000.00000000.08000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0084e90
                .node:  f0084e90
                socket-name: 'U0802'
                reg:  00000000.00000001.00000000.08000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0084fd8
                .node:  f0084fd8
                socket-name: 'U0902'
                reg:  00000000.00000002.00000000.08000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0085120
                .node:  f0085120
                socket-name: 'U1002'
                reg:  00000000.00000003.00000000.08000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

        Node 0xf00852c0
            .node:  f00852c0
            reg:  00000000.40000000.00000000.10000000
            #size-cells:  00000002
            fru: 'motherboard'
            device_type: 'memory-bank'
            name: 'bank'

            Node 0xf0085414
                .node:  f0085414
                socket-name: 'U0703'
                reg:  00000000.00000000.00000000.04000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf008555c
                .node:  f008555c
                socket-name: 'U0803'
                reg:  00000000.00000001.00000000.04000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf00856a4
                .node:  f00856a4
                socket-name: 'U0903'
                reg:  00000000.00000002.00000000.04000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf00857ec
                .node:  f00857ec
                socket-name: 'U1003'
                reg:  00000000.00000003.00000000.04000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

        Node 0xf008598c
            .node:  f008598c
            reg:  00000000.60000000.00000000.00000000
            #size-cells:  00000002
            fru: 'motherboard'
            device_type: 'memory-bank'
            name: 'bank'

    Node 0xf0085ec0
        .node:  f0085ec0
        manufacturer#:  00000017
        implementation#:  00000011
        mask#:  00000020
        sparc-version:  00000009
        ecache-associativity:  00000001
        ecache-line-size:  00000040
        ecache-size:  00100000
        #dtlb-entries:  00000040
        dcache-associativity:  00000001
        dcache-line-size:  00000020
        dcache-size:  00004000
        #itlb-entries:  00000040
        icache-associativity:  00000002
        icache-line-size:  00000020
        icache-size:  00004000
        upa-portid:  00000000
        clock-frequency:  0ec82e00
        reg:  000001c0.00000000.00000000.00000008
        device_type: 'cpu'
        name: 'SUNW,UltraSPARC-II'

    Node 0xf008622c
        .node:  f008622c
        manufacturer#:  00000017
        implementation#:  00000011
        mask#:  00000020
        sparc-version:  00000009
        ecache-associativity:  00000001
        ecache-line-size:  00000040
        ecache-size:  00100000
        #dtlb-entries:  00000040
        dcache-associativity:  00000001
        dcache-line-size:  00000020
        dcache-size:  00004000
        #itlb-entries:  00000040
        icache-associativity:  00000002
        icache-line-size:  00000020
        icache-size:  00004000
        upa-portid:  00000001
        clock-frequency:  0ec82e00
        reg:  000001c2.00000000.00000000.00000008
        device_type: 'cpu'
        name: 'SUNW,UltraSPARC-II'


[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.30.0 2003/11/11 10:37'
[    0.000000] PROMLIB: Root node compatible: sun4u
[    0.000000] Linux version 2.6.35-rc1 (mroos@laimi) (gcc version 4.4.4 (Debian 4.4.4-3) ) #8 SMP Mon May 31 15:03:20 EEST 2010
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 08:00:20:b0:4e:f6
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@1f,4000/ebus@1/se@14,400000:a
[    0.000000] PROM: Built device tree with 67952 bytes of memory.
[    0.000000] Top of RAM: 0x4febe000, Total RAM: 0x4feac000
[    0.000000] Memory hole size: 0MB
[    0.000000] [0000010000000000-fffff80000c00000] page_structs1072 node=0 entry=0/8192
[    0.000000] [0000010000000000-fffff80001000000] page_structs1072 node=0 entry=1/8192
[    0.000000] [0000010000800000-fffff80001400000] page_structs1072 node=0 entry=2/8192
[    0.000000] [0000010000800000-fffff80001800000] page_structs1072 node=0 entry=3/8192
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x00000000 -> 0x00027f5f
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00027eff
[    0.000000]     0: 0x00027f00 -> 0x00027f4b
[    0.000000]     0: 0x00027f53 -> 0x00027f5f
[    0.000000] On node 0 totalpages: 163670
[    0.000000]   Normal zone: 1279 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 162391 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] PERCPU: Embedded 6 pages/cpu @fffff80001c00000 s13120 r8192 d27840 u2097152
[    0.000000] pcpu-alloc: s13120 r8192 d27840 u2097152 alloc=1*4194304
[    0.000000] pcpu-alloc: [0] 0 1 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 162391
[    0.000000] Kernel command line: root=/dev/sda2 ro debug ignore_loglevel
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 262144 (order: 8, 2097152 bytes)
[    0.000000] Inode-cache hash table entries: 131072 (order: 7, 1048576 bytes)
[    0.000000] Memory: 1284584k available (2976k kernel code, 1264k data, 176k init) [fffff80000000000,000000004febe000]
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Verbose stalled-CPUs detection is disabled.
[    0.000000] NR_IRQS:255
[    0.000000] clocksource: mult[81084210] shift[29]
[    0.000000] clockevent: mult[3f7ced91] shift[32]
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled, bootconsole disabled
[   79.639108] Calibrating delay using timer specific routine.. 497.05 BogoMIPS (lpj$85285)
[   79.639182] pid_max: default: 32768 minimum: 301
[   79.639601] Security Framework initialized
[   79.639824] Mount-cache hash table entries: 512
[   79.700016] CPU 1: synchronized TICK with master CPU (last diff -13 cycles, maxerr 546 cycles)
[   79.700060] Brought up 2 CPUs
[   79.702259] khelper used greatest stack depth: 13152 bytes left
[   79.704045] NET: Registered protocol family 16
[   79.709317] khelper used greatest stack depth: 12568 bytes left
[   79.714118] khelper used greatest stack depth: 11984 bytes left
[   79.756522] /pci@1f,4000: PCI IO[1fe02010000] MEM[1ff80000000]
[   79.756624] /pci@1f,4000: PSYCHO PCI Bus Module ver[4:0]
[   79.756669] PCI: Scanning PBM /pci@1f,4000
[   79.762008] /pci@1f,2000: PCI IO[1fe02000000] MEM[1ff00000000]
[   79.762082] /pci@1f,2000: PSYCHO PCI Bus Module ver[4:0]
[   79.762124] PCI: Scanning PBM /pci@1f,2000
[   79.786453] bio: create slab <bio-0> at 0
[   79.788993] vgaarb: loaded
[   79.791275] SCSI subsystem initialized
[   79.796649] /pci@1f,4000/ebus@1/eeprom@14,0: Mostek regs at 0x1fff1000000
[   79.798604] AUXIO: Found device at /pci@1f,4000/ebus@1/auxio@14,726000
[   79.799162] Switching to clocksource tick
[   79.805548] NET: Registered protocol family 2
[   79.806000] IP route cache hash table entries: 65536 (order: 6, 524288 bytes)
[   79.810260] TCP established hash table entries: 262144 (order: 9, 4194304 bytes)
[   79.833221] TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
[   79.838976] TCP: Hash tables configured (established 262144 bind 65536)
[   79.839080] TCP reno registered
[   79.839177] UDP hash table entries: 1024 (order: 2, 32768 bytes)
[   79.839462] UDP-Lite hash table entries: 1024 (order: 2, 32768 bytes)
[   79.840469] NET: Registered protocol family 1
[   79.840665] PCI: CLS 0 bytes, default 64
[   79.841007] power: Control reg at 1fff1724000
[   79.848301] VFS: Disk quotas dquot_6.5.2
[   79.848567] Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
[   79.849467] msgmni has been set to 2508
[   79.851467] alg: No test for stdrng (krng)
[   79.852397] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[   79.852525] io scheduler noop registered
[   79.852714] io scheduler cfq registered (default)
[   79.893585] /pci@1f,4000/ebus@1/su@14,3083f8: Keyboard port at 1fff13083f8, irq 9
[   79.893969] /pci@1f,4000/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8, irq 10
[   79.896138] f0070074: ttyS0 at MMIO 0x1fff1400000 (irq = 7) is a SAB82532 V3.2
[   79.896265] Console: ttyS0 (SAB82532)
[   85.636324] console [ttyS0] enabled
[   85.678365] f0070074: ttyS1 at MMIO 0x1fff1400040 (irq = 7) is a SAB82532 V3.2
[   85.764994] f0071b18: ttyS2 at MMIO 0x1fff1200000 (irq = 8) is a SAB82532 V3.2
[   85.851606] f0071b18: ttyS3 at MMIO 0x1fff1200040 (irq = 8) is a SAB82532 V3.2
[   85.940488] PCI: Enabling device: (0000:00:03.0), cmd 147
[   86.005665] sym0: <875> rev 0x14 at pci 0000:00:03.0 irq 13
[   86.158372] sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
[   86.234770] sym0: SCSI BUS has been reset.
[   86.282917] scsi0 : sym-2.2.3
[   86.321002] PCI: Enabling device: (0000:00:03.1), cmd 3
[   86.384008] sym1: <875> rev 0x14 at pci 0000:00:03.1 irq 14
[   86.536620] sym1: No NVRAM, ID 7, Fast-20, SE, parity checking
[   86.613071] sym1: SCSI BUS has been reset.
[   86.661198] scsi1 : sym-2.2.3
[   86.701990] mice: PS/2 mouse device common for all mice
[   86.767075] rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t59 as rtc0
[   86.849892] TCP cubic registered
[   86.888039] NET: Registered protocol family 10
[   86.942237] lo: Disabled Privacy Extensions
[   86.991679] NET: Registered protocol family 17
[   87.046750] registered taskstats version 1
[   87.095111] ------------[ cut here ]------------
[   87.150055] WARNING: at fs/sysfs/dir.c:451 sysfs_add_one+0x8c/0xc0()
[   87.226040] sysfs: cannot create duplicate filename '/devices/root/f006d1b0/pci0000:00/0000:00:01.0/slot'
[   87.340634] Modules linked in:
[   87.377009] Call Trace:
[   87.406251]  [000000000045c0cc] warn_slowpath_fmt+0x2c/0x40
[   87.472898]  [000000000052b54c] sysfs_add_one+0x8c/0xc0
[   87.535419]  [000000000052c738] sysfs_do_create_link+0xb8/0x180
[   87.606262]  [00000000005acd48] pci_create_sysfs_dev_files+0x348/0x4a0
[   87.684360]  [0000000000841a80] pci_sysfs_init+0x20/0x6c
[   87.747877]  [0000000000426ab8] do_one_initcall+0x18/0x180
[   87.813513]  [0000000000830334] kernel_init+0x1a8/0x240
[   87.876001]  [000000000042b650] kernel_thread+0x30/0x60
[   87.938481]  [00000000006dda98] rest_init+0x18/0x80
[   87.996793] ---[ end trace 7b2d525f2c996b63 ]---
[   88.052259] ------------[ cut here ]------------
[   88.107276] WARNING: at fs/sysfs/dir.c:451 sysfs_add_one+0x8c/0xc0()
[   88.183245] sysfs: cannot create duplicate filename '/devices/root/f006d1b0/pci0000:00/0000:00:01.1/slot'
[   88.297846] Modules linked in:
[   88.334213] Call Trace:
[   88.363459]  [000000000045c0cc] warn_slowpath_fmt+0x2c/0x40
[   88.430100]  [000000000052b54c] sysfs_add_one+0x8c/0xc0
[   88.492626]  [000000000052c738] sysfs_do_create_link+0xb8/0x180
[   88.563453]  [00000000005acd48] pci_create_sysfs_dev_files+0x348/0x4a0
[   88.641561]  [0000000000841a80] pci_sysfs_init+0x20/0x6c
[   88.705095]  [0000000000426ab8] do_one_initcall+0x18/0x180
[   88.770699]  [0000000000830334] kernel_init+0x1a8/0x240
[   88.833199]  [000000000042b650] kernel_thread+0x30/0x60
[   88.895684]  [00000000006dda98] rest_init+0x18/0x80
[   88.954006] ---[ end trace 7b2d525f2c996b64 ]---
[   89.009303] ------------[ cut here ]------------
[   89.064422] WARNING: at fs/sysfs/dir.c:451 sysfs_add_one+0x8c/0xc0()
[   89.140445] sysfs: cannot create duplicate filename '/devices/root/f006d1b0/pci0000:00/0000:00:03.0/slot'
[   89.255046] Modules linked in:
[   89.291416] Call Trace:
[   89.320642]  [000000000045c0cc] warn_slowpath_fmt+0x2c/0x40
[   89.387302]  [000000000052b54c] sysfs_add_one+0x8c/0xc0
[   89.449810]  [000000000052c738] sysfs_do_create_link+0xb8/0x180
[   89.520652]  [00000000005acd48] pci_create_sysfs_dev_files+0x348/0x4a0
[   89.598750]  [0000000000841a80] pci_sysfs_init+0x20/0x6c
[   89.662292]  [0000000000426ab8] do_one_initcall+0x18/0x180
[   89.727897]  [0000000000830334] kernel_init+0x1a8/0x240
[   89.790394]  [000000000042b650] kernel_thread+0x30/0x60
[   89.852882]  [00000000006dda98] rest_init+0x18/0x80
[   89.911208] ---[ end trace 7b2d525f2c996b65 ]---
[   89.966497] ------------[ cut here ]------------
[   90.021625] WARNING: at fs/sysfs/dir.c:451 sysfs_add_one+0x8c/0xc0()
[   90.097648] sysfs: cannot create duplicate filename '/devices/root/f006d1b0/pci0000:00/0000:00:03.1/slot'
[   90.212252] Modules linked in:
[   90.248620] Call Trace:
[   90.277845]  [000000000045c0cc] warn_slowpath_fmt+0x2c/0x40
[   90.344507]  [000000000052b54c] sysfs_add_one+0x8c/0xc0
[   90.407004]  [000000000052c738] sysfs_do_create_link+0xb8/0x180
[   90.477855]  [00000000005acd48] pci_create_sysfs_dev_files+0x348/0x4a0
[   90.555961]  [0000000000841a80] pci_sysfs_init+0x20/0x6c
[   90.619482]  [0000000000426ab8] do_one_initcall+0x18/0x180
[   90.685125]  [0000000000830334] kernel_init+0x1a8/0x240
[   90.747602]  [000000000042b650] kernel_thread+0x30/0x60
[   90.810087]  [00000000006dda98] rest_init+0x18/0x80
[   90.868400] ---[ end trace 7b2d525f2c996b66 ]---
[   90.923880] scsi: waiting for bus probes to complete ...
[   90.993690] scsi target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 15)
[   91.082570] scsi 0:0:0:0: Direct-Access     HP       9.10GB A 80-6331      PQ: 0 ANSI: 2
[   91.178662] scsi target0:0:0: tagged command queuing enabled, command queue depth 16.
[   91.272422] scsi target0:0:0: Beginning Domain Validation
[   91.353613] scsi target0:0:0: Domain Validation skipping write tests
[   91.428793] scsi target0:0:0: Ending Domain Validation
[   92.982752] scsi 0:0:6:0: CD-ROM            TOSHIBA  XM6201TASUN32XCD 1103 PQ: 0 ANSI: 2
[   93.078798] scsi target0:0:6: Beginning Domain Validation
[   93.144772] scsi target0:0:6: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 16)
[   93.228316] scsi target0:0:6: Domain Validation skipping write tests
[   93.303504] scsi target0:0:6: Ending Domain Validation
[   95.711748] sd 0:0:0:0: [sda] 17773524 512-byte logical blocks: (9.10 GB/8.47 GiB)
[   95.712901] scsi_scan_0 used greatest stack depth: 10704 bytes left
[   95.876776] rtc-m48t59 rtc-m48t59.0: setting system clock to 2010-05-31 13:11:28 UTC (1275311488)
[   95.982924] sd 0:0:0:0: [sda] Write Protect is off
[   96.040152] sd 0:0:0:0: [sda] Mode Sense: 9f 00 10 08
[   96.102714] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   96.210752]  sda: sda1 sda2 sda3 sda4
[   96.272637] sd 0:0:0:0: [sda] Attached SCSI disk
[   96.347821] EXT3-fs: barriers not enabled
[   96.404350] kjournald starting.  Commit interval 5 seconds
[   96.469172] EXT3-fs (sda2): mounted filesystem with writeback data mode
[   96.548212] VFS: Mounted root (ext3 filesystem) readonly on device 8:2.
[   97.321865] async/0 used greatest stack depth: 10048 bytes left
[   97.471896] modprobe used greatest stack depth: 9344 bytes left
[   97.964343] date used greatest stack depth: 8656 bytes left
[   99.411071] udevd used greatest stack depth: 8 bytes left
[  100.219774] PCI: Enabling device: (0000:00:01.1), cmd 2
[  100.281510] sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@davemloft.net)
[  100.372159] eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:b0:4e:f6
[  100.818660] sr0: scsi-1 drive
[  100.853496] Uniform CD-ROM driver Revision: 3.20
[  100.909555] sr 0:0:6:0: Attached scsi CD-ROM sr0
[  101.161794] sd 0:0:0:0: Attached scsi generic sg0 type 0
[  101.224834] sr 0:0:6:0: Attached scsi generic sg1 type 5
[  102.562874] Adding 441776k swap on /dev/sda4.  Priority:-1 extents:1 across:441776k 
[  102.997251] EXT3-fs (sda2): using internal journal
[  103.474959] loop: module loaded
[  110.261672] eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.

-- 
Meelis Roos (mroos@linux.ee)
