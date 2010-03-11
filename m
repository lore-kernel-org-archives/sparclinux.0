From: Frans van Berckel <fberckel@xs4all.nl>
Date: Thu, 11 Mar 2010 08:30:31 +0000
Subject: Re: XVR-500 additional pci ids
Message-Id: <1268296231.1752.5.camel@deblnxsrv254.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-GEsQZ62Tknh68sbo+e/E"
List-Id: <sparclinux.vger.kernel.org>
References: <201002251955.23519.dennis@ausil.us>
In-Reply-To: <201002251955.23519.dennis@ausil.us>
To: sparclinux@vger.kernel.org


--=-GEsQZ62Tknh68sbo+e/E
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Thanks for asking. Attaching XVR 1000 (SUNW,gfb) prtconf -pv.


Frans van Berckel

On Wed, 2010-03-10 at 18:24 -0800, David Miller wrote:
> From: Frans van Berckel <fberckel@xs4all.nl>
> Date: Tue, 02 Mar 2010 09:20:39 +0100
> 
> > But I wanne get my XVR-1200 supported by the kernel.
> 
> Can you get me "prtconf -pv" or "lspci" output with the card
> installed?
> 
> I think just adding the matching PCI device ID to the driver should
> allow the card to work just fine.
> 
> So if someone can get me the PCI device ID for these other XVR-*
> cards, I can add them to the driver.


--=-GEsQZ62Tknh68sbo+e/E
Content-Disposition: attachment; filename="xvr-1000-prtconf-pv.txt"
Content-Type: text/plain; name="xvr-1000-prtconf-pv.txt"; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

System Configuration:  Sun Microsystems  sun4u
Memory size: 2048 Megabytes
System Peripherals (PROM Nodes):

Node 0xf0029b10
    .node:  f0029b10
    banner-name: 'Sun Blade 2000/1000 (UltraSPARC-III+) '
    idprom:  01830003.ba5b86cb.11192003.5b86cb10.00000000.00000000.00000000=
.00000000
    model: 'SUNW,501-6230'
    energystar-v3: =20
    scsi-initiator-id:  00000007
    stick-frequency:  004c4b40
    clock-frequency:  08a48640
    breakpoint-trap:  0000007f
    #size-cells:  00000002
    name: 'SUNW,Sun-Blade-1000'
    device_type: 'gptwo'

    Node 0xf002ce58
        .node:  f002ce58
        name: 'packages'

        Node 0xf00485cc
            .node:  f00485cc
            name: 'SUNW,builtin-drivers'

        Node 0xf0053e1c
            .node:  f0053e1c
            disk-write-fix: =20
            name: 'deblocker'

        Node 0xf00542f8
            .node:  f00542f8
            name: 'disk-label'

        Node 0xf0054c30
            .node:  f0054c30
            iso6429-1983-colors: =20
            name: 'terminal-emulator'

        Node 0xf0058be8
            .node:  f0058be8
            name: 'obp-tftp'

        Node 0xf0060958
            .node:  f0060958
            source: '/flashprom:'
            name: 'dropins'

        Node 0xf007d324
            .node:  f007d324
            name: 'kbd-translator'

    Node 0xf002cec8
        .node:  f002cec8
        bootargs:  00
        bootpath: '/pci@8,600000/SUNW,qlc@4/fp@0,0/disk@w21000004cfa36c64,0=
:a'
        mmu:  fff73a78
        memory:  fff73c78
        stdout:  fff19420
        stdin:  fff059c0
        stdout-#lines:  00000022
        name: 'chosen'

    Node 0xf002cf34
        .node:  f002cf34
        version: 'OBP 4.5.21 2003/02/24 17:23'
        model: 'SUNW,4.5'
        aligned-allocator: =20
        relative-addressing: =20
        name: 'openprom'

        Node 0xf002cfc4
            .node:  f002cfc4
            name: 'client-services'

    Node 0xf002d06c
        .node:  f002d06c
        test-args: =20
        diag-passes: '1'
        enclosure-type: '540-3256-15'
        banner-name: 'Sun Blade 2000/1000'
        energystar-enabled?: 'true'
        pcia-probe-list: '4,1'
        pcib-probe-list: '5,6,1,2,3,4'
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
        ttyb-mode: '19200,8,n,1,-'
        ttya-mode: '9600,8,n,1,-'
        output-device: 'screen:r1440x900x60'
        input-device: 'keyboard'
        load-base: '16384'
        auto-boot?: 'true'
        boot-command: 'boot'
        diag-file: =20
        diag-device: 'disk net'
        boot-file: =20
        boot-device: 'disk cdrom net'
        use-nvramrc?: 'false'
        nvramrc: =20
        security-mode: 'none'
        security-password: =20
        security-#badlogins: '0'
        #power-cycles: '164'
        diag-script: 'none'
        diag-level: 'min'
        diag-switch?: 'false'
        error-reset-recovery: 'boot'
        name: 'options'

    Node 0xf002d0dc
        .node:  f002d0dc
        screen: '/upa@8,480000/SUNW,gfb@0,0'
        mouse: '/pci@8,700000/usb@5,3/mouse@2'
        keyboard: '/pci@8,700000/usb@5,3/keyboard@1'
        disk1: '/pci@8,600000/SUNW,qlc@4/fp@0,0/disk@2,0'
        disk0: '/pci@8,600000/SUNW,qlc@4/fp@0,0/disk@1,0'
        disk: '/pci@8,600000/SUNW,qlc@4/fp@0,0/disk@1,0'
        scsi: '/pci@8,600000/SUNW,qlc@4'
        net: '/pci@8,700000/network@5,1:'
        cdrom: '/pci@8,700000/scsi@6/disk@6,0:f'
        tape: '/pci@8,700000/scsi@6,1/tape@4,0'
        tape1: '/pci@8,700000/scsi@6,1/tape@5,0'
        tape0: '/pci@8,700000/scsi@6,1/tape@4,0'
        beep: '/pci@8,700000/ebus@5/beep@1,32'
        floppy: '/pci@8,700000/ebus@5/floppy'
        ttyb: '/pci@8,700000/ebus@5/serial@1,400000:b'
        ttya: '/pci@8,700000/ebus@5/serial@1,400000:a'
        name: 'aliases'

    Node 0xf003e110
        .node:  f003e110
        reg:  00000000.00000000.00000000.80000000
        available:  00000000.7fe6e000.00000000.0001e000.00000000.7fda8000.0=
