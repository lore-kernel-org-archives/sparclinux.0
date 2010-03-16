From: Frans van Berckel <fberckel@xs4all.nl>
Date: Tue, 16 Mar 2010 19:34:50 +0000
Subject: Re: Debian Sparc 5.4 on Sun blade 2500
Message-Id: <1268768091.1768.29.camel@deblnxsrv254.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-0grDSm68sfYIFqPv/anI"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-0grDSm68sfYIFqPv/anI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If I am well your card isn't supported yet. Searching the attachment
it's a XVR 600 true. 

Maybe we can get the XVR 500 driver to do the XVR 600 as well. 

Forwarding this e-mail to the kernel Sparc list. I know kernel developer
David was looking for the XVR 600 information, to check this out.

On Tue, 2010-03-16 at 15:13 -0400, Paul Cao wrote:
> Thanks for the hint. The hardware info is attached. Please see if  
> there is a driver for the video card.
> 
> On Mar 16, 2010, at 3:00 PM, Frans van Berckel wrote:
> 
> > That's okay. I wouldn't ask you to install Solaris, because you are on
> > Debian already now. Installing sparc-utils will help you with a lot of
> > interesting Sparc tools.
> >
> > # sudo apt-get install sparc-utils
> >
> > # prtconf -pv
> >
> > You can save the information in a txt file with.
> >
> > # prtconf -pv >> sun-blade-2500+xvr-600.txt
> >
> > And attach the txt or the information to a e-mail. So we are sure what
> > card is stick into your 2500. It's about the hardware ID's.
> >
> > After that we know what driver will fit your one as best.
> >
> > On Tue, 2010-03-16 at 09:34 -0400, Paul Cao wrote:
> >> I don't have solaris on that machine any longer. Here are some of the
> >> lshw information. It seems that it is recognized as XVR-500 but how
> >> come the display is fuzzy with dark strips vertically all over the
> >> screen?
> >> Thanks.
> >>
> >> On Mar 15, 2010, at 12:55 PM, Frans van Berckel wrote:
> >>
> >>> This looks okay to me, please post your prtconf -pv as well. It's
> >>> about the XVR-600 PCI device ID and machine information.

--=-0grDSm68sfYIFqPv/anI
Content-Disposition: attachment; filename="sun-blade-2500+xvr-600.txt"
Content-Type: text/plain; name="sun-blade-2500+xvr-600.txt"; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

System Configuration:  Sun Microsystems  sun4u
Memory size: 4096 Megabytes
System Peripherals (PROM Nodes):

Node 0xf002a080
    .node:  f002a080
    energystar-v3: =20
    banner-name: 'Sun Blade 2500'
    model: 'SUNW,375-3105'
    idprom:  01830003.ba786c81.000003ba.786c8182.00000000.00000000.00000000=
.00000000
    scsi-initiator-id:  00000007
    stick-frequency:  00b71b00
    clock-frequency:  09896800
    breakpoint-trap:  0000007f
    #size-cells:  00000002
    name: 'SUNW,Sun-Blade-2500'
    device_type: 'jbus'

    Node 0xf002d1ac
        .node:  f002d1ac
        name: 'packages'

        Node 0xf004a050
            .node:  f004a050
            name: 'SUNW,builtin-drivers'

        Node 0xf0059380
            .node:  f0059380
            disk-write-fix: =20
            name: 'deblocker'

        Node 0xf0059864
            .node:  f0059864
            name: 'disk-label'

        Node 0xf005a1b8
            .node:  f005a1b8
            iso6429-1983-colors: =20
            name: 'terminal-emulator'

        Node 0xf0061e44
            .node:  f0061e44
            source: '/flashprom@2,0:'
            name: 'dropins'

        Node 0xf008acb4
            .node:  f008acb4
            name: 'kbd-translator'

        Node 0xf008baa4
            .node:  f008baa4
            name: 'obp-tftp'

        Node 0xf009b42c
            .node:  f009b42c
            name: 'SUNW,i2c-ram-device'

        Node 0xf009bc70
            .node:  f009bc70
            name: 'SUNW,fru-device'

        Node 0xf009c478
            .node:  f009c478
            maximum-reason-length:  000000fa
            name: 'SUNW,asr'

    Node 0xf002d224
        .node:  f002d224
        bootargs:  00
        bootpath: '/pci@1d,700000/scsi@4/disk@0,0:a'
        mmu:  fff74080
        memory:  fff74290
        stdout:  fedab588
        stdin:  fad77e98
        stdout-#lines:  00000022
        name: 'chosen'

    Node 0xf002d298
        .node:  f002d298
        version: 'OBP 4.17.1 2005/04/11 14:24'
        model: 'SUNW,4.17.1'
        aligned-allocator: =20
        relative-addressing: =20
        name: 'openprom'

        Node 0xf002d328
            .node:  f002d328
            name: 'client-services'

    Node 0xf002d3e0
        .node:  f002d3e0
        asr-policy: 'normal'
        test-args: 'none'
        diag-passes: '1'
        local-mac-address?: 'true'
        fcode-debug?: 'false'
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
        auto-boot-on-error?: 'true'
        error-reset-recovery: 'sync'
        load-base: '16384'
        auto-boot?: 'true'
        network-boot-arguments: =20
        boot-command: 'boot'
        diag-file: =20
        diag-device: 'disk net'
        boot-file: =20
        boot-device: '/pci@1d,700000/scsi@4/disk@0,0:a =3D disk cdrom net'
        use-nvramrc?: 'false'
        nvramrc: =20
        security-mode: 'none'
        security-password: =20
        security-#badlogins: '0'
        verbosity: 'min'
        diag-trigger: 'none'
        service-mode?: 'false'
        diag-script: 'normal'
        diag-level: 'max'
        diag-switch?: 'false'
        name: 'options'

    Node 0xf002d458
        .node:  f002d458
        screen: '/pci@1f,700000/SUNW,XVR-600@2'
        keyboard: '/pci@1e,600000/usb@b/keyboard@1'
        mouse: '/pci@1e,600000/usb@a/mouse@1'
        net: '/pci@1c,600000/network@3'
        cdrom: '/pci@1e,600000/ide@d/cdrom@2,0:f'
        ide: '/pci@1e,600000/ide@d'
        disk1: '/pci@1d,700000/scsi@4/disk@1,0'
        disk0: '/pci@1d,700000/scsi@4/disk@0,0'
        disk: '/pci@1d,700000/scsi@4/disk@0,0'
        scsi: '/pci@1d,700000/scsi@4'
        ttyb: '/pci@1e,600000/isa@7/serial@0,2e8'
        ttya: '/pci@1e,600000/isa@7/serial@0,3f8'
        name: 'aliases'

    Node 0xf003fcd8
        .node:  f003fcd8
        reg:  00000000.00000000.00000000.40000000.00000001.00000000.0000000=
