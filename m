From: Frans van Berckel <fberckel@xs4all.nl>
Date: Sun, 04 Apr 2010 07:45:13 +0000
Subject: Re: Kernel panic - not syncing: Irrecoverable deferred error trap
Message-Id: <1270367114.2030.6.camel@deblnxsrv254.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-vGGi9/ePmdCDEPm4KEnp"
List-Id: <sparclinux.vger.kernel.org>
References: <1270240845.1783.52.camel@deblnxsrv254.localdomain>
In-Reply-To: <1270240845.1783.52.camel@deblnxsrv254.localdomain>
To: sparclinux@vger.kernel.org


--=-vGGi9/ePmdCDEPm4KEnp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Good new, it boots ... attaching 

xvr-1200-booting-now.txt
prtconf-pv+sb2000+xvr1000+xvr1200.txt


Thanks!


On Sat, 2010-04-03 at 15:12 -0700, David Miller wrote:
> From: Frans van Berckel <fberckel@xs4all.nl>
> Date: Sat, 03 Apr 2010 17:13:46 +0200
> 
> > On Sat, 2010-04-03 at 01:16 -0700, David Miller wrote:
> >> Out of curiosity do you have multiple monitors hooked up to the
> >> XVR-1200 device, or just one?
> > 
> > Ahhh ahhm ... choose a other option, non monitors is hooked up.
> 
> Ok, so the device node we need to ignore seems to show up
> on any card that supports multihead at all, regardless of
> whether there are monitors attached to the inputs.
> 
> And this set of cards would include at least the XVR-1200
> 
> >> I bet this might explain the XVR-600 failures I could not reproduce,
> >> as seen by Paul Cao, CC:'d.  Paul if you had two monitors hooked up to
> >> your XVR-600, try next time installing with just one monitor attached.
> >> 
> >> Frans, if you could test the patch below I'd really appreciate it.
> > 
> > Gonna do this compile run next. Just a 2.6.26 or 2.6.34?
> 
> It doesn't matter, either way works to test this fix.
> 
> Thanks again.

--=-vGGi9/ePmdCDEPm4KEnp
Content-Disposition: attachment; filename="prtconf-pv+sb2000+xvr1000+xvr1200.txt"
Content-Type: text/plain; name="prtconf-pv+sb2000+xvr1000+xvr1200.txt"; charset="UTF-8"
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
        stdout:  fff199d0
        stdin:  fff19ea0
        stdout-#lines:  ffffffff
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
        #power-cycles: '189'
        diag-script: 'none'
        diag-level: 'min'
        diag-switch?: 'false'
        error-reset-recovery: 'boot'
        name: 'options'

    Node 0xf002d0dc
        .node:  f002d0dc
        screen: '/upa@8,480000/SUNW,gfb@0,0'
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
        available:  00000000.7fe60000.00000000.0001e000.00000000.7fda8000.0=
0000000.000a8000.00000000.7f000000.00000000.00da4000.00000000.00000000.0000=
0000.7effe000
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
ff22000.00000000.00004000.80000000.7ff280b6.00000000.fff18000.00000000.0000=
4000.80000000.7fda40b6.00000000.fff0e000.00000000.0000a000.80000000.7fe920b=
6.00000000.fff0c000.00000000.00002000.800007fe.7e40008e.00000000.fff08000.0=
0000000.00002000.80000000.7ff660b6.00000000.fef7e000.00000000.00042000.8000=
0000.7fee40b6.00000000.fef6e000.00000000.00010000.800007f8.0083008e.0000000=
0.feef0000.00000000.00010000.80000400.0470008e.00000000.feeee000.00000000.0=
0002000.80000400.0441008e.00000000.feeec000.00000000.00002000.80000400.0440=
008e.00000000.feee8000.00000000.00004000.80000000.7ff4c0b6.00000000.feed600=
0.00000000.00010000.80000400.0460008e.00000000.feed4000.00000000.00002000.8=
0000400.0441008e.00000000.feed2000.00000000.00002000.80000400.0440008e.0000=
0000.feece000.00000000.00004000.80000000.7ff480b6.00000000.f00d6000.0000000=
0.00002000.80000000.7fe820b6.00000000.f00d4000.00000000.00002000.80000000.7=
fe880b6.00000000.f00d2000.00000000.00002000.80000000.7fe8a0b6.00000000.f00d=
0000.00000000.00002000.80000000.7fe8c0b6.00000000.f00ce000.00000000.0000200=
0.80000000.7fe8e0b6.00000000.f00cc000.00000000.00002000.80000000.7fe900b6.0=
0000000.f00ca000.00000000.00002000.80000000.7fe9e0b6.00000000.f00c8000.0000=
0000.00002000.80000000.7fea00b6.00000000.f00c6000.00000000.00002000.8000000=
0.7fe9c0b6.00000000.f00c4000.00000000.00002000.80000000.7fea40b6.00000000.f=
00c2000.00000000.00002000.80000000.7fea60b6.00000000.f00c0000.00000000.0000=
2000.80000000.7fea20b6.00000000.f00be000.00000000.00002000.80000000.7feac0b=
6.00000000.f00bc000.00000000.00002000.80000000.7feae0b6.00000000.f00ba000.0=
0000000.00002000.80000000.7fea80b6.00000000.f00b8000.00000000.00002000.8000=
0000.7feaa0b6.00000000.f00b6000.00000000.00002000.80000000.7feb40b6.0000000=
0.f00b4000.00000000.00002000.80000000.7feb00b6.00000000.f00b2000.00000000.0=
0002000.80000000.7feb20b6.00000000.f00b0000.00000000.00002000.80000000.7feb=
c0b6.00000000.f00ae000.00000000.00002000.80000000.7febe0b6.00000000.f00ac00=
0.00000000.00002000.80000000.7feba0b6.00000000.f00aa000.00000000.00002000.8=
0000000.7fec00b6.00000000.f00a8000.00000000.00002000.80000000.7fec20b6.0000=
0000.f00a6000.00000000.00002000.80000000.7fec40b6.00000000.f00a4000.0000000=
0.00002000.80000000.7fed60b6.00000000.f00a2000.00000000.00002000.80000000.7=
fed80b6.00000000.f00a0000.00000000.00002000.80000000.7feda0b6.00000000.f009=
e000.00000000.00002000.80000000.7fedc0b6.00000000.f009c000.00000000.0000200=
0.80000000.7fede0b6.00000000.f009a000.00000000.00002000.80000000.7fee00b6.0=
0000000.f0098000.00000000.00002000.80000000.7fee20b6.00000000.f0096000.0000=
0000.00002000.80000000.7ff260b6.00000000.f0094000.00000000.00002000.8000000=
0.7ff2c0b6.00000000.f0092000.00000000.00002000.80000000.7ff2e0b6.00000000.f=
0090000.00000000.00002000.80000000.7ff300b6.00000000.f008e000.00000000.0000=
2000.80000000.7ff320b6.00000000.f008c000.00000000.00002000.80000000.7ff340b=
6.00000000.f008a000.00000000.00002000.80000000.7ff560b6.00000000.f0088000.0=
0000000.00002000.80000000.7ff380b6.00000000.f0084000.00000000.00004000.8000=
0000.7ff3a0b6.00000000.f0082000.00000000.00002000.80000000.7ff3e0b6.0000000=
0.f0080000.00000000.00002000.80000000.7ff440b6.00000000.f0000000.00000000.0=
0080000.80000000.7ff800b6.00000000.41286000.00000000.02d7a000.80000000.0168=
6036.00000000.40000000.00000000.00c00000.80000000.00400036.00000000.0000200=
0.00000000.009fe000.80000000.00002036
        existing:  00000000.00000000.00000800.00000000.fffff800.00000000.00=