0000000.000b6000.00000000.7fd94000.00000000.00010000.00000000.7fd82000.0000=
0000.0000e000.00000000.7f000000.00000000.00c7e000.00000000.00000000.0000000=
0.7effe000
        name: 'memory'

    Node 0xf003e6f4
        .node:  f003e6f4
        translations:  00000000.fff70000.00000000.00010000.80000000.7ff700b=
6.00000000.fff64000.00000000.0000c000.80000000.7ff580b6.00000000.fff5e000.0=
0000000.00002000.800007ff.fff8008e.00000000.fff4c000.00000000.00002000.8000=
07ff.fff8008e.00000000.fff4a000.00000000.00002000.800007ff.fff8008e.0000000=
0.fff48000.00000000.00002000.800007ff.ee00208e.00000000.fff46000.00000000.0=
0002000.80000000.7ff540b6.00000000.fff44000.00000000.00002000.800007fe.7e30=
008e.00000000.fff42000.00000000.00002000.80000000.7effe0b6.00000000.fff4000=
0.00000000.00002000.80000000.7ff500b6.00000000.fff3e000.00000000.00002000.8=
00007fe.7e30008e.00000000.fff3c000.00000000.00002000.800007fe.7e30008e.0000=
0000.fff3a000.00000000.00002000.800007fe.7e00008e.00000000.fff38000.0000000=
0.00002000.800007fe.7e00008e.00000000.fff36000.00000000.00002000.80000000.7=
ff420b6.00000000.fff34000.00000000.00002000.800007fe.7e00008e.00000000.fff3=
2000.00000000.00002000.80000000.7ff400b6.00000000.fff30000.00000000.0000200=
0.800007fe.7e30008e.00000000.fff2e000.00000000.00002000.800007fe.7e30008e.0=
0000000.fff2c000.00000000.00002000.800007fe.7e72008e.00000000.fff2a000.0000=
0000.00002000.80000000.7ff360b6.00000000.fff28000.00000000.00002000.800007f=
f.ec00208e.00000000.fff26000.00000000.00002000.800007fe.0012208e.00000000.f=
ff22000.00000000.00004000.80000000.7ff280b6.00000000.fff20000.00000000.0000=
2000.800007f8.0020008e.00000000.fff1e000.00000000.00002000.800007f8.0021008=
e.00000000.fff1c000.00000000.00002000.800007f8.0080608e.00000000.fff18000.0=
0000000.00004000.80000000.7fda40b6.00000000.fff14000.00000000.00002000.8000=
0400.0440008e.00000000.fff12000.00000000.00002000.80000400.0448008e.0000000=
0.fff10000.00000000.00002000.800007fe.0100008e.00000000.fff0a000.00000000.0=
0006000.80000000.7fe960b6.00000000.fff08000.00000000.00002000.80000000.7ff6=
60b6.00000000.fff04000.00000000.00004000.80000000.7fe9e0b6.00000000.fff0000=
0.00000000.00004000.80000000.7fe920b6.00000000.feffe000.00000000.00002000.8=
0000000.7fe900b6.00000000.fef7e000.00000000.00042000.80000000.7fee40b6.0000=
0000.fef66000.00000000.00018000.800007f8.0082808e.00000000.fef46000.0000000=
0.00020000.800007f8.7000008e.00000000.feef0000.00000000.00010000.80000400.0=
470008e.00000000.feeee000.00000000.00002000.80000400.0441008e.00000000.feee=
c000.00000000.00002000.80000400.0440008e.00000000.feee8000.00000000.0000400=
0.80000000.7ff4c0b6.00000000.feed6000.00000000.00010000.80000400.0460008e.0=
0000000.feed4000.00000000.00002000.80000400.0441008e.00000000.feed2000.0000=
0000.00002000.80000400.0440008e.00000000.feece000.00000000.00004000.8000000=
0.7ff480b6.00000000.faecc000.00000000.04000000.800007f8.0400008e.00000000.f=
adcc000.00000000.00100000.80000000.7fc7e0b6.00000000.f00ce000.00000000.0000=
2000.80000000.7fe9c0b6.00000000.f00cc000.00000000.00002000.80000000.7fea40b=
6.00000000.f00ca000.00000000.00002000.80000000.7fea60b6.00000000.f00c8000.0=
0000000.00002000.80000000.7fea20b6.00000000.f00c6000.00000000.00002000.8000=
0000.7feac0b6.00000000.f00c4000.00000000.00002000.80000000.7feae0b6.0000000=
0.f00c2000.00000000.00002000.80000000.7fd900b6.00000000.f00c0000.00000000.0=
0002000.80000000.7fd7e0b6.00000000.f00be000.00000000.00002000.80000000.7fd8=
00b6.00000000.f00bc000.00000000.00002000.80000000.7fd920b6.00000000.f00ba00=
0.00000000.00002000.80000000.7fea80b6.00000000.f00b8000.00000000.00002000.8=
0000000.7feaa0b6.00000000.f00b6000.00000000.00002000.80000000.7feb40b6.0000=
0000.f00b4000.00000000.00002000.80000000.7feb00b6.00000000.f00b2000.0000000=
0.00002000.80000000.7feb20b6.00000000.f00b0000.00000000.00002000.80000000.7=
febc0b6.00000000.f00ae000.00000000.00002000.80000000.7febe0b6.00000000.f00a=
c000.00000000.00002000.80000000.7feba0b6.00000000.f00aa000.00000000.0000200=
0.80000000.7fec00b6.00000000.f00a8000.00000000.00002000.80000000.7fec20b6.0=
0000000.f00a6000.00000000.00002000.80000000.7fec40b6.00000000.f00a4000.0000=
0000.00002000.80000000.7fed60b6.00000000.f00a2000.00000000.00002000.8000000=
0.7fed80b6.00000000.f00a0000.00000000.00002000.80000000.7feda0b6.00000000.f=
009e000.00000000.00002000.80000000.7fedc0b6.00000000.f009c000.00000000.0000=
2000.80000000.7fede0b6.00000000.f009a000.00000000.00002000.80000000.7fee00b=
6.00000000.f0098000.00000000.00002000.80000000.7fee20b6.00000000.f0096000.0=
0000000.00002000.80000000.7ff260b6.00000000.f0094000.00000000.00002000.8000=
0000.7ff2c0b6.00000000.f0092000.00000000.00002000.80000000.7ff2e0b6.0000000=
0.f0090000.00000000.00002000.80000000.7ff300b6.00000000.f008e000.00000000.0=
0002000.80000000.7ff320b6.00000000.f008c000.00000000.00002000.80000000.7ff3=
40b6.00000000.f008a000.00000000.00002000.80000000.7ff560b6.00000000.f008800=
0.00000000.00002000.80000000.7ff380b6.00000000.f0084000.00000000.00004000.8=
0000000.7ff3a0b6.00000000.f0082000.00000000.00002000.80000000.7ff3e0b6.0000=
0000.f0080000.00000000.00002000.80000000.7ff440b6.00000000.f0000000.0000000=
0.00080000.80000000.7ff800b6.00000000.413ee000.00000000.02c12000.80000000.0=
17ee036.00000000.40000000.00000000.00c00000.80000000.00400036.00000000.0000=
2000.00000000.00bfe000.80000000.00002036
        existing:  00000000.00000000.00000800.00000000.fffff800.00000000.00=