0.40000000.00000002.00000000.00000000.40000000.00000003.00000000.00000000.4=
0000000
        available:  00000003.3fd60000.00000000.0001a000.00000003.3f000000.0=
0000000.00d5a000.00000003.00000000.00000000.3effe000.00000002.00000000.0000=
0000.40000000.00000001.00000000.00000000.40000000.00000000.00000000.0000000=
0.40000000
        name: 'memory'

    Node 0xf00402f4
        .node:  f00402f4
        translations:  00000000.00002000.00000000.003fe000.80000000.0000203=
6.00000000.00400000.00000000.00800000.80000003.3f000036.00000000.40000000.0=
0000000.00800000.80000003.3f000036.00000000.f0000000.00000000.00080000.8000=
0003.3ff800b6.00000000.f0080000.00000000.00010000.80000003.3ff200b6.0000000=
0.f0090000.00000000.00010000.80000003.3ff000b6.00000000.f00a0000.00000000.0=
0010000.80000003.3fef00b6.00000000.f00b0000.00000000.00010000.80000003.3fed=
00b6.00000000.f00c0000.00000000.00010000.80000003.3feb00b6.00000000.f00d000=
0.00000000.00010000.80000003.3fd800b6.00000000.f00e0000.00000000.00010000.8=
0000003.3fea00b6.00000000.fac70000.00000000.00002000.80000003.3fd7e0b6.0000=
0000.fac72000.00000000.00002000.80000003.3fd900b6.00000000.fac74000.0000000=
0.00002000.80000003.3fec00b6.00000000.fac76000.00000000.0010e000.80000003.3=
fd920b6.00000000.fad84000.00000000.00020000.800007f7.0010008e.00000000.fada=
4000.00000000.04000000.800007f7.0400008e.00000000.feda4000.00000000.0000800=
0.80000003.3fee80b6.00000000.fedac000.00000000.00002000.80000003.3fec20b6.0=
0000000.fedae000.00000000.00004000.80000003.3fee00b6.00000000.fedb2000.0000=
0000.00004000.80000003.3fec40b6.00000000.fedb6000.00000000.00002000.800007f=
f.0200008e.00000000.fedba000.00000000.00002000.800007fe.0000208e.00000000.f=
edbc000.00000000.00002000.80000003.3ff120b6.00000000.fedbe000.00000000.0000=
2000.80000400.0fe0208e.00000000.fedc0000.00000000.00002000.80000003.3ff1e0b=
6.00000000.fedc2000.00000000.00002000.80000400.0fc6208e.00000000.fedc4000.0=
0000000.00002000.800007fe.0100008e.00000000.fedc6000.00000000.00002000.8000=
0003.3ff400b6.00000000.fedc8000.00000000.00002000.80000003.3effe0b6.0000000=
0.fedca000.00000000.00100000.800007ff.f000008e.00000000.feeca000.00000000.0=
0006000.80000003.3ff160b6.00000000.feed0000.00000000.00002000.800007fe.0100=
008e.00000000.feed2000.00000000.00002000.800007fe.0100008e.00000000.feed400=
0.00000000.00002000.80000003.3ff420b6.00000000.feed6000.00000000.00002000.8=
00007f6.0000008e.00000000.feed8000.00000000.00004000.80000003.3ff300b6.0000=
0000.feedc000.00000000.00008000.80000400.0fc1008e.00000000.feee4000.0000000=
0.00002000.80000400.0fc0008e.00000000.feee6000.00000000.0000c000.80000400.0=
ff0008e.00000000.feef2000.00000000.00002000.80000400.0fc6408e.00000000.feef=
4000.00000000.00004000.80000003.3ff340b6.00000000.feef8000.00000000.0000800=
0.80000400.0f41008e.00000000.fef00000.00000000.00100000.800007ff.f000008e.0=
0000000.fff00000.00000000.00002000.80000400.0f40008e.00000000.fff02000.0000=
0000.0000c000.80000400.0f60008e.00000000.fff0e000.00000000.00002000.800007c=
6.0000208e.00000000.fff10000.00000000.00004000.80000003.3ff380b6.00000000.f=
ff14000.00000000.00008000.80000400.0ec1008e.00000000.fff1c000.00000000.0000=
2000.80000400.0ec0008e.00000000.fff1e000.00000000.0000c000.80000400.0ef0008=
e.00000000.fff2a000.00000000.00002000.800007ce.0000008e.00000000.fff2c000.0=
0000000.00004000.80000003.3ff3c0b6.00000000.fff30000.00000000.00008000.8000=
0400.0e41008e.00000000.fff38000.00000000.00002000.80000400.0e40008e.0000000=
0.fff3a000.00000000.0000c000.80000400.0e60008e.00000000.fff46000.00000000.0=
0002000.80000003.3ff440b6.00000000.fff48000.00000000.00002000.80000400.0fc6=
408e.00000000.fff4a000.00000000.00002000.800007fe.0000408e.00000000.fff4c00=
0.00000000.00002000.80000003.3ff600b6.00000000.fff4e000.00000000.00002000.8=
00007fe.0000008e.00000000.fff54000.00000000.00016000.80000003.3ff480b6.0000=
0000.fff6a000.00000000.00006000.80000003.3ff620b6.00000000.fff70000.0000000=
0.00010000.80000003.3ff700b6
        existing:  00000000.00000000.00000800.00000000.fffff800.00000000.00=
000800.00000000
        available:  fffff800.00000000.000007fc.00000000.00000001.00000000.0=
00007ff.00000000.00000000.ffff0000.00000000.0000e000.00000000.00000000.0000=
0000.f0000000.00000000.fedb8000.00000000.00002000.00000000.f0800000.0000000=
0.0a470000
        page-size:  00002000
        name: 'virtual-memory'

    Node 0xf0066600
        .node:  f0066600
        clock-divisors:  00000001.00000002.00000020
        clock-frequency: 'LK@'
        manufacturer#:  0000003e
        implementation#:  00000016
        mask#:  00000024
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

    Node 0xf0066d44
        .node:  f0066d44
        memory-control-register-1:  f0000126.3fb01c4e
        memory-layout:  44494d4d.30000000.44494d4d.31000000.44494d4d.320000=
