From: Jim Faulkner <jfaulkne@ccs.neu.edu>
Date: Wed, 31 Aug 2011 00:47:16 +0000
Subject: Re: bug report: Sun Blade 100 kernel panics during boot under 3.0.3
Message-Id: <20110831004715.GA30110@alumni-linux.ccs.neu.edu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
List-Id: <sparclinux.vger.kernel.org>
References: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
In-Reply-To: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
To: sparclinux@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Aug 30, 2011 at 07:26:24PM -0400, David Miller wrote:
> 
> Can you give us "/usr/sbin/prtconf -pv" output from a working boot
> so we can add it to our collection?  Thanks.
> 
> Try turning on the ofpci_verbose tracing facility by passing
> 'ofpci_debug=1' on the kernel command line.
> 

OK, I've attached the output of prtconf -pv.  AFAIK the only things in
the box that didn't ship from the factory are a tulip ethernet card and
the hard drives.  I don't have a reason to believe that they are causing
the problem.

I won't have the time to sit down in front of this box for a few days,
but I'll try the tracing facility the next time I do.


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="prtconf-pv.txt"
Content-Transfer-Encoding: quoted-printable

System Configuration:  Sun Microsystems  sun4u
Memory size: 896 Megabytes
System Peripherals (PROM Nodes):

Node 0xf0029598
    .node:  f0029598
    banner-name: 'Sun Blade 100 (UltraSPARC-IIe)'
    clock-frequency:  04fca6ea
    energystar-v3: =20
    idprom:  01830003.ba084e64.000003ba.084e6482.00000000.00000000.00000000=
=2E00000000
    scsi-initiator-id:  00000007
    reset-reason: 'POR'
    breakpoint-trap:  0000007f
    #size-cells:  00000002
    model: 'SUNW,375-0096'
    name: 'SUNW,Sun-Blade-100'
    device_type: 'upa'
    stick-frequency:  0054c563

    Node 0xf002c72c
        .node:  f002c72c
        name: 'packages'

        Node 0xf0046d78
            .node:  f0046d78
            name: 'SUNW,builtin-drivers'

        Node 0xf0050f8c
            .node:  f0050f8c
            disk-write-fix: =20
            name: 'deblocker'

        Node 0xf0051470
            .node:  f0051470
            name: 'disk-label'

        Node 0xf0051dc4
            .node:  f0051dc4
            iso6429-1983-colors: =20
            name: 'terminal-emulator'

        Node 0xf005990c
            .node:  f005990c
            source: '/flashprom@0,0:'
            name: 'dropins'

        Node 0xf00653c0
            .node:  f00653c0
            name: 'obp-tftp'

        Node 0xf006a8c4
            .node:  f006a8c4
            name: 'kbd-translator'

    Node 0xf002c7a4
        .node:  f002c7a4
        bootargs:  00
        bootpath: '/pci@1f,0/ide@d/cdrom@1,0:f'
        mmu:  fff73328
        memory:  fff73538
        stdout:  fff49748
        stdin:  fff319b8
        stdout-#lines:  00000022
        name: 'chosen'

    Node 0xf002c818
        .node:  f002c818
        version: 'OBP 4.13.4 2004/05/19 18:35'
        model: 'SUNW,4.13.4'
        aligned-allocator: =20
        relative-addressing: =20
        name: 'openprom'

        Node 0xf002c8a8
            .node:  f002c8a8
            name: 'client-services'

    Node 0xf002c960
        .node:  f002c960
        test-args: =20
        diag-passes: '1'
        pci-probe-list: '7,c,3,8,d,13,5'
        local-mac-address?: 'false'
        fcode-debug?: 'false'
        silent-mode?: 'false'
        scsi-initiator-id: '7'
        oem-logo: =20
        oem-logo?: 'false'
        oem-banner: =20
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
        load-base: '16384'
        auto-boot?: 'true'
        boot-command: 'boot'
        diag-file: =20
        diag-device: 'disk net'
        boot-file: =20
        boot-device: 'disk2'
        use-nvramrc?: 'true'
        nvramrc:  3a206865.6c6c6f20.28202e2e.20290a2e.22204865.6c6c6f2c.207=
76f72.6c642e20.22206372.0a3b0a0a.2e224865.6c6c6f20.776f726c.642e2220.63720a=
3b.0a0a0a0a.52415354.4552434f.4e534f4c.455f4247.434f4c3d.5753434f.4c5f424c.=
41434b0a
        security-mode: 'none'
        security-password: =20
        security-#badlogins: '0'
        diag-script: 'none'
        diag-level: 'max'
        diag-switch?: 'false'
        error-reset-recovery: 'boot'
        name: 'options'

    Node 0xf002c9d8
        .node:  f002c9d8
        screen: '/pci@1f,0/SUNW,m64B@13'
        mouse: '/pci@1f,0/usb@c,3/hub@4/mouse@4'
        keyboard: '/pci@1f,0/usb@c,3/keyboard@3'
        net: '/pci@1f,0/network@c,1'
        cdrom2: '/pci@1f,0/ide@d/cdrom@2,0:f'
        cdrom1: '/pci@1f,0/ide@d/cdrom@1,0:f'
        cdrom: '/pci@1f,0/ide@d/cdrom@1,0:f'
        disk: '/pci@1f,0/ide@d/disk@0,0'
        disk3: '/pci@1f,0/ide@d/disk@3,0'
        disk2: '/pci@1f,0/ide@d/disk@2,0'
        disk1: '/pci@1f,0/ide@d/disk@1,0'
        disk0: '/pci@1f,0/ide@d/disk@0,0'
        ide: '/pci@1f,0/ide@d'
        floppy: '/pci@1f,0/isa@7/dma/floppy'
        ttyb: '/pci@1f,0/isa@7/serial@0,2e8'
        ttya: '/pci@1f,0/isa@7/serial@0,3f8'
        name: 'aliases'

    Node 0xf003d3d4
        .node:  f003d3d4
        reg:  00000000.00000000.00000000.08000000.00000000.20000000.0000000=
