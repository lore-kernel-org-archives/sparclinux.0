From: Meelis Roos <mroos@linux.ee>
Date: Tue, 09 Jun 2015 07:14:57 +0000
Subject: PCI slot detection on older systems
Message-Id: <alpine.LRH.2.11.1506021120010.17837@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I tested todays git 4.1.0-rc6-00040-gc46a024 on multiple sparc 
servers.

On V210, V240, V440 (similar bunch on USIIIi servers) and PCI slot 
detection seems to work - it mirrors prtconf information (1, 2 and 3 
slots per PCI bus on V440, less on the smallers ones).

On V245 there are 4 slots with 2 risers (2-port PCI-X and PCI-E risers 
are present). Two of them are detected, including PCI-E link speeds. The 
names are strange though (224 and 226). Two PCI-X slots are not detected 
(there is a FC card in one of them that is detected fine).

prtconf has names "PCI-X 1" "PCI-X 3" and "PCI-E 2" "PCI-E 0".

For reference, the "prtconf -pv" is below.

On T2000 there are 3 physical slots described in prtconf 
(physical-slot#: e0, e1, e2 properties of devices). sysfs has slots 224, 
225 and 226 (the same e0, e1, e2). They have PCI-E speeds displayed 
correctly.

So it seems that the slots are detected fine, V210 and T200 display all 
the information available from prom conf tree, but on V245 the slot 
number are detected but slot names are not?


System Configuration:  Sun Microsystems  sun4u
Memory size: 4096 Megabytes
System Peripherals (PROM Nodes):

Node 0xf002a25c
    .node:  f002a25c
    interrupt-map:  00000400.0fd30000.00000001.f006872c.0000003d.00000400.0fd20000.00000001.f006872c.0000003c
    interrupt-map-mask:  00000fff.0fff0000.00000003
    #interrupt-cells:  00000001
    banner-name: 'Sun Fire V245'
    model: 'SUNW,375-3464'
    idprom:  01840014.4f720e2e.00000000.720e2ede.f1010a00.00000000.00000000.000000fa
    scsi-initiator-id:  00000007
    name: 'SUNW,Sun-Fire-V245'
    stick-frequency:  01312d00
    clock-frequency:  0b34a700
    breakpoint-trap:  0000007f
    #size-cells:  00000002
    device_type: 'jbus'

    Node 0xf002d444
        .node:  f002d444
        name: 'packages'

        Node 0xf0049e30
            .node:  f0049e30
            name: 'SUNW,builtin-drivers'

        Node 0xf005a350
            .node:  f005a350
            lba64:  
            disk-write-fix:  
            name: 'deblocker'

        Node 0xf005aa4c
            .node:  f005aa4c
            name: 'disk-label'

        Node 0xf005b3a8
            .node:  f005b3a8
            iso6429-1983-colors:  
            name: 'terminal-emulator'

        Node 0xf00630c8
            .node:  f00630c8
            source: '/flashprom:'
            name: 'dropins'

        Node 0xf007b1a4
            .node:  f007b1a4
            name: 'kbd-translator'

        Node 0xf007c4b8
            .node:  f007c4b8
            name: 'obp-tftp'

        Node 0xf008be5c
            .node:  f008be5c
            name: 'SUNW,i2c-ram-device'

        Node 0xf008c6a0
            .node:  f008c6a0
            name: 'SUNW,fru-device'

        Node 0xf008cea8
            .node:  f008cea8
            maximum-reason-length:  000000fa
            name: 'SUNW,asr'

    Node 0xf002d4bc
        .node:  f002d4bc
        bootargs:  00
        bootpath: '/pci@1e,600000/pci@0/pci@a/pci@0/pci@8/scsi@1/disk@0,0:a'
        mmu:  fff74080
        memory:  fff74290
        stdout:  fefffb00
        stdin:  fefffd90
        stdout-#lines:  ffffffff
        name: 'chosen'

    Node 0xf002d530
        .node:  f002d530
        version: 'OBP 4.30.4 2009/08/19 07:18'
        model: 'SUNW,4.30.4'
        aligned-allocator:  
        relative-addressing:  
        name: 'openprom'

        Node 0xf002d5c0
            .node:  f002d5c0
            name: 'client-services'

    Node 0xf002d678
        .node:  f002d678
        asr-policy: 'normal'
        keyboard-layout: 'US-English'
        test-args:  
        diag-passes: '1'
        local-mac-address?: 'true'
        fcode-debug?: 'false'
        scsi-initiator-id: '7'
        oem-logo:  
        oem-logo?: 'false'
        oem-banner: 'Ehh ei tea'
        oem-banner?: 'false'
        ansi-terminal?: 'true'
        screen-#columns: '80'
        screen-#rows: '34'
        ttyb-rts-dtr-off: 'false'
        ttyb-ignore-cd: 'true'
        ttya-rts-dtr-off: 'false'
        ttya-ignore-cd: 'true'
        ttyb-mode: '9600,8,n,1,-'
        ttya-mode: '9600,8,n,1,-'
        output-device: 'screen'
        input-device: 'keyboard'
        auto-boot-on-error?: 'true'
        error-reset-recovery: 'sync'
        load-base: '16384'
        auto-boot?: 'true'
        network-boot-arguments:  
        boot-command: 'boot'
        diag-file:  
        diag-device: 'net'
        boot-file:  
        boot-device: 'disk net'
        use-nvramrc?: 'false'
        nvramrc:  
        security-mode: 'none'
        security-password:  
        security-#badlogins: '0'
        verbosity: 'normal'
        diag-trigger: 'error-reset power-on-reset '
        service-mode?: 'false'
        diag-script: 'normal'
        diag-level: 'max'
        diag-switch?: 'false'
        name: 'options'

    Node 0xf002d6f0
        .node:  f002d6f0
        net: '/pci@1e,600000/pci@0/pci@9/pci@0/network@4'
        net0: '/pci@1e,600000/pci@0/pci@9/pci@0/network@4'
        net1: '/pci@1e,600000/pci@0/pci@9/pci@0/network@4,1'
        net2: '/pci@1e,600000/pci@0/pci@a/pci@0/network@4'
        net3: '/pci@1e,600000/pci@0/pci@a/pci@0/network@4,1'
        cdrom: '/pci@1e,600000/pci@0/pci@1/pci@0/ide@1f/cdrom@0,0:f'
        ide: '/pci@1e,600000/pci@0/pci@1/pci@0/ide@1f'
        disk: '/pci@1e,600000/pci@0/pci@a/pci@0/pci@8/scsi@1/disk@0,0'
        disk0: '/pci@1e,600000/pci@0/pci@a/pci@0/pci@8/scsi@1/disk@0,0'
        disk1: '/pci@1e,600000/pci@0/pci@a/pci@0/pci@8/scsi@1/disk@1,0'
        disk2: '/pci@1e,600000/pci@0/pci@a/pci@0/pci@8/scsi@1/disk@2,0'
        disk3: '/pci@1e,600000/pci@0/pci@a/pci@0/pci@8/scsi@1/disk@3,0'
        scsi: '/pci@1e,600000/pci@0/pci@a/pci@0/pci@8/scsi@1'
        ttya: '/ebus@1f,464000/serial@2,80'
        ttyb: '/ebus@1f,464000/serial@2,40'
        sc-control: '/ebus@1f,464000/rmc-comm@2,0'
        name: 'aliases'

    Node 0xf003fce0
        .node:  f003fce0
        reg:  00000000.00000000.00000000.80000000.00000001.00000000.00000000.80000000
        available:  00000001.7fee6000.00000000.00002000.00000001.7fee0000.00000000.00004000.00000001.7fe44000.00000000.0001c000.00000001.7f000000.00000000.00e34000.00000001.00000000.00000000.7effe000.00000000.00000000.00000000.80000000
        name: 'memory'

    Node 0xf00402ec
        .node:  f00402ec
        translations:  00000000.00002000.00000000.003fe000.80000000.00002036.00000000.00400000.00000000.00800000.80000001.00000036.00000000.40000000.00000000.04000000.80000001.00000036.00000000.f0000000.00000000.00080000.80000001.7ff800b6.00000000.f0080000.00000000.00010000.80000001.7ff200b6.00000000.f0090000.00000000.00010000.80000001.7ff100b6.00000000.f00a0000.00000000.00010000.80000001.7fed00b6.00000000.f00b0000.00000000.00010000.80000001.7fec00b6.00000000.f00c0000.00000000.00020000.80000001.7fea00b6.00000000.f00e0000.00000000.00020000.80000001.7fe800b6.00000000.f0100000.00000000.00010000.80000001.7fe700b6.00000000.f0110000.00000000.00010000.80000001.7fe600b6.00000000.feb20000.00000000.00200000.800007ff.f000008e.00000000.fed20000.00000000.000f0000.80000400.0ff0008e.00000000.fee10000.00000000.000f0000.80000400.0f60008e.00000000.fefe4000.00000000.0001c000.80000001.7feee0b6.00000000.fff10000.00000000.00002000.800007f8.1000008e.00000000.fff12000.00000000.00002000.800007f9.0020
 408e.00000000.fff14000.00000000.00002000.800007f9.0020008e.00000000.fff16000.00000000.00002000.800007f9.0020008e.00000000.fff1c000.00000000.00002000.800007ff.f200008e.00000000.fff1e000.00000000.00002000.80000001.7feec0b6.00000000.fff20000.00000000.00002000.800007f9.0020008e.00000000.fff22000.00000000.00002000.80000001.7ff340b6.00000000.fff24000.00000000.00002000.80000001.7ff320b6.00000000.fff26000.00000000.00002000.800007ff.f100008e.00000000.fff28000.00000000.00002000.80000001.7ff360b6.00000000.fff2a000.00000000.00002000.80000001.7ff440b6.00000000.fff2c000.00000000.00006000.80000001.7ff0a0b6.00000000.fff32000.00000000.00002000.800007ff.f300008e.00000000.fff34000.00000000.00002000.80000001.7effe0b6.00000000.fff36000.00000000.00002000.800007f6.0020008e.00000000.fff38000.00000000.00004000.80000001.7ff380b6.00000000.fff3c000.00000000.00002000.80000400.0fc0008e.00000000.fff3e000.00000000.00002000.800007f8.00d0808e.00000000.fff40000.00000000.00004000.80000001.7ff3c0b6.00000000.fff
 44000.00000000.00002000.80000400.0f40008e.00000000.fff46000.00000000.00004000.80000001.7ff400b6.00000000.fff4a000.00000000.00002000.80000400.0fd3008e.00000000.fff50000.00000000.00002000.80000001.7ff5e0b6.00000000.fff52000.00000000.00016000.80000001.7ff460b6.00000000.fff68000.00000000.00008000.80000001.7ff600b6.00000000.fff70000.00000000.00010000.80000001.7ff700b6
        existing:  00000000.00000000.00000800.00000000.fffff800.00000000.00000800.00000000
        available:  fffff800.00000000.000007fc.00000000.00000001.00000000.000007ff.00000000.00000000.ffff0000.00000000.0000e000.00000000.00000000.00000000.f0000000.00000000.fff18000.00000000.00004000.00000000.fff00000.00000000.00010000.00000000.fef00000.00000000.000e4000.00000000.f0800000.00000000.0e320000
        page-size:  00002000
        name: 'virtual-memory'

    Node 0xf0067eac
        .node:  f0067eac
        clock-divisors:  00000001.00000002.00000020
        clock-frequency:  59a53800
        manufacturer#:  0000003e
        implementation#:  00000016
        mask#:  00000034
        ecache-associativity:  00000004
        ecache-line-size:  00000040
        sparc-version:  00000009
        #dtlb-entries:  00000010
        dcache-associativity:  00000004
        dcache-line-size:  00000020
        dcache-size:  00010000
        #itlb-entries:  00000010
        icache-associativity:  00000004
        icache-line-size:  00000020
        icache-size:  00008000
        device_type: 'cpu'
        cpuid:  00000000
        portid:  00000000
        reg:  00000400.00000000.00000000.00010000
        ecache-size:  00100000
        name: 'SUNW,UltraSPARC-IIIi'

    Node 0xf00685f0
        .node:  f00685f0
        memory-control-register-1:  5000010a.3e901cb7
        memory-layout:  42302f44.30000000.42302f44.31000000.42312f44.30000000.42312f44.31000000.01ff00ff.0000ff00.ff0000ff.ffff00ff.00800000.00000000.00001718.1c1f7275.797b2c53.545758ae.afb2b353.545758ae.afb2b348.494f50a5.a6aaab48.494f50a5.a6aaab3d.40444599.9ba1a235.37393c92.9396973d.40444599.9ba1a235.37393c92.93969702.0406085e.5f626302.0406085e.5f62630c.0d131469.6a6d6e0c.0d131469.6a6d6e21.2327287e.7f838517.181c1f72.75797b2c.2d313386.878e9021.2327287e.7f838500
        compatible:  53554e57.2c556c74.72615350.4152432d.49494969.2c6d6300.53554e57.2c6d6300
        portid:  00000000
        reg:  00000400.00000000.00000000.00000008
        device_type: 'memory-controller'
        name: 'memory-controller'

    Node 0xf006872c
        .node:  f006872c
        interrupt-map:  00000000.00000000.00000000.00000001.f006872c.00000014.00000000.00000000.00000000.00000002.f006872c.00000015.00000000.00000000.00000000.00000003.f006872c.00000016.00000000.00000000.00000000.00000004.f006872c.00000017
        interrupt-map-mask:  00000000.00000000.00000000.00000007
        #interrupt-cells:  00000001
        available:  81000000.00000000.00003000.00000000.0000d000.82000000.00000000.00120000.00000000.000e0000.82000000.00000000.05000000.00000000.7aff0000.c3000000.00000001.00000000.00000000.ffff0000
        reg:  00000400.0f600000.00000000.000f0000.00000400.0f410000.00000000.00064000
        ranges:  00000000.00000000.00000000.000007f8.00000000.00000000.10000000.01000000.00000000.00000000.000007f8.10000000.00000000.10000000.02000000.00000000.00000000.000007f9.00000000.00000000.7fff0000.03000000.00000000.00000000.000007fc.00000000.00000001.ffff0000
        msi-address-ranges:  00000000.7fff0000.00010000.00000003.ffff0000.00010000
        msi-eq-devino:  00000000.00000024.00000018
        #msi-eqs:  00000024
        msix-data-width:  00000020
        msi-eq-size:  00000080
        msi-ranges:  00000000.00000100
        msi-data-mask:  000000ff
        #msi:  00000100
        bus-range:  00000002.0000000d
        bus-parity-generated:  
        compatible: 'pciex108e,80f0'
        name: 'pci'
        device_type: 'pciex'
        #address-cells:  00000003
        #size-cells:  00000002
        module-manufacturer#:  00000036
        fire-revision#:  00000003
        module-revision#:  00000003
        portid:  0000001e
        ino-bitmap:  fff7f817.ffffffff
        interrupts:  0000003f.0000003e

        Node 0xf00ad404
            .node:  f00ad404
            assigned-addresses:  82020010.00000000.00100000.00000000.00020000
            ranges:  81000000.00000000.00000000.81000000.00000000.00000000.00000000.00003000.82000000.00000000.00200000.82000000.00000000.00200000.00000000.04e00000
            bus-range:  00000003.0000000d
            compatible:  70636965.78313062.352c3835.33322e62.61007063.69657831.3062352c.38353332.00706369.6578636c.6173732c.30363034.30300070.63696578.636c6173.732c3036.303400
            reg:  00020000.00000000.00000000.00000000.00000000
            #address-cells:  00000003
            #size-cells:  00000002
            device_type: 'pciex'
            name: 'pci'
            interrupts:  00000001
            cache-line-size:  00000010
            class-code:  00060400
            revision-id:  000000ba
            device-id:  00008532
            vendor-id:  000010b5

            Node 0xf00af7c8
                .node:  f00af7c8
                ranges:  81000000.00000000.00000000.81000000.00000000.00000000.00000000.00002000.82000000.00000000.00200000.82000000.00000000.00200000.00000000.03e00000
                bus-range:  00000004.00000005
                compatible:  70636965.78313062.352c3835.33322e62.61007063.69657831.3062352c.38353332.00706369.6578636c.6173732c.30363034.30300070.63696578.636c6173.732c3036.303400
                reg:  00030800.00000000.00000000.00000000.00000000
                #address-cells:  00000003
                #size-cells:  00000002
                device_type: 'pciex'
                name: 'pci'
                interrupts:  00000001
                cache-line-size:  00000010
                class-code:  00060400
                revision-id:  000000ba
                device-id:  00008532
                vendor-id:  000010b5

                Node 0xf00b1b8c
                    .node:  f00b1b8c
                    interrupt-map:  0000e000.00000000.00000000.00000001.f006872c.00000000.0000e100.00000000.00000000.00000002.f006872c.00000000.0000e200.00000000.00000000.00000003.f006872c.00000000.0000e300.00000000.00000000.00000004.f006872c.00000001.0000f800.00000000.00000000.00000001.f006872c.00000004
                    interrupt-map-mask:  0000ff00.00000000.00000000.00000007
                    #interrupt-cells:  00000001
                    available:  81000000.00000000.00001140.00000000.00000ec0.82000000.00000000.00202000.00000000.00002000.82000000.00000000.00208000.00000000.00df8000
                    ranges:  81000000.00000000.00001000.81000000.00000000.00001000.00000000.00001000.82000000.00000000.00200000.82000000.00000000.00200000.00000000.03e00000
                    bus-range:  00000005.00000005
                    compatible:  70636965.78313062.392c3532.34392e30.00706369.65783130.62392c35.32343900.70636965.78636c61.73732c30.36303430.30007063.69657863.6c617373.2c303630.3400
                    reg:  00040000.00000000.00000000.00000000.00000000
                    #address-cells:  00000003
                    #size-cells:  00000002
                    device_type: 'pciex'
                    name: 'pci'
                    cache-line-size:  00000010
                    class-code:  00060400
                    revision-id:  00000000
                    device-id:  00005249
                    vendor-id:  000010b9

                    Node 0xf00b3f2c
                        .node:  f00b3f2c
                        assigned-addresses:  8205e010.00000000.01000000.00000000.01000000
                        sunw,find-fcode:  f00b975c
                        maximum-frame#:  0000ffff
                        reg:  0005e000.00000000.00000000.00000000.00000000.0205e010.00000000.00000000.00000000.01000000
                        #size-cells:  00000000
                        #address-cells:  00000001
                        compatible:  70636931.3062392c.35323337.2e313062.392e3532.33372e33.00706369.31306239.2c353233.372e3130.62392e35.32333700.70636931.3062392c.35323337.00706369.31306239.2c353233.372e3300.70636931.3062392c.35323337.00706369.636c6173.732c3063.30333130.00706369.636c6173.732c3063.303300
                        name: 'usb'
                        66mhz-capable:  
                        fast-back-to-back:  
                        devsel-speed:  00000001
                        latency-timer:  00000040
                        max-latency:  00000050
                        min-grant:  00000000
                        interrupts:  00000001
                        cache-line-size:  00000010
                        class-code:  000c0310
                        subsystem-id:  00005237
                        subsystem-vendor-id:  000010b9
                        revision-id:  00000003
                        device-id:  00005237
                        vendor-id:  000010b9

                    Node 0xf00ba5f8
                        .node:  f00ba5f8
                        assigned-addresses:  8205e110.00000000.02000000.00000000.01000000
                        sunw,find-fcode:  f00bfe28
                        maximum-frame#:  0000ffff
                        reg:  0005e100.00000000.00000000.00000000.00000000.0205e110.00000000.00000000.00000000.01000000
                        #size-cells:  00000000
                        #address-cells:  00000001
                        compatible:  70636931.3062392c.35323337.2e313062.392e3532.33372e33.00706369.31306239.2c353233.372e3130.62392e35.32333700.70636931.3062392c.35323337.00706369.31306239.2c353233.372e3300.70636931.3062392c.35323337.00706369.636c6173.732c3063.30333130.00706369.636c6173.732c3063.303300
                        name: 'usb'
                        66mhz-capable:  
                        fast-back-to-back:  
                        devsel-speed:  00000001
                        latency-timer:  00000040
                        max-latency:  00000050
                        min-grant:  00000000
                        interrupts:  00000002
                        cache-line-size:  00000010
                        class-code:  000c0310
                        subsystem-id:  00005237
                        subsystem-vendor-id:  000010b9
                        revision-id:  00000003
                        device-id:  00005237
                        vendor-id:  000010b9

                        Node 0xf00c0c40
                            .node:  f00c0c40
                            #size-cells:  00000000
                            #address-cells:  00000001
                            endpoints: '0,8,81,1'
                            interface#:  00000000
                            compatible:  75736233.65622c33.3330312e.33303000.75736233.65622c33.33303100.75736233.65622c63.6c617373.392e302e.30007573.62336562.2c636c61.7373392e.30007573.62336562.2c636c61.73733900.7573622c.636c6173.73392e30.2e300075.73622c63.6c617373.392e3000.7573622c.636c6173.73390075.73626966.3365622c.636c6173.73392e30.2e300075.73626966.3365622c.636c6173.73392e30.00757362.69663365.622c636c.61737339.00757362.69662c63.6c617373.392e302e.30007573.6269662c.636c6173.73392e30.00757362.69662c63.6c617373.3900
                            name: 'hub'
                            reg:  00000001
                            assigned-address:  00000002
                            0max-packet:  00000008

                    Node 0xf00cc644
                        .node:  f00cc644
                        assigned-addresses:  8205e310.00000000.00200000.00000000.00002000
                        reg:  0005e300.00000000.00000000.00000000.00000000.0205e310.00000000.00000000.00000000.00002000
                        compatible:  70636931.3062392c.35323339.2e313062.392e3532.33382e32.30303100.70636931.3062392c.35323339.2e313062.392e3532.33380070.63693130.62392c35.32333800.70636931.3062392c.35323339.2e323030.31007063.69313062.392c3532.33390070.6369636c.6173732c.30633033.32300070.6369636c.6173732c.30633033.00
                        name: 'usb'
                        66mhz-capable:  
                        fast-back-to-back:  
                        devsel-speed:  00000001
                        latency-timer:  00000040
                        max-latency:  00000020
                        min-grant:  00000010
                        interrupts:  00000004
                        cache-line-size:  00000010
                        class-code:  000c0320
                        subsystem-id:  00005238
                        subsystem-vendor-id:  000010b9
                        revision-id:  00000001
                        device-id:  00005239
                        vendor-id:  000010b9

                    Node 0xf00ccd3c
                        .node:  f00ccd3c
                        assigned-addresses:  8105f010.00000000.00000000.00000000.00001000
                        ranges:  00000000.00000000.8105f010.00000000.00000000.00001000
                        reg:  0005f000.00000000.00000000.00000000.00000000.8105f010.00000000.00000000.00000000.00001000
                        #size-cells:  00000001
                        #address-cells:  00000002
                        name: 'isa'
                        devsel-speed:  00000001
                        latency-timer:  00000040
                        max-latency:  00000018
                        min-grant:  00000001
                        cache-line-size:  00000000
                        class-code:  00060100
                        subsystem-id:  00001575
                        subsystem-vendor-id:  000010b9
                        revision-id:  00000000
                        device-id:  00001575
                        vendor-id:  000010b9

                        Node 0xf00cdb98
                            .node:  f00cdb98
                            address:  fff10070
                            reg:  00000000.00000070.00000004
                            compatible: 'isa-m5823p'
                            model: 'm5823'
                            name: 'rtc'

                    Node 0xf00ceac0
                        .node:  f00ceac0
                        assigned-addresses:  8105f810.00000000.00001040.00000000.00000040.8105f814.00000000.00001080.00000000.00000040.8105f818.00000000.000010c0.00000000.00000040.8105f81c.00000000.00001100.00000000.00000040.8105f820.00000000.00001000.00000000.00000040
                        reg:  0005f800.00000000.00000000.00000000.00000000.0105f810.00000000.00000000.00000000.00000028.0105f814.00000000.00000000.00000000.00000024.0105f818.00000000.00000000.00000000.00000028.0105f81c.00000000.00000000.00000000.00000024.0105f820.00000000.00000000.00000000.00000030
                        compatible:  70636931.3062392c.35323239.2e313062.392e3532.32392e63.38007063.69313062.392c3532.32392e31.3062392e.35323239.00706369.31306239.2c353232.39007063.69313062.392c3532.32392e63.38007063.69313062.392c3532.32390070.6369636c.6173732c.30313031.38660070.6369636c.6173732c.30313031.00
                        #address-cells:  00000002
                        device_type: 'ide'
                        name: 'ide'
                        66mhz-capable:  
                        fast-back-to-back:  
                        devsel-speed:  00000001
                        latency-timer:  00000040
                        max-latency:  00000000
                        min-grant:  00000000
                        interrupts:  00000001
                        cache-line-size:  00000010
                        class-code:  0001018f
                        subsystem-id:  00005229
                        subsystem-vendor-id:  000010b9
                        revision-id:  000000c8
                        device-id:  00005229
                        vendor-id:  000010b9

                        Node 0xf00d1da4
                            .node:  f00d1da4
                            device_type: 'block'
                            name: 'disk'
                            compatible: 'ide-disk'

                        Node 0xf00d2498
                            .node:  f00d2498
                            device_type: 'block'
                            name: 'cdrom'
                            compatible: 'ide-cdrom'

            Node 0xf00d3084
                .node:  f00d3084
                slot-names:  00000001.5043492d.45203200
                ranges:  82000000.00000000.fff00000.82000000.00000000.fff00000.ffffffff.00200000
                bus-range:  00000006.00000006
                compatible:  70636965.78313062.352c3835.33322e62.61007063.69657831.3062352c.38353332.00706369.6578636c.6173732c.30363034.30300070.63696578.636c6173.732c3036.303400
                reg:  00031000.00000000.00000000.00000000.00000000
                physical-slot#:  000000e2
                #address-cells:  00000003
                #size-cells:  00000002
                device_type: 'pciex'
                name: 'pci'
                interrupts:  00000001
                cache-line-size:  00000010
                class-code:  00060400
                revision-id:  000000ba
                device-id:  00008532
                vendor-id:  000010b5

            Node 0xf00d550c
                .node:  f00d550c
                slot-names:  00000001.5043492d.45203000
                ranges:  82000000.00000000.fff00000.82000000.00000000.fff00000.ffffffff.00200000
                bus-range:  00000007.00000007
                compatible:  70636965.78313062.352c3835.33322e62.61007063.69657831.3062352c.38353332.00706369.6578636c.6173732c.30363034.30300070.63696578.636c6173.732c3036.303400
                reg:  00034000.00000000.00000000.00000000.00000000
                physical-slot#:  000000e0
                #address-cells:  00000003
                #size-cells:  00000002
                device_type: 'pciex'
                name: 'pci'
                interrupts:  00000001
                cache-line-size:  00000010
                class-code:  00060400
                revision-id:  000000ba
                device-id:  00008532
                vendor-id:  000010b5

            Node 0xf00d7994
                .node:  f00d7994
                ranges:  82000000.00000000.04000000.82000000.00000000.04000000.00000000.00600000
                bus-range:  00000008.0000000a
                compatible:  70636965.78313062.352c3835.33322e62.61007063.69657831.3062352c.38353332.00706369.6578636c.6173732c.30363034.30300070.63696578.636c6173.732c3036.303400
                reg:  00034800.00000000.00000000.00000000.00000000
                #address-cells:  00000003
                #size-cells:  00000002
                device_type: 'pciex'
                name: 'pci'
                interrupts:  00000001
                cache-line-size:  00000010
                class-code:  00060400
                revision-id:  000000ba
                device-id:  00008532
                vendor-id:  000010b5

                Node 0xf00d9d58
                    .node:  f00d9d58
                    available:  82000000.00000000.04000000.00000000.00010000.82000000.00000000.04040000.00000000.001c0000
                    ranges:  82000000.00000000.04000000.82000000.00000000.04000000.00000000.00600000
                    bus-range:  00000009.0000000a
                    compatible:  70636965.78313136.362c3130.332e6235.00706369.65783131.36362c31.30330070.63696578.636c6173.732c3036.30343030.00706369.6578636c.6173732c.30363034.00
                    reg:  00080000.00000000.00000000.00000000.00000000
                    #address-cells:  00000003
                    #size-cells:  00000002
                    device_type: 'pciex'
                    name: 'pci'
                    cache-line-size:  00000010
                    class-code:  00060400
                    revision-id:  000000b5
                    device-id:  00000103
                    vendor-id:  00001166

                    Node 0xf00dc0f4
                        .node:  f00dc0f4
                        local-mac-address:  00144f72.0e2e
                        assigned-addresses:  82092010.00000000.04200000.00000000.00200000.82092018.00000000.04010000.00000000.00010000.82092030.00000000.04020000.00000000.00010000
                        compatible:  70636931.3465342c.31363638.2e313038.652e3136.36382e61.33007063.69313465.342c3136.36382e31.3038652e.31363638.00706369.31303865.2c313636.38007063.69313465.342c3136.36382e61.33007063.69313465.342c3136.36380070.6369636c.6173732c.30323030.30300070.6369636c.6173732c.30323030.00
                        reg:  00092000.00000000.00000000.00000000.00000000.03092010.00000000.00000000.00000000.00200000.03092018.00000000.00000000.00000000.00010000
                        max-frame-size:  00010000
                        address-bits:  00000030
                        network-interface-type: 'ethernet'
                        device_type: 'network'
                        name: 'network'
                        66mhz-capable:  
                        fast-back-to-back:  
                        devsel-speed:  00000001
                        latency-timer:  00000040
                        max-latency:  00000000
                        min-grant:  00000040
                        interrupts:  00000001
                        cache-line-size:  00000010
                        class-code:  00020000
                        subsystem-id:  00001668
                        subsystem-vendor-id:  0000108e
                        revision-id:  000000a3
                        device-id:  00001668
                        vendor-id:  000014e4

                    Node 0xf00e2f6c
                        .node:  f00e2f6c
                        local-mac-address:  00144f72.0e2f
                        assigned-addresses:  82092110.00000000.04400000.00000000.00200000.82092118.00000000.04030000.00000000.00010000
                        compatible:  70636931.3465342c.31363638.2e313038.652e3136.36382e61.33007063.69313465.342c3136.36382e31.3038652e.31363638.00706369.31303865.2c313636.38007063.69313465.342c3136.36382e61.33007063.69313465.342c3136.36380070.6369636c.6173732c.30323030.30300070.6369636c.6173732c.30323030.00
                        reg:  00092100.00000000.00000000.00000000.00000000.03092110.00000000.00000000.00000000.00200000.03092118.00000000.00000000.00000000.00010000
                        max-frame-size:  00010000
                        address-bits:  00000030
                        network-interface-type: 'ethernet'
                        device_type: 'network'
                        name: 'network'
                        66mhz-capable:  
                        fast-back-to-back:  
                        devsel-speed:  00000001
                        latency-timer:  00000040
                        max-latency:  00000000
                        min-grant:  00000040
                        interrupts:  00000002
                        cache-line-size:  00000010
                        class-code:  00020000
                        subsystem-id:  00001668
                        subsystem-vendor-id:  0000108e
                        revision-id:  000000a3
                        device-id:  00001668
                        vendor-id:  000014e4

                    Node 0xf00e9dd0
                        .node:  f00e9dd0
                        ranges:  82000000.00000000.fff00000.82000000.00000000.fff00000.ffffffff.00200000
                        bus-range:  0000000a.0000000a
                        compatible:  70636931.3136362c.3130342e.62340070.63693131.36362c31.30340070.6369636c.6173732c.30363034.30300070.6369636c.6173732c.30363034.00
                        reg:  00094000.00000000.00000000.00000000.00000000
                        #address-cells:  00000003
                        #size-cells:  00000002
                        device_type: 'pci'
                        name: 'pci'
                        66mhz-capable:  
                        devsel-speed:  00000001
                        latency-timer:  00000040
                        cache-line-size:  00000010
                        class-code:  00060400
                        revision-id:  000000b4
                        device-id:  00000104
                        vendor-id:  00001166

            Node 0xf00ec3f0
                .node:  f00ec3f0
                ranges:  81000000.00000000.00002000.81000000.00000000.00002000.00000000.00001000.82000000.00000000.04600000.82000000.00000000.04600000.00000000.00a00000
                bus-range:  0000000b.0000000d
                compatible:  70636965.78313062.352c3835.33322e62.61007063.69657831.3062352c.38353332.00706369.6578636c.6173732c.30363034.30300070.63696578.636c6173.732c3036.303400
                reg:  00035000.00000000.00000000.00000000.00000000
                #address-cells:  00000003
                #size-cells:  00000002
                device_type: 'pciex'
                name: 'pci'
                interrupts:  00000001
                cache-line-size:  00000010
                class-code:  00060400
                revision-id:  000000ba
                device-id:  00008532
                vendor-id:  000010b5

                Node 0xf00ee7b4
                    .node:  f00ee7b4
                    available:  82000000.00000000.04600000.00000000.00010000.82000000.00000000.04640000.00000000.001c0000
                    ranges:  81000000.00000000.00002000.81000000.00000000.00002000.00000000.00001000.82000000.00000000.04600000.82000000.00000000.04600000.00000000.00a00000
                    bus-range:  0000000c.0000000d
                    compatible:  70636965.78313136.362c3130.332e6235.00706369.65783131.36362c31.30330070.63696578.636c6173.732c3036.30343030.00706369.6578636c.6173732c.30363034.00
                    reg:  000b0000.00000000.00000000.00000000.00000000
                    #address-cells:  00000003
                    #size-cells:  00000002
                    device_type: 'pciex'
                    name: 'pci'
                    cache-line-size:  00000010
                    class-code:  00060400
                    revision-id:  000000b5
                    device-id:  00000103
                    vendor-id:  00001166

                    Node 0xf00f0b50
                        .node:  f00f0b50
                        local-mac-address:  00144f72.0e30
                        assigned-addresses:  820c2010.00000000.04800000.00000000.00200000.820c2018.00000000.04610000.00000000.00010000.820c2030.00000000.04620000.00000000.00010000
                        compatible:  70636931.3465342c.31363638.2e313038.652e3136.36382e61.33007063.69313465.342c3136.36382e31.3038652e.31363638.00706369.31303865.2c313636.38007063.69313465.342c3136.36382e61.33007063.69313465.342c3136.36380070.6369636c.6173732c.30323030.30300070.6369636c.6173732c.30323030.00
                        reg:  000c2000.00000000.00000000.00000000.00000000.030c2010.00000000.00000000.00000000.00200000.030c2018.00000000.00000000.00000000.00010000
                        max-frame-size:  00010000
                        address-bits:  00000030
                        network-interface-type: 'ethernet'
                        device_type: 'network'
                        name: 'network'
                        66mhz-capable:  
                        fast-back-to-back:  
                        devsel-speed:  00000001
                        latency-timer:  00000040
                        max-latency:  00000000
                        min-grant:  00000040
                        interrupts:  00000001
                        cache-line-size:  00000010
                        class-code:  00020000
                        subsystem-id:  00001668
                        subsystem-vendor-id:  0000108e
                        revision-id:  000000a3
                        device-id:  00001668
                        vendor-id:  000014e4

                    Node 0xf00f79c8
                        .node:  f00f79c8
                        local-mac-address:  00144f72.0e31
                        assigned-addresses:  820c2110.00000000.04a00000.00000000.00200000.820c2118.00000000.04630000.00000000.00010000
                        compatible:  70636931.3465342c.31363638.2e313038.652e3136.36382e61.33007063.69313465.342c3136.36382e31.3038652e.31363638.00706369.31303865.2c313636.38007063.69313465.342c3136.36382e61.33007063.69313465.342c3136.36380070.6369636c.6173732c.30323030.30300070.6369636c.6173732c.30323030.00
                        reg:  000c2100.00000000.00000000.00000000.00000000.030c2110.00000000.00000000.00000000.00200000.030c2118.00000000.00000000.00000000.00010000
                        max-frame-size:  00010000
                        address-bits:  00000030
                        network-interface-type: 'ethernet'
                        device_type: 'network'
                        name: 'network'
                        66mhz-capable:  
                        fast-back-to-back:  
                        devsel-speed:  00000001
                        latency-timer:  00000040
                        max-latency:  00000000
                        min-grant:  00000040
                        interrupts:  00000002
                        cache-line-size:  00000010
                        class-code:  00020000
                        subsystem-id:  00001668
                        subsystem-vendor-id:  0000108e
                        revision-id:  000000a3
                        device-id:  00001668
                        vendor-id:  000014e4

                    Node 0xf00fe82c
                        .node:  f00fe82c
                        interrupt-map:  00000000.00000000.00000000.00000001.f006872c.0000000f.00000000.00000000.00000000.00000002.f006872c.00000010.00000000.00000000.00000000.00000003.f006872c.00000011.00000000.00000000.00000000.00000004.f006872c.00000012
                        interrupt-map-mask:  00000000.00000000.00000000.00000007
                        #interrupt-cells:  00000001
                        available:  81000000.00000000.00002100.00000000.00000f00.82000000.00000000.04c20000.00000000.001e0000
                        ranges:  81000000.00000000.00002000.81000000.00000000.00002000.00000000.00001000.82000000.00000000.04c00000.82000000.00000000.04c00000.00000000.00400000
                        bus-range:  0000000d.0000000d
                        compatible:  70636931.3136362c.3130342e.62340070.63693131.36362c31.30340070.6369636c.6173732c.30363034.30300070.6369636c.6173732c.30363034.00
                        reg:  000c4000.00000000.00000000.00000000.00000000
                        #address-cells:  00000003
                        #size-cells:  00000002
                        device_type: 'pci'
                        name: 'pci'
                        66mhz-capable:  
                        devsel-speed:  00000001
                        latency-timer:  00000040
                        cache-line-size:  00000010
                        class-code:  00060400
                        revision-id:  000000b4
                        device-id:  00000104
                        vendor-id:  00001166

                        Node 0xf0100c30
                            .node:  f0100c30
                            firmware-version: '1.08.04.00'
                            mpt-version: '1.05'
                            assigned-addresses:  810d0810.00000000.00002000.00000000.00000100.820d0814.00000000.04c00000.00000000.00010000.820d081c.00000000.04c10000.00000000.00010000.820d0830.00000000.04e00000.00000000.00200000
                            compatible:  70636931.3030302c.35302e31.3030302e.33303230.2e320070.63693130.30302c35.302e3130.30302e33.30323000.70636931.3030302c.33303230.00706369.31303030.2c35302e.32007063.69313030.302c3530.00706369.636c6173.732c3031.30303030.00706369.636c6173.732c3031.30300070.63693130.30302c35.3600
                            model: 'LSI,1064'
                            reg:  000d0800.00000000.00000000.00000000.00000000.010d0810.00000000.00000000.00000000.00000100.030d0814.00000000.00000000.00000000.00010000.030d081c.00000000.00000000.00000000.00010000.020d0830.00000000.00000000.00000000.00200000
                            version: '1.00.41'
                            wide:  00000010
                            device_type: 'scsi-2'
                            name: 'scsi'
                            local-wwid:  50800200.00002999
                            devsel-speed:  00000001
                            latency-timer:  000000f8
                            max-latency:  0000000a
                            min-grant:  00000040
                            interrupts:  00000001
                            cache-line-size:  00000080
                            class-code:  00010000
                            subsystem-id:  00003020
                            subsystem-vendor-id:  00001000
                            revision-id:  00000002
                            device-id:  00000050
                            vendor-id:  00001000

                            Node 0xf010d3e8
                                .node:  f010d3e8
                                device_type: 'byte'
                                compatible: 'st'
                                name: 'tape'

                            Node 0xf010e128
                                .node:  f010e128
                                lba64:  
                                device_type: 'block'
                                compatible: 'sd'
                                name: 'disk'

    Node 0xf0071e78
        .node:  f0071e78
        interrupt-map:  00000000.00000000.00000000.00000001.f0071e78.00000014.00000000.00000000.00000000.00000002.f0071e78.00000015.00000000.00000000.00000000.00000003.f0071e78.00000016.00000000.00000000.00000000.00000004.f0071e78.00000017
        interrupt-map-mask:  00000000.00000000.00000000.00000007
        #interrupt-cells:  00000001
        available:  81000000.00000000.00001000.00000000.0ffff000.82000000.00000000.00200000.00000000.7fdf0000.c3000000.00000001.00000000.00000000.ffff0000
        reg:  00000400.0ff00000.00000000.000f0000.00000400.0fc10000.00000000.00064000
        ranges:  00000000.00000000.00000000.000007f6.00000000.00000000.10000000.01000000.00000000.00000000.000007f6.10000000.00000000.10000000.02000000.00000000.00000000.000007f7.00000000.00000000.7fff0000.03000000.00000000.00000000.000007f4.00000000.00000001.ffff0000
        msi-address-ranges:  00000000.7fff0000.00010000.00000003.ffff0000.00010000
        msi-eq-devino:  00000000.00000024.00000018
        #msi-eqs:  00000024
        msix-data-width:  00000020
        msi-eq-size:  00000080
        msi-ranges:  00000000.00000100
        msi-data-mask:  000000ff
        #msi:  00000100
        bus-range:  00000002.00000004
        bus-parity-generated:  
        compatible: 'pciex108e,80f0'
        name: 'pci'
        device_type: 'pciex'
        #address-cells:  00000003
        #size-cells:  00000002
        module-manufacturer#:  00000036
        fire-revision#:  00000003
        module-revision#:  00000003
        portid:  0000001f
        ino-bitmap:  fff3c77d.ffffffff
        interrupts:  0000003f.0000003e

        Node 0xf009ca88
            .node:  f009ca88
            slot-names:  00000004.5043492d.58203300
            interrupt-map:  00000000.00000000.00000000.00000001.f0071e78.0000000e.00000000.00000000.00000000.00000002.f0071e78.0000000f.00000000.00000000.00000000.00000003.f0071e78.00000010.00000000.00000000.00000000.00000004.f0071e78.00000011
            interrupt-map-mask:  00000000.00000000.00000000.00000007
            #interrupt-cells:  00000001
            available:  81000000.00000000.00000100.00000000.00000f00.82000000.00000000.00102000.00000000.0001e000.82000000.00000000.00140000.00000000.000c0000
            ranges:  81000000.00000000.00000000.81000000.00000000.00000000.00000000.00001000.82000000.00000000.00100000.82000000.00000000.00100000.00000000.00100000
            bus-range:  00000003.00000003
            compatible:  70636965.78383038.362c3334.302e3900.70636965.78383038.362c3334.30007063.69657863.6c617373.2c303630.34303000.70636965.78636c61.73732c30.36303400
            reg:  00020000.00000000.00000000.00000000.00000000
            #address-cells:  00000003
            #size-cells:  00000002
            device_type: 'pciex'
            name: 'pci'
            cache-line-size:  00000010
            class-code:  00060400
            revision-id:  00000009
            device-id:  00000340
            vendor-id:  00008086

            Node 0xf009ee24
                .node:  f009ee24
                assigned-addresses:  81031010.00000000.00000000.00000000.00000100.82031014.00000000.00100000.00000000.00002000.82031030.00000000.00120000.00000000.00020000
                name: 'QLGC,qlc'
                model: 'QLA2340'
                port-wwn:  210000e0.8b90d24a
                node-wwn:  200000e0.8b90d24a
                reg:  00031000.00000000.00000000.00000000.00000000.01031010.00000000.00000000.00000000.00000100.03031014.00000000.00000000.00000000.00001000
                compatible:  70636931.3037372c.32333132.2e653131.2e313030.2e320070.63693130.37372c32.3331322e.6531312e.31303000.70636965.31312c31.30300070.63693130.37372c32.3331322e.32007063.69313037.372c3233.31320070.6369636c.6173732c.63303430.3000
                manufacturer: 'QLGC'
                #size-cells:  00000000
                #address-cells:  00000002
                device_type: 'scsi-fcp'
                version: 'ISP2312 Host Adapter fcode version 1.17 08/09/07'
                fcode-rom-offset:  00000000
                66mhz-capable:  
                devsel-speed:  00000001
                latency-timer:  00000040
                max-latency:  00000000
                min-grant:  00000040
                interrupts:  00000001
                cache-line-size:  00000010
                class-code:  000c0400
                subsystem-id:  00000100
                subsystem-vendor-id:  00000e11
                revision-id:  00000002
                device-id:  00002312
                vendor-id:  00001077

                Node 0xf00a996c
                    .node:  f00a996c
                    #size-cells:  00000000
                    #address-cells:  00000004
                    reg:  00000000.00000000
                    device_type: 'fp'
                    name: 'fp'

                    Node 0xf00aa068
                        .node:  f00aa068
                        device_type: 'block'
                        compatible: 'ssd'
                        name: 'disk'

        Node 0xf00aaf68
            .node:  f00aaf68
            slot-names:  00000002.5043492d.58203100
            interrupt-map:  00000000.00000000.00000000.00000001.f006872c.0000000b.00000000.00000000.00000000.00000002.f006872c.0000000c.00000000.00000000.00000000.00000003.f006872c.0000000d.00000000.00000000.00000000.00000004.f006872c.0000000e
            interrupt-map-mask:  00000000.00000000.00000000.00000007
            #interrupt-cells:  00000001
            ranges:  82000000.00000000.fff00000.82000000.00000000.fff00000.ffffffff.00200000
            bus-range:  00000004.00000004
            compatible:  70636965.78383038.362c3334.312e3900.70636965.78383038.362c3334.31007063.69657863.6c617373.2c303630.34303000.70636965.78636c61.73732c30.36303400
            reg:  00020200.00000000.00000000.00000000.00000000
            #address-cells:  00000003
            #size-cells:  00000002
            device_type: 'pciex'
            name: 'pci'
            cache-line-size:  00000010
            class-code:  00060400
            revision-id:  00000009
            device-id:  00000341
            vendor-id:  00008086

    Node 0xf0091c20
        .node:  f0091c20
        interrupt-map:  00000002.00000080.00000001.f0071e78.00000008.00000002.00000040.00000001.f0071e78.00000009.00000002.00000000.00000001.f0071e78.0000000a.00000003.00000000.00000001.f0071e78.00000000.00000003.00000040.00000001.f0071e78.00000003
        interrupt-map-mask:  00000003.000fffff.00000003
        #interrupt-cells:  00000001
        ranges:  00000000.00000000.000007ff.f0000000.01000000.00000001.00000000.000007ff.f1000000.01000000.00000002.00000000.000007ff.f2000000.01000000.00000003.00000000.000007ff.f3000000.01000000
        revision:  00000000
        #size-cells:  00000001
        #address-cells:  00000002
        reg:  00000400.0fc64000.00000000.00000020
        portid:  0000001f
        device_type: 'ebus'
        compatible: 'jbus-ebus'
        name: 'ebus'

        Node 0xf00927d0
            .node:  f00927d0
            model: 'SUNW,525-2320'
            version:  4f425020.342e3330.2e342032.3030392f.30382f31.39203037.3a313820.53756e20.46697265.20563231.352f5632.34350050.4f535420.342e3330.2e342032.3030392f.30382f31.39203037.3a333500.4f424449.41472034.2e33302e.34203230.30392f30.382f3139.2030373a.32392020.00
            name: 'flashprom'
            reg:  00000000.00000000.00200000

        Node 0xf00934ec
            .node:  f00934ec
            ignore-cd:  
            reg:  00000002.00000080.00000008
            interrupts:  00000001
            compatible:  73753136.35353200.73753136.35353000.737500
            device_type: 'serial'
            name: 'serial'

        Node 0xf009504c
            .node:  f009504c
            ignore-cd:  
            reg:  00000002.00000040.00000008
            interrupts:  00000001
            compatible:  73753136.35353200.73753136.35353000.737500
            device_type: 'serial'
            name: 'serial'

        Node 0xf0096bac
            .node:  f0096bac
            reg:  00000002.00000000.00000008
            interrupts:  00000001
            compatible: 'rmc_comm'
            device_type: 'serial'
            name: 'rmc-comm'

        Node 0xf009871c
            .node:  f009871c
            reg:  00000002.000000c0.00000001
            compatible: 'pmugpio'
            gpio-device-type: 'SUNW,cpld'
            name: 'gpio'

        Node 0xf009880c
            .node:  f009880c
            version: '5.10'
            reg:  00000003.00000000.00000081
            compatible: 'epic'
            name: 'env-monitor'

        Node 0xf0098b3c
            .node:  f0098b3c
            interrupts:  00000001
            button:  
            reg:  00000003.00000040.00000082
            power-device-type: 'SUNW,pic18lf65j10'
            name: 'power'

    Node 0xf0098ea0
        .node:  f0098ea0
        interrupt-map:  00000000.000000d0.00000001.f0071e78.00000006
        interrupt-map-mask:  000000ff.000000ff.00000003
        #interrupt-cells:  00000001
        reg:  00000400.0fd30000.00000000.00000040
        i2c-clock-val:  0000000f
        portid:  0000001f
        interrupts:  00000001
        device_type: 'i2c'
        compatible: 'fire-i2c'
        #size-cells:  00000000
        #address-cells:  00000002
        name: 'i2c'

        Node 0xf009a59c
            .node:  f009a59c
            reg:  00000000.00000032
            compatible: 'i2c-at24c64'
            device_type: 'fru-prom'
            name: 'pdb-fru-prom'

        Node 0xf009a848
            .node:  f009a848
            reg:  00000000.00000064
            compatible: 'i2c-at24c64'
            device_type: 'fru-prom'
            name: 'sasbp-fru-prom'

        Node 0xf009aaf4
            .node:  f009aaf4
            name: 'power-supply-fru-prom'
            reg:  00000000.0000006c
            compatible: 'i2c-at34c02'

        Node 0xf009ace4
            .node:  f009ace4
            reg:  00000000.0000007c
            compatible: 'i2c-pcf8574'
            name: 'ioexp'

        Node 0xf009ae98
            .node:  f009ae98
            reg:  00000000.00000080
            compatible: 'i2c-pca9555'
            name: 'gpio'

        Node 0xf009af58
            .node:  f009af58
            reg:  00000000.000000a2
            compatible: 'i2c-at24c64'
            device_type: 'fru-prom'
            name: 'motherboard-fru-prom'

        Node 0xf009b210
            .node:  f009b210
            reg:  00000000.000000a6
            compatible: 'i2c-at24c64'
            device_type: 'nvram'
            name: 'nvram'

        Node 0xf009b5f4
            .node:  f009b5f4
            device_type: 'idprom'
            reg:  00000000.000000a6
            name: 'idprom'

        Node 0xf009bb98
            .node:  f009bb98
            reg:  00000000.000000a8
            compatible: 'i2c-at24c64'
            device_type: 'fru-prom'
            name: 'riser-fru-prom'

        Node 0xf009be44
            .node:  f009be44
            reg:  00000000.000000aa
            compatible: 'i2c-at24c64'
            device_type: 'fru-prom'
            name: 'riser-fru-prom'

        Node 0xf009c0f0
            .node:  f009c0f0
            reg:  00000000.000000b0
            compatible: 'i2c-adt7462'
            name: 'hardware-monitor'

        Node 0xf009c1bc
            .node:  f009c1bc
            reg:  00000000.000000d0
            compatible: 'i2c-ds1307'
            name: 'rscrtc'

        Node 0xf009c27c
            .node:  f009c27c
            reg:  00000000.000000dc
            compatible: 'i2c-ics9fg108'
            name: 'clock-generator'

        Node 0xf009c34c
            .node:  f009c34c
            reg:  00000000.000000e0
            compatible: 'i2c-at34c02'
            name: 'dimm-spd'

        Node 0xf009c50c
            .node:  f009c50c
            reg:  00000000.000000e2
            compatible: 'i2c-at34c02'
            name: 'dimm-spd'


-- 
Meelis Roos (mroos@linux.ee)