00.44494d4d.33000000.01ff00ff.00ff00ff.0000ff00.ff00ffff.00800000.00000000.=
00005354.5758aeaf.b2b32c02.0406085e.5f626302.0406085e.5f62630c.0d131469.6a6=
d6e0c.0d131469.6a6d6e17.181c1f72.75797b17.181c1f72.75797b21.2327287e.7f8385=
21.2327287e.7f83852c.2d313386.878e9035.37393c92.93969735.37393c92.9396973d.=
40444599.9ba1a23d.40444599.9ba1a248.494f50a5.a6aaab48.494f50a5.a6aaab53.545=
758ae.afb2b300
        compatible:  53554e57.2c556c74.72615350.4152432d.49494969.2c6d6300.=
53554e57.2c6d6300
        portid:  00000000
        reg:  00000400.00000000.00000000.00000008
        device_type: 'memory-controller'
        name: 'memory-controller'

    Node 0xf0066e80
        .node:  f0066e80
        clock-divisors:  00000001.00000002.00000020
        clock-frequency: 'LK@'
        manufacturer#:  0000003e
        implementation#:  00000016
        mask#:  00000024
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
        cpuid:  00000001
        portid:  00000001
        reg:  00000400.00800000.00000000.00010000
        ecache-size:  00100000
        name: 'SUNW,UltraSPARC-IIIi'

    Node 0xf00671a4
        .node:  f00671a4
        memory-control-register-1:  00000000.00000000
        memory-layout:  44494d4d.34000000.44494d4d.35000000.44494d4d.360000=
00.44494d4d.37000000.01ff00ff.00ff00ff.0000ff00.ff00ffff.00800000.00000000.=
00005354.5758aeaf.b2b32c02.0406085e.5f626302.0406085e.5f62630c.0d131469.6a6=
d6e0c.0d131469.6a6d6e17.181c1f72.75797b17.181c1f72.75797b21.2327287e.7f8385=
21.2327287e.7f83852c.2d313386.878e9035.37393c92.93969735.37393c92.9396973d.=
40444599.9ba1a23d.40444599.9ba1a248.494f50a5.a6aaab48.494f50a5.a6aaab53.545=
758ae.afb2b300
        compatible:  53554e57.2c556c74.72615350.4152432d.49494969.2c6d6300.=
53554e57.2c6d6300
        portid:  00000001
        reg:  00000400.00800000.00000000.00000008
        device_type: 'memory-controller'
        name: 'memory-controller'

    Node 0xf00672e0
        .node:  f00672e0
        available:  81000000.00000000.00000900.00000000.0000f700.82000000.0=
0000000.00100000.00000000.00100000.82000000.00000000.00400000.00000000.bfc0=
0000.82000000.00000000.e0000000.00000000.10000000
        reg:  00000400.0e600000.00000000.0000b000.00000400.0e410000.0000000=
0.00007020.000007ce.00000000.00000000.00000100.00000400.0e780000.00000000.0=
0010000
        ranges:  00000000.00000000.00000000.000007ce.00000000.00000000.0100=
0000.01000000.00000000.00000000.000007ce.01000000.00000000.01000000.0200000=
0.00000000.00000000.000007cf.00000000.00000001.00000000.03000000.00000000.0=
0000000.000007cf.00000000.00000001.00000000
        virtual-dma:  c0000000.20000000
        #virtual-dma-size-cells:  00000001
        #virtual-dma-addr-cells:  00000001
        no-streaming-cache: =20
        clock-frequency:  03ef1480
        bus-range:  00000000.00000000
        bus-parity-generated: =20
        no-probe-list: '0'
        compatible: 'pci108e,a801'
        name: 'pci'
        device_type: 'pci'
        #address-cells:  00000003
        #size-cells:  00000002
        implementation#:  00000023
        version#:  00000004
        portid:  0000001c
        ino-bitmap:  f000000f.00170408
        interrupt-map:  00001000.00000000.00000000.00000001.f00672e0.000000=
00.00001000.00000000.00000000.00000002.f00672e0.00000001.00001000.00000000.=
00000000.00000003.f00672e0.00000002.00001000.00000000.00000000.00000004.f00=
672e0.00000003.00001800.00000000.00000000.00000001.f00672e0.0000001c.000018=
00.00000000.00000000.00000002.f00672e0.0000001d.00001800.00000000.00000000.=
00000003.f00672e0.0000001e.00001800.00000000.00000000.00000004.f00672e0.000=
0001f
        interrupt-map-mask:  00fff800.00000000.00000000.00000007
        #interrupt-cells:  00000001
        slot-names:  00000004.50434933.00
        66mhz-capable: =20
        interrupts:  00000032.00000030.00000031.00000034.00000023

        Node 0xf00e4fdc
            .node:  f00e4fdc
            assigned-addresses:  83001810.00000000.00200000.00000000.002000=
00
            compatible:  70636931.3465342c.31363437.2e313038.652e3136.34372=
e30.00706369.31346534.2c313634.372e3130.38652e31.36343700.70636931.3038652c=
.31363437.00706369.31346534.2c313634.372e3000.70636931.3465342c.31363437.00=
706369.636c6173.732c3032.30303030.00706369.636c6173.732c3032.303000
            reg:  00001800.00000000.00000000.00000000.00000000.03001810.000=
00000.00000000.00000000.00200000
            max-frame-size:  00010000
            address-bits:  00000030
            device_type: 'network'
            name: 'network'
            66mhz-capable: =20
            fast-back-to-back: =20
            devsel-speed:  00000001
            class-code:  00020000
            interrupts:  00000001
            latency-timer:  00000040
            cache-line-size:  00000010
            max-latency:  00000000
            min-grant:  00000040
            subsystem-id:  00001647
            subsystem-vendor-id:  0000108e
            revision-id:  00000000
            device-id:  00001647
            vendor-id:  000014e4

    Node 0xf006fdbc
        .node:  f006fdbc
        portid:  0000001c
        reg:  00000400.0e000000.00000000.00000008.00000400.0e410050.0000000=
0.00000010
        compatible: 'jbus-ppm'
        name: 'ppm'

    Node 0xf006feb0
        .node:  f006feb0
        available:  81000000.00000000.00000500.00000000.0000fb00.82000000.0=
0000000.00108000.00000000.bfef8000.82000000.00000000.e0000000.00000000.0000=
0000
        reg:  00000400.0ef00000.00000000.0000b000.00000400.0ec10000.0000000=
0.00007020.000007c6.00000000.00000000.00000100.00000400.0ef80000.00000000.0=
0010000
        ranges:  00000000.00000000.00000000.000007c6.00000000.00000000.0100=