0.10000000.00000000.40000000.00000000.10000000.00000000.60000000.00000000.1=
0000000
        available:  00000000.6fdd6000.00000000.00010000.00000000.6f000000.0=
0000000.00dd2000.00000000.60000000.00000000.0effe000.00000000.40000000.0000=
0000.10000000.00000000.20000000.00000000.10000000.00000000.00000000.0000000=
0.08000000
        name: 'memory'

    Node 0xf003da4c
        .node:  f003da4c
        translations:  00000000.00002000.00000000.003fe000.80000000.0000203=
6.00000000.00400000.00000000.00800000.80000000.6f000036.00000000.40000000.0=
0000000.00800000.80000000.6f000036.00000000.f0000000.00000000.00080000.8000=
0000.6ff800b6.00000000.f0080000.00000000.00010000.80000000.6ff200b6.0000000=
0.f0090000.00000000.00010000.80000000.6fdf00b6.00000000.f00a0000.00000000.0=
0010000.80000000.6ff100b6.00000000.f00b0000.00000000.00010000.80000000.6ff0=
00b6.00000000.fde00000.00000000.01000000.800001ff.0300008e.00000000.fee0000=
0.00000000.00100000.800001ff.f000008e.00000000.fef00000.00000000.00100000.8=
0000000.6fe000b6.00000000.fff00000.00000000.00004000.80000000.6ff4c0b6.0000=
0000.fff04000.00000000.00010000.800001fe.0000008e.00000000.fff18000.0000000=
0.00002000.80000000.6ff560b6.00000000.fff28000.00000000.00006000.80000000.6=
fdea0b6.00000000.fff2e000.00000000.00002000.80000000.6ff380b6.00000000.fff3=
0000.00000000.00004000.80000000.6ff300b6.00000000.fff34000.00000000.0000400=
0.80000000.6ff3a0b6.00000000.fff38000.00000000.00002000.800001ff.0200008e.0=
0000000.fff3c000.00000000.00004000.80000000.6ff340b6.00000000.fff40000.0000=
0000.00002000.800001fe.0200008e.00000000.fff42000.00000000.00002000.800001f=
e.0100008e.00000000.fff44000.00000000.00002000.80000000.6ff420b6.00000000.f=
ff46000.00000000.00002000.800001ff.0042208e.00000000.fff48000.00000000.0000=
2000.80000000.6ff460b6.00000000.fff4a000.00000000.00002000.800001fe.0100008=
e.00000000.fff4c000.00000000.00002000.80000000.6ff440b6.00000000.fff4e000.0=
0000000.00002000.800001fe.0200008e.00000000.fff50000.00000000.00002000.8000=
01ff.f100008e.00000000.fff52000.00000000.00004000.80000000.6ff480b6.0000000=
0.fff56000.00000000.00004000.80000000.6ff500b6.00000000.fff5a000.00000000.0=
0002000.80000000.6effe0b6.00000000.fff60000.00000000.00010000.80000000.6ff5=
80b6.00000000.fff70000.00000000.00010000.80000000.6ff700b6
        existing:  00000000.00000000.00000800.00000000.fffff800.00000000.00=
000800.00000000
        available:  fffff800.00000000.000007fc.00000000.00000001.00000000.0=
00007ff.00000000.00000000.ffff0000.00000000.0000e000.00000000.00000000.0000=
0000.f0000000.00000000.fff3a000.00000000.00002000.00000000.fff1a000.0000000=
0.0000e000.00000000.fff14000.00000000.00004000.00000000.f0800000.00000000.0=
d600000
        page-size:  00002000
        name: 'virtual-memory'

    Node 0xf005c528
        .node:  f005c528
        available:  81000000.00000000.00000a30.00000000.000000d0.81000000.0=
0000000.00000c00.00000000.00000400.81000000.00000000.00002000.00000000.0000=
e000.82000000.00000000.00428000.00000000.00018000.82000000.00000000.0046000=
0.00000000.003a0000.82000000.00000000.01400000.00000000.00c00000.82000000.0=
0000000.04100000.00000000.5bf00000.82000000.00000000.80000000.00000000.4000=
0000.82000000.00000000.e0000000.00000000.10000000
        bus-range:  00000000.00000001
        interrupt-map:  00000800.00000000.00000000.00000002.f005c528.000000=