000800.00000000
        available:  fffff800.00000000.000007fc.00000000.00000001.00000000.0=
00007ff.00000000.00000000.ffff0000.00000000.0000e000.00000000.00000000.0000=
0000.f0000000.00000000.fff1c000.00000000.00006000.00000000.fff0a000.0000000=
0.00002000.00000000.fff00000.00000000.00008000.00000000.fefc0000.00000000.0=
0040000.00000000.fef00000.00000000.0006e000.00000000.feee6000.00000000.0000=
2000.00000000.f0800000.00000000.0e6ce000
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
0000000.0012e000.00000000.00002000.82000000.00000000.00160000.00000000.002a=
0000.82000000.00000000.04000000.00000000.04000000.82000000.00000000.1000000=
0.00000000.6c000000
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

        Node 0xf00ba9dc
            .node:  f00ba9dc
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

            Node 0xf00bf010
                .node:  f00bf010
                device_type: 'block'
                compatible: 'sd'
                name: 'disk'

            Node 0xf00bfb98
                .node:  f00bfb98
                device_type: 'byte'
                compatible: 'st'
                name: 'tape'

        Node 0xf00c08fc
            .node:  f00c08fc
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

            Node 0xf00c4f30
                .node:  f00c4f30
                device_type: 'block'
                compatible: 'sd'
                name: 'disk'

            Node 0xf00c5ab8
                .node:  f00c5ab8
                device_type: 'byte'
                compatible: 'st'
                name: 'tape'

        Node 0xf00c681c
            .node:  f00c681c
            assigned-addresses:  82001010.00000000.08000000.00000000.080000=
00.82001014.00000000.00140000.00000000.00020000.82001018.00000000.02000000.=
00000000.02000000.82001030.00000000.00130000.00000000.00010000
            s-fru-len:  00000800
            s-fru-offset:  0000f400
            s-fru-dev: 'fcode-prom'
            version: '@(#)jfb.fth 1.10 03/04/03 SMI '
            reg:  00001000.00000000.00000000.00000000.00000000.42001010.000=
00000.00000000.00000000.08000000.02001014.00000000.00000000.00000000.000200=
00.42001018.00000000.00000000.00000000.02000000
            monitor_mode:  00000005
            v_freq:  00000042
            height:  00000384
            width:  00000480
            edid_data:  00000000.00000000.00000000.00000000.00000000.000000=
00.00000000.00000000.00000000.00000000.00000000.00000000.00000000.00000000.=
00000000.00000000.00000000.00000000.00000000.00000000.00000000.00000000.000=
00000.00000000.00000000.00000000.00000000.00000000.00000000.00000000.000000=
00.00000000
            no_edid_blks:  00000000
            dev-comm:  fff0f2e8
            device_type: 'display'
            model: 'SUNW,375-3101'
            name: 'SUNW,XVR-1200'
            fcode-rom-offset:  00000000
            66mhz-capable: =20
            fast-back-to-back: =20
            devsel-speed:  00000001
            class-code:  00038000
            interrupts:  00000001
            latency-timer:  00000040
            cache-line-size:  00000010
            max-latency:  00000000
            min-grant:  00000000
            subsystem-id:  00001044
            subsystem-vendor-id:  00003d3d
            revision-id:  00000001
            device-id:  000007a2
            vendor-id:  00003d3d

        Node 0xf00d5e0c
            .node:  f00d5e0c
            assigned-addresses:  82001110.00000000.0012c000.00000000.000020=