0000.01000000.00000000.00000000.000007c6.01000000.00000000.01000000.0200000=
0.00000000.00000000.000007c7.00000000.00000001.00000000.03000000.00000000.0=
0000000.000007c7.00000000.00000001.00000000
        virtual-dma:  c0000000.20000000
        #virtual-dma-size-cells:  00000001
        #virtual-dma-addr-cells:  00000001
        no-streaming-cache: =20
        clock-frequency:  03ef1480
        bus-range:  00000000.00000000
        bus-parity-generated: =20
        no-probe-list: '0'
        compatible: 'pci108e,a801'
        name: 'pci'
        device_type: 'pci'
        #address-cells:  00000003
        #size-cells:  00000002
        implementation#:  00000023
        version#:  00000004
        portid:  0000001d
        ino-bitmap:  000000f0.00000300
        interrupt-map:  00001000.00000000.00000000.00000001.f006feb0.000000=
04.00001000.00000000.00000000.00000002.f006feb0.00000005.00001000.00000000.=
00000000.00000003.f006feb0.00000006.00001000.00000000.00000000.00000004.f00=
6feb0.00000007.00002000.00000000.00000000.00000001.f006feb0.00000029.000020=
00.00000000.00000000.00000002.f006feb0.00000028
        interrupt-map-mask:  00fff800.00000000.00000000.00000007
        #interrupt-cells:  00000001
        66mhz-capable: =20
        slot-names:  00000004.50434932.00
        interrupts:  00000033.00000030.00000031.00000034.00000025

        Node 0xf00d8d60
            .node:  f00d8d60
            assigned-addresses:  81002010.00000000.00000300.00000000.000001=
00.83002014.00000000.00100000.00000000.00002000.8300201c.00000000.00102000.=
00000000.00002000
            device_type: 'scsi-2'
            clock-frequency:  02625a00
            reg:  00002000.00000000.00000000.00000000.00000000.01002010.000=
00000.00000000.00000000.00000100.03002014.00000000.00000000.00000000.000020=
00.0300201c.00000000.00000000.00000000.00002000
            name: 'scsi'
            compatible:  70636931.3030302c.32312e31.3030302e.31303030.2e310=
070.63693130.30302c32.312e3130.30302e31.30303000.70636931.3030302c.31303030=
.00706369.31303030.2c32312e.31007063.69313030.302c3231.00706369.636c6173.73=
2c3031.30303030.00706369.636c6173.732c3031.303000
            66mhz-capable: =20
            devsel-speed:  00000001
            class-code:  00010000
            interrupts:  00000001
            latency-timer:  00000040
            cache-line-size:  00000010
            max-latency:  00000012
            min-grant:  00000011
            subsystem-id:  00001000
            subsystem-vendor-id:  00001000
            revision-id:  00000001
            device-id:  00000021
            vendor-id:  00001000

            Node 0xf00dd568
                .node:  f00dd568
                device_type: 'block'
                compatible: 'sd'
                name: 'disk'

            Node 0xf00de0f8
                .node:  f00de0f8
                device_type: 'byte'
                compatible: 'st'
                name: 'tape'

        Node 0xf00dee6c
            .node:  f00dee6c
            assigned-addresses:  81002110.00000000.00000400.00000000.000001=
00.83002114.00000000.00104000.00000000.00002000.8300211c.00000000.00106000.=
00000000.00002000
            device_type: 'scsi-2'
            clock-frequency:  02625a00
            reg:  00002100.00000000.00000000.00000000.00000000.01002110.000=
00000.00000000.00000000.00000100.03002114.00000000.00000000.00000000.000020=
00.0300211c.00000000.00000000.00000000.00002000
            name: 'scsi'
            compatible:  70636931.3030302c.32312e31.3030302e.31303030.2e310=
070.63693130.30302c32.312e3130.30302e31.30303000.70636931.3030302c.31303030=
.00706369.31303030.2c32312e.31007063.69313030.302c3231.00706369.636c6173.73=
2c3031.30303030.00706369.636c6173.732c3031.303000
            66mhz-capable: =20
            devsel-speed:  00000001
            class-code:  00010000
            interrupts:  00000002
            latency-timer:  00000040
            cache-line-size:  00000010
            max-latency:  00000012
            min-grant:  00000011
            subsystem-id:  00001000
            subsystem-vendor-id:  00001000
            revision-id:  00000001
            device-id:  00000021
            vendor-id:  00001000

            Node 0xf00e3674
                .node:  f00e3674
                device_type: 'block'
                compatible: 'sd'
                name: 'disk'

            Node 0xf00e4204
                .node:  f00e4204
                device_type: 'byte'
                compatible: 'st'
                name: 'tape'

    Node 0xf0078524
        .node:  f0078524
        available:  81000000.00000000.00000a30.00000000.000000d0.81000000.0=
0000000.00000c00.00000000.0000f400.82000000.00000000.00106000.00000000.0007=
a000.82000000.00000000.00200000.00000000.00e00000.82000000.00000000.0310000=
0.00000000.bcf00000.82000000.00000000.e0000000.00000000.10000000
        reg:  00000400.0f600000.00000000.0000b000.00000400.0f410000.0000000=
0.00007020.000007fe.00000000.00000000.00000100.00000400.0f780000.00000000.0=
0010000
        ranges:  00000000.00000000.00000000.000007fe.00000000.00000000.0100=
0000.01000000.00000000.00000000.000007fe.01000000.00000000.01000000.0200000=
0.00000000.00000000.000007ff.00000000.00000001.00000000.03000000.00000000.0=
0000000.000007ff.00000000.00000001.00000000
        virtual-dma:  c0000000.20000000
        #virtual-dma-size-cells:  00000001
        #virtual-dma-addr-cells:  00000001
        no-streaming-cache: =20
        clock-frequency:  01f78a40
        bus-range:  00000000.00000001
        bus-parity-generated: =20
        no-probe-list: '0'
        compatible: 'pci108e,a801'
        name: 'pci'
        device_type: 'pci'
        #address-cells:  00000003
        #size-cells:  00000002
        implementation#:  00000023
        version#:  00000004
        portid:  0000001e
        interrupt-map:  00001000.00000000.00000000.00000001.f0078524.000000=