06.00000800.00000000.00000000.00000003.f005c528.0000001c.00000800.00000000.=
00000000.00000004.f005c528.00000024.00001000.00000000.00000000.00000001.f00=
5c528.0000000f.00001800.00000000.00000000.00000001.f005c528.0000001e.000040=
00.00000000.00000000.00000001.f005c528.00000023.00006000.00000000.00000000.=
00000002.f005c528.00000006.00006000.00000000.00000000.00000003.f005c528.000=
0001c.00006000.00000000.00000000.00000004.f005c528.00000024.00006800.000000=
00.00000000.00000001.f005c528.0000000c.00003800.00000000.00000000.00000001.=
f005c528.0000002a.00003800.00000000.00000000.00000002.f005c528.00000027.000=
03800.00000000.00000000.00000003.f005c528.00000021.00003800.00000000.000000=
00.00000004.f005c528.0000002b.00003800.00000000.00000000.00000005.f005c528.=
00000020.00009800.00000000.00000000.00000001.f005c528.0000000f
        interrupt-map-mask:  00fff800.00000000.00000000.00000007
        #interrupt-cells:  00000001
        virtual-dma:  c0000000.20000000
        reg:  000001fe.00000000.00000000.00010000.000001fe.01000000.0000000=
0.00000100
        ranges:  00000000.00000000.00000000.000001fe.01000000.00000000.0100=
0000.01000000.00000000.00000000.000001fe.02000000.00000000.01000000.0200000=
0.00000000.00000000.000001ff.00000000.00000001.00000000.03000000.00000000.0=
0000000.000001ff.00000000.00000001.00000000
        #virtual-dma-size-cells:  00000001
        #virtual-dma-addr-cells:  00000001
        clock-frequency:  01f78a40
        latency-timer: =20
        button-interrupt: =20
        no-streaming-cache: =20
        interrupts:  00000030.0000002e.0000002f.00000025
        upa-portid:  0000001f
        bus-parity-generated: =20
        compatible: 'pci108e,a001'
        name: 'pci'
        device_type: 'pci'
        #address-cells:  00000003
        #size-cells:  00000002

        Node 0xf006b6b4
            .node:  f006b6b4
            interrupt-map-mask:  0000001f.00ffffff.00000003
            #interrupt-cells:  00000001
            ranges:  00000000.00000000.82006010.00000000.f0000000.01000000.=
00000001.00000000.82006014.00000000.f1000000.00800000
            reg:  00006000.00000000.00000000.00000000.00000000.82006010.000=
00000.f0000000.00000000.01000000.82006014.00000000.f1000000.00000000.008000=
00
            #size-cells:  00000001
            #address-cells:  00000002
            name: 'ebus'
            max-latency:  00000019
            min-grant:  0000000a
            class-code:  00068000
            revision-id:  00000001
            devsel-speed:  00000001
            fast-back-to-back: =20
            device-id:  00001100
            vendor-id:  0000108e

            Node 0xf006c758
                .node:  f006c758
                model: 'SUNW,370-4116'
                version:  4f425020.342e3133.2e342032.3030342f.30352f31.3920=
3138.3a333500.504f5354.20322e30.2e312032.3030312f.30382f32.33203137.3a31330=
0.4f424449.41472034.2e31332e.34203230.30342f30.352f3139.2031383a.33392020.00
                name: 'flashprom'
                reg:  00000000.00000000.00100000

            Node 0xf006d3ec
                .node:  f006d3ec
                model: 'mk48t59'
                address:  fff50000
                reg:  00000001.00000000.00002000
                device_type: 'nvram'
                name: 'eeprom'

            Node 0xf006e01c
                .node:  f006e01c
                device_type: 'idprom'
                name: 'idprom'

        Node 0xf006e250
            .node:  f006e250
            assigned-addresses:  81003810.00000000.00000000.00000000.000100=
00.82003814.00000000.00000000.00000000.00100000
            interrupt-map:  00000000.00000000.00000001.f005c528.0000002a.00=
000000.00000800.00000001.f005c528.00000020.00000000.000003f8.00000001.f005c=
528.0000002b.00000000.000002e8.00000001.f005c528.0000002b
            interrupt-map-mask:  00000003.00ffffff.0000000f
            #interrupt-cells:  00000001
            ranges:  00000000.00000000.81003810.00000000.00000000.00010000.=
00000001.00000000.82003814.00000000.00000000.00100000
            reg:  00003800.00000000.00000000.00000000.00000000.81003810.000=
00000.00000000.00000000.00010000.82003814.00000000.00000000.00000000.001000=
00
            #size-cells:  00000001
            #address-cells:  00000002
            name: 'isa'
            devsel-speed:  00000001
            class-code:  00060100
            latency-timer:  00000000
            cache-line-size:  00000000
            max-latency:  00000000
            min-grant:  00000000
            subsystem-id:  00001533
            subsystem-vendor-id:  000010b9
            revision-id:  00000000
            device-id:  00001533
            vendor-id:  000010b9

            Node 0xf006f518
                .node:  f006f518
                interrupts:  00000001
                interrupt-map:  00000000.000003f0.00000001.f005c528.0000002=