00
            reg:  00001100.00000000.00000000.00000000.00000000.02001110.000=
00000.00000000.00000000.00002000
            compatible:  70636933.6433642c.3761322e.33643364.2e313034.342e3=
100.70636933.6433642c.3761322e.33643364.2e313034.34007063.69336433.642c3130=
.34340070.63693364.33642c37.61322e31.00706369.33643364.2c376132.00706369.63=
6c6173.732c3033.38303030.00706369.636c6173.732c3033.383000
            name: 'display'
            66mhz-capable: =20
            fast-back-to-back: =20
            devsel-speed:  00000001
            class-code:  00038000
            latency-timer:  00000000
            cache-line-size:  00000000
            max-latency:  00000000
            min-grant:  00000000
            subsystem-id:  00001044
            subsystem-vendor-id:  00003d3d
            revision-id:  00000001
            device-id:  000007a2
            vendor-id:  00003d3d

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


--=-vGGi9/ePmdCDEPm4KEnp
Content-Disposition: attachment; filename="xvr-1200-booting-now.txt"
Content-Type: text/plain; name="xvr-1200-booting-now.txt"; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sun Blade 2000/1000 (UltraSPARC-III+) , No Keyboard
Copyright 1998-2002 Sun Microsystems, Inc.  All rights reserved.
OpenBoot 4.5, 2048 MB memory installed, Serial #56329931.
Ethernet address 0:3:ba:5b:86:cb, Host ID: 835b86cb.

Initializing Memory=0D                                                     =
                =20=0DInitializing Memory=0D                               =
                                      =20=0DInitializing Memory=0D         =
                                                            =20=0DRebooting=
 with command: boot
Boot device: disk  File and args:=20
SILO Version 1.4.14
boot:=20
Linux                    LinuxOLD                 LinuxSda2               =20
LinuxSda2OLD             LinuxSerial              LinuxSda2Serial         =20
boot: LinuxSda2Serial
Allocated 64 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 2.6.26
Loading initial ramdisk (6820903 bytes at 0x7F000000 phys, 0x40C00000 virt)=
...
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.5.21 2003/02/24 17:23'
[    0.000000] PROMLIB: Root node compatible:=20
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.26-2-sparc64 (Debian 2.6.26-21) (dannf@deb=
ian.org) (gcc version 4.1.3 20080704 (prerelease) (Debian 4.1.2-25)) #1 Sun=
 Apr 4 00:31:15 CEST 2010
[    0.000000] console [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:5b:86:cb
[    0.000000] Kernel: Using 1 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@8,700000/ebus@5/serial@1,400000:a
[    0.000000] PROM: Built device tree with 69704 bytes of memory.
[    0.000000] Top of RAM: 0x7fe7e000, Total RAM: 0x7fe68000
[    0.000000] Memory hole size: 0MB
[    0.000000] [0000000200000000-fffff80000800000] page_structs=3D131072 no=
de=3D0 entry=3D0/0
[    0.000000] [0000000200000000-fffff80000c00000] page_structs=3D131072 no=
de=3D0 entry=3D1/0
[    0.000000] [0000000200700000-fffff80001000000] page_structs=3D131072 no=
de=3D0 entry=3D2/0
[    0.000000] [0000000200700000-fffff80001400000] page_structs=3D131072 no=
de=3D0 entry=3D3/0
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal          0 ->   261951
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[4] active PFN ranges
[    0.000000]     0:        0 ->   260095
[    0.000000]     0:   260096 ->   261842
[    0.000000]     0:   261844 ->   261928
[    0.000000]     0:   261936 ->   261951
[    0.000000] Booting Linux...
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 260149
[    0.000000] Kernel command line: root=3D/dev/sda2 ro of_debug=3D1 ofpci_=
debug=3D1 console=3Dtty0 console=3DttyS0,9600n8
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] clocksource: mult[c80000] shift[16]
[    0.000000] clockevent: mult[147ae14] shift[32]
[   84.161156] Console: colour dummy device 80x25
[   84.214247] console [tty0] enabled
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.5.21 2003/02/24 17:23'
[    0.000000] PROMLIB: Root node compatible:=20
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.26-2-sparc64 (Debian 2.6.26-21) (dannf@deb=
ian.org) (gcc version 4.1.3 20080704 (prerelease) (Debian 4.1.2-25)) #1 Sun=
 Apr 4 00:31:15 CEST 2010