000800.00000000
        available:  fffff800.00000000.000007fc.00000000.00000001.00000000.0=
00007ff.00000000.00000000.ffff0000.00000000.0000e000.00000000.00000000.0000=
0000.f0000000.00000000.fff16000.00000000.00002000.00000000.fefc0000.0000000=
0.0003e000.00000000.fef00000.00000000.00046000.00000000.feee6000.00000000.0=
0002000.00000000.feecc000.00000000.00002000.00000000.f0800000.00000000.0a5c=
c000
        page-size:  00002000
        name: 'virtual-memory'

    Node 0xf006bd10
        .node:  f006bd10
        clock-divisors:  00000001.00000002.00000020
        sparc-version:  00000009
        #dtlb-entries:  00000010
        dcache-associativity:  00000004
        dcache-line-size:  00000020
        dcache-size:  00010000
        #itlb-entries:  00000010
        icache-associativity:  00000004
        icache-line-size:  00000020
        icache-size:  00008000
        cpuid:  00000000
        portid:  00000000
        reg:  00000400.00000000.00000000.00010000
        device_type: 'cpu'
        manufacturer#:  0000003e
        implementation#:  00000015
        mask#:  00000023
        ecache-associativity:  00000002
        ecache-line-size:  00000200
        ecache-size:  00800000
        clock-frequency:  3c7fabc0
        name: 'SUNW,UltraSPARC-III+'

    Node 0xf006c544
        .node:  f006c544
        memory-layout:  4a303130.30000000.4a303230.32000000.4a303330.340000=