7.00000000.00000378.00000001.f005c528.00000021
                interrupt-map-mask:  00000000.00000fff.0000000f
                reg:  00000000.00000000.00010000
                compatible: 'isadma'
                name: 'dma'

                Node 0xf006fda4
                    .node:  f006fda4
                    manual: =20
                    interrupts:  00000001
                    unit:  00000001
                    dma-channel:  00000002
                    reg:  00000000.000003f0.00000008.00000000.00000000.0000=
0500
                    compatible: 'pnpALI,1533,0'
                    name: 'floppy'

                Node 0xf006ff1c
                    .node:  f006ff1c
                    interrupts:  00000001
                    reg:  00000000.00000378.00000008.00000000.00000000.0000=
0500
                    dma-channel:  00000001
                    compatible: 'pnpALI,1533,3'
                    name: 'parallel'

            Node 0xf00700d4
                .node:  f00700d4
                button: =20
                interrupts:  00000001
                reg:  00000000.00000800.00000030
                compatible: 'acpi-power'
                name: 'power'

            Node 0xf007024c
                .node:  f007024c
                ignore-cd: =20
                reg:  00000000.000003f8.00000008
                interrupts:  00000001
                compatible:  73753136.35353000.737500
                device_type: 'serial'
                name: 'serial'

            Node 0xf0071c8c
                .node:  f0071c8c
                ignore-cd: =20
                reg:  00000000.000002e8.00000008
                interrupts:  00000001
                compatible:  73753136.35353000.737500
                device_type: 'serial'
                name: 'serial'

        Node 0xf0073770
            .node:  f0073770
            assigned-addresses:  81001810.00000000.00000000.00000000.000000=
10
            ranges:  00000000.00000000.00001800.00000000.00000000.00000100.=
00000001.00000000.81001810.00000000.00000600.00000100.00000002.00000000.810=
01814.00000000.00000000.00000100
            reg:  00001800.00000000.00000000.00000000.00000000.81001810.000=
00000.00000600.00000000.00000010
            compatible:  70636931.3062392c.37313031.2e300070.63693130.62392=
c37.31303100.70636963.6c617373.2c303030.30303000.70636963.6c617373.2c303030=
=2E3000
            #address-cells:  00000002
            #size-cells:  00000001
            name: 'pmu'
            devsel-speed:  00000001
            class-code:  00000000
            latency-timer:  00000000
            cache-line-size:  00000000
            max-latency:  00000000
            min-grant:  00000000
            revision-id:  00000000
            device-id:  00007101
            vendor-id:  000010b9

            Node 0xf00747d8
                .node:  f00747d8
                reg:  00000000.00000000.00000100.00000001.00000000.00000100
                #address-cells:  00000002
                #size-cells:  00000000
                interrupts:  00000001
                compatible: 'i2c-smbus'
                name: 'i2c'

                Node 0xf0075cb0
                    .node:  f0075cb0
                    reg:  00000000.00000030
                    compatible: 'i2c-max1617'
                    name: 'temperature'

                Node 0xf0075d78
                    .node:  f0075d78
                    reg:  00000000.00000040
                    compatible: 'i2c-scm001'
                    name: 'card-reader'

                Node 0xf0075e40
                    .node:  f0075e40
                    reg:  00000000.000000a0
                    compatible: 'i2c-at34c02'
                    name: 'dimm-spd'

                Node 0xf0076000
                    .node:  f0076000
                    reg:  00000000.000000a2
                    compatible: 'i2c-at34c02'
                    name: 'dimm-spd'

                Node 0xf00761c0
                    .node:  f00761c0
                    reg:  00000000.000000a4
                    compatible: 'i2c-at34c02'
                    name: 'dimm-spd'

                Node 0xf0076380
                    .node:  f0076380
                    reg:  00000000.000000a6
                    compatible: 'i2c-at34c02'
                    name: 'dimm-spd'

            Node 0xf00765b4
                .node:  f00765b4
                reg:  00000000.000000b2.00000001.00000000.000000d3.00000001=
=2E00000002.00000042.00000002.00000002.00000061.00000001
                compatible: 'SUNW,smbus-beep'
                name: 'beep'

            Node 0xf00766e8
                .node:  f00766e8
                register-mask:  00000000.00000001
                reg:  00000000.000000b3.00000001.80000000.000000ba.00000001=
=2E00000000.000000bb.00000001
                compatible: 'SUNW,smbus-ppm'
                name: 'ppm'

            Node 0xf007683c
                .node:  f007683c
                register-mask:  00000000.00000002
                reg:  00000000.000000c8.00000004.80000000.000000ba.00000001
                compatible: 'SUNW,smbus-fan-control'
                name: 'fan-control'

        Node 0xf0076d28
            .node:  f0076d28
            assigned-addresses:  81003810.00000000.00000000.00000000.000100=
00.82003814.00000000.00000000.00000000.00100000
            interrupt-map:  00000000.00000000.00000001.f005c528.0000002a.00=