0c.00001000.00000000.00000000.00000002.f0078524.0000000d.00001000.00000000.=
00000000.00000003.f0078524.0000000e.00001000.00000000.00000000.00000004.f00=
78524.0000000f.00001800.00000000.00000000.00000001.f0078524.00000010.000018=
00.00000000.00000000.00000002.f0078524.00000011.00001800.00000000.00000000.=
00000003.f0078524.00000012.00001800.00000000.00000000.00000004.f0078524.000=
00013.00002000.00000000.00000000.00000001.f0078524.00000014.00002000.000000=
00.00000000.00000002.f0078524.00000015.00002000.00000000.00000000.00000003.=
f0078524.00000016.00002000.00000000.00000000.00000004.f0078524.00000017.000=
03000.00000000.00000000.00000001.f0078524.0000001b.00004000.00000000.000000=
00.00000001.f0078524.00000024.00005000.00000000.00000000.00000001.f0078524.=
00000027.00005800.00000000.00000000.00000001.f0078524.00000026.00006800.000=
00000.00000000.00000001.f0078524.00000018
        ino-bitmap:  6bfff000.00047cd7
        interrupt-map-mask:  00fff800.00000000.00000000.00000007
        #interrupt-cells:  00000001
        slot-names:  0000001c.50434934.00504349.31005043.493000
        interrupts:  00000032.00000030.00000031.00000034.00000021

        Node 0xf00a10fc
            .node:  f00a10fc
            assigned-addresses:  81003810.00000000.00000000.00000000.000100=
00.82003814.00000000.00000000.00000000.00100000.82003818.00000000.00000000.=
00000000.00100000
            interrupt-map:  00000000.00000320.00000001.f0078524.0000002e.00=
000000.00000800.00000001.f0078524.00000020.00000000.000003f8.00000001.f0078=
524.0000002c.00000000.000002e8.00000001.f0078524.0000002c.00000000.000003e8=
.00000001.f0078524.0000002c
            interrupt-map-mask:  00000003.00ffffff.0000000f
            #interrupt-cells:  00000001
            ranges:  00000000.00000000.81003810.00000000.00000000.00010000.=
00000001.00000000.82003814.00000000.00000000.00100000.00000002.00000000.820=
03818.00000000.f0000000.00100000
            reg:  00003800.00000000.00000000.00000000.00000000.81003810.000=
00000.00000000.00000000.00010000.82003814.00000000.00000000.00000000.001000=
00.82003818.00000000.f0000000.00000000.00100000
            #size-cells:  00000001
            #address-cells:  00000002
            name: 'isa'
            devsel-speed:  00000001
            class-code:  00060100
            latency-timer:  00000000
            cache-line-size:  00000000
            max-latency:  00000000
            min-grant:  00000000
            revision-id:  00000000
            device-id:  00001533
            vendor-id:  000010b9

            Node 0xf00a2144
                .node:  f00a2144
                sunw,location: 'U38'
                model: 'SUNW,370-5708'
                version:  4f425020.342e3137.2e312032.3030352f.30342f31.3120=
3134.3a323420.53756e20.426c6164.65203235.3030004f.42444941.4720342e.31372e3=
1.20323030.352f3034.2f313120.31343a33.35202000.504f5354.20342e31.372e3120.3=
2303035.2f30342f.31312031.343a3432.00
                name: 'flashprom'
                compatible: 'isa-flashprom'
                reg:  00000002.00000000.00100000

            Node 0xf00a2da4
                .node:  f00a2da4
                address:  feed2070
                reg:  00000000.00000070.00000002
                compatible: 'isa-m5823p'
                model: 'm5823'
                name: 'rtc'

            Node 0xf00a3c4c
                .node:  f00a3c4c
                interrupt-map:  00000000.00000058.00000001.f0078524.0000001=
d.00000000.0000005c.00000001.f0078524.0000001e
                interrupts:  00000001
                #interrupt-cells:  00000001
                interrupt-map-mask:  00000000.000000ff.00000003
                reg:  00000000.00000320.00000002
                device_type: 'i2c'
                compatible: 'pcf8584'
                #size-cells:  00000000
                #address-cells:  00000002
                name: 'i2c'

                Node 0xf00a509c
                    .node:  f00a509c
                    revision-id:  00000014
                    reg:  00000000.00000012
                    compatible: 'SUNW,i2c-imax'
                    name: 'i2c-bridge'

                Node 0xf00a5298
                    .node:  f00a5298
                    reg:  00000000.00000030
                    compatible: 'i2c-pca9556'
                    name: 'gpio'

                Node 0xf00a5408
                    .node:  f00a5408
                    interrupts:  00000001
                    reg:  00000000.00000058
                    compatible: 'i2c-adm1031'
                    name: 'hardware-monitor'

                Node 0xf00a54f8
                    .node:  f00a54f8
                    interrupts:  00000001
                    reg:  00000000.0000005c
                    compatible: 'i2c-adm1031'
                    name: 'hardware-monitor'

                Node 0xf00a55e8
                    .node:  f00a55e8
                    reg:  00000000.0000006e
                    compatible: 'i2c-fm3560'
                    name: 'gpio'

                Node 0xf00a56a8
                    .node:  f00a56a8
                    reg:  00000000.0000009c
                    compatible: 'i2c-fm3560'
                    name: 'gpio'

                Node 0xf00a5768
                    .node:  f00a5768
                    reg:  00000000.000000a0
                    compatible: 'i2c-at24c64'
                    device_type: 'fru-prom'
                    name: 'audio-card-fru-prom'

                Node 0xf00a5a1c
                    .node:  f00a5a1c
                    reg:  00000000.000000a2
                    compatible: 'i2c-at24c64'
                    device_type: 'fru-prom'
                    name: 'motherboard-fru-prom'

                Node 0xf00a5cd4
                    .node:  f00a5cd4
                    reg:  00000000.000000a8
                    compatible: 'i2c-at24c64'
                    device_type: 'fru-prom'
                    name: 'scsi-backplane-fru-prom'

                Node 0xf00a5f8c
                    .node:  f00a5f8c
                    reg:  00000000.000000b6
                    compatible: 'i2c-at34c02'
                    name: 'dimm-spd'

                Node 0xf00a614c
                    .node:  f00a614c
                    reg:  00000000.000000b8
                    compatible: 'i2c-at34c02'
                    name: 'dimm-spd'

                Node 0xf00a630c
                    .node:  f00a630c
                    reg:  00000000.000000ba
                    compatible: 'i2c-at34c02'
                    name: 'dimm-spd'

                Node 0xf00a64cc
                    .node:  f00a64cc
                    reg:  00000000.000000bc
                    compatible: 'i2c-at34c02'
                    name: 'dimm-spd'

                Node 0xf00a668c
                    .node:  f00a668c
                    reg:  00000000.000000d2
                    compatible: 'i2c-ics951601'
                    name: 'clock-generator'

            Node 0xf00a67c8
                .node:  f00a67c8
                button: =20
                interrupts:  00000001
                reg:  00000000.00000800.00000030
                compatible:  616c6931.35333564.2b2d706f.77657200.61637069.2=