[    0.000000] console [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:5b:86:cb
[    0.000000] Kernel: Using 1 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@8,700000/ebus@5/serial@1,400000:a
[    0.000000] PROM: Built device tree with 69704 bytes of memory.
[    0.000000] Top of RAM: 0x7fe7e000, Total RAM: 0x7fe68000
[    0.000000] Memory hole size: 0MB
[    0.000000] [0000000200000000-fffff80000800000] page_structs=3D131072 no=
de=3D0 entry=3D0/0
[    0.000000] [0000000200000000-fffff80000c00000] page_structs=3D131072 no=
de=3D0 entry=3D1/0
[    0.000000] [0000000200700000-fffff80001000000] page_structs=3D131072 no=
de=3D0 entry=3D2/0
[    0.000000] [0000000200700000-fffff80001400000] page_structs=3D131072 no=
de=3D0 entry=3D3/0
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal          0 ->   261951
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[4] active PFN ranges
[    0.000000]     0:        0 ->   260095
[    0.000000]     0:   260096 ->   261842
[    0.000000]     0:   261844 ->   261928
[    0.000000]     0:   261936 ->   261951
[    0.000000] Booting Linux...
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 260149
[    0.000000] Kernel command line: root=3D/dev/sda2 ro of_debug=3D1 ofpci_=
debug=3D1 console=3Dtty0 console=3DttyS0,9600n8
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] clocksource: mult[c80000] shift[16]
[    0.000000] clockevent: mult[147ae14] shift[32]
[   84.161156] Console: colour dummy device 80x25
[   84.214247] console [tty0] enabled
[   86.399342] Dentry cache hash table entries: 262144 (order: 8, 2097152 b=
ytes)
[   86.485589] Inode-cache hash table entries: 131072 (order: 7, 1048576 by=
tes)
[   86.628609] Memory: 2064288k available (2592k kernel code, 944k data, 17=
6k init) [fffff80000000000,000000007fe7e000]
[   86.832811] Calibrating delay using timer specific routine.. 9.98 BogoMI=
PS (lpj=3D19973)
[   86.925939] Security Framework initialized
[   86.974792] SELinux:  Disabled at boot.
[   87.020616] Capability LSM initialized
[   87.065433] Mount-cache hash table entries: 512
[   87.119980] Initializing cgroup subsys ns
[   87.167495] Initializing cgroup subsys cpuacct
[   87.220609] Initializing cgroup subsys devices
[   87.274444] net_namespace: 1208 bytes
[   87.317977] NET: Registered protocol family 16
[   87.372495] /memory reg[0] -> 0
[   87.408548] /SUNW,UltraSPARC-III+@0,0 reg[0] -> 40000000000
[   87.475105] /memory-controller@0,400000 reg[0] -> 40000400000
[   87.543845] /pci@8,700000 reg[0] -> 40004700000
[   87.597944] /pci@8,700000 reg[1] -> 40004410000
[   87.652072] /pci@8,700000 reg[2] -> 7ffee000000
[   87.706463] /pci@8,700000/ebus@5/flashprom@0,0 reg[0] -> 7fe7d000000
[   87.782389] /pci@8,700000/ebus@5/bbc@1,0 reg[0] -> 7fe7e000000
[   87.852190] /pci@8,700000/ebus@5/ppm@1,e reg[0] -> 7fe7e00000e
[   87.921876] /pci@8,700000/ebus@5/ppm@1,e reg[1] -> 7fe7e728000
[   87.991672] /pci@8,700000/ebus@5/ppm@1,e reg[2] -> 7fe7e30002e
[   88.061456] /pci@8,700000/ebus@5/ppm@1,e reg[3] -> 7fe7e300600
[   88.131348] /pci@8,700000/ebus@5/i2c@1,2e reg[0] -> 7fe7e00002e
[   88.202088] /pci@8,700000/ebus@5/i2c@1,2e reg[1] -> 7fe7e00002d
[   88.273019] /pci@8,700000/ebus@5/i2c@1,2e/dimm-fru@1,a0 reg[0] -> 100000=
0a0
[   88.356352] /pci@8,700000/ebus@5/i2c@1,2e/dimm-fru@1,a4 reg[0] -> 100000=
0a4
[   88.439682] /pci@8,700000/ebus@5/i2c@1,2e/dimm-fru@1,a8 reg[0] -> 100000=
0a8
[   88.523016] /pci@8,700000/ebus@5/i2c@1,2e/dimm-fru@1,ac reg[0] -> 100000=
0ac
[   88.606353] /pci@8,700000/ebus@5/i2c@1,2e/nvram@0,a0 reg[0] -> a0
[   88.679266] /pci@8,700000/ebus@5/i2c@1,2e/idprom@0,a0 reg[0] -> a0
[   88.753234] /pci@8,700000/ebus@5/i2c@1,30 reg[0] -> 7fe7e000030
[   88.824074] /pci@8,700000/ebus@5/i2c@1,30/cpu-fru@0,a0 reg[0] -> a0
[   88.899064] /pci@8,700000/ebus@5/i2c@1,30/temperature@0,52 reg[0] -> 52
[   88.978226] /pci@8,700000/ebus@5/i2c@1,30/fan-control@0,48 reg[0] -> 48
[   89.057398] /pci@8,700000/ebus@5/i2c@1,30/card-reader@0,40 reg[0] -> 40
[   89.136566] /pci@8,700000/ebus@5/i2c@1,30/motherboard-fru@0,a8 reg[0] ->=
 a8