00.4a303430.36000000.4a303130.31000000.4a303230.33000000.4a303330.35000000.=
4a303430.37000000.010055aa.55000000.55aa5500.00015a00.55aafffa.95aaffff.ffa=
a55aa.ffffff79.0292f6f9.e40055aa.55000000.55aa5500.00015a00.55aafffa.95aaff=
ff.ffaa55aa.ffffff79.0292f6f9.e40055aa.55000000.55aa5500.00015a00.55aafffa.=
95aaffff.ffaa55aa.ffffff79.0292f6f9.e40055aa.55000000.55aa5500.00015a00.55a=
afffa.95aaffff.ffaa55aa.ffffff79.0292f6f9.e4050505.05797979.63635962.0a1716=
16.160a790a.7e7e7e7e.0a0c0d0e.0f161718.19202122.23202122.23202122.232a2b2c.=
2d2a2b2c.2d4c4d4e.4f565758.59565758.59565758.60616260.616a6b6c.6d0c0d0e.0f0=
c0d0e.0f0c0d0e.0f181917.18191718.19202122.232a2b2c.2d2a2b2c.2d4c4d4e.4f4c4d=
4e.4f4c4d4e.4f565758.59606162.63606162.636a6b6c.6d6a6b6c.6d6a6b6c.6d040404.=
04787878.d7d7cdd6.098b8a8a.8a097809.7d7d7d7d.09808182.838a8b8c.8d949596.979=
49596.97949596.979e9fa0.a19e9fa0.a1c0c1c2.c3cacbcc.cdcacbcc.cdcacbcc.d4d5d6=
d4.d5dedfe0.e1808182.83808182.83808182.838c8d8b.8c8d8b8c.8d949596.979e9fa0.=
a19e9fa0.a1c0c1c2.c3c0c1c2.c3c0c1c2.c3cacbcc.cdd4d5d6.d7d4d5d6.d7dedfe0.e1d=
edfe0.e1dedfe0.e1030303.03777777.68685e67.081c1b1b.1b080877.7c7c7c7c.081112=
13.141b1c1d.1e252627.28252627.28252627.28474849.4a474849.4a515253.545b5c5d.=
5e5b5c5d.5e5b5c5d.65666765.666f7071.72111213.14111213.14111213.141d1e1c.1d1=
e1c1d.1e252627.28474849.4a474849.4a515253.54515253.54515253.545b5c5d.5e6566=
67.68656667.686f7071.726f7071.726f7071.72020202.02767676.dcdcd2db.07908f8f.=
8f077607.7b7b7b7b.07858687.888f9091.92999a9b.9c999a9b.9c999a9b.9cbbbcbd.beb=
bbcbd.bec5c6c7.c8cfd0d1.d2cfd0d1.d2cfd0d1.d9dadbd9.dae3e4e5.e6858687.888586=
87.88858687.88919290.91929091.92999a9b.9cbbbcbd.bebbbcbd.bec5c6c7.c8c5c6c7.=
c8c5c6c7.c8cfd0d1.d2d9dadb.dcd9dadb.dce3e4e5.e6e3e4e5.e6e3e4e5.e600
        compatible:  53554e57.2c556c74.72615350.4152432d.4949492c.6d630053.=
554e572c.6d6300
        portid:  00000000
        reg:  00000400.00400000.00000000.00000048
        device_type: 'memory-controller'
        name: 'memory-controller'

    Node 0xf006c678
        .node:  f006c678
        available:  81000000.00000000.00000500.00000000.0000fb00.82000000.0=
0000000.0012c000.00000000.002d4000.82000000.00000000.02000000.00000000.7a00=
0000
        reg:  00000400.04700000.00000000.00018000.00000400.04410000.0000000=
0.00000050.000007ff.ee000000.00000000.00000100
        ranges:  00000000.00000000.00000000.000007ff.ee000000.00000000.0100=
0000.01000000.00000000.00000000.000007ff.ef000000.00000000.01000000.0200000=
0.00000000.00000000.000007fe.00000000.00000001.00000000.03000000.00000000.0=
0000000.000007fe.00000000.00000001.00000000
        ino-bitmap:  f3fff000.001fecff
        interrupt-map:  00000800.00000000.00000000.00000001.f006c678.000000=