000000.00000800.00000001.f005c528.00000020.00000000.000003f8.00000001.f005c=
528.0000002b.00000000.000002e8.00000001.f005c528.0000002b
            interrupt-map-mask:  00000003.00ffffff.0000000f
            #interrupt-cells:  00000001
            ranges:  00000000.00000000.81003810.00000000.00000000.00010000.=
00000001.00000000.82003814.00000000.00000000.00100000
            reg:  00003800.00000000.00000000.00000000.00000000.81003810.000=
00000.00000000.00000000.00010000.82003814.00000000.00000000.00000000.001000=
00
            #size-cells:  00000001
            #address-cells:  00000002
            name: 'isa'
            devsel-speed:  00000001
            class-code:  00060100
            latency-timer:  00000000
            cache-line-size:  00000000
            max-latency:  00000000
            min-grant:  00000000
            subsystem-id:  00001533
            subsystem-vendor-id:  000010b9
            revision-id:  00000000
            device-id:  00001533
            vendor-id:  000010b9

            Node 0xf0077ff0
                .node:  f0077ff0
                interrupts:  00000001
                interrupt-map:  00000000.000003f0.00000001.f005c528.0000002=
7.00000000.00000378.00000001.f005c528.00000021
                interrupt-map-mask:  00000000.00000fff.0000000f
                reg:  00000000.00000000.00010000
                compatible: 'isadma'
                name: 'dma'

                Node 0xf007887c
                    .node:  f007887c
                    manual: =20
                    interrupts:  00000001
                    unit:  00000001
                    dma-channel:  00000002
                    reg:  00000000.000003f0.00000008.00000000.00000000.0000=
0500
                    compatible: 'pnpALI,1533,0'
                    name: 'floppy'

                Node 0xf00789f4
                    .node:  f00789f4
                    interrupts:  00000001
                    reg:  00000000.00000378.00000008.00000000.00000000.0000=
0500
                    dma-channel:  00000001
                    compatible: 'pnpALI,1533,3'
                    name: 'parallel'

            Node 0xf0078bac
                .node:  f0078bac
                button: =20
                interrupts:  00000001
                reg:  00000000.00000800.00000030
                compatible: 'acpi-power'
                name: 'power'

            Node 0xf0078d24
                .node:  f0078d24
                reg:  00000000.000003f8.00000008
                interrupts:  00000001
                compatible:  73753136.35353000.737500
                device_type: 'serial'
                name: 'serial'

            Node 0xf007a764
                .node:  f007a764
                reg:  00000000.000002e8.00000008
                interrupts:  00000001
                compatible:  73753136.35353000.737500
                device_type: 'serial'
                name: 'serial'

        Node 0xf007c414
            .node:  f007c414
            assigned-addresses:  82006110.00000000.00400000.00000000.000200=
00.82006130.00000000.00800000.00000000.00400000
            shared-pins: 'mii'
            interrupts:  00000002
            model: 'SUNW,pci-eri'
            version: '1.11'
            compatible:  70636931.3038652c.31313031.2e310070.63693130.38652=
c31.31303100.70636963.6c617373.2c303230.30303000.70636963.6c617373.2c303230=
=2E3000
            device_type: 'network'
            address-bits:  00000030
            max-frame-size:  00004000
            reg:  00006100.00000000.00000000.00000000.00000000.02006110.000=
00000.00000000.00000000.00008000
            name: 'network'
            fast-back-to-back: =20
            devsel-speed:  00000001
            class-code:  00020000
            latency-timer:  00000040
            cache-line-size:  00000010
            max-latency:  00000005
            min-grant:  0000000a
            revision-id:  00000001
            device-id:  00001101
            vendor-id:  0000108e

        Node 0xf0084a04
            .node:  f0084a04
            assigned-addresses:  82006210.00000000.00420000.00000000.000020=
00.82006214.00000000.00422000.00000000.00002000.82006230.00000000.00c00000.=
00000000.00400000
            reg:  00006200.00000000.00000000.00000000.00000000.02006210.000=
00000.00000000.00000000.00002000.02006214.00000000.00000000.00000000.000020=
00.02006230.00000000.00000000.00000000.00400000
            compatible:  70636931.3038652c.31313032.2e313030.31007063.69313=
038.652c3131.30320070.6369636c.6173732c.30633030.31300070.6369636c.6173732c=
=2E30633030.00
            name: 'firewire'
            interrupts:  00000003
            fast-back-to-back: =20
            devsel-speed:  00000001
            class-code:  000c0010
            latency-timer:  00000040
            cache-line-size:  00000010
            max-latency:  00000005
            min-grant:  0000000a
            revision-id:  00000001
            device-id:  00001102
            vendor-id:  0000108e

        Node 0xf0084d40
            .node:  f0084d40
            assigned-addresses:  82006310.00000000.02000000.00000000.010000=
00.82006330.00000000.01000000.00000000.00400000
            sunw,find-fcode:  f008a09c
            maximum-frame#:  0000ffff
            reg:  00006300.00000000.00000000.00000000.00000000.02006310.000=
00000.00000000.00000000.01000000
            #size-cells:  00000000
            #address-cells:  00000001
            compatible:  70636931.3038652c.31313033.2e310070.63693130.38652=