[   89.219898] /pci@8,700000/ebus@5/i2c@1,30/i2c-bridge@0,60 reg[0] -> 60
[   89.298027] /pci@8,700000/ebus@5/beep@1,32 reg[0] -> 7fe7e000032
[   89.369911] /pci@8,700000/ebus@5/audio@1,200000 reg[0] -> 7fe7e200000
[   89.446892] /pci@8,700000/ebus@5/audio@1,200000 reg[1] -> 7fe7e702000
[   89.523978] /pci@8,700000/ebus@5/audio@1,200000 reg[2] -> 7fe7e704000
[   89.601056] /pci@8,700000/ebus@5/audio@1,200000 reg[3] -> 7fe7e722000
[   89.678254] /pci@8,700000/ebus@5/rtc@1,300070 reg[0] -> 7fe7e300070
[   89.753247] /pci@8,700000/ebus@5/gpio@1,300600 reg[0] -> 7fe7e300600
[   89.829295] /pci@8,700000/ebus@5/pmc@1,300700 reg[0] -> 7fe7e300700
[   89.904286] /pci@8,700000/ebus@5/floppy@1,3023f0 reg[0] -> 7fe7e3023f0
[   89.982320] /pci@8,700000/ebus@5/floppy@1,3023f0 reg[1] -> 7fe7e706000
[   90.060436] /pci@8,700000/ebus@5/floppy@1,3023f0 reg[2] -> 7fe7e720000
[   90.138674] /pci@8,700000/ebus@5/parallel@1,300278 reg[0] -> 7fe7e300278
[   90.218774] /pci@8,700000/ebus@5/parallel@1,300278 reg[1] -> 7fe7e30002e
[   90.298985] /pci@8,700000/ebus@5/parallel@1,300278 reg[2] -> 7fe7e700000
[   90.379298] /pci@8,700000/ebus@5/serial@1,400000 reg[0] -> 7fe7e400000
[   90.457427] /pci@8,700000/network@5,1 reg[0] -> 7fe00100000
[   90.523988] /pci@8,700000/network@5,1 reg[1] -> 7fe00400000
[   90.590757] /pci@8,700000/firewire@5,2 reg[0] -> 7fe00120000
[   90.658359] /pci@8,700000/firewire@5,2 reg[1] -> 7fe00122000
[   90.726071] /pci@8,700000/firewire@5,2 reg[2] -> 7fe00800000
[   90.793888] /pci@8,700000/usb@5,3 reg[0] -> 7fe01000000
[   90.856278] /pci@8,700000/usb@5,3 reg[1] -> 7fe00c00000
[   90.918887] /pci@8,700000/scsi@6 reg[0] -> 7ffef000300
[   90.980237] /pci@8,700000/scsi@6 reg[1] -> 7fe00124000
[   91.041696] /pci@8,700000/scsi@6 reg[2] -> 7fe00126000
[   91.103447] /pci@8,700000/scsi@6,1 reg[0] -> 7ffef000400
[   91.166699] /pci@8,700000/scsi@6,1 reg[1] -> 7fe00128000
[   91.230241] /pci@8,700000/scsi@6,1 reg[2] -> 7fe0012a000
[   91.294079] /pci@8,700000/SUNW,XVR-1200@2 reg[0] -> 7fe08000000
[   91.364618] /pci@8,700000/SUNW,XVR-1200@2 reg[1] -> 7fe00140000
[   91.435455] /pci@8,700000/SUNW,XVR-1200@2 reg[2] -> 7fe02000000
[   91.506282] /pci@8,700000/SUNW,XVR-1200@2 reg[3] -> 7fe00130000
[   91.577228] /pci@8,700000/display@2,1 reg[0] -> 7fe0012c000
[   91.643886] /pci@8,600000 reg[0] -> 40004600000
[   91.697957] /pci@8,600000 reg[1] -> 40004410000
[   91.752113] /pci@8,600000 reg[2] -> 7ffec000000
[   91.806418] /pci@8,600000/SUNW,qlc@4 reg[0] -> 7ffed000300
[   91.871914] /pci@8,600000/SUNW,qlc@4 reg[1] -> 7fd00100000
[   91.937541] /pci@8,600000/SUNW,qlc@4 reg[2] -> 7fd00120000
[   92.003269] /pci@8,600000/SUNW,qlc@4/fp@0,0 reg[0] -> 0
[   92.065858] /upa@8,480000 reg[0] -> 40004480000
[   92.119833] /upa@8,480000 reg[1] -> 40004706000
[   92.173993] /upa@8,480000 reg[2] -> 40004708000
[   92.228274] /upa@8,480000/SUNW,gfb@0,0 reg[0] -> 7f800000000
[   92.295875] /upa@8,480000/SUNW,gfb@0,0 reg[1] -> 7f800200000
[   92.363588] /upa@8,480000/SUNW,gfb@0,0 reg[2] -> 7f800210000
[   92.431292] /upa@8,480000/SUNW,gfb@0,0 reg[3] -> 7f800300000
[   92.498998] /upa@8,480000/SUNW,gfb@0,0 reg[4] -> 7f800806000
[   92.566707] /upa@8,480000/SUNW,gfb@0,0 reg[5] -> 7f800828000
[   92.634417] /upa@8,480000/SUNW,gfb@0,0 reg[6] -> 7f804000000
[   92.702125] /upa@8,480000/SUNW,gfb@0,0 reg[7] -> 7f808000000
[   92.769833] /upa@8,480000/SUNW,gfb@0,0 reg[8] -> 7f870000000
[   92.837647] /ppm@8,410050 reg[0] -> 40004410050
[   92.892502] PCI: Probing for controllers.
[   92.939655] /pci@8,700000: SCHIZO PCI Bus Module ver[7:0]
[   93.004216] /pci@8,700000: PCI IO[7ffef000000] MEM[7fe00000000]
[   93.079247] /pci@8,600000: SCHIZO PCI Bus Module ver[7:0]
[   93.142031] /pci@8,600000: PCI IO[7ffed000000] MEM[7fd00000000]
[   93.217008] PCI: Scanning PBM /pci@8,600000
[   93.265395] PCI: scan_bus[/pci@8,600000] bus no 0
[   93.321507]   * /pci@8,600000/SUNW,qlc@4
[   93.368428]     create device, devfn: 20, type: scsi-fcp
[   93.431947]     class: 0x10000 device name: 0001:00:04.0
[   93.495466]     parse addresses (60 bytes) @ fffff8007fe605c0
[   93.564216]   start: 7ffed000300, end: 7ffed0003ff, i: 10
[   93.628797]   start: 7fd00100000, end: 7fd00101fff, i: 14
[   93.693382]   start: 7fd00120000, end: 7fd0013ffff, i: 30
[   93.757965]     adding to system ...
[   93.800681] PCI: dev header type: 0
[   93.842489] PCI: Scanning PBM /pci@8,700000
[   93.892443] PCI: scan_bus[/pci@8,700000] bus no 0
[   93.948600]   * /pci@8,700000/ebus@5
[   93.991313]     create device, devfn: 28, type:=20
[   94.046520]     class: 0x68000 device name: 0000:00:05.0
[   94.110053]     adding to system ...
[   94.152762] PCI: dev header type: 0
[   94.194426]   * /pci@8,700000/network@5,1
[   94.242361]     create device, devfn: 29, type: network
[   94.304857]     class: 0x20000 device name: 0000:00:05.1
[   94.368389]     parse addresses (40 bytes) @ fffff8007fe6a300
[   94.437139]   start: 7fe00100000, end: 7fe0011ffff, i: 10
[   94.501724]   start: 7fe00400000, end: 7fe007fffff, i: 30
[   94.566306]     adding to system ...
[   94.609016] PCI: dev header type: 0
[   94.650681]   * /pci@8,700000/firewire@5,2
[   94.699661]     create device, devfn: 2a, type:=20
[   94.754859]     class: 0xc0010 device name: 0000:00:05.2
[   94.818394]     parse addresses (60 bytes) @ fffff8007fe69140
[   94.887144]   start: 7fe00120000, end: 7fe00121fff, i: 10
[   94.951728]   start: 7fe00122000, end: 7fe00123fff, i: 14
[   95.016312]   start: 7fe00800000, end: 7fe00bfffff, i: 30
[   95.080895]     adding to system ...
[   95.123603] PCI: dev header type: 0
[   95.165270]   * /pci@8,700000/usb@5,3
[   95.209040]     create device, devfn: 2b, type:=20
[   95.264240]     class: 0xc0310 device name: 0000:00:05.3
[   95.327774]     parse addresses (40 bytes) @ fffff8007fe68340
[   95.396524]   start: 7fe01000000, end: 7fe01ffffff, i: 10
[   95.461109]   start: 7fe00c00000, end: 7fe00ffffff, i: 30
[   95.525691]     adding to system ...
[   95.568400] PCI: dev header type: 0
[   95.610066]   * /pci@8,700000/scsi@6
[   95.652791]     create device, devfn: 30, type: scsi-2
[   95.714253]     class: 0x10000 device name: 0000:00:06.0
[   95.777778]     parse addresses (60 bytes) @ fffff8007fe672c0
[   95.846529]   start: 7ffef000300, end: 7ffef0003ff, i: 10
[   95.911112]   start: 7fe00124000, end: 7fe00125fff, i: 14
[   95.975697]   start: 7fe00126000, end: 7fe00127fff, i: 18
[   96.040279]     adding to system ...
[   96.082988] PCI: dev header type: 0
[   96.124654]   * /pci@8,700000/scsi@6,1
[   96.169463]     create device, devfn: 31, type: scsi-2
[   96.230922]     class: 0x10000 device name: 0000:00:06.1
[   96.294451]     parse addresses (60 bytes) @ fffff8007fe65a80
[   96.363202]   start: 7ffef000400, end: 7ffef0004ff, i: 10
[   96.427784]   start: 7fe00128000, end: 7fe00129fff, i: 14
[   96.492369]   start: 7fe0012a000, end: 7fe0012bfff, i: 18
[   96.556951]     adding to system ...
[   96.599661] PCI: dev header type: 0
[   96.641326]   * /pci@8,700000/SUNW,XVR-1200@2
[   96.693433]     create device, devfn: 10, type: display
[   96.755938]     class: 0x38000 device name: 0000:00:02.0
[   96.819457]     parse addresses (80 bytes) @ fffff8007fe64200
[   96.888206]   start: 7fe08000000, end: 7fe0fffffff, i: 10
[   96.952790]   start: 7fe00140000, end: 7fe0015ffff, i: 14
[   97.017374]   start: 7fe02000000, end: 7fe03ffffff, i: 18
[   97.081959]   start: 7fe00130000, end: 7fe0013ffff, i: 30
[   97.146540]     adding to system ...
[   97.189250] PCI: dev header type: 0
[   97.230916]   * /pci@8,700000/display@2,1
[   97.278854]     create device, devfn: 11, type:=20
[   97.334059]     class: 0x38000 device name: 0000:00:02.1
[   97.397588]     parse addresses (20 bytes) @ fffff8007fe62840
[   97.466338]   start: 7fe0012c000, end: 7fe0012dfff, i: 10
[   97.530919]     adding to system ...
[   97.573629] PCI: dev header type: 0
[   97.616183] ebus0: [flashprom] [bbc] [ppm] [i2c -> (dimm-fru) (dimm-fru)=
 (dimm-fru) (dimm-fru) (nvram) (idprom)] [i2c -> (cpu-fru) (temperature) (f=
an-control) (card-reader) (motherboard-fru) (i2c-bridge)] [beep] [audio] [r=
tc] [gpio] [pmc] [floppy] [parallel] [serial]
[   97.901613] usbcore: registered new interface driver usbfs
[   97.965705] usbcore: registered new interface driver hub
[   98.029205] usbcore: registered new device driver usb
[   98.101602] /pci@8,700000/ebus@5/rtc@1,300070: Clock regs at 000007fe7e3=
00070
[   98.186328] NET: Registered protocol family 2
[   99.269427] IP route cache hash table entries: 65536 (order: 6, 524288 b=
ytes)
[   99.354253] TCP established hash table entries: 262144 (order: 9, 419430=
4 bytes)
[   99.454990] TCP bind hash table entries: 65536 (order: 6, 524288 bytes)
[   99.534102] TCP: Hash tables configured (established 262144 bind 65536)
[   99.611782] TCP reno registered
[   99.661459] NET: Registered protocol family 1
[   99.712112] checking if image is initramfs... it is
[  101.062796] Freeing initrd memory: 6661k freed
[  101.114850] Mini RTC Driver
[  101.147789] /memory-controller@0,400000: US3 memory controller at 000004=
0000400000 [ACTIVE]
[  101.248187] audit: initializing netlink socket (disabled)
[  101.312147] type=3D2000 audit(1270365500.266:1): initialized
[  101.378196] Total HugeTLB memory allocated, 0
[  101.430082] VFS: Disk quotas dquot_6.5.1
[  101.476851] Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
[  101.555004] msgmni has been set to 4046
[  101.601033] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 253)
[  101.689214] io scheduler noop registered
[  101.736072] io scheduler anticipatory registered
[  101.791280] io scheduler deadline registered
[  101.842350] io scheduler cfq registered (default)
[  101.899554] e3d: Found device at 0000:00:02.0
[  102.061938] Console: switching to colour frame buffer device 144x56
[  102.238738] e3d: Ignoring secondary output device at 0000:00:02.1
[  102.318299] [drm] Initialized drm 1.1.0 20060810
[  102.373008] f0086c30: ttyS0 at MMIO 0x7fe7e400000 (irq =3D 12) is a SAB8=
2532 V3.2
[  102.460433] Console: ttyS0 (SAB82532)=8D+=02=8A=82=92r=AA=82=9A=B2=9A=B2=
=EA=81console handover: boot [earlyprom0] -> real [ttyS0]
[  102.573722] f0086c30: ttyS1 at MMIO 0x7fe7e400040 (irq =3D 12) is a SAB8=
2532 V3.2
[  102.665742] brd: module loaded
[  102.703273] loop: module loaded
[  102.740400] Uniform Multi-Platform E-IDE driver
[  102.794713] ide: Assuming 33MHz system bus speed for PIO modes; override=
 with idebus=3Dxx