0c.00000800.00000000.00000000.00000002.f006c678.0000000d.00000800.00000000.=
00000000.00000003.f006c678.0000000e.00000800.00000000.00000000.00000004.f00=
6c678.0000000f.00001000.00000000.00000000.00000001.f006c678.00000010.000010=
00.00000000.00000000.00000002.f006c678.00000011.00001000.00000000.00000000.=
00000003.f006c678.00000012.00001000.00000000.00000000.00000004.f006c678.000=
00013.00001800.00000000.00000000.00000001.f006c678.00000014.00001800.000000=
00.00000000.00000002.f006c678.00000015.00001800.00000000.00000000.00000003.=
f006c678.00000016.00001800.00000000.00000000.00000004.f006c678.00000017.000=
02800.00000000.00000000.00000002.f006c678.0000001d.00002800.00000000.000000=
00.00000003.f006c678.0000001e.00002800.00000000.00000000.00000004.f006c678.=
0000001f.00003000.00000000.00000000.00000001.f006c678.00000018.00003000.000=
00000.00000000.00000002.f006c678.00000019
        interrupt-map-mask:  00fff800.00000000.00000000.00000007
        #interrupt-cells:  00000001
        slot-names:  0000001c.50434920.34005043.49203300.50434920.3200
        interrupts:  00000033.00000030.00000031.00000034.00000026
        clock-frequency:  01f78a40
        bus-range:  00000000.00000000
        bus-parity-generated: =20
        no-probe-list: '0'
        compatible: 'pci108e,8001'
        name: 'pci'
        device_type: 'pci'
        #address-cells:  00000003
        #size-cells:  00000002
        implementation#:  0000002a
        version#:  00000007
        portid:  00000008

        Node 0xf007e070
            .node:  f007e070
            interrupt-map:  00000001.0000002e.00000001.f006c678.00000023.00=
000001.00000030.00000001.f006c678.00000023.00000001.00200000.00000001.f006c=
678.00000020.00000001.00200000.00000002.f006c678.00000021.00000001.00300070=
.00000001.f006c678.00000024.00000001.003023f0.00000001.f006c678.00000025.00=
000001.00300278.00000001.f006c678.0000001c.00000001.00400000.00000001.f006c=
678.00000022
            interrupt-map-mask:  0000001f.00ffffff.00000003
            #interrupt-cells:  00000001
            ranges:  00000000.00000000.82002810.00000000.7d000000.01000000.=
00000001.00000000.82002814.00000000.7e000000.00800000
            reg:  00002800.00000000.00000000.00000000.00000000.02002810.000=
00000.00000000.00000000.01000000.02002814.00000000.00000000.00000000.008000=
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

            Node 0xf007f474
                .node:  f007f474
                model: 'SUNW,525-1807'
                reg:  00000000.00000000.00200000
                version:  4f425020.342e352e.32312032.3030332f.30322f32.3420=
3137.3a323300.504f5354.20342e37.2e342032.3030322f.31322f32.33203137.3a30340=
0
                name: 'flashprom'

            Node 0xf00800cc
                .node:  f00800cc
                reg:  00000001.00000000.00100000
                name: 'bbc'

            Node 0xf008015c
                .node:  f008015c
                reg:  00000001.0000000e.0000001b.00000001.00728000.00000004=
.00000001.0030002e.00000002.00000001.00300600.00000008
                compatible:  65627573.2d70706d.0053554e.572c6262.632d7070.6=
d00
                name: 'ppm'

            Node 0xf00803b8
                .node:  f00803b8
                interrupts:  00000001
                reg:  00000001.0000002e.00000002.00000001.0000002d.00000001
                compatible: 'SUNW,bbc-i2c'
                #size-cells:  00000000
                #address-cells:  00000002
                name: 'i2c'

                Node 0xf00814d4
                    .node:  f00814d4
                    reg:  00000001.000000a0
                    compatible: 'i2c-at24c64'
                    name: 'dimm-fru'

                Node 0xf0081590
                    .node:  f0081590
                    reg:  00000001.000000a4
                    compatible: 'i2c-at24c64'
                    name: 'dimm-fru'

                Node 0xf008164c
                    .node:  f008164c
                    reg:  00000001.000000a8
                    compatible: 'i2c-at24c64'
                    name: 'dimm-fru'

                Node 0xf0081708
                    .node:  f0081708
                    reg:  00000001.000000ac
                    compatible: 'i2c-at24c64'
                    name: 'dimm-fru'

                Node 0xf00817c4
                    .node:  f00817c4
                    reg:  00000000.000000a0
                    compatible: 'i2c-at24c64'
                    device_type: 'nvram'
                    name: 'nvram'

                Node 0xf0081e5c
                    .node:  f0081e5c
                    device_type: 'idprom'
                    reg:  00000000.000000a0
                    name: 'idprom'

            Node 0xf00823e0
                .node:  f00823e0
                interrupts:  00000001
                reg:  00000001.00000030.00000002
                compatible: 'SUNW,bbc-i2c'
                #size-cells:  00000000
                #address-cells:  00000002
                name: 'i2c'

                Node 0xf00834f0
                    .node:  f00834f0
                    reg:  00000000.000000a0
                    compatible: 'i2c-at24c64'
                    name: 'cpu-fru'

                Node 0xf00835ac
                    .node:  f00835ac
                    reg:  00000000.00000052
                    compatible: 'i2c-max1617'
                    name: 'temperature'

                Node 0xf008366c
                    .node:  f008366c
                    reg:  00000000.00000048
                    compatible: 'i2c-tda8444'
                    name: 'fan-control'

                Node 0xf008372c
                    .node:  f008372c
                    reg:  00000000.00000040
                    compatible: 'i2c-scm001'
                    name: 'card-reader'

                Node 0xf00837ec
                    .node:  f00837ec
                    reg:  00000000.000000a8
                    compatible: 'i2c-at24c64'
                    name: 'motherboard-fru'

                Node 0xf0083da0
                    .node:  f0083da0
                    revision-id:  00000012
                    reg:  00000000.00000060
                    compatible: 'i2c-firei'
                    name: 'i2c-bridge'

            Node 0xf0084030
                .node:  f0084030
                reg:  00000001.00000032.00000006
                compatible: 'SUNW,bbc-beep'
                name: 'beep'

            Node 0xf00840f0
                .node:  f00840f0
                model: 'SUNW,CS4231g'
                aux2: 'none'
                aux1: 'loopback'
                interrupts:  00000001.00000002
                dma-model: 'eb2dma'
                reg:  00000001.00200000.00000100.00000001.00702000.00000010=