c31.31303300.70636963.6c617373.2c306330.33313000.70636963.6c617373.2c306330=
=2E3300
            name: 'usb'
            interrupts:  00000004
            fast-back-to-back: =20
            devsel-speed:  00000001
            class-code:  000c0310
            latency-timer:  00000040
            cache-line-size:  00000010
            max-latency:  00000005
            min-grant:  0000000a
            revision-id:  00000001
            device-id:  00001103
            vendor-id:  0000108e

            Node 0xf008aeb4
                .node:  f008aeb4
                keyboard: =20
                endpoints: '0,8,81,8'
                interface#:  00000000
                compatible:  75736234.33302c35.2e313032.00757362.3433302c.3=
5007573.62696634.33302c63.6c617373.332e312e.31007573.62696634.33302c63.6c61=
7373.332e3100.75736269.66343330.2c636c61.73733300.75736269.662c636c.6173733=
3.2e312e31.00757362.69662c63.6c617373.332e3100.75736269.662c636c.61737333.00
                name: 'keyboard'
                reg:  00000003
                low-speed: =20
                assigned-address:  00000002
                0max-packet:  00000008

            Node 0xf0090adc
                .node:  f0090adc
                #size-cells:  00000000
                #address-cells:  00000001
                endpoints: '0,8,81,1'
                interface#:  00000000
                compatible:  75736234.35312c32.3034362e.31323500.75736234.3=
5312c32.30343600.75736234.35312c63.6c617373.392e302e.30007573.62343531.2c63=
6c61.7373392e.30007573.62343531.2c636c61.73733900.7573622c.636c6173.73392e3=
0.2e300075.73622c63.6c617373.392e3000.7573622c.636c6173.73390075.73626966.3=
435312c.636c6173.73392e30.2e300075.73626966.3435312c.636c6173.73392e30.0075=
7362.69663435.312c636c.61737339.00757362.69662c63.6c617373.392e302e.3000757=
3.6269662c.636c6173.73392e30.00757362.69662c63.6c617373.3900
                name: 'hub'
                reg:  00000004
                assigned-address:  00000003
                0max-packet:  00000008

                Node 0xf0095d18
                    .node:  f0095d18
                    keyboard: =20
                    endpoints: '0,8,81,8'
                    interface#:  00000000
                    compatible:  75736234.3133632c.32313035.2e333530.007573=
62.34313363.2c323130.35007573.62696634.3133632c.636c6173.73332e31.2e310075.=
73626966.34313363.2c636c61.7373332e.31007573.62696634.3133632c.636c6173.733=
30075.73626966.2c636c61.7373332e.312e3100.75736269.662c636c.61737333.2e3100=
75.73626966.2c636c61.73733300
                    name: 'keyboard'
                    reg:  00000003
                    low-speed: =20
                    assigned-address:  00000004
                    0max-packet:  00000008

                Node 0xf009b914
                    .node:  f009b914
                    mouse: =20
                    endpoints: '0,8,81,4'
                    interface#:  00000000
                    compatible:  75736234.35652c34.302e3330.30007573.623435=
65.2c343000.75736269.66343565.2c636c61.7373332e.312e3200.75736269.66343565.=
2c636c61.7373332e.31007573.62696634.35652c63.6c617373.33007573.6269662c.636=
c6173.73332e31.2e320075.73626966.2c636c61.7373332e.31007573.6269662c.636c61=
73.733300
                    name: 'mouse'
                    reg:  00000004
                    low-speed: =20
                    assigned-address:  00000005
                    0max-packet:  00000008

        Node 0xf009dc7c
            .node:  f009dc7c
            assigned-addresses:  81001810.00000000.00000000.00000000.000000=
10
            ranges:  00000000.00000000.00001800.00000000.00000000.00000100.=
00000001.00000000.81001810.00000000.00000600.00000100.00000002.00000000.810=
01814.00000000.00000000.00000100
            reg:  00001800.00000000.00000000.00000000.00000000.81001810.000=
00000.00000600.00000000.00000010
            compatible:  70636931.3062392c.37313031.2e300070.63693130.62392=
c37.31303100.70636963.6c617373.2c303030.30303000.70636963.6c617373.2c303030=
=2E3000
            #address-cells:  00000002
            #size-cells:  00000001
            name: 'pmu'
            devsel-speed:  00000001
            class-code:  00000000
            latency-timer:  00000000
            cache-line-size:  00000000
            max-latency:  00000000
            min-grant:  00000000
            revision-id:  00000000
            device-id:  00007101
            vendor-id:  000010b9

            Node 0xf009ece4
                .node:  f009ece4
                reg:  00000000.00000000.00000100.00000001.00000000.00000100
                #address-cells:  00000002
                #size-cells:  00000000
                interrupts:  00000001
                compatible: 'i2c-smbus'
                name: 'i2c'

                Node 0xf00a01bc
                    .node:  f00a01bc
                    reg:  00000000.00000030
                    compatible: 'i2c-max1617'
                    name: 'temperature'

                Node 0xf00a0284
                    .node:  f00a0284
                    reg:  00000000.00000040
                    compatible: 'i2c-scm001'
                    name: 'card-reader'

                Node 0xf00a034c
                    .node:  f00a034c
                    reg:  00000000.000000a0
                    compatible: 'i2c-at34c02'
                    name: 'dimm-spd'

                Node 0xf00a050c
                    .node:  f00a050c
                    reg:  00000000.000000a2
                    compatible: 'i2c-at34c02'
                    name: 'dimm-spd'

                Node 0xf00a06cc
                    .node:  f00a06cc
                    reg:  00000000.000000a4
                    compatible: 'i2c-at34c02'
                    name: 'dimm-spd'

                Node 0xf00a088c
                    .node:  f00a088c
                    reg:  00000000.000000a6
                    compatible: 'i2c-at34c02'
                    name: 'dimm-spd'

            Node 0xf00a0ac0
                .node:  f00a0ac0
                reg:  00000000.000000b2.00000001.00000000.000000d3.00000001=