d706f77.657200
                name: 'power'

            Node 0xf00a6930
                .node:  f00a6930
                ignore-cd: =20
                sunw,location: 'TTYA'
                reg:  00000000.000003f8.00000008
                interrupts:  00000001
                compatible:  73753136.35353000.737500
                device_type: 'serial'
                name: 'serial'

            Node 0xf00a84ac
                .node:  f00a84ac
                ignore-cd: =20
                sunw,location: 'ARC'
                reg:  00000000.000002e8.00000008
                interrupts:  00000001
                compatible:  73753136.35353000.737500
                device_type: 'serial'
                name: 'serial'

            Node 0xf00aa07c
                .node:  f00aa07c
                interrupt-map:  00000000.00000378.00000001.f0078524.0000002=
d
                #interrupt-cells:  00000001
                interrupt-map-mask:  00000000.00000fff.0000000f
                reg:  00000000.00000000.00010000
                compatible: 'isadma'
                name: 'dma'

                Node 0xf00aa950
                    .node:  f00aa950
                    sunw,location: 'ECPP'
                    interrupts:  00000001
                    reg:  00000000.00000378.00000008.00000000.00000000.0000=
0500
                    dma-channel:  00000001
                    compatible:  706e7041.4c492c31.3533352c.3300706e.70414c=
49.2c313533.332c3300
                    name: 'parallel'

        Node 0xf00bbb28
            .node:  f00bbb28
            assigned-addresses:  81003010.00000000.00000000.00000000.000000=
10
            ranges:  00000000.00000000.00003000.00000000.00000000.00000100.=
00000001.00000000.81003010.00000000.00000600.00000100.00000002.00000000.810=
03014.00000000.00000000.00000100
            reg:  00003000.00000000.00000000.00000000.00000000.81003010.000=
00000.00000600.00000000.00000010
            compatible:  70636931.3062392c.37313031.2e300070.63693130.62392=
c37.31303100.70636963.6c617373.2c303030.30303000.70636963.6c617373.2c303030=
.3000
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

            Node 0xf00bcbc0
                .node:  f00bcbc0
                reg:  00000000.00000000.00000100.00000001.00000000.00000100
                #address-cells:  00000002
                #size-cells:  00000000
                interrupts:  00000001
                compatible: 'i2c-smbus'
                name: 'i2c'

                Node 0xf00be0c8
                    .node:  f00be0c8
                    reg:  00000000.00000040
                    compatible: 'i2c-scm001'
                    name: 'card-reader'

            Node 0xf00be258
                .node:  f00be258
                reg:  00000000.000000b2.00000001.00000000.000000d3.00000001=
.00000002.00000042.00000002.00000002.00000061.00000001
                compatible: 'SUNW,smbus-beep'
                name: 'beep'

            Node 0xf00be38c
                .node:  f00be38c
                reg:  00000000.000000b3.00000001.00000000.000000b9.00000001
                compatible:  616c6931.35333564.2b2d7070.6d005355.4e572c73.6=
d627573.2d70706d.00
                name: 'ppm'

        Node 0xf00be544
            .node:  f00be544
            assigned-addresses:  81004010.00000000.00000900.00000000.000001=
00.82004014.00000000.00100000.00000000.00002000
            reg:  00004000.00000000.00000000.00000000.00000000.01004010.000=
00000.00000000.00000000.00000100.02004014.00000000.00000000.00000000.000020=
00
            compatible:  70636931.3062392c.35343531.2e313062.392e3534.35312=
e32.00706369.31306239.2c353435.312e3130.62392e35.34353100.70636931.3062392c=
.35343531.00706369.31306239.2c353435.312e3200.70636931.3062392c.35343531.00=
706369.636c6173.732c3034.30313030.00706369.636c6173.732c3034.303100
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
            revision-id:  00000002
            device-id:  00005451
            vendor-id:  000010b9

        Node 0xf00be8e4
            .node:  f00be8e4
            assigned-addresses:  82005010.00000000.01000000.00000000.010000=
00
            sunw,find-fcode:  f00c3c24
            maximum-frame#:  0000ffff
            reg:  00005000.00000000.00000000.00000000.00000000.02005010.000=
00000.00000000.00000000.01000000
            #size-cells:  00000000
            #address-cells:  00000001
            compatible:  70636931.3062392c.35323337.2e330070.63693130.62392=
c35.32333700.70636963.6c617373.2c306330.33313000.70636963.6c617373.2c306330=
.3300
            name: 'usb'
            fast-back-to-back: =20
            devsel-speed:  00000001
            class-code:  000c0310
            interrupts:  00000001
            latency-timer:  00000040
            cache-line-size:  00000000
            max-latency:  00000050
            min-grant:  00000000
            revision-id:  00000003
            device-id:  00005237
            vendor-id:  000010b9

            Node 0xf00c4a3c
                .node:  f00c4a3c
                mouse: =20
                endpoints: '0,8,81,3'
                interface#:  00000000
                compatible:  75736234.33302c31.30302e31.30370075.73623433.3=
02c3130.30007573.62696634.33302c63.6c617373.332e312e.32007573.62696634.3330=
2c63.6c617373.332e3100.75736269.66343330.2c636c61.73733300.75736269.662c636=
c.61737333.2e312e32.00757362.69662c63.6c617373.332e3100.75736269.662c636c.6=
1737333.00
                name: 'mouse'
                reg:  00000001
                low-speed: =20
                assigned-address:  00000002
                0max-packet:  00000008

        Node 0xf00c6d1c
            .node:  f00c6d1c
            assigned-addresses:  82005810.00000000.02000000.00000000.010000=
00
            sunw,find-fcode:  f00cc05c
            maximum-frame#:  0000ffff
            reg:  00005800.00000000.00000000.00000000.00000000.02005810.000=
00000.00000000.00000000.01000000
            #size-cells:  00000000
            #address-cells:  00000001
            compatible:  70636931.3062392c.35323337.2e330070.63693130.62392=
