From: Meelis Roos <mroos@linux.ee>
Date: Mon, 02 May 2011 10:39:46 +0000
Subject: SBus devices sometimes detected, sometimes not
Message-Id: <alpine.SOC.1.00.1105021259220.6200@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is 2.6.39-rc3..rc5 on Sun Ultra 1 with SBus hme card.
On about 50% of boots, hme is found fine and works. On other half boots 
(not strictly in any order) SBus hme is not detected with this error:

hme: probe of f006be34 failed with error -22

grepping the logs, I sometimes also find similar errors about qlogicpti:

qpti: probe of f00798c4 failed with error -22

The node addresses are always the same for the device.

2.6.38 did not have this problem.

On SBus-only E3000 and SBus+PCI E3500, SBus HME and other SBus 
devices are detected fine so far in a handful of tests.

prtconf -pv output:
System Configuration:  Sun Microsystems  sun4u
Memory size: 832 Megabytes
System Peripherals (PROM Nodes):

Node 0xf0029970
    .node:  f0029970
    energystar-v2:  
    idprom:  01800800.20886d6a.00000000.886d6aa9.00000000.00000000.10000000.00000000
    reset-reason: 'S-POR'
    breakpoint-trap:  0000007f
    #size-cells:  00000002
    model: 'SUNW,501-2836'
    name: 'SUNW,Ultra-1'
    clock-frequency:  0442dc41
    banner-name: 'Sun Ultra 1 SBus (UltraSPARC 143MHz)'
    device_type: 'upa'

    Node 0xf002cbb4
        .node:  f002cbb4
        name: 'packages'

        Node 0xf0033d38
            .node:  f0033d38
            iso6429-1983-colors:  
            name: 'terminal-emulator'

        Node 0xf0036a74
            .node:  f0036a74
            disk-write-fix:  
            name: 'deblocker'

        Node 0xf0037150
            .node:  f0037150
            name: 'obp-tftp'

        Node 0xf0041f10
            .node:  f0041f10
            name: 'disk-label'

        Node 0xf005fc58
            .node:  f005fc58
            name: 'sun-keyboard'

    Node 0xf002cc24
        .node:  f002cc24
        stdout:  fffe6040
        stdin:  fffe6228
        mmu:  fffe8438
        memory:  fffe8638
        bootargs:  00
        bootpath: '/sbus@1f,0/espdma@e,8400000/esp@e,8800000/sd@0,0:a'
        stdout-#lines:  ffffffff
        name: 'chosen'

    Node 0xf002cc90
        .node:  f002cc90
        version: 'OBP 3.35.0 2004/04/19 12:15'
        model: 'SUNW,3.35'
        decode-complete:  
        aligned-allocator:  
        relative-addressing:  
        name: 'openprom'

        Node 0xf002cd20
            .node:  f002cd20
            name: 'client-services'

    Node 0xf002cdc8
        .node:  f002cdc8
        tpe-link-test?: 'true'
        scsi-initiator-id: '7'
        keyboard-click?: 'false'
        keymap:  
        sbus-probe-list: '012'
        ttyb-rts-dtr-off: 'false'
        ttyb-ignore-cd: 'true'
        ttya-rts-dtr-off: 'false'
        ttya-ignore-cd: 'true'
        ttyb-mode: '9600,8,n,1,-'
        ttya-mode: '9600,8,n,1,-'
        mfg-mode: 'off'
        diag-level: 'max'
        #power-cycles: '1193'
        system-board-serial#: '5013051005142'
        system-board-date: '33a6c68b'
        fcode-debug?: 'false'
        output-device: 'ttya'
        input-device: 'ttya'
        load-base: '16384'
        boot-command: 'boot'
        auto-boot?: 'true'
        watchdog-reboot?: 'true'
        diag-file:  
        diag-device: 'net'
        boot-file:  
        boot-device: 'disk net'
        local-mac-address?: 'false'
        ansi-terminal?: 'true'
        screen-#columns: '80'
        screen-#rows: '34'
        silent-mode?: 'false'
        use-nvramrc?: 'false'
        nvramrc:  
        security-mode: 'none'
        security-password:  
        security-#badlogins: '0'
        oem-logo:  
        oem-logo?: 'false'
        oem-banner:  
        oem-banner?: 'false'
        hardware-revision:  
        last-hardware-update:  
        diag-switch?: 'false'
        name: 'options'

    Node 0xf002ce38
        .node:  f002ce38
        net-aui: '/sbus/ledma@e,8400010:aui/le@e,8c00000'
        net-tpe: '/sbus/ledma@e,8400010:tpe/le@e,8c00000'
        net: '/sbus/ledma@e,8400010/le@e,8c00000'
        disk: '/sbus/espdma@e,8400000/esp@e,8800000/sd@0,0'
        cdrom: '/sbus/espdma@e,8400000/esp@e,8800000/sd@6,0:f'
        tape: '/sbus/espdma@e,8400000/esp@e,8800000/st@4,0'
        tape1: '/sbus/espdma@e,8400000/esp@e,8800000/st@5,0'
        tape0: '/sbus/espdma@e,8400000/esp@e,8800000/st@4,0'
        disk6: '/sbus/espdma@e,8400000/esp@e,8800000/sd@6,0'
        disk5: '/sbus/espdma@e,8400000/esp@e,8800000/sd@5,0'
        disk4: '/sbus/espdma@e,8400000/esp@e,8800000/sd@4,0'
        disk3: '/sbus/espdma@e,8400000/esp@e,8800000/sd@3,0'
        disk2: '/sbus/espdma@e,8400000/esp@e,8800000/sd@2,0'
        disk1: '/sbus/espdma@e,8400000/esp@e,8800000/sd@1,0'
        disk0: '/sbus/espdma@e,8400000/esp@e,8800000/sd@0,0'
        scsi: '/sbus/espdma@e,8400000/esp@e,8800000'
        floppy: '/sbus/SUNW,fdtwo'
        ttyb: '/sbus/zs@f,1100000:b'
        ttya: '/sbus/zs@f,1100000:a'
        keyboard!: '/sbus/zs@f,1000000:forcemode'
        keyboard: '/sbus/zs@f,1000000'
        name: 'aliases'

    Node 0xf004cadc
        .node:  f004cadc
        reg:  00000000.00000000.00000000.10000000.00000000.10000000.00000000.10000000.00000000.20000000.00000000.10000000.00000000.30000000.00000000.04000000
        available:  00000000.33f3c000.00000000.00014000.00000000.33f00000.00000000.0002c000.00000000.00000000.00000000.33efe000
        name: 'memory'

    Node 0xf004d0bc
        .node:  f004d0bc
        translations:  00000000.fffe0000.00000000.00010000.80000000.33f700b6.00000000.fffd8000.00000000.00008000.80000000.33f600b6.00000000.fffcc000.00000000.00008000.800001fe.0000008e.00000000.fffc8000.00000000.00004000.80000000.33f5c0b6.00000000.fffc6000.00000000.00002000.800001fe.0000208e.00000000.fffc4000.00000000.00002000.800001fe.0000208e.00000000.fffc2000.00000000.00002000.800001fe.0000208e.00000000.fffc0000.00000000.00002000.800001ff.f120008e.00000000.fffbe000.00000000.00002000.800001ff.f120008e.00000000.fffbc000.00000000.00002000.800001ff.f130008e.00000000.fffba000.00000000.00002000.800001ff.f190008e.00000000.fffb8000.00000000.00002000.800001ff.f100008e.00000000.fffb6000.00000000.00002000.80000000.33efe0b6.00000000.fffb4000.00000000.00002000.80000000.33f580b6.00000000.fffb2000.00000000.00002000.800001ff.f140008e.00000000.fffb0000.00000000.00002000.800001ff.f110008e.00000000.fffa0000.00000000.00002000.80000000.33f560b6.00000000.f0080000.00000000.00002000.80000000.33f5
 40b6.00000000.f0000000.00000000.00080000.80000000.33f800b6.00000000.40000000.00000000.04000000.80000000.00400036.00000000.00002000.00000000.00bfe000.80000000.00002036
        existing:  00000000.00000000.00000800.00000000.fffff800.00000000.00000800.00000000
        available:  fffff800.00000000.000007fc.00000000.00000001.00000000.000007ff.00000000.00000000.ffff0000.00000000.0000e000.00000000.00000000.00000000.f0000000.00000000.fffa2000.00000000.0000e000.00000000.fff00000.00000000.000a0000.00000000.f0800000.00000000.0e800000
        page-size:  00002000
        name: 'virtual-memory'

    Node 0xf00595dc
        .node:  f00595dc
        address:  fffc7c00.fffc5860.fffc3060
        interrupts:  000007f0.000007f1
        reg:  000001fe.00003c00.00000000.00000020.000001fe.00003860.00000000.00000010.000001fe.00003060.00000000.00000010
        name: 'counter-timer'

    Node 0xf0059940
        .node:  f0059940
        scsi-initiator-id:  00000007
        version#:  00000001
        implementation#:  00000000
        address:  fffcc000
        interrupts:  000007f4.000007f5.000007f6.000007e5.000007ea.000007f7
        ranges:  00000000.00000000.000001ff.00000000.10000000.00000001.00000000.000001ff.10000000.10000000.00000002.00000000.000001ff.20000000.10000000.00000003.00000000.000001ff.30000000.10000000.0000000d.00000000.000001ff.d0000000.10000000.0000000e.00000000.000001ff.e0000000.10000000.0000000f.00000000.000001ff.f0000000.10000000
        reg:  000001fe.00000000.00000000.00008000
        slot-address-bits:  0000001c
        up-burst-sizes:  0078007f
        burst-sizes:  00f8007f
        device_type: 'sbus'
        name: 'sbus'
        model: 'SUNW,sysio'
        thermal-interrupt:  
        bus-parity-generated:  
        upa-portid:  0000001f
        clock-frequency:  017d7840

        Node 0xf0059e44
            .node:  f0059e44
            internal-loopback:  
            dma-model: 'apcdma'
            interrupts:  00000024
            reg:  0000000d.0c000000.00000200
            name: 'SUNW,CS4231'

        Node 0xf0059f50
            .node:  f0059f50
            address:  fffba000
            reg:  0000000f.01900000.00000001
            name: 'auxio'

        Node 0xf0059fe0
            .node:  f0059fe0
            version:  4f425020.332e3335.2e302032.3030342f.30342f31.39203132.3a313500.504f5354.20332e31.302e3620.31393936.2f31302f.31382031.303a3139.00
            model: 'SUNW,525-1410'
            reg:  0000000f.00000000.00080000.0000000f.01380000.00080000
            name: 'flashprom'

        Node 0xf005a0a8
            .node:  f005a0a8
            status: 'disabled'
            device_type: 'block'
            interrupts:  00000029
            reg:  0000000f.01400000.00000008
            name: 'SUNW,fdtwo'

        Node 0xf005a1dc
            .node:  f005a1dc
            address:  fffbe000
            reg:  0000000f.01200000.00002000
            model: 'mk48t59'
            name: 'eeprom'

        Node 0xf005a290
            .node:  f005a290
            port-b-ignore-cd:  
            port-a-ignore-cd:  
            reg:  0000000f.01100000.00000004
            interrupts:  00000028
            device_type: 'serial'
            name: 'zs'

        Node 0xf005b730
            .node:  f005b730
            reg:  0000000f.01000000.00000004
            interrupts:  00000028
            port-b-ignore-cd:  
            port-a-ignore-cd:  
            keyboard:  
            device_type: 'serial'
            name: 'zs'

        Node 0xf005d18c
            .node:  f005d18c
            address:  fffbc000
            model: 'SUNW,sc-up'
            reg:  0000000f.01300000.00000008
            name: 'sc'

        Node 0xf005d240
            .node:  f005d240
            freq-syn: 'MC12429'
            reg:  0000000f.01304000.00000003
            name: 'SUNW,pll'

        Node 0xf0062784
            .node:  f0062784
            reg:  0000000e.08400000.00000010
            name: 'espdma'

            Node 0xf0062a74
                .node:  f0062a74
                device_type: 'scsi'
                clock-frequency:  02625a00
                interrupts:  00000020
                reg:  0000000e.08800000.00000040
                name: 'esp'

                Node 0xf0065348
                    .node:  f0065348
                    device_type: 'block'
                    name: 'sd'

                Node 0xf0065e54
                    .node:  f0065e54
                    device_type: 'byte'
                    name: 'st'

        Node 0xf0066ae4
            .node:  f0066ae4
            burst-sizes:  0000003f
            reg:  0000000e.08400010.00000020
            name: 'ledma'

            Node 0xf006707c
                .node:  f006707c
                device_type: 'network'
                busmaster-regval:  00000007
                interrupts:  00000021
                reg:  0000000e.08c00000.00000004
                name: 'le'

        Node 0xf0069908
            .node:  f0069908
            reg:  0000000e.0c800000.0000001c
            interrupts:  00000022
            name: 'SUNW,bpp'

        Node 0xf006be34
            .node:  f006be34
            hm-rev:  00000022
            model: 'SUNW,501-2739'
            device_type: 'network'
            intr:  00000004.00000000
            interrupts:  00000004
            address-bits:  00000030
            max-frame-size:  00004000
            reg:  00000000.08c00000.00000108.00000000.08c02000.00002000.00000000.08c04000.00002000.00000000.08c06000.00002000.00000000.08c07000.00000020
            name: 'SUNW,hme'

        Node 0xf00735ac
            .node:  f00735ac
            hm-rev:  00000022
            device_type: 'scsi'
            clock-frequency:  02625a00
            intr:  00000003.00000000
            interrupts:  00000003
            reg:  00000000.08800000.00000010.00000000.08810000.00000040
            name: 'SUNW,fas'

            Node 0xf007831c
                .node:  f007831c
                device_type: 'block'
                name: 'sd'

            Node 0xf0078bd8
                .node:  f0078bd8
                device_type: 'byte'
                name: 'st'

        Node 0xf00798c4
            .node:  f00798c4
            scsi-initiator-id:  00000007
            isp-fcode: '1.21 95/05/18'
            device_type: 'scsi'
            intr:  00000003.00000000
            interrupts:  00000003
            wide:  00
            clock-frequency:  02625a00
            reg:  00000001.00010000.00000450
            64-bit-clean:  00
            model: 'QLGC,ISP1000'
            name: 'QLGC,isp'

            Node 0xf007f130
                .node:  f007f130
                device_type: 'block'
                name: 'sd'

            Node 0xf007f944
                .node:  f007f944
                device_type: 'byte'
                name: 'st'

    Node 0xf006b9d0
        .node:  f006b9d0
        manufacturer#:  00000017
        implementation#:  00000010
        mask#:  00000040
        sparc-version:  00000009
        ecache-associativity:  00000001
        ecache-line-size:  00000040
        ecache-size:  00080000
        #dtlb-entries:  00000040
        dcache-associativity:  00000001
        dcache-line-size:  00000020
        dcache-size:  00004000
        #itlb-entries:  00000040
        icache-associativity:  00000002
        icache-line-size:  00000020
        icache-size:  00004000
        upa-portid:  00000000
        clock-frequency:  0885b882
        reg:  000001c0.00000000.00000000.00000008
        device_type: 'cpu'
        name: 'SUNW,UltraSPARC'