=2E00000002.00000042.00000002.00000002.00000061.00000001
                compatible: 'SUNW,smbus-beep'
                name: 'beep'

            Node 0xf00a0bf4
                .node:  f00a0bf4
                register-mask:  00000000.00000001
                reg:  00000000.000000b3.00000001.80000000.000000ba.00000001=
=2E00000000.000000bb.00000001
                compatible: 'SUNW,smbus-ppm'
                name: 'ppm'

            Node 0xf00a0d48
                .node:  f00a0d48
                register-mask:  00000000.00000002
                reg:  00000000.000000c8.00000004.80000000.000000ba.00000001
                compatible: 'SUNW,smbus-fan-control'
                name: 'fan-control'

        Node 0xf00a0f30
            .node:  f00a0f30
            assigned-addresses:  81004010.00000000.00000900.00000000.000001=
00.82004014.00000000.00424000.00000000.00002000
            reg:  00004000.00000000.00000000.00000000.00000000.01004010.000=
00000.00000000.00000000.00000100.02004014.00000000.00000000.00000000.000020=
00
            compatible:  70636931.3062392c.35343531.2e313062.392e3534.35312=
e31.00706369.31306239.2c353435.312e3130.62392e35.34353100.70636931.3062392c=
=2E35343531.00706369.31306239.2c353435.312e3100.70636931.3062392c.35343531.=
00706369.636c6173.732c3034.30313030.00706369.636c6173.732c3034.303100
            name: 'sound'
            fast-back-to-back: =20
            devsel-speed:  00000001
            class-code:  00040100
            interrupts:  00000001
            latency-timer:  00000040
            cache-line-size:  00000000
            max-latency:  00000018
            min-grant:  00000002
            subsystem-id:  00005451
            subsystem-vendor-id:  000010b9
            revision-id:  00000001
            device-id:  00005451
            vendor-id:  000010b9

        Node 0xf00a12d0
            .node:  f00a12d0
            assigned-addresses:  81006810.00000000.00000a00.00000000.000000=
08.81006814.00000000.00000a18.00000000.00000008.81006818.00000000.00000a10.=
00000000.00000008.8100681c.00000000.00000a08.00000000.00000008.81006820.000=
00000.00000a20.00000000.00000010
            reg:  00006800.00000000.00000000.00000000.00000000.01006810.000=
00000.00000000.00000000.00000008.01006814.00000000.00000000.00000000.000000=
04.01006818.00000000.00000000.00000000.00000008.0100681c.00000000.00000000.=
00000000.00000004.01006820.00000000.00000000.00000000.00000010
            compatible:  70636931.3062392c.35323239.2e633300.70636931.30623=
92c.35323239.00706369.636c6173.732c3031.30316666.00706369.636c6173.732c3031=
=2E303100
            #address-cells:  00000002
            device_type: 'ide'
            name: 'ide'
            fast-back-to-back: =20
            devsel-speed:  00000001
            class-code:  000101ff
            interrupts:  00000001
            latency-timer:  00000040
            cache-line-size:  00000000
            max-latency:  00000004
            min-grant:  00000002
            revision-id:  000000c3
            device-id:  00005229
            vendor-id:  000010b9

            Node 0xf00a3eac
                .node:  f00a3eac
                device_type: 'block'
                name: 'disk'
                compatible: 'ide-disk'

            Node 0xf00a4560
                .node:  f00a4560
                device_type: 'block'
                name: 'cdrom'
                compatible: 'ide-cdrom'

        Node 0xf00a4ec8
            .node:  f00a4ec8
            address:  fde00000
            assigned-addresses:  82009810.00000000.03000000.00000000.010000=
00.81009814.00000000.00000b00.00000000.00000100.82009818.00000000.00426000.=
00000000.00002000.82009830.00000000.00440000.00000000.00020000
            aty,fcode: '1.69'
            aty,card#: '109-XXXXX-XX'
            aty,rom#: '113-XXXXX-100'
            model: 'ATY,RageXL'
            name: 'SUNW,m64B'
            pgx_version: '@(#) pgx24+.fth 1.8 01/03/12 '
            reg:  00009800.00000000.00000000.00000000.00000000.02009810.000=