c35.32333700.70636963.6c617373.2c306330.33313000.70636963.6c617373.2c306330=
.3300
            name: 'usb'
            fast-back-to-back: =20
            devsel-speed:  00000001
            class-code:  000c0310
            interrupts:  00000001
            latency-timer:  00000040
            cache-line-size:  00000000
            max-latency:  00000050
            min-grant:  00000000
            revision-id:  00000003
            device-id:  00005237
            vendor-id:  000010b9

            Node 0xf00cce74
                .node:  f00cce74
                keyboard: =20
                endpoints: '0,8,81,8'
                interface#:  00000000
                compatible:  75736234.33302c35.2e323030.00757362.3433302c.3=
5007573.62696634.33302c63.6c617373.332e312e.31007573.62696634.33302c63.6c61=
7373.332e3100.75736269.66343330.2c636c61.73733300.75736269.662c636c.6173733=
3.2e312e31.00757362.69662c63.6c617373.332e3100.75736269.662c636c.61737333.0=
0
                name: 'keyboard'
                reg:  00000001
                low-speed: =20
                assigned-address:  00000002
                0max-packet:  00000008

        Node 0xf00d2b28
            .node:  f00d2b28
            assigned-addresses:  81006810.00000000.00000a00.00000000.000000=
08.81006814.00000000.00000a18.00000000.00000008.81006818.00000000.00000a10.=
00000000.00000008.8100681c.00000000.00000a08.00000000.00000008.81006820.000=
00000.00000a20.00000000.00000010
            reg:  00006800.00000000.00000000.00000000.00000000.01006810.000=
00000.00000000.00000000.00000008.01006814.00000000.00000000.00000000.000000=
04.01006818.00000000.00000000.00000000.00000008.0100681c.00000000.00000000.=
00000000.00000004.01006820.00000000.00000000.00000000.00000010
            compatible:  70636931.3062392c.35323239.2e633400.70636931.30623=
92c.35323239.00706369.636c6173.732c3031.30316666.00706369.636c6173.732c3031=
.303100
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
            revision-id:  000000c4
            device-id:  00005229
            vendor-id:  000010b9

            Node 0xf00d5834
                .node:  f00d5834
                device_type: 'block'
                name: 'disk'
                compatible: 'ide-disk'

            Node 0xf00d5ee8
                .node:  f00d5ee8
                device_type: 'block'
                name: 'cdrom'
                compatible: 'ide-cdrom'

        Node 0xf00d6850
            .node:  f00d6850
            assigned-addresses:  82001010.00000000.00102000.00000000.000020=
00.81001014.00000000.00000b00.00000000.00000100.82001018.00000000.00180000.=
00000000.00080000.82001030.00000000.00104000.00000000.00002000
            reg:  00001000.00000000.00000000.00000000.00000000.82001010.000=
00000.00102000.00000000.00002000.01001014.00000000.00000000.00000000.000001=
00.02001018.00000000.00000000.00000000.00080000.02001030.00000000.00000000.=
00000000.00002000
            compatible:  70636938.3038362c.62353535.2e313038.652e3637.36612=
e33.00706369.38303836.2c623535.352e3130.38652e36.37366100.70636931.3038652c=
.36373661.00706369.38303836.2c623535.352e3300.70636938.3038362c.62353535.00=
706369.636c6173.732c3036.38303030.00706369.636c6173.732c3036.383000
            name: 'pci108e,676a'
            66mhz-capable: =20
            fast-back-to-back: =20
            devsel-speed:  00000001
            class-code:  00068000
            interrupts:  00000001
            latency-timer:  00000040
            cache-line-size:  00000010
            max-latency:  00000020
            min-grant:  00000000
            subsystem-id:  0000676a
            subsystem-vendor-id:  0000108e
            revision-id:  00000003
            device-id:  0000b555
            vendor-id:  00008086

        Node 0xf00d6c6c
            .node:  f00d6c6c
            available:  82000000.00000000.0300c000.00000000.000f4000
            ranges:  82000000.00000000.03000000.82000000.00000000.03000000.=
00000000.00100000
            bus-range:  00000001.00000001
            compatible:  70636931.3034632c.61633233.2e320070.63693130.34632=
c61.63323300.70636963.6c617373.2c303630.34303000.70636963.6c617373.2c303630=
.3400
            reg:  00002000.00000000.00000000.00000000.00000000
            #address-cells:  00000003
            #size-cells:  00000002
            device_type: 'pci'
            name: 'pci'
            devsel-speed:  00000001
            class-code:  00060400
            latency-timer:  00000040
            cache-line-size:  00000010
            revision-id:  00000002
            device-id:  0000ac23
            vendor-id:  0000104c

            Node 0xf00d7eb8
                .node:  f00d7eb8
                assigned-addresses:  82014010.00000000.03000000.00000000.00=
002000
                reg:  00014000.00000000.00000000.00000000.00000000.02014010=
.00000000.00000000.00000000.00002000
                compatible:  70636931.3033332c.33352e31.3233352e.33352e31.3=
0343300.70636931.3033332c.33352e31.3233352e.33350070.63693132.33352c33.3500=
7063.69313033.332c3335.2e313034.33007063.69313033.332c3335.00706369.636c617=
3.732c3063.30333130.00706369.636c6173.732c3063.303300
                name: 'usb'
                devsel-speed:  00000001
                class-code:  000c0310
                interrupts:  00000001
                latency-timer:  00000040
                cache-line-size:  00000010
                max-latency:  0000002a
                min-grant:  00000001
                subsystem-id:  00000035
                subsystem-vendor-id:  00001235
                revision-id:  00000043
                device-id:  00000035
                vendor-id:  00001033

            Node 0xf00d8200
                .node:  f00d8200
                assigned-addresses:  82014110.00000000.03002000.00000000.00=
002000
                reg:  00014100.00000000.00000000.00000000.00000000.02014110=
.00000000.00000000.00000000.00002000
                compatible:  70636931.3033332c.33352e31.3233352e.33352e31.3=
0343300.70636931.3033332c.33352e31.3233352e.33350070.63693132.33352c33.3500=
7063.69313033.332c3335.2e313034.33007063.69313033.332c3335.00706369.636c617=
3.732c3063.30333130.00706369.636c6173.732c3063.303300
                name: 'usb'
                devsel-speed:  00000001
                class-code:  000c0310
                interrupts:  00000002
                latency-timer:  00000040
                cache-line-size:  00000010
                max-latency:  0000002a
                min-grant:  00000001
                subsystem-id:  00000035
                subsystem-vendor-id:  00001235
                revision-id:  00000043
                device-id:  00000035
                vendor-id:  00001033

            Node 0xf00d8548
                .node:  f00d8548
                assigned-addresses:  82014210.00000000.03004000.00000000.00=