Full dmesg of a failing boot, with debug option:

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.35.0 2004/04/19 12:15'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.39-rc5-00091-gfafc992 (mroos@melon) (gcc version 4.4.6 (Debian 4.4.6-2) ) #123 Fri Apr 29 14:45:34 EEST 2011
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 08:00:20:88:6d:6a
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /sbus@1f,0/zs@f,1100000:a
[    0.000000] PROM: Built device tree with 34609 bytes of memory.
[    0.000000] Top of RAM: 0x33f50000, Total RAM: 0x33f3e000
[    0.000000] Memory hole size: 0MB
[    0.000000] [0000010000000000-fffff80000c00000] page_structs1072 node=0 entry=0/8192
[    0.000000] [0000010000000000-fffff80001000000] page_structs1072 node=0 entry=1/8192
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x00000000 -> 0x00019fa8
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00019f7f
[    0.000000]     0: 0x00019f80 -> 0x00019f96
[    0.000000]     0: 0x00019f9e -> 0x00019fa8
[    0.000000] On node 0 totalpages: 106399
[    0.000000]   Normal zone: 832 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 105567 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 105567
[    0.000000] Kernel command line: root=/dev/sda2 ro debug ignore_loglevel
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
[    0.000000] Memory: 837040k available (2720k kernel code, 928k data, 136k init) [fffff80000000000,0000000033f50000]
[    0.000000] NR_IRQS:255
[    0.000000] clocksource: mult[dfce39c4] shift[29]
[    0.000000] clockevent: mult[249a6b51] shift[32]
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled, bootconsole disabled
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.35.0 2004/04/19 12:15'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.39-rc5-00091-gfafc992 (mroos@melon) (gcc version 4.4.6 (Debian 4.4.6-2) ) #123 Fri Apr 29 14:45:34 EEST 2011
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 08:00:20:88:6d:6a
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /sbus@1f,0/zs@f,1100000:a
[    0.000000] PROM: Built device tree with 34609 bytes of memory.
[    0.000000] Top of RAM: 0x33f50000, Total RAM: 0x33f3e000
[    0.000000] Memory hole size: 0MB
[    0.000000] [0000010000000000-fffff80000c00000] page_structs1072 node=0 entry=0/8192
[    0.000000] [0000010000000000-fffff80001000000] page_structs1072 node=0 entry=1/8192
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x00000000 -> 0x00019fa8
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00019f7f
[    0.000000]     0: 0x00019f80 -> 0x00019f96
[    0.000000]     0: 0x00019f9e -> 0x00019fa8
[    0.000000] On node 0 totalpages: 106399
[    0.000000]   Normal zone: 832 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 105567 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 105567
[    0.000000] Kernel command line: root=/dev/sda2 ro debug ignore_loglevel
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
[    0.000000] Memory: 837040k available (2720k kernel code, 928k data, 136k init) [fffff80000000000,0000000033f50000]
[    0.000000] NR_IRQS:255
[    0.000000] clocksource: mult[dfce39c4] shift[29]
[    0.000000] clockevent: mult[249a6b51] shift[32]
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled, bootconsole disabled
[   54.715091] Calibrating delay using timer specific routine.. 286.85 BogoMIPS (lpj34278)
[   54.715212] pid_max: default: 32768 minimum: 301
[   54.715925] Mount-cache hash table entries: 512
[   54.717260] Initializing cgroup subsys blkio
[   54.721607] NET: Registered protocol family 16
[   54.747481] SYSIO: UPA portID ffffffff, at 000001fe00000000
[   54.781981] bio: create slab <bio-0> at 0
[   54.786643] SCSI subsystem initialized
[   54.790928] /sbus@1f,0/eeprom@f,1200000: Mostek regs at 0x1fff1200000
[   54.792775] AUXIO: Found device at /sbus@1f,0/auxio@f,1900000
[   54.793310] Switching to clocksource tick
[   54.795390] Switched to NOHz mode on CPU #0
[   54.842301] NET: Registered protocol family 2
[   54.842808] IP route cache hash table entries: 8192 (order: 3, 65536 bytes)
[   54.843659] IPv4 FIB: Using LC-trie version 0.409
[   54.844617] TCP established hash table entries: 32768 (order: 6, 524288 bytes)
[   54.847938] TCP bind hash table entries: 32768 (order: 5, 262144 bytes)
[   54.849655] TCP: Hash tables configured (established 32768 bind 32768)
[   54.849749] TCP reno registered
[   54.849829] UDP hash table entries: 512 (order: 1, 16384 bytes)
[   54.850021] UDP-Lite hash table entries: 512 (order: 1, 16384 bytes)
[   54.851208] NET: Registered protocol family 1
[   54.855601] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[   54.860149] msgmni has been set to 1634
[   54.861683] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[   54.861834] io scheduler noop registered
[   54.861919] io scheduler deadline registered
[   54.862153] io scheduler cfq registered (default)
[   54.866623] f005a290: ttyS0 at MMIO 0x1fff1100000 (irq = 9) is a zs
[   54.866743] Console: ttyS0 (SunZilog zs0)
[   59.308387] console [ttyS0] enabled
[   59.350982] f005a290: ttyS1 at MMIO 0x1fff1100004 (irq = 9) is a zs
[   59.426366] f005b730: Keyboard at MMIO 0x1fff1000000 (irq = 9) is a zs
[   59.503080] f005b730: Mouse at MMIO 0x1fff1000004 (irq = 9) is a zs
[   59.582208] esp: esp0, regs[1ffe8800000:1ffe8400000] irq[10]
[   59.648102] esp: esp0 is a FAS100A, 40 MHz (ccf=0), SCSI ID 7
[   62.724008] scsi0 : esp
[   62.755072] scsi 0:0:0:0: Direct-Access     MAXTOR   ATLAS10K4_36SCA  DFV0 PQ: 0 ANSI: 3
[   62.850304] scsi target0:0:0: Beginning Domain Validation
[   62.917213] scsi target0:0:0: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
[   63.000048] scsi target0:0:0: Domain Validation skipping write tests
[   63.074759] scsi target0:0:0: Ending Domain Validation
[   64.315345] scsi 0:0:6:0: CD-ROM            TOSHIBA  XM-5401TASUN4XCD 2565 PQ: 0 ANSI: 2
[   64.410496] scsi target0:0:6: Beginning Domain Validation
[   64.489103] scsi target0:0:6: FAST-5 SCSI 4.2 MB/s ST (236 ns, offset 15)
[   64.576663] scsi target0:0:6: Domain Validation skipping write tests
[   64.650854] scsi target0:0:6: Ending Domain Validation
[   64.720955] esp: esp1, regs[1ff08810000:1ff08800000] irq[14]
[   64.786815] esp: esp1 is a FASHME, 40 MHz (ccf=0), SCSI ID 7
[   67.863979] scsi1 : esp
[   71.408186] sd 0:0:0:0: [sda] 71833096 512-byte logical blocks: (36.7 GB/34.2 GiB)
[   71.499601] mousedev: PS/2 mouse device common for all mice
[   71.568442] rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t59 as rtc0
[   71.647257] sd 0:0:0:0: [sda] Write Protect is off
[   71.704128] sd 0:0:0:0: [sda] Mode Sense: ed 00 10 08
[   71.766308] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   71.870153] TCP cubic registered
[   71.906843] NET: Registered protocol family 17
[   71.959995] Registering the dns_resolver key type
[   72.018664] rtc-m48t59 rtc-m48t59.0: setting system clock to 2011-04-30 10:29:11 UTC (1304159351)
[   72.131859]  sda: sda1 sda2 sda3 sda4
[   72.181271] sd 0:0:0:0: [sda] Attached SCSI disk
[   72.565091] input: Sun Mouse as /devices/root/f0059940/f005b730/serio1/input/input0
[   72.665138] EXT3-fs: barriers not enabled
[   72.713659] kjournald starting.  Commit interval 5 seconds
[   72.777794] EXT3-fs (sda2): mounted filesystem with writeback data mode
[   72.856671] VFS: Mounted root (ext3 filesystem) readonly on device 8:2.
[   76.189823] /sbus@1f,0/flashprom@f,0: OBP Flash, RD 1fff0000000[80000] WR 1fff1380000[80000]
[   76.909059] qlogicpti0: IRQ 15 SCSI ID 7 
[   77.347303] sunlance.c:v2.02 8/24/03 Miguel de Icaza (miguel@nuclecu.unam.mx)
[   77.433479] SunLance: using auto-carrier-detection.
[   77.492644] eth0: LANCE 08:00:20:88:6d:6a
[   77.716846] sr0: scsi-1 drive
[   77.750573] cdrom: Uniform CD-ROM driver Revision: 3.20
[   77.814894] sr 0:0:6:0: Attached scsi CD-ROM sr0
[   78.378300] udevd[364]: renamed network interface eth0 to eth1
[   78.510164] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   78.572319] sr 0:0:6:0: Attached scsi generic sg1 type 5
[   79.198210] (Firmware v1.31.32)(FCode 1.21 95/05/18)
[   79.253680] qlogicpti0: [Fast Wide, using single ended interface]
[   79.328716] scsi2 : PTI Qlogic,ISP SBUS SCSI irq 15 regs at 000001ff10010000
[   83.283197] hme: probe of f006be34 failed with error -22
[   83.348112] parport0: sunbpp at 0x1ffec800000
[   86.113935] EXT3-fs (sda2): using internal journal
[   87.107776] NET: Registered protocol family 10
[   88.439778] kjournald starting.  Commit interval 5 seconds
[   88.508907] EXT3-fs (sda1): using internal journal
[   88.564392] EXT3-fs (sda1): mounted filesystem with writeback data mode

-- 
Meelis Roos (mroos@linux.ee)