[  102.891473] mice: PS/2 mouse device common for all mice
[  102.954385] usbcore: registered new interface driver usbhid
[  103.020966] usbhid: v2.6:USB HID core driver
[  103.072885] TCP cubic registered
[  103.110965] NET: Registered protocol family 17
[  103.164638] registered taskstats version 1
[  103.213592] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Loading, please wait...
Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... [  104.088191] sungem.c:v0.98 8/2=
4/03 David S. Miller (davem@redhat.com)
[  104.167070] eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:ba:5b:86=
:cb
[  104.250541] eth0: Found Generic MII PHY
[  104.370526] SCSI subsystem initialized
[  104.417207] ohci_hcd 0000:00:05.3: OHCI Host Controller
[  104.479872] ohci_hcd 0000:00:05.3: new USB bus registered, assigned bus =
number 1
[  104.568688] ohci_hcd 0000:00:05.3: irq 15, io mem 0x7fe01000000
[  104.674913] QLogic Fibre Channel HBA Driver: 8.02.01-k4
[  104.746808] qla2xxx 0001:00:04.0: Found an ISP2200, irq 21, iobase 0x000=
007fd00100000
[  104.861710] qla2xxx 0001:00:04.0: Configuring PCI space...
[  104.948584] qla2xxx 0001:00:04.0: Configure NVRAM parameters...
[  105.135121] qla2xxx 0001:00:04.0: Inconsistent NVRAM detected: checksum=
=3D0x0 id=3D<4>qla2xxx 0001:00:04.0: Falling back to functioning (yet inval=
id -- WWPN) defaults.
[  105.358322] qla2xxx 0001:00:04.0: Verifying loaded RISC code...
[  105.461170] usb usb1: configuration #1 chosen from 1 choice
[  105.554172] hub 1-0:1.0: USB hub found
[  105.625577] hub 1-0:1.0: 4 ports detected
[  105.701208] firmware: requesting ql2200_fw.bin
[  105.801563] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[  105.911496] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[  106.027282] usb usb1: Product: OHCI Host Controller
[  106.115420] usb usb1: Manufacturer: Linux 2.6.26-2-sparc64 ohci_hcd
[  106.221085] usb usb1: SerialNumber: 0000:00:05.3
[  106.359744] ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=3D[14]  MMIO=3D=
[7fe00120000-7fe001207ff]  Max Packet=3D[2048]  IR/IT contexts=3D[4/4]
[  106.653500] eth0: Link is up at 100 Mbps, full-duplex.
[  117.393347] qla2xxx 0001:00:04.0: Allocated (252 KB) for firmware dump..=
.
[  117.637298] qla2xxx 0001:00:04.0: LIP reset occured (f8e8).
[  117.753326] qla2xxx 0001:00:04.0: LIP occured (f8e8).
[  117.849859] qla2xxx 0001:00:04.0: LOOP UP detected (1 Gbps).
[  117.954043] scsi0 : qla2xxx
[  118.025161] qla2xxx 0001:00:04.0:=20
[  118.025164]  QLogic Fibre Channel HBA Driver: 8.02.01-k4
[  118.025168]   QLogic QLA22xx -=20
[  118.025170]   ISP2200: PCI (66 MHz) @ 0001:00:04.0 hdma-, host#=3D0, fw=
=3D2.02.08 TP
[  118.407176] sym0: <875> rev 0x37 at pci 0000:00:06.0 irq 16
[  118.599908] sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
[  118.714579] sym0: SCSI BUS has been reset.
[  118.800973] scsi1 : sym-2.2.3
[  118.876585] sym1: <875> rev 0x37 at pci 0000:00:06.1 irq 17
[  119.068033] sym1: No NVRAM, ID 7, Fast-20, SE, parity checking
[  119.181742] sym1: SCSI BUS has been reset.
[  119.267515] scsi2 : sym-2.2.3
[  119.348596] scsi 0:0:0:0: Direct-Access     SEAGATE  ST336605FSUN36G  06=
38 PQ: 0 ANSI: 3
[  119.492201] scsi: waiting for bus probes to complete ...
[  123.541579] scsi 1:0:6:0: CD-ROM            TOSHIBA  DVD-ROM SD-M1401 10=
07 PQ: 0 ANSI: 2
[  123.676044]  target1:0:6: Beginning Domain Validation
[  123.773797]  target1:0:6: asynchronous
[  123.873781]  target1:0:6: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
[  123.990409]  target1:0:6: Domain Validation skipping write tests
[  124.099824]  target1:0:6: Ending Domain Validation
[  124.208413] Driver 'sd' needs updating - please use bus_type methods
[  124.327872] sd 0:0:0:0: [sda] 71132959 512-byte hardware sectors (36420 =
MB)
[  124.451156] sd 0:0:0:0: [sda] Write Protect is off
[  124.549697] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled=
, supports DPO and FUA
[  124.693912] sd 0:0:0:0: [sda] 71132959 512-byte hardware sectors (36420 =
MB)
[  124.817664] sd 0:0:0:0: [sda] Write Protect is off
[  124.917005] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled=
, supports DPO and FUA
[  125.058368]  sda: sda1 sda2 sda3 sda4 sda5 sda6
[  125.155728] sd 0:0:0:0: [sda] Attached SCSI disk
[  126.909772] Driver 'sr' needs updating - please use bus_type methods
[  127.025493] sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
[  127.137677] Uniform CD-ROM driver Revision: 3.20
[  127.269425] sd 0:0:0:0: Attached scsi generic sg0 type 0
[  127.369280] sr 1:0:6:0: Attached scsi generic sg1 type 5
done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top [  1=
28.001415] kjournald starting.  Commit interval 5 seconds
... done.
Begin: Running /scripts[  128.103056] EXT3-fs: mounted filesystem with orde=
red data mode.
/local-premount ... done.
Begin: Running /scripts/local-bottom ... done.
done.
Begin: Running /scripts/init-bottom ... done.
version 2.86 booting
Starting the hotplug events dispatcher: udevd[  129.926913] udevd version 1=
25 started
.
Synthesizing the initial hotplug events...done.
Waiting for /dev to be fully populated...done.
Setting the system clock.
Activating swap...[  132.292898] Adding 891584k swap on /dev/sda4.  Priorit=
y:-1 extents:1 across:891584k
done.
Checking root file system...fsck 1.41.3 (12-Oct-2008)
/dev/sda2: clean, 161734[  132.689822] EXT3 FS on sda2, internal journal
/427392 files, 752399/1708914 blocks
done.
Setting the system clock.
Cleaning up ifupdown....
Loading kernel modules...done.
Checking file systems...fsck 1.41.3 (12-Oct-2008)
/dev/sda1: clean, 50/48192 files, 56331/96390 blocks
/dev/sda6: clean, 70702/1308160 files, 612498/5225140 blocks
done.
Setting kernel variables (/etc/sysctl.conf)...done.
Mounting local filesystems...[  134.009131] kjournald starting.  Commit int=
erval 5 seconds
[  134.123921] EXT3 FS on sda6, internal journal
[  134.211821] EXT3-fs: mounted filesystem with ordered data mode.
done.
Activating swapfile swap...done.
Setting up networking....
Configuring network interfaces...[  134.910017] eth0: Link is up at 100 Mbp=
s, full-duplex.
[  135.007994] eth0: Pause is disabled
done.
Starting portmap daemon....
Starting NFS common utilities: statd.
Setting console screen modes and fonts.
Entering runlevel: 2
Starting enhanced syslogd: rsyslogd.
Starting OpenBSD Secure Shell server: sshd[  137.275131] NET: Registered pr=
otocol family 10
[  137.363448] lo: Disabled Privacy Extensions
.
Starting MTA: exim4.
Starting NFS common utilities: statd.
Not starting internet superserver: no services enabled.
Starting deferred execution scheduler: atd.
Starting periodic command scheduler: crond.

Debian GNU/Linux 5.0 deblnxsrv251 ttyS0

deblnxsrv251 login:

--=-vGGi9/ePmdCDEPm4KEnp--

