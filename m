From: Eric Brower <ebrower@gmail.com>
Date: Fri, 06 Feb 2009 19:32:44 +0000
Subject: Re: SBus HME startup failure
Message-Id: <ec7cefb0902061132w388cf9em3d32b2713f2e8833@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0901271205350.17434@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0901271205350.17434@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Meelis,

I'm running a somewhat-current davem sparc-2.6 GIT.  I'm not sure if
your kernel is similar, but if PCI and SBUS are both enabled in the
kernel, the SBus device probe routines will be run on all matching HME
devices, which means both PCI and SBus.

I have not studied the new driver model and OF implementation in
sufficient detail, but the underlying bus type for an of_device (PCI,
SBus, etc) appears not to be kept, rather "of" is used in these cases.
 So, without knowing the underlying bus type, simply using "name" or
"compatible" for device matching seems insufficient (at least in the
case of HME, or any other device that has both PCI and SBus
implementations available).

So, admitting this may not be the proper fix, the following at least
allows the SBus probe to exit early.  I'm not sure if this will solve
your issue, but it solves mine.

diff --git a/drivers/net/sunhme.c b/drivers/net/sunhme.c
index 7a72a31..781908f 100644
--- a/drivers/net/sunhme.c
+++ b/drivers/net/sunhme.c
@@ -2629,6 +2629,16 @@ static int __devinit happy_meal_sbus_pro
        int i, qfe_slot = -1;
        int err = -ENODEV;