.00000001.00704000.00000010.00000001.00722000.00000004
                compatible: 'SUNW,CS4231'
                name: 'audio'

            Node 0xf00842e8
                .node:  f00842e8
                address:  fff30070
                reg:  00000001.00300070.00000002
                compatible: 'ds1287'
                model: 'ds1287'
                name: 'rtc'
                interrupts:  00000001

            Node 0xf0084b80
                .node:  f0084b80
                reg:  00000001.00300600.00000008
                compatible: 'ns87317-gpio'
                name: 'gpio'

            Node 0xf0084e50
                .node:  f0084e50
                address:  fff2e700
                reg:  00000001.00300700.00000002
                compatible: 'ns87317-pmc'
                name: 'pmc'

            Node 0xf0084ffc
                .node:  f0084ffc
                interrupts:  00000001
                status: 'disabled'
                reg:  00000001.003023f0.00000008.00000001.00706000.00000010=
.00000001.00720000.00000004
                device_type: 'block'
                compatible: 'fdthree'
                name: 'floppy'

            Node 0xf0086ae0
                .node:  f0086ae0
                reg:  00000001.00300278.00000010.00000001.0030002e.00000002=
.00000001.00700000.00000010
                compatible:  6e733837.3331372d.65637070.00656370.7000
                name: 'parallel'
                interrupts:  00000001

            Node 0xf0086c30
                .node:  f0086c30
                port-b-ignore-cd: =20
                port-a-ignore-cd: =20
                reg:  00000001.00400000.00000080
                compatible:  73616238.32353332.00736500
                device_type: 'serial'
                name: 'serial'
                interrupts:  00000001

        Node 0xf00ac3c0
            .node:  f00ac3c0
            assigned-addresses:  82002910.00000000.00100000.00000000.000200=
00.82002930.00000000.00400000.00000000.00400000
            shared-pins: 'mii'
            interrupts:  00000002
            model: 'SUNW,pci-eri'
            version: '1.10'
            compatible:  70636931.3038652c.31313031.2e310070.63693130.38652=
c31.31303100.70636963.6c617373.2c303230.30303000.70636963.6c617373.2c303230=
.3000
            device_type: 'network'
            address-bits:  00000030
            max-frame-size:  00004000
            reg:  00002900.00000000.00000000.00000000.00000000.02002910.000=
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

        Node 0xf00b4588
            .node:  f00b4588
            assigned-addresses:  82002a10.00000000.00120000.00000000.000020=
00.82002a14.00000000.00122000.00000000.00002000.82002a30.00000000.00800000.=
00000000.00400000
            reg:  00002a00.00000000.00000000.00000000.00000000.02002a10.000=
00000.00000000.00000000.00002000.02002a14.00000000.00000000.00000000.000020=
00.02002a30.00000000.00000000.00000000.00400000
            compatible:  70636931.3038652c.31313032.2e313030.31007063.69313=
038.652c3131.30320070.6369636c.6173732c.30633030.31300070.6369636c.6173732c=
.30633030.00
            name: 'firewire'
            power-managed?: =20
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

        Node 0xf00b48e0
            .node:  f00b48e0
            assigned-addresses:  82002b10.00000000.01000000.00000000.010000=
00.82002b30.00000000.00c00000.00000000.00400000
            sunw,find-fcode:  f00b9c30
            maximum-frame#:  0000ffff
            reg:  00002b00.00000000.00000000.00000000.00000000.02002b10.000=
00000.00000000.00000000.01000000
            #size-cells:  00000000
            #address-cells:  00000001
            compatible:  70636931.3038652c.31313033.2e310070.63693130.38652=
c31.31303300.70636963.6c617373.2c306330.33313000.70636963.6c617373.2c306330=
.3300
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

            Node 0xf00ba94c
                .node:  f00ba94c
                keyboard: =20
                endpoints: '0,1'
                compatible:  75736234.33302c35.2e313033.00757362.3433302c.3=
5007573.62696634.33302c63.6c617373.332e312e.31007573.62696634.33302c63.6c61=
7373.332e3100.75736269.66343330.2c636c61.73733300.75736269.662c636c.6173733=
3.2e312e31.00757362.69662c63.6c617373.332e3100.75736269.662c636c.61737333.0=
0
                name: 'keyboard'
                reg:  00000001
                low-speed: =20
                assigned-address:  00000002

            Node 0xf00c0070
                .node:  f00c0070
                mouse: =20
                endpoints: '0,1'
                compatible:  75736234.33302c31.30302e31.30350075.73623433.3=