00000.00000000.00000000.01000000.02009818.00000000.00000000.00000000.000010=
00.02009830.00000000.00000000.00000000.00020000
            character-set: 'ISO8859-1'
            device_type: 'display'
            linebytes:  00000500
            depth:  00000008
            height:  00000400
            width:  00000500
            fb-memory:  00000008
            aty,flags:  0000001b
            aty,status:  00000004
            edid:  00ffffff.ffffff00.10ac20a0.53344331.18100103.0e291f78.ee=
ee91a3.544c9926.0f5054a5.4b008180.a940714f.01010101.01010101.0101483f.40306=
2b0.324040c0.13006f13.1100001e.000000ff.00433935.33363636.45314334.530a0000=
=2E00fc0044.454c4c20.32303037.46500a20.000000fd.00384c1e.5311000a.20202020.=
2020002e
            fast-back-to-back: =20
            devsel-speed:  00000001
            class-code:  00030000
            interrupts:  00000001
            latency-timer:  00000040
            cache-line-size:  00000010
            max-latency:  00000000
            min-grant:  00000008
            revision-id:  00000027
            device-id:  00004752
            vendor-id:  00001002

        Node 0xf00ae520
            .node:  f00ae520
            available:  81000000.00000000.00001100.00000000.00000f00.820000=
00.00000000.04002000.00000000.0001e000.82000000.00000000.04040000.00000000.=
000c0000
            interrupt-map:  00010000.00000000.00000000.00000001.f005c528.00=
000019.00010000.00000000.00000000.00000002.f005c528.00000002.00010000.00000=
000.00000000.00000003.f005c528.00000018.00010000.00000000.00000000.00000004=
=2Ef005c528.00000008.00010800.00000000.00000000.00000001.f005c528.0000000a.=
00010800.00000000.00000000.00000002.f005c528.0000001b.00010800.00000000.000=
00000.00000003.f005c528.0000000b.00010800.00000000.00000000.00000004.f005c5=
28.0000001a.00011000.00000000.00000000.00000001.f005c528.00000015.00011000.=
00000000.00000000.00000002.f005c528.00000005.00011000.00000000.00000000.000=
00003.f005c528.00000014.00011000.00000000.00000000.00000004.f005c528.000000=
04
            interrupt-map-mask:  00fff800.00000000.00000000.00000007
            ranges:  81000000.00000000.00001000.81000000.00000000.00001000.=
00000000.00001000.82000000.00000000.04000000.82000000.00000000.04000000.000=
00000.00100000
            bus-range:  00000001.00000001
            compatible:  70636931.3031312c.32342e33.00706369.31303131.2c323=
400.70636963.6c617373.2c303630.34303000.70636963.6c617373.2c303630.3400
            reg:  00002800.00000000.00000000.00000000.00000000
            #address-cells:  00000003
            #size-cells:  00000002
            device_type: 'pci'
            name: 'pci'
            fast-back-to-back: =20
            devsel-speed:  00000001
            class-code:  00060400
            latency-timer:  00000040
            cache-line-size:  00000010
            revision-id:  00000003
            device-id:  00000024
            vendor-id:  00001011

            Node 0xf00af7b8
                .node:  f00af7b8
                assigned-addresses:  81010810.00000000.00001000.00000000.00=
000100.82010814.00000000.04000000.00000000.00002000.82010830.00000000.04020=
000.00000000.00020000
                reg:  00010800.00000000.00000000.00000000.00000000.01010810=
=2E00000000.00000000.00000000.00000100.02010814.00000000.00000000.00000000.=
00002000.02010830.00000000.00000000.00000000.00020000
                compatible:  70636931.3331372c.3938352e.31313133.2e656330.3=
22e3131.00706369.31333137.2c393835.2e313131.332e6563.30320070.63693131.3133=
2c65.63303200.70636931.3331372c.3938352e.31310070.63693133.31372c39.3835007=
0.6369636c.6173732c.30323030.30300070.6369636c.6173732c.30323030.00
                name: 'ethernet'
                fast-back-to-back: =20
                devsel-speed:  00000001
                class-code:  00020000
                interrupts:  00000001
                latency-timer:  00000040
                cache-line-size:  00000010
                max-latency:  000000ff
                min-grant:  000000ff
                subsystem-id:  0000ec02
                subsystem-vendor-id:  00001113
                revision-id:  00000011
                device-id:  00000985
                vendor-id:  00001317

    Node 0xf0065088
        .node:  f0065088
        clock-frequency:  1debe980
        manufacturer#:  00000017
        implementation#:  00000013
        mask#:  00000014
        clock-divisors:  00000001.00000002.00000006
        ecache-size:  00040000
        name: 'SUNW,UltraSPARC-IIe'
        device_type: 'cpu'
        sparc-version:  00000009
        ecache-associativity:  00000004
        ecache-line-size:  00000040
        #dtlb-entries:  00000040
        dcache-associativity:  00000001
        dcache-line-size:  00000020
        dcache-size:  00004000
        #itlb-entries:  00000040
        icache-associativity:  00000002
        icache-line-size:  00000020
        icache-size:  00004000
        upa-portid:  00000000
        reg:  000001c0.00000000.00000000.00000008


--ReaqsoxgOBHFXBhH--