+       /* if SBus and PCI are both enabled, the current implementation
+        * will cause the SBus probe to run on PCI devices.  This should
+        * be fixed in the OF routines, unless this "collision" is
+        * particular to HME, but for now we'll check for an idiomatic
+        * PCI-only property and exit if found.
+        */
+       if (of_find_property(dp, "device-id", NULL)) {
+               return err;
+       }
+
        if (is_qfe) {
                qp = quattro_sbus_find(op);
                if (qp = NULL)


On Tue, Jan 27, 2009 at 2:16 AM, Meelis Roos <mroos@linux.ee> wrote:
> Hello,
>
> it's me again with the E3500 and 2.6.29-rc2+git. I said it was working
> fine but I have found 2 glitches and this is one of them.
>
> It seems the SBus HME card is detected but initialization fails:
>
> [  145.666490] sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@davemloft.net)
> [  145.755837] eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:b6:ee:e2
> [  145.836295] happymeal: Cannot map MAC TX registers.
> [  145.895305] PCI: Enabling device: (0000:00:01.1), cmd 2
> [  145.897821] eth1: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:b6:ee:e2
>
> PCI one is detected and works fine.
>
> 2.6.27 worked fine, 2.6.28 not tested (should I test it to narrow the
> cause down?)
>
> Current prtconf -pv:
>
> System Configuration:  Sun Microsystems  sun4u
> Memory size: 1280 Megabytes
> System Peripherals (PROM Nodes):
>
> Node 0xf0029c88
>    .node:  f0029c88
>    clock-frequency:  05f5e100
>    previous-reset-reason: 'S-POR'
>    banner-name: '5-slot Sun Enterprise E3500'
>    idprom:  01800800.20b6eee2.00000000.b6eee2a9.00000000.00000000.00000000.00000000
>    reset-reason: 'S-POR'
>    fatal-reset-info:  00006000
>    breakpoint-trap:  0000007f
>    #size-cells:  00000002
>    name: 'SUNW,Ultra-Enterprise'
>
>    Node 0xf002cf50
>        .node:  f002cf50
>        name: 'packages'
>
>        Node 0xf00365c0
>            .node:  f00365c0
>            iso6429-1983-colors:
>            name: 'terminal-emulator'
>
>        Node 0xf003932c
>            .node:  f003932c
>            disk-write-fix:
>            name: 'deblocker'
>
>        Node 0xf0039a08
>            .node:  f0039a08
>            name: 'obp-tftp'
>
>        Node 0xf00447cc
>            .node:  f00447cc
>            name: 'disk-label'
>
>    Node 0xf002cfc0
>        .node:  f002cfc0
>        stdout:  ffdbfe20
>        stdin:  ffdbf9c0
>        eeprom:  f005dd0c
>        mmu:  fffe9f70
>        memory:  fffea170
>        bootargs:  00
>        bootpath: '/pci@f,4000/SUNW,isptwo@3/sd@2,0:a'
>        stdout-#lines:  ffffffff
>        name: 'chosen'
>
>    Node 0xf002d02c
>        .node:  f002d02c
>        add-brd-supported-types: '014'
>        version: 'OBP 3.2.30 2002/10/25 14:03'
>        model: 'SUNW,3.2'
>        decode-complete:
>        aligned-allocator:
>        relative-addressing:
>        name: 'openprom'
>
>        Node 0xf002d0bc
>            .node:  f002d0bc
>            name: 'client-services'
>
>    Node 0xf002d164
>        .node:  f002d164
>        disabled-memory-list:
>        disabled-board-list:
>        memory-interleave: 'max'
>        configuration-policy: 'component'
>        scsi-initiator-id: '7'
>        keyboard-click?: 'false'
>        keymap:
>        ttyb-rts-dtr-off: 'false'
>        ttyb-ignore-cd: 'true'
>        ttya-rts-dtr-off: 'false'
>        ttya-ignore-cd: 'true'
>        ttyb-mode: '9600,8,n,1,-'
>        ttya-mode: '9600,8,n,1,-'
>        sbus-specific-probe:
>        sbus-probe-default: 'd3120'
>        mfg-mode: 'off '
>        diag-level: 'max'
>        powerfail-time: '0'
>        #power-cycles: '11'
>        fcode-debug?: 'false'
>        output-device: 'screen'
>        input-device: 'keyboard'
>        load-base: '16384'
>        boot-command: 'boot'
>        auto-boot?: 'false'
>        watchdog-reboot?: 'false'
>        diag-file:
>        diag-device: 'mydisk'
>        boot-file:
>        boot-device: 'mydisk'
>        local-mac-address?: 'false'
>        ansi-terminal?: 'true'
>        screen-#columns: '80'
>        screen-#rows: '34'
>        silent-mode?: 'false'
>        use-nvramrc?: 'true'
>        nvramrc:  64657661.6c696173.206d7964.69736b20.2f706369.40662c34.3030302f.53554e57.2c697370.74776f40.332f7364.40322c30.0a
>        security-mode: 'none'
>        security-password:
>        security-#badlogins: '0'
>        oem-logo:
>        oem-logo?: 'false'
>        oem-banner:
>        oem-banner?: 'false'
>        hardware-revision:
>        last-hardware-update: '0'
>        diag-switch?: 'false'
>        name: 'options'
>
>    Node 0xf002d1d4
>        .node:  f002d1d4
>        mydisk: '/pci@f,4000/SUNW,isptwo@3/sd@2,0'
>        disk: '/sbus@2,0/SUNW,socal@d,10000/sf@0,0/ssd@0,0'
>        disksocal: '/sbus@2,0/SUNW,socal@d,10000/sf@0,0/ssd@0,0'
>        diskbrd: '/sbus@3,0/SUNW,fas@3,8800000/sd@a,0'
>        diskisp: '/sbus@3,0/QLGC,isp@0,10000/sd@0,0'
>        net: '/sbus@3,0/SUNW,hme@3,8c00000'
>        cdrom: '/sbus@3,0/SUNW,fas@3,8800000/sd@6,0:f'
>        tape: '/sbus@3,0/SUNW,fas@3,8800000/st@4,0'
>        scsi: '/sbus@3,0/SUNW,fas@3,8800000'
>        disk0: '/sbus@3,0/SUNW,fas@3,8800000/sd@0,0'
>        disk1: '/sbus@3,0/SUNW,fas@3,8800000/sd@1,0'
>        disk2: '/sbus@3,0/SUNW,fas@3,8800000/sd@2,0'
>        disk3: '/sbus@3,0/SUNW,fas@3,8800000/sd@3,0'
>        disk4: '/sbus@3,0/SUNW,fas@3,8800000/sd@4,0'
>        disk5: '/sbus@3,0/SUNW,fas@3,8800000/sd@5,0'
>        tape0: '/sbus@3,0/SUNW,fas@3,8800000/st@4,0'
>        tape1: '/sbus@3,0/SUNW,fas@3,8800000/st@5,0'
>        ttya: '/central/fhc/zs@0,902000:a'
>        ttyb: '/central/fhc/zs@0,902000:b'
>        keyboard: '/central/fhc/zs@0,904000'
>        keyboard!: '/central/fhc/zs@0,904000:forcemode'
>        name: 'aliases'
>
>    Node 0xf004efb4
>        .node:  f004efb4
>        reg:  00000000.00000000.00000000.40000000.00000000.40000000.00000000.10000000
>        available:  00000000.4fcec000.00000000.00014000.00000000.4fc00000.00000000.000ea000.00000000.00000000.00000000.4f7de000
>        name: 'memory'
>
>    Node 0xf004f594
>        .node:  f004f594
>        translations:  00000000.fffd0000.00000000.00020000.80000000.4ff600b6.00000000.fff70000.00000000.00060000.80000000.4fef80b6.00000000.fff6e000.00000000.00002000.80000000.4fbfe0b6.00000000.fff6c000.00000000.00002000.80000000.4fef60b6.00000000.fff66000.00000000.00002000.800001ff.f890208e.00000000.fff64000.00000000.00002000.800001ff.f890808e.00000000.fff62000.00000000.00002000.800001ff.f890808e.00000000.fff60000.00000000.00002000.800001c4.f830008e.00000000.fff5e000.00000000.00002000.800001dc.f830008e.00000000.ffdda000.00000000.00184000.80000000.4fd720b6.00000000.ffdce000.00000000.0000c000.800001cc.f880408e.00000000.ffdcc000.00000000.00002000.80000000.4fd700b6.00000000.ffdca000.00000000.00002000.800001ff.f820608e.00000000.ffdc6000.00000000.00004000.80000000.4fd4c0b6.00000000.ffdc4000.00000000.00002000.800001ff.f890408e.00000000.ffdc2000.00000000.00002000.80000000.4fd4a0b6.00000000.ffdba000.00000000.00006000.80000000.4fd440b6.00000000.ffdb4000.00000000.00006000.800001c4.0000
>  008e.00000000.ffdae000.00000000.00006000.800001c4.0000008e.00000000.ffda6000.00000000.00008000.80000000.4fd680b6.00000000.ffd9a000.00000000.0000c000.800001c4.f880408e.00000000.ffd98000.00000000.00002000.800001c4.f830008e.00000000.ffd96000.00000000.00002000.800001c4.0000208e.00000000.ffd94000.00000000.00002000.800001c4.0000208e.00000000.ffd92000.00000000.00002000.800001c4.0000208e.00000000.ffd8c000.00000000.00006000.800001c6.0000008e.00000000.ffd86000.00000000.00006000.800001c6.0000008e.00000000.ffd7e000.00000000.00008000.80000000.4fd600b6.00000000.ffd7c000.00000000.00002000.800001c6.0000208e.00000000.ffd7a000.00000000.00002000.800001c6.0000208e.00000000.ffd78000.00000000.00002000.800001c6.0000208e.00000000.ffd76000.00000000.00002000.800001dc.0000408e.00000000.ffd74000.00000000.00002000.880001dc.0100008e.00000000.ffd66000.00000000.0000e000.800001dc.0000008e.00000000.ffd5e000.00000000.00008000.80000000.4fd580b6.00000000.ffd5c000.00000000.00002000.800001dc.0000208e.00000000.ffd
>  5a000.00000000.00002000.880001dc.0180008e.00000000.ffd4c000.00000000.0000e000.800001dc.0000008e.00000000.ffd40000.00000000.0000c000.800001dc.f880408e.00000000.ffd3e000.00000000.00002000.800001dc.f830008e.00000000.ffd3c000.00000000.00002000.800001dc.0000008e.00000000.ffd3a000.00000000.00002000.800001dc.0000008e.00000000.ffd38000.00000000.00002000.800001dc.0000008e.00000000.ffd36000.00000000.00002000.800001de.0000408e.00000000.ffd34000.00000000.00002000.880001de.0100008e.00000000.ffd26000.00000000.0000e000.800001de.0000008e.00000000.ffd1e000.00000000.00008000.80000000.4fd500b6.00000000.ffd1c000.00000000.00002000.800001de.0000208e.00000000.ffd1a000.00000000.00002000.880001de.0180008e.00000000.ffd0c000.00000000.0000e000.800001de.0000008e.00000000.ffd0a000.00000000.00002000.800001de.0000008e.00000000.ffd08000.00000000.00002000.800001de.0000008e.00000000.ffd06000.00000000.00002000.800001de.0000008e.00000000.ffb06000.00000000.00200000.80000000.4f7de0b6.00000000.f07fe000.00000000.00
>  002000.800001ff.f004208e.00000000.f02a0000.00000000.00040000.80000000.4fd040b6.00000000.f0080000.00000000.00220000.80000000.4f9de0b6.00000000.f0000000.00000000.00080000.80000000.4ff800b6.00000000.40000000.00000000.00800000.80000000.00400036.00000000.00002000.00000000.00ffe000.80000000.00002036
>        existing:  00000000.00000000.00000800.00000000.fffff800.00000000.00000800.00000000
>        available:  fffff800.00000000.000007fc.00000000.00000001.00000000.000007ff.00000000.00000000.ffff0000.00000000.0000e000.00000000.00000000.00000000.f0000000.00000000.ffdc0000.00000000.00002000.00000000.f0800000.00000000.0f306000
>        page-size:  00002000
>        name: 'virtual-memory'
>
>    Node 0xf005da70
>        .node:  f005da70
>        ranges:  00000000.f8000000.000001ff.f8000000.08000000
>        reg:  000001ff.00000000.00000000.08000000
>        name: 'central'
>
>        Node 0xf005db8c
>            .node:  f005db8c
>            board-model: 'SUNW,501-2511'
>            ranges:  00000000.00000000.00000000.f8000000.08000000
>            reg:  00000000.f8800000.00000110.00000000.f8802000.00000010.00000000.f8804000.00000020.00000000.f8806000.00000020.00000000.f8808000.00000020.00000000.f880a000.00000020
>            name: 'fhc'
>
>            Node 0xf005dd0c
>                .node:  f005dd0c
>                address:  fff62000
>                watchdog-enable:
>                interrupts:  0000003a
>                reg:  00000000.00908000.00002000
>                model: 'mk48t59'
>                name: 'eeprom'
>
>            Node 0xf005de3c
>                .node:  f005de3c
>                port-b-ignore-cd:
>                port-a-ignore-cd:
>                address:  fff66000
>                interrupts:  00000039
>                device_type: 'serial'
>                reg:  00000000.00902000.00000008
>                name: 'zs'
>
>            Node 0xf005df14
>                .node:  f005df14
>                address:  ffdc4000
>                port-b-ignore-cd:
>                port-a-ignore-cd:
>                keyboard:
>                interrupts:  00000039
>                device_type: 'serial'
>                reg:  00000000.00904000.00000008
>                name: 'zs'
>
>            Node 0xf005e05c
>                .node:  f005e05c
>                reg:  00000000.00900000.00000008.00000000.00906000.00000060.00000000.0090c000.00000001
>                interrupts:  00000038
>                name: 'clock-board'
>
>    Node 0xf00df7bc
>        .node:  f00df7bc
>        board-type: 'cpu'
>        board-model: 'SUNW,501-2557'
>        ranges:  00000000.00000000.000001cc.f8000000.08000000
>        central-space:
>        board#:  00000003
>        reg:  000001cc.f8800000.00000000.00000110.000001cc.f8802000.00000000.00000010.000001cc.f8804000.00000000.00000020.000001cc.f8806000.00000000.00000020.000001cc.f8808000.00000000.00000020.000001cc.f880a000.00000000.00000020
>        manfid#:  0000003e
>        version#:  00000001
>        model: 'SUNW,fhc0FA0'
>        name: 'fhc'
>
>        Node 0xf00dfa08
>            .node:  f00dfa08
>            reg:  00000000.01000000.00008000.00000000.02000000.01000000
>            bank-0-status: 'ok'
>            bank-1-status: 'ok'
>            manfid#:  0000003e
>            version#:  00000005
>            model: 'SUNW,ac0F9E'
>            device_type: 'memory-controller'
>            name: 'ac'
>
>        Node 0xf00dfb90
>            .node:  f00dfb90
>            reg:  00000000.00600000.00000010
>            name: 'simm-status'
>
>        Node 0xf00dfc28
>            .node:  f00dfc28
>            interrupts:  0000003b
>            reg:  00000000.00400000.00000010
>            name: 'environment'
>
>        Node 0xf00dfce4
>            .node:  f00dfce4
>            reg:  00000000.00200000.00008000.00000000.00280000.00008000
>            name: 'sram'
>
>        Node 0xf00dfd80
>            .node:  f00dfd80
>            version:  4f425020.2020332e.322e3330.20323030.322f3130.2f323520.31343a30.3300504f.53542020.332e392e.33302032.3030322f.31302f32.35203134.3a303400
>            model: 'SUNW,525-1431'
>            reg:  00000000.00000000.00080000
>            name: 'flashprom'
>
>    Node 0xf00dfec4
>        .node:  f00dfec4
>        manufacturer#:  00000017
>        implementation#:  00000011
>        mask#:  000000a0
>        sparc-version:  00000009
>        ecache-associativity:  00000001
>        ecache-line-size:  00000040
>        ecache-size:  00800000
>        #dtlb-entries:  00000040
>        dcache-associativity:  00000001
>        dcache-line-size:  00000020
>        dcache-size:  00004000
>        #itlb-entries:  00000040
>        icache-associativity:  00000002
>        icache-line-size:  00000020
>        icache-size:  00004000
>        upa-portid:  00000006
>        clock-frequency:  17d78400
>        rated-frequency:  17d78400
>        reg:  000001cc.00000000.00000000.00000008
>        board#:  00000003
>        device_type: 'cpu'
>        name: 'SUNW,UltraSPARC-II'
>
>    Node 0xf00e0284
>        .node:  f00e0284
>        manufacturer#:  00000017
>        implementation#:  00000011
>        mask#:  000000a0
>        sparc-version:  00000009
>        ecache-associativity:  00000001
>        ecache-line-size:  00000040
>        ecache-size:  00800000
>        #dtlb-entries:  00000040
>        dcache-associativity:  00000001
>        dcache-line-size:  00000020
>        dcache-size:  00004000
>        #itlb-entries:  00000040
>        icache-associativity:  00000002
>        icache-line-size:  00000020
>        icache-size:  00004000
>        upa-portid:  00000007
>        clock-frequency:  17d78400
>        rated-frequency:  17d78400
>        reg:  000001ce.00000000.00000000.00000008
>        board#:  00000003
>        device_type: 'cpu'
>        name: 'SUNW,UltraSPARC-II'
>
>    Node 0xf006f7bc
>        .node:  f006f7bc
>        ranges:  00000001.00000000.000001c5.10000000.10000000.00000002.00000000.000001c5.20000000.10000000.0000000d.00000000.000001c5.d0000000.10000000
>        interrupts:  000000b4.000000b5.000000b6.000000a5.000000aa.000000b7
>        version#:  00000001
>        implementation#:  00000000
>        bus-parity-generated:
>        address:  ffdb4000
>        scsi-initiator-id:  00000007
>        model: 'SUNW,sysio'
>        reg:  000001c4.00000000.00000000.00006000
>        slot-address-bits:  0000001c
>        up-burst-sizes:  0078007f
>        burst-sizes:  00f8007f
>        device_type: 'sbus'
>        name: 'sbus'
>        upa-portid:  00000002
>        clock-frequency:  017d7840
>        board#:  00000001
>
>        Node 0xf0075084
>            .node:  f0075084
>            wwn:  20040800.20b6eee2
>            intr:  00000003.00000000
>            interrupts:  00000022
>            ranges:  00000000.00000000.0000000d.00010240.00000018.00000001.00000000.0000000d.00010258.00000018.00000010.00000000.0000000d.00010300.00000008.00000011.00000000.0000000d.00010308.00000008
>            reg:  0000000d.00010000.00010018
>            device_type: 'socal'
>            version: '@(#) FCode 1.12 99/07/30'
>            manufacturer: 'SUNW'
>            model: '501-3060'
>            name: 'SUNW,socal'
>
>            Node 0xf007c8ec
>                .node:  f007c8ec
>                port-wwn:  20050800.20b6eee2
>                reg:  00000000.00000000.00000018.00000010.00000000.00000008
>                port#:  00000000
>                #address-cells:  00000004
>                device_type: 'scsi-3'
>                name: 'sf'
>
>                Node 0xf007e704
>                    .node:  f007e704
>                    device_type: 'block'
>                    name: 'ssd'
>
>            Node 0xf007efd4
>                .node:  f007efd4
>                port-wwn:  20060800.20b6eee2
>                reg:  00000001.00000000.00000018.00000011.00000000.00000008
>                port#:  00000001
>                #address-cells:  00000004
>                device_type: 'scsi-3'
>                name: 'sf'
>
>                Node 0xf007f670
>                    .node:  f007f670
>                    device_type: 'block'
>                    name: 'ssd'
>
>        Node 0xf0080050
>            .node:  f0080050
>            local-mac-address:  080020ee.2248
>            gem-rev:  00000000
>            burst-sizes:  0078007f
>            shared-pins: 'serdes'
>            board-rev:  00000005
>            interrupts:  00000004
>            compatible: 'SUNW,sbus-gem'
>            model: 'SUNW,sbus-gem'
>            has-fcode: ' '
>            version: '1.7'
>            device_type: 'network'
>            address-bits:  00000030
>            max-frame-size:  00004000
>            reg:  00000001.00100000.00000014.00000001.00200000.00009060
>            name: 'network'
>
>        Node 0xf0086420
>            .node:  f0086420
>            scsi-initiator-id:  00000007
>            isp-fcode: '1.21 95/05/18'
>            device_type: 'scsi'
>            intr:  00000003.00000000
>            interrupts:  00000003
>            wide:  00
>            clock-frequency:  02625a00
>            reg:  00000002.00010000.00000450
>            64-bit-clean:  00
>            model: 'QLGC,ISP1000'
>            name: 'QLGC,isp'
>
>            Node 0xf008bc8c
>                .node:  f008bc8c
>                device_type: 'block'
>                name: 'sd'
>
>            Node 0xf008c4a0
>                .node:  f008c4a0
>                device_type: 'byte'
>                name: 'st'
>
>    Node 0xf0071c1c
>        .node:  f0071c1c
>        board-type: 'dual-sbus-soc+'
>        manfid#:  0000003e
>        version#:  00000001
>        ranges:  00000000.00000000.000001c4.f8000000.08000000
>        reg:  000001c4.f8800000.00000000.00000110.000001c4.f8802000.00000000.00000010.000001c4.f8804000.00000000.00000020.000001c4.f8806000.00000000.00000020.000001c4.f8808000.00000000.00000020.000001c4.f880a000.00000000.00000020
>        board-model: 'SUNW,501-2558'
>        model: 'SUNW,fhc0FA0'
>        board#:  00000001
>        name: 'fhc'
>
>        Node 0xf00720cc
>            .node:  f00720cc
>            manfid#:  0000003e
>            version#:  00000005
>            device_type: 'memory-controller'
>            reg:  00000000.01000000.00008000.00000000.02000000.01000000
>            model: 'SUNW,ac0F9E'
>            name: 'ac'
>
>        Node 0xf0072204
>            .node:  f0072204
>            interrupts:  0000003b
>            reg:  00000000.00400000.00000010
>            name: 'environment'
>
>        Node 0xf00722c0
>            .node:  f00722c0
>            version:  46434f44.4520312e.382e3330.20323030.322f3130.2f323520.31343a30.32006950.4f535420.332e342e.33302032.3030322f.31302f32.35203134.3a303300
>            model: 'SUNW,525-1757'
>            reg:  00000000.00000000.00080000
>            name: 'flashprom'
>
>        Node 0xf00726f8
>            .node:  f00726f8
>            address:  ffd98000
>            interrupts:  0000003a
>            reg:  00000000.00300000.00002000
>            model: 'mk48t59'
>            name: 'eeprom'
>
>        Node 0xf00727f0
>            .node:  f00727f0
>            reg:  00000000.00500000.00000010
>            name: 'sbus-speed'
>
>    Node 0xf00728e4
>        .node:  f00728e4
>        address:  ffd97c00.ffd93860.ffd95060
>        interrupts:  000000b0.000000b1
>        reg:  000001c4.00003c00.00000000.00000020.000001c4.00003860.00000000.00000010.000001c4.00003060.00000000.00000010
>        board#:  00000001
>        name: 'counter-timer'
>
>    Node 0xf0072ad4
>        .node:  f0072ad4
>        ranges:  00000000.00000000.000001c7.00000000.10000000.00000003.00000000.000001c7.30000000.10000000
>        interrupts:  000000f4.000000f5.000000f6.000000e5.000000ea.000000f7
>        version#:  00000001
>        implementation#:  00000000
>        bus-parity-generated:
>        address:  ffd8c000
>        scsi-initiator-id:  00000007
>        model: 'SUNW,sysio'
>        reg:  000001c6.00000000.00000000.00006000
>        slot-address-bits:  0000001c
>        up-burst-sizes:  0078007f
>        burst-sizes:  00f8007f
>        device_type: 'sbus'
>        name: 'sbus'
>        upa-portid:  00000003
>        clock-frequency:  017d7840
>        board#:  00000001
>
>        Node 0xf008d070
>            .node:  f008d070
>            hm-rev:  00000022
>            device_type: 'network'
>            intr:  00000004.00000000
>            interrupts:  00000004
>            address-bits:  00000030
>            max-frame-size:  00004000
>            reg:  00000003.08c00000.00000108.00000003.08c02000.00002000.00000003.08c04000.00002000.00000003.08c06000.00002000.00000003.08c07000.00000020
>            name: 'SUNW,hme'
>
>        Node 0xf0093c14
>            .node:  f0093c14
>            hm-rev:  00000022
>            device_type: 'scsi'
>            clock-frequency:  02625a00
>            intr:  00000003.00000000
>            interrupts:  00000003
>            reg:  00000003.08800000.00000010.00000003.08810000.00000040
>            name: 'SUNW,fas'
>
>            Node 0xf009864c
>                .node:  f009864c
>                device_type: 'block'
>                name: 'sd'
>
>            Node 0xf0098f08
>                .node:  f0098f08
>                device_type: 'byte'
>                name: 'st'
>
>        Node 0xf0099bf4
>            .node:  f0099bf4
>            reg:  00000000.00000000.00000400.00000000.00100000.00001000.00000000.00200000.00040000.00000000.00300000.00020000.00000000.00400000.00002000.00000000.00500000.00002000.00000000.00600000.00001000.00000000.00700000.00020000.00000000.00800000.00000400.00000000.00900000.00000400
>            intr:  00000004.00000000
>            interrupts:  00000004
>            media: 'utp'
>            atm-speed: 'SUNI-155'
>            sahi-revision: 'a'
>            model: 'SUNW,SAHI-3'
>            name: 'ba'
>
>    Node 0xf0074e94
>        .node:  f0074e94
>        address:  ffd7dc00.ffd79860.ffd7b060
>        interrupts:  000000f0.000000f1
>        reg:  000001c6.00003c00.00000000.00000020.000001c6.00003860.00000000.00000010.000001c6.00003060.00000000.00000010
>        board#:  00000001
>        name: 'counter-timer'
>
>    Node 0xf01bf7bc
>        .node:  f01bf7bc
>        available:  82000000.00000000.02808000.00000000.7d7f8000.81000000.00000000.00000400.00000000.0000fc00
>        bus-range:  00000000.00000000
>        version#:  00000004
>        implementation#:  00000000
>        clock-frequency:  01f78a40
>        upa-portid:  0000000e
>        interrupts:  000003b1.000003ae.000003af.000003a5.000003a8.000003b2
>        ranges:  00000000.00000000.00000000.000001dc.01000000.00000000.00800000.01000000.00000000.00000000.000001dc.02010000.00000000.00010000.02000000.00000000.00000000.000001dd.80000000.00000000.80000000.03000000.00000000.00000000.000001dd.80000000.00000000.80000000
>        address:  ffd76000.ffd74000.ffd66000
>        reg:  000001dc.00004000.00000000.00002000.000001dc.01000000.00000000.00000100.000001dc.00000000.00000000.0000d000
>        board#:  00000007
>        model: 'SUNW,psycho'
>        compatible: 'pci108e,8000'
>        bus-parity-generated:
>        #size-cells:  00000002
>        #address-cells:  00000003
>        device_type: 'pci'
>        name: 'pci'
>
>        Node 0xf01d3d84
>            .node:  f01d3d84
>            assigned-addresses:  82000810.00000000.01000000.00000000.01000000.82000814.00000000.02000000.00000000.00800000
>            power-consumption:  00000000.00e4e1c0
>            reg:  00000800.00000000.00000000.00000000.00000000.02000810.00000000.00000000.00000000.01000000.02000814.00000000.00000000.00000000.00800000
>            compatible:  70636931.3038652c.31303030.00706369.636c6173.732c3036.38303030.00
>            name: 'pci108e,1000'
>            66mhz-capable:  00000000
>            udf-supported:  00000000
>            fast-back-to-back:  00000001
>            devsel-speed:  00000001
>            class-code:  00068000
>            interrupts:  00000001
>            max-latency:  00000019
>            min-grant:  0000000a
>            revision-id:  00000001
>            device-id:  00001000
>            vendor-id:  0000108e
>
>        Node 0xf01d4058
>            .node:  f01d4058
>            assigned-addresses:  82000910.00000000.02800000.00000000.00007030
>            compatible: 'pci108e,1001'
>            version: '1.17'
>            device_type: 'network'
>            hm-rev:  000000c1
>            address-bits:  00000030
>            max-frame-size:  00004000
>            reg:  00000900.00000000.00000000.00000000.00000000.02000910.00000000.00000000.00000000.00007030
>            model: 'SUNW,cheerio'
>            name: 'SUNW,hme'
>            66mhz-capable:  00000000
>            udf-supported:  00000000
>            fast-back-to-back:  00000001
>            devsel-speed:  00000001
>            class-code:  00020000
>            interrupts:  000003a1
>            max-latency:  00000005
>            min-grant:  0000000a
>            revision-id:  00000001
>            device-id:  00001001
>            vendor-id:  0000108e
>
>    Node 0xf01c88e0
>        .node:  f01c88e0
>        available:  82800000.00000000.00400000.00000000.7fc00000.81800000.00000000.00000400.00000000.0000fc00
>        bus-range:  00000080.00000080
>        version#:  00000004
>        implementation#:  00000000
>        clock-frequency:  01f78a40
>        slot-names:  00000004.7063692d.736c6f74.203000
>        upa-portid:  0000000e
>        66mhz-capable:
>        interrupts:  000003b0.000003ae.000003af.000003a5.000003a8.000003b2
>        ranges:  00800000.00000000.00000000.000001dc.01000000.00000000.00800000.01000000.00000000.00000000.000001dc.02000000.00000000.00010000.02000000.00000000.00000000.000001dd.00000000.00000000.80000000.03000000.00000000.00000000.000001dd.00000000.00000000.80000000
>        address:  ffd5c000.ffd5a000.ffd4c000
>        reg:  000001dc.00002000.00000000.00002000.000001dc.01800000.00000000.00000100.000001dc.00000000.00000000.0000d000
>        board#:  00000007
>        model: 'SUNW,psycho'
>        compatible: 'pci108e,8000'
>        bus-parity-generated:
>        #size-cells:  00000002
>        #address-cells:  00000003
>        device_type: 'pci'
>        name: 'pci'
>
>        Node 0xf01e7cb8
>            .node:  f01e7cb8
>            assigned-addresses:  82801010.00000000.00200000.00000000.00009060
>            local-mac-address:  0003ba04.8154
>            shared-pins: 'serdes'
>            board-rev:  00000006
>            model: 'SUNW,pci-gem'
>            has-fcode: ' '
>            version: '1.7 '
>            device_type: 'network'
>            address-bits:  00000030
>            max-frame-size:  00004000
>            reg:  00801000.00000000.00000000.00000000.00000000.02801010.00000000.00000000.00000000.00009060
>            gem-rev:  00000001
>            compatible:  70636931.3038652c.32626164.00706369.636c6173.732c3032.30303030.00
>            name: 'network'
>            fcode-rom-offset:  00000000
>            66mhz-capable:  00000001
>            udf-supported:  00000000
>            fast-back-to-back:  00000001
>            devsel-speed:  00000002
>            class-code:  00020000
>            interrupts:  00000001
>            subsystem-id:  00000001
>            max-latency:  00000040
>            min-grant:  00000040
>            revision-id:  00000001
>            device-id:  00002bad
>            vendor-id:  0000108e
>
>    Node 0xf01c923c
>        .node:  f01c923c
>        board-type: 'dual-pci'
>        manfid#:  0000003e
>        version#:  00000001
>        ranges:  00000000.00000000.000001dc.f8000000.08000000
>        reg:  000001dc.f8800000.00000000.00000110.000001dc.f8802000.00000000.00000010.000001dc.f8804000.00000000.00000020.000001dc.f8806000.00000000.00000020.000001dc.f8808000.00000000.00000020.000001dc.f880a000.00000000.00000020
>        board-model: 'SUNW,501-3023'
>        model: 'SUNW,fhc0FA0'
>        board#:  00000007
>        name: 'fhc'
>
>        Node 0xf01c9718
>            .node:  f01c9718
>            manfid#:  0000003e
>            version#:  00000005
>            device_type: 'memory-controller'
>            reg:  00000000.01000000.00008000.00000000.02000000.01000000
>            model: 'SUNW,ac0F9E'
>            name: 'ac'
>
>        Node 0xf01c9850
>            .node:  f01c9850
>            interrupts:  0000003b
>            reg:  00000000.00400000.00000010
>            name: 'environment'
>
>        Node 0xf01c990c
>            .node:  f01c990c
>            version:  46434f44.4520312e.382e3330.20323030.322f3130.2f323520.31343a30.32006950.4f535420.332e302e.33302032.3030322f.31302f32.35203134.3a303300
>            model: 'SUNW,525-1680'
>            reg:  00000000.00000000.00080000
>            name: 'flashprom'
>
>        Node 0xf01c9d44
>            .node:  f01c9d44
>            address:  ffd3e000
>            interrupts:  0000003a
>            reg:  00000000.00300000.00002000
>            model: 'mk48t59'
>            name: 'eeprom'
>
>        Node 0xf01c9e3c
>            .node:  f01c9e3c
>            reg:  00000000.00500000.00000010
>            name: 'sbus-speed'
>
>    Node 0xf01c9f28
>        .node:  f01c9f28
>        address:  ffd3dc00.ffd39860.ffd3b060
>        interrupts:  000003ac.000003ad
>        reg:  000001dc.00001c00.00000000.00000020.000001dc.00001860.00000000.00000010.000001dc.00001060.00000000.00000010
>        board#:  00000007
>        name: 'counter-timer'
>
>    Node 0xf01ca118
>        .node:  f01ca118
>        available:  82000000.00000000.00020000.00000000.7ffe0000.81000000.00000000.00000500.00000000.0000fb00
>        bus-range:  00000000.00000000
>        version#:  00000004
>        implementation#:  00000000
>        clock-frequency:  01f78a40
>        upa-portid:  0000000f
>        interrupts:  000003f1.000003ee.000003ef.000003e5.000003e8.000003f2
>        ranges:  00000000.00000000.00000000.000001de.01000000.00000000.00800000.01000000.00000000.00000000.000001de.02010000.00000000.00010000.02000000.00000000.00000000.000001df.80000000.00000000.80000000.03000000.00000000.00000000.000001df.80000000.00000000.80000000
>        address:  ffd36000.ffd34000.ffd26000
>        reg:  000001de.00004000.00000000.00002000.000001de.01000000.00000000.00000100.000001de.00000000.00000000.0000d000
>        board#:  00000007
>        model: 'SUNW,psycho'
>        compatible: 'pci108e,8000'
>        bus-parity-generated:
>        #size-cells:  00000002
>        #address-cells:  00000003
>        device_type: 'pci'
>        name: 'pci'
>
>        Node 0xf01dc3c0
>            .node:  f01dc3c0
>            assigned-addresses:  81001810.00000000.00000400.00000000.00000100.82001814.00000000.00002000.00000000.00001000.82001830.00000000.00010000.00000000.00010000
>            model: 'QLGC,ISP1040B'
>            scsi-initiator-id:  00000007
>            clock-frequency:  03938700
>            alternate-reg:  00000000.00000000.00000000.00000000.00000000.02001814.00000000.00000000.00000000.00000100.01001810.00000000.00000000.00000000.00000100
>            reg:  00001800.00000000.00000000.00000000.00000000.01001810.00000000.00000000.00000000.00000100.02001814.00000000.00000000.00000000.00001000.02001830.00000000.00000000.00000000.00010000
>            power-consumption:  00000000.00000000.00895440.00895440
>            manufacturer: 'QLGC'
>            device_type: 'scsi'
>            name: 'SUNW,isptwo'
>            66mhz-capable:  00000000
>            udf-supported:  00000000
>            fast-back-to-back:  00000000
>            devsel-speed:  00000001
>            class-code:  00010000
>            interrupts:  000003e0
>            max-latency:  00000000
>            min-grant:  00000000
>            revision-id:  00000002
>            device-id:  00001020
>            vendor-id:  00001077
>
>            Node 0xf01e6534
>                .node:  f01e6534
>                device_type: 'block'
>                name: 'sd'
>
>            Node 0xf01e7010
>                .node:  f01e7010
>                device_type: 'byte'
>                name: 'st'
>
>    Node 0xf01d320c
>        .node:  f01d320c
>        available:  82800000.00000000.00004000.00000000.7fffc000.81800000.00000000.00000900.00000000.0000f700
>        bus-range:  00000080.00000080
>        version#:  00000004
>        implementation#:  00000000
>        clock-frequency:  03ef1480
>        slot-names:  00000004.7063692d.736c6f74.203100
>        upa-portid:  0000000f
>        66mhz-capable:
>        interrupts:  000003f0.000003ee.000003ef.000003e5.000003e8.000003f2
>        ranges:  00800000.00000000.00000000.000001de.01000000.00000000.00800000.01000000.00000000.00000000.000001de.02000000.00000000.00010000.02000000.00000000.00000000.000001df.00000000.00000000.80000000.03000000.00000000.00000000.000001df.00000000.00000000.80000000
>        address:  ffd1c000.ffd1a000.ffd0c000
>        reg:  000001de.00002000.00000000.00002000.000001de.01800000.00000000.00000100.000001de.00000000.00000000.0000d000
>        board#:  00000007
>        model: 'SUNW,psycho'
>        compatible: 'pci108e,8000'
>        bus-parity-generated:
>        #size-cells:  00000002
>        #address-cells:  00000003
>        device_type: 'pci'
>        name: 'pci'
>
>        Node 0xf01ee484
>            .node:  f01ee484
>            assigned-addresses:  81801010.00000000.00000400.00000000.00000100.83801014.00000000.00002000.00000000.00002000.8180101c.00000000.00000800.00000000.00000100
>            power-consumption:  00000000.00e4e1c0
>            reg:  00801000.00000000.00000000.00000000.00000000.01801010.00000000.00000000.00000000.00000100.03801014.00000000.00000000.00000000.00002000.0180101c.00000000.00000000.00000000.00000100
>            compatible:  70636939.3030352c.34340070.63693930.30352c38.30313700.70636963.6c617373.2c303130.30303000.73637369.00
>            name: 'scsi'
>            66mhz-capable:  00000001
>            udf-supported:  00000000
>            fast-back-to-back:  00000000
>            devsel-speed:  00000002
>            class-code:  00010000
>            interrupts:  00000001
>            subsystem-vendor-id:  00009005
>            subsystem-id:  00000044
>            max-latency:  00000019
>            min-grant:  00000028
>            revision-id:  00000010
>            device-id:  00008017
>            vendor-id:  00009005
>
>    Node 0xf01d3b68
>        .node:  f01d3b68
>        address:  ffd0bc00.ffd07860.ffd09060
>        interrupts:  000003ec.000003ed
>        reg:  000001de.00001c00.00000000.00000020.000001de.00001860.00000000.00000010.000001de.00001060.00000000.00000010
>        board#:  00000007
>        name: 'counter-timer'
>
>
> --
> Meelis Roos (mroos@linux.ee)
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
E