02c3130.30007573.62696634.33302c63.6c617373.332e312e.32007573.62696634.3330=
2c63.6c617373.332e3100.75736269.66343330.2c636c61.73733300.75736269.662c636=
c.61737333.2e312e32.00757362.69662c63.6c617373.332e3100.75736269.662c636c.6=
1737333.00
                name: 'mouse'
                reg:  00000002
                low-speed: =20
                assigned-address:  00000003

        Node 0xf00c2284
            .node:  f00c2284
            assigned-addresses:  81003010.00000000.00000300.00000000.000001=
00.82003014.00000000.00124000.00000000.00002000.82003018.00000000.00126000.=
00000000.00002000
            device_type: 'scsi-2'
            clock-frequency:  02625a00
            reg:  00003000.00000000.00000000.00000000.00000000.01003010.000=
00000.00000000.00000000.00000100.02003014.00000000.00000000.00000000.000020=
00.02003018.00000000.00000000.00000000.00002000
            name: 'scsi'
            compatible:  70636931.3030302c.662e3337.00706369.31303030.2c660=
070.6369636c.6173732c.30313030.30300070.6369636c.6173732c.30313030.00
            devsel-speed:  00000001
            class-code:  00010000
            interrupts:  00000001
            latency-timer:  00000040
            cache-line-size:  00000010
            max-latency:  00000040
            min-grant:  00000011
            revision-id:  00000037
            device-id:  0000000f
            vendor-id:  00001000

            Node 0xf00c68b8
                .node:  f00c68b8
                device_type: 'block'
                compatible: 'sd'
                name: 'disk'

            Node 0xf00c7440
                .node:  f00c7440
                device_type: 'byte'
                compatible: 'st'
                name: 'tape'

        Node 0xf00c81a4
            .node:  f00c81a4
            assigned-addresses:  81003110.00000000.00000400.00000000.000001=
00.82003114.00000000.00128000.00000000.00002000.82003118.00000000.0012a000.=
00000000.00002000
            device_type: 'scsi-2'
            clock-frequency:  02625a00
            reg:  00003100.00000000.00000000.00000000.00000000.01003110.000=
00000.00000000.00000000.00000100.02003114.00000000.00000000.00000000.000020=
00.02003118.00000000.00000000.00000000.00002000
            name: 'scsi'
            compatible:  70636931.3030302c.662e3337.00706369.31303030.2c660=
070.6369636c.6173732c.30313030.30300070.6369636c.6173732c.30313030.00
            devsel-speed:  00000001
            class-code:  00010000
            interrupts:  00000002
            latency-timer:  00000040
            cache-line-size:  00000010
            max-latency:  00000040
            min-grant:  00000011
            revision-id:  00000037
            device-id:  0000000f
            vendor-id:  00001000

            Node 0xf00cc7d8
                .node:  f00cc7d8
                device_type: 'block'
                compatible: 'sd'
                name: 'disk'

            Node 0xf00cd360
                .node:  f00cd360
                device_type: 'byte'
                compatible: 'st'
                name: 'tape'

    Node 0xf0075220
        .node:  f0075220
        available:  81000000.00000000.00000400.00000000.0000fc00.82000000.0=
0000000.00102000.00000000.0001e000.82000000.00000000.00140000.00000000.7eec=
0000
        ino-bitmap:  0000003f.00000000
        interrupt-map:  00000800.00000000.00000000.00000001.f0075220.000000=
00.00000800.00000000.00000000.00000002.f0075220.00000001.00000800.00000000.=
00000000.00000003.f0075220.00000002.00000800.00000000.00000000.00000004.f00=
75220.00000003.00002000.00000000.00000000.00000001.f0075220.00000004
        interrupt-map-mask:  00fff800.00000000.00000000.00000007
        #interrupt-cells:  00000001
        reg:  00000400.04600000.00000000.00018000.00000400.04410000.0000000=
0.00000050.000007ff.ec000000.00000000.00000100
        ranges:  00000000.00000000.00000000.000007ff.ec000000.00000000.0100=
0000.01000000.00000000.00000000.000007ff.ed000000.00000000.01000000.0200000=
0.00000000.00000000.000007fd.00000000.00000001.00000000.03000000.00000000.0=
0000000.000007fd.00000000.00000001.00000000
        66mhz-capable: =20
        slot-names:  00000002.50434920.3100
        interrupts:  00000032.00000030.00000031.00000034.00000027
        clock-frequency:  03ef1480
        bus-range:  00000000.00000000
        bus-parity-generated: =20
        no-probe-list: '0'
        compatible: 'pci108e,8001'
        name: 'pci'
        device_type: 'pci'
        #address-cells:  00000003
        #size-cells:  00000002
        implementation#:  0000002a
        version#:  00000007
        portid:  00000008

        Node 0xf00a6444
            .node:  f00a6444
            assigned-addresses:  81002010.00000000.00000300.00000000.000001=