002000
                reg:  00014200.00000000.00000000.00000000.00000000.02014210=
.00000000.00000000.00000000.00002000
                compatible:  70636931.3033332c.65302e31.3233352e.65302e32.3=
0303400.70636931.3033332c.65302e31.3233352e.65300070.63693132.33352c65.3000=
7063.69313033.332c6530.2e323030.34007063.69313033.332c6530.00706369.636c617=
3.732c3063.30333230.00706369.636c6173.732c3063.303300
                name: 'usb'
                devsel-speed:  00000001
                class-code:  000c0320
                interrupts:  00000003
                latency-timer:  00000040
                cache-line-size:  00000010
                max-latency:  00000022
                min-grant:  00000010
                subsystem-id:  000000e0
                subsystem-vendor-id:  00001235
                revision-id:  00000004
                device-id:  000000e0
                vendor-id:  00001033

            Node 0xf00d8890
                .node:  f00d8890
                assigned-addresses:  82015810.00000000.03006000.00000000.00=
002000.82015814.00000000.03008000.00000000.00004000
                reg:  00015800.00000000.00000000.00000000.00000000.02015810=
.00000000.00000000.00000000.00002000.02015814.00000000.00000000.00000000.00=
004000
                compatible:  70636931.3034632c.38303234.2e313233.352e3830.3=
2342e31.30303000.70636931.3034632c.38303234.2e313233.352e3830.32340070.6369=
3132.33352c38.30323400.70636931.3034632c.38303234.2e313030.30007063.6931303=
4.632c3830.32340070.6369636c.6173732c.30633030.31300070.6369636c.6173732c.3=
0633030.00
                name: 'firewire'
                devsel-speed:  00000001
                class-code:  000c0010
                interrupts:  00000001
                latency-timer:  00000040
                cache-line-size:  00000010
                max-latency:  00000004
                min-grant:  00000002
                subsystem-id:  00008024
                subsystem-vendor-id:  00001235
                revision-id:  00000000
                device-id:  00008024
                vendor-id:  0000104c

    Node 0xf0080ca0
        .node:  f0080ca0
        portid:  0000001e
        reg:  00000400.0f000000.00000000.00000008.00000400.0f410050.0000000=
0.00000010
        compatible: 'jbus-ppm'
        name: 'ppm'

    Node 0xf0080d94
        .node:  f0080d94
        available:  81000000.00000000.00000300.00000000.0000fd00.82000000.0=
0000000.00130000.00000000.01ed0000.82000000.00000000.08000000.00000000.b800=
0000.82000000.00000000.e0000000.00000000.00000000
        reg:  00000400.0ff00000.00000000.0000b000.00000400.0fc10000.0000000=
0.00007020.000007f6.00000000.00000000.00000100.00000400.0ff80000.00000000.0=
0010000
        ranges:  00000000.00000000.00000000.000007f6.00000000.00000000.0100=
0000.01000000.00000000.00000000.000007f6.01000000.00000000.01000000.0200000=
0.00000000.00000000.000007f7.00000000.00000001.00000000.03000000.00000000.0=
0000000.000007f7.00000000.00000001.00000000
        virtual-dma:  c0000000.20000000
        #virtual-dma-size-cells:  00000001
        #virtual-dma-addr-cells:  00000001
        no-streaming-cache: =20
        clock-frequency:  03ef1480
        bus-range:  00000000.00000000
        bus-parity-generated: =20
        no-probe-list: '0'
        compatible: 'pci108e,a801'
        name: 'pci'
        device_type: 'pci'
        #address-cells:  00000003
        #size-cells:  00000002
        implementation#:  00000023
        version#:  00000004
        portid:  0000001f
        interrupt-map:  00001000.00000000.00000000.00000001.f0080d94.000000=
08.00001000.00000000.00000000.00000002.f0080d94.00000009.00001000.00000000.=
00000000.00000003.f0080d94.0000000a.00001000.00000000.00000000.00000004.f00=
80d94.0000000b
        ino-bitmap:  00000f00.001b0008
        interrupt-map-mask:  00fff800.00000000.00000000.00000007
        #interrupt-cells:  00000001
        66mhz-capable: =20
        slot-names:  00000004.50434935.00
        interrupts:  00000033.00000030.00000031.00000034.00000023

        Node 0xf00ae51c
            .node:  f00ae51c
            linebytes:  00000800
            character-set: 'ISO8859-1'
            assigned-addresses:  c2001010.00000000.04000000.00000000.040000=
00.82001014.00000000.00100000.00000000.00020000.c2001018.00000000.02000000.=
00000000.02000000.82001030.00000000.00120000.00000000.00010000
            s-fru-len:  00000800
            s-fru-offset:  0000f400
            s-fru-dev: 'fcode-prom'
            version: '@(#)xvr600.fth 1.5 03/05/09 SMI '
            reg:  00001000.00000000.00000000.00000000.00000000.42001010.000=
00000.00000000.00000000.04000000.02001014.00000000.00000000.00000000.000200=
00.42001018.00000000.00000000.00000000.02000000
            monitor_mode:  00000012
            v_freq:  0000003c
            height:  00000400
            width:  00000500
            edid_data:  00ffffff.ffffff00.4eae8c05.4d524f02.340e0103.80261e=
78.ebee84a3.544c9926.115054bf.ef008180.81907186.818f0101.01010101.0101302a.=
00985100.2a403070.13007c2c.11000014.000000fd.00384b1e.510e000a.20202020.202=
00000.00fc0047.48313950.530a2020.20202020.000000ff.00303435.324d5230.353931=
0a.2020004c
            no_edid_blks:  00000001
            dev-comm:  feda41c8
            device_type: 'display'
            model: 'SUNW,375-3153'
            name: 'SUNW,XVR-600'
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
            subsystem-id:  00001047
            subsystem-vendor-id:  00003d3d
            revision-id:  00000001
            device-id:  000007a2
            vendor-id:  00003d3d

    Node 0xf00893d8
        .node:  f00893d8
        #address-cells:  00000002
        #size-cells:  00000000
        reg:  00000400.0fc64000.00000000.00000010
        compatible: 'jbus-i2c'
        device_type: 'i2c'
        name: 'i2c'

        Node 0xf008a71c
            .node:  f008a71c
            reg:  00000000.000000ae
            compatible: 'i2c-at24c64'
            device_type: 'nvram'
            name: 'nvram'

        Node 0xf008aa84
            .node:  f008aa84
            device_type: 'idprom'
            reg:  00000000.000000ae
            name: 'idprom'


--=-0grDSm68sfYIFqPv/anI--