00.82002014.00000000.00100000.00000000.00002000.82002030.00000000.00120000.=
00000000.00020000
            port-wwn:  21000003.ba5b86cb
            node-wwn:  21000003.ba5b86cb
            reg:  00002000.00000000.00000000.00000000.00000000.01002010.000=
00000.00000000.00000000.00000100.02002014.00000000.00000000.00000000.000010=
00
            compatible:  70636931.3037372c.32323030.2e350070.63693130.37372=
c32.32303000.70636963.6c617373.2c303130.30303000.70636963.6c617373.2c303130=
.3000
            manufacturer: 'QLGC'
            #size-cells:  00000000
            #address-cells:  00000002
            device_type: 'scsi-fcp'
            name: 'SUNW,qlc'
            version: 'ISP2200 FC-AL Host Adapter Driver: 1.12 01/01/16'
            66mhz-capable: =20
            fast-back-to-back: =20
            devsel-speed:  00000001
            class-code:  00010000
            interrupts:  00000001
            latency-timer:  00000040
            cache-line-size:  00000010
            max-latency:  00000000
            min-grant:  00000040
            revision-id:  00000005
            device-id:  00002200
            vendor-id:  00001077

            Node 0xf00aad44
                .node:  f00aad44
                #size-cells:  00000000
                #address-cells:  00000004
                reg:  00000000.00000000
                device_type: 'fp'
                name: 'fp'

                Node 0xf00ab440
                    .node:  f00ab440
                    device_type: 'block'
                    compatible: 'ssd'
                    name: 'disk'

    Node 0xf007c12c
        .node:  f007c12c
        clock-frequency:  07270e00
        ranges:  000001c0.00000000.000007f8.00000000.00000002.00000000.0000=
01c2.00000000.000007fa.00000000.00000002.00000000
        reg:  00000400.04480000.00000000.00000020.00000400.04706000.0000000=
0.00000010.00000400.04708000.00000000.00000010
        #size-cells:  00000002
        #address-cells:  00000002
        portid:  00000008
        compatible: 'upa64s'
        power-managed?: =20
        device_type: 'upa'
        name: 'upa'

        Node 0xf008b73c
            .node:  f008b73c
            width:  00000500
            height:  00000400
            vertical-frequency:  0000003c
            active-video-channel#:  00000002
            character-set: 'ISO8859-1'
            status: 'okay'
            edid-source:  31337733.00686431.3500
            edid:  00000000.00000000.00000000.00000000.00000000.00000000.00=
000000.00000000.00000000.00000000.00000000.00000000.00000000.00000000.00000=
000.00000000.00000000.00000000.00000000.00000000.00000000.00000000.00000000=
.00000000.00000000.00000000.00000000.00000000.00000000.00000000.00000000.00=
000000.00ffffff.ffffff00.26cd0256.e8c90000.29110103.68312078.2a9510a6.5444a=
125.145054bf.ef80714f.81808140.814f810f.95009040.b3002139.9030621a.274068b0=
.3600ea40.1100001c.000000ff.00303538.38314d37.41353136.38380000.00fd0037.4b=
1e5011.000a2020.20202020.000000fc.00504c32.32303157.0a202020.2020004a
            #video-channels:  00000002
            plink-mfg:  00000001
            plink-dev:  00000006
            plink-rev:  00000000
            daughtercard-present: =20
            encoder-id:  00000002
            3dram64-id:  01c08000.01c08000.01c08000.01c08000.01c08000.01c08=
000.01c08000.01c08000.01c08000.01c08000.01c08000.01c08000.01c08000.01c08000=
.01c08000.01c08000
            3dram64-config:  00000010
            xchip-id:  00000001
            fbc3-sdram-size:  10000000
            fbc3-id:  00000002
            cafe-id:  00001101
            cafe-mcode:  00000013
            cafe-rdram-size:  02000000
            cafe-rdram-id:  ffffffff.ffffffff.ffffffff.ffffffff
            board-type:  00000002
            upa-interrupt-slave: =20
            interrupts:  00000005
            upa-portid:  00000000
            reg:  000001c0.00000000.00000000.00040000.000001c0.00200000.000=
00000.00002000.000001c0.00210000.00000000.00002000.000001c0.00300000.000000=
00.00020000.000001c0.00806000.00000000.00002000.000001c0.00828000.00000000.=
00018000.000001c0.04000000.00000000.04000000.000001c0.08000000.00000000.080=
00000.000001c0.70000000.00000000.10000000
            version: '@(#) gfb.fth 1.15 02/01/28 '
            device-name: 'Sun XVR-1000 Graphics Accelerator, model D256'
            sunw,lpm-ranges:  00000019.00000019.0000001e.00000021.00000023.=
00000033.00000028.0000003f
            device_type: 'display'
            model: 'SUNW,501-5865'
            name: 'SUNW,gfb'

    Node 0xf007d244
        .node:  f007d244
        portid:  00000008
        reg:  00000400.04410050.00000000.00000008
        compatible:  6770322d.70706d00.73706d00
        name: 'ppm'


--=-GEsQZ62Tknh68sbo+e/E--

