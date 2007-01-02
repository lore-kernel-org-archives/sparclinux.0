From: Eki <eki@sci.fi>
Date: Tue, 02 Jan 2007 14:03:25 +0000
Subject: IRQ routing(?) problem on Enterprise 450 with Areca SATA RAID controller
Message-Id: <20070102140325.GB11095@wopr.homeunix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

It seems that 2.6.17 (or -stable 2.6.17.14) is the last working
kernel with E450, using Areca SATA RAID controller.

I tested a lot of newer kernel versions, 2.6.18, 2.6.19, some -rc's,
and the latest sparc-2.6 git tree as of 30th december, but none of them
will work correctly:

 [root@e450] [~] # uname -r
 2.6.20-rc2-davem-061230

 [root@e450] [~] # modprobe arcmsr
 ARECA RAID ADAPTER2: FIRMWARE VERSION V1.42 2006-10-13
 scsi2 : Areca SATA Host Adapter RAID Controller( RAID6 capable)
 Driver Version 1.20.00.13
 arcmsr2: abort device command of scsi id=0 lun=0
 arcmsr2: scsi id=0 lun=0 ccb='0xfffff800fc840000' poll command abort successfully
 arcmsr2: abort device command of scsi id=0 lun=0
 arcmsr2: scsi id=0 lun=0 ccb='0xfffff800fc840240' poll command abort successfully
 arcmsr2: abort device command of scsi id=0 lun=0
 arcmsr2: scsi id=0 lun=0 ccb='0xfffff800fc840480' poll command abort successfully
 scsi 2:0:0:0: scsi: Device offlined - not ready after error recovery
 arcmsr2: abort device command of scsi id=1 lun=0
 arcmsr2: scsi id=1 lun=0 ccb='0xfffff800fc8406c0' poll command abort successfully
 arcmsr2: abort device command of scsi id=1 lun=0
 arcmsr2: scsi id=1 lun=0 ccb='0xfffff800fc840900' poll command abort successfully

I found this thread from August, which seems to describe the same
problem I'm experiencing:

http://www.spinics.net/lists/sparclinux/msg00458.html

I've done as David S. Miller suggested, and booted the kernel with
"ofdebug=2"

I've attached "prtconf -lv" from a working 2.6.17.14 and non-working
2.6.20-rc2 kernels.

Anybody have any idea what's going on?

Thanks,

Eki

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="prtconf_2.6.17.14.txt"
Content-Transfer-Encoding: quoted-printable

System Configuration:  Sun Microsystems  sun4u
Memory size: 4096 Megabytes
System Peripherals (PROM Nodes):

Node 0xf002a490
    scsi-initiator-id:  00000007
    reset-reason: 'S-POR'
    energystar-v2: =20
    model: 'SUNW,501-5270'
    idprom:  01800800.2096014b.ffffffff.96014ba9.efffefff.ff00ff00.00000000=
=2E00000000
    compatible: 'sun4u'
    builtin-io-device-port:  0000001f
    device-probe-order: '1b,0,4,9,'
    breakpoint-trap:  0000007f
    #size-cells:  00000002
    name: 'SUNW,Ultra-4'
    clock-frequency:  05f5e100
    banner-name: 'Sun Enterprise 450 (4 X UltraSPARC-II 400MHz)'
    device_type: 'upa'

    Node 0xf002d8d4
        name: 'packages'

        Node 0xf0034e48
            iso6429-1983-colors: =20
            name: 'terminal-emulator'

        Node 0xf0037b84
            disk-write-fix: =20
            name: 'deblocker'

        Node 0xf0038260
            name: 'obp-tftp'

        Node 0xf00430e4
            name: 'disk-label'

        Node 0xf0066bc8
            name: 'SUNW,builtin-drivers'

        Node 0xf007cb6c
            name: 'sun-keyboard'

    Node 0xf002d944
        stdin:  fff19710
        stdout:  fff19cd0
        mmu:  fffe9438
        memory:  fffe9638
        bootargs:  00
        bootpath: '/pci@1f,4000/scsi@3/disk@0,0:a'
        stdout-#lines:  ffffffff
        name: 'chosen'

    Node 0xf002d9b0
        version: 'OBP 3.30.0 2003/11/11 10:41'
        model: 'SUNW,3.30'
        decode-complete: =20
        aligned-allocator: =20
        relative-addressing: =20
        name: 'openprom'

        Node 0xf002da40
            name: 'client-services'

    Node 0xf002dae8
        tpe-link-test?: 'true'
        scsi-initiator-id: '7'
        keyboard-click?: 'false'
        keymap: =20
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
        pci0-probe-list: '1,3,2,4'
        upa-port-skip-list: 'none'
        memory-interleave: 'auto'
        disk-led-assoc: '0'
        diag-level: 'min'
        diag-script: 'normal'
        diag-targets: 'none'
        diag-trigger: 'power-reset'
        diag-continue?: 'false'
        diag-passes: '1'
        diag-verbosity: 'tests'
        env-monitor: 'enabled'
        .asr-disable-list: =20
        .asr-status: '18437736870358094097'
        .post-status: '18437736870358094097'
        .post-address: '18446744073441856352'
        .post-flag: '0'
        .rsc-status: '85'
        .obp-flags: '0'
        .obp-state: '6'
        .obp-status: '0'
        mfg-options: 'server-class'
        #power-cycles: '212'
        system-board-serial#: '828M2CD0'
        system-board-date: '35a834d8'
        fcode-debug?: 'false'
        output-device: 'ttya'
        input-device: 'ttya'
        load-base: '16384'
        boot-command: 'boot'
        auto-boot?: 'false'
        auto-boot-on-error?: 'false'
        watchdog-reboot?: 'false'
        diag-file: =20
        diag-device: 'net'
        boot-file: =20
        boot-device: 'disk net'
        local-mac-address?: 'false'
        ansi-terminal?: 'true'
        screen-#columns: '80'
        screen-#rows: '34'
        silent-mode?: 'false'
        use-nvramrc?: 'false'
        nvramrc: =20
        security-mode: 'none'
        security-password: =20
        security-#badlogins: '0'
        oem-logo: =20
        oem-logo?: 'false'
        oem-banner: =20
        oem-banner?: 'false'
        hardware-revision: 'UUUUUUUUUUUUUUU'
        last-hardware-update: 'UUUUUUU'
        .upa-noprobe-mask: '0'
        diag-switch?: 'false'
        name: 'options'

    Node 0xf002db58
        disk: '/pci@1f,4000/scsi@3/disk@0,0'
        disk0: '/pci@1f,4000/scsi@3/disk@0,0'
        disk1: '/pci@1f,4000/scsi@3/disk@1,0'
        disk2: '/pci@1f,4000/scsi@3/disk@2,0'
        disk3: '/pci@1f,4000/scsi@3/disk@3,0'
        scsi: '/pci@1f,4000/scsi@3'
        diskx0: '/pci@1f,4000/scsi@2/disk@0,0'
        diskx1: '/pci@1f,4000/scsi@2/disk@1,0'
        diskx2: '/pci@1f,4000/scsi@2/disk@2,0'
        diskx3: '/pci@1f,4000/scsi@2/disk@3,0'
        cdrom: '/pci@1f,4000/scsi@2/disk@6,0:f'
        tape: '/pci@1f,4000/scsi@2/tape@4,0'
        scsix: '/pci@1f,4000/scsi@2'
        pci: '/pci@1f,4000'
        pcia: '/pci@1f,2000'
        pcib: '/pci@1f,4000'
        pci0: '/pci@1f,4000'
        pci1: '/pci@1f,2000'
        pci2: '/pci@4,4000'
        pci3: '/pci@4,2000'
        pci4: '/pci@6,4000'
        pci5: '/pci@6,2000'
        flash: '/pci@1f,4000/ebus@1/flashprom@10,0'
        nvram: '/pci@1f,4000/ebus@1/eeprom@14,0'
        parallel: '/pci@1f,4000/ebus@1/ecpp@14,3043bc'
        net: '/pci@1f,4000/network@1,1'
        ebus: '/pci@1f,4000/ebus@1'
        i2c: '/pci@1f,4000/ebus@1/SUNW,envctrl'
        floppy: '/pci@1f,4000/ebus@1/fdthree'
        tty: '/pci@1f,4000/ebus@1/se'
        ttyb: '/pci@1f,4000/ebus@1/se:b'
        ttya: '/pci@1f,4000/ebus@1/se:a'
        keyboard!: '/pci@1f,4000/ebus@1/su@14,3083f8:forcemode'
        keyboard: '/pci@1f,4000/ebus@1/su@14,3083f8'
        mouse: '/pci@1f,4000/ebus@1/su@14,3062f8'
        name: 'aliases'

    Node 0xf0051de8
        interleave:  00000000.00000000.00000001.00000000.00000004
        reg:  00000000.00000000.00000001.00000000
        #size-cells:  00000002
        available:  00000000.ffeb6000.00000000.00002000.00000000.ffe98000.0=
0000000.00016000.00000000.ffe00000.00000000.00096000.00000000.00000000.0000=
0000.ffdfe000
        name: 'memory'

    Node 0xf00523c8
        translations:  00000000.fffe0000.00000000.00010000.80000000.ffef00b=
6.00000000.fffcc000.00000000.00014000.80000000.ffed40b6.00000000.fffc6000.0=
0000000.00002000.800001fe.0000208e.00000000.fffc4000.00000000.00002000.8000=
01fe.0180008e.00000000.fffb6000.00000000.0000e000.800001fe.0000008e.0000000=
0.fffb4000.00000000.00002000.800001fe.0000408e.00000000.fffb2000.00000000.0=
0002000.800001fe.0100008e.00000000.fffa4000.00000000.0000e000.800001fe.0000=
008e.00000000.fffa0000.00000000.00004000.80000000.ffed00b6.00000000.fff9e00=
0.00000000.00002000.800001fe.0000008e.00000000.fff9c000.00000000.00002000.8=
00001fe.0000008e.00000000.fff9a000.00000000.00002000.800001fe.0000008e.0000=
0000.fff98000.00000000.00002000.800001ff.f100008e.00000000.fff96000.0000000=
0.00002000.800001ff.f100008e.00000000.fff94000.00000000.00002000.800001ff.f=
150008e.00000000.fff92000.00000000.00002000.800001ff.f172608e.00000000.fff9=
0000.00000000.00002000.800001ff.f172808e.00000000.fff8e000.00000000.0000200=
0.800001ff.f172a08e.00000000.fff8c000.00000000.00002000.800001ff.f172c08e.0=
0000000.fff8a000.00000000.00002000.800001ff.f172e08e.00000000.fff88000.0000=
0000.00002000.800001ff.f130808e.00000000.fff82000.00000000.00006000.8000000=
0.ffec80b6.00000000.fff80000.00000000.00002000.80000000.ffdfe0b6.00000000.f=
ff7e000.00000000.00002000.80000000.ffec60b6.00000000.fff7c000.00000000.0000=
2000.800001ff.f160008e.00000000.fff7a000.00000000.00002000.800001ff.f130208=
e.00000000.fff78000.00000000.00002000.800001ff.f170608e.00000000.fff76000.0=
0000000.00002000.800001ff.f172008e.00000000.fff74000.00000000.00002000.8000=
01ff.f130208e.00000000.fff72000.00000000.00002000.800001ff.f130208e.0000000=
0.fff70000.00000000.00002000.800001c8.0000208e.00000000.fff6e000.00000000.0=
0002000.800001c8.0180008e.00000000.fff60000.00000000.0000e000.800001c8.0000=
008e.00000000.fff5e000.00000000.00002000.800001c8.0000408e.00000000.fff5c00=
0.00000000.00002000.800001c8.0100008e.00000000.fff4e000.00000000.0000e000.8=
00001c8.0000008e.00000000.fff4a000.00000000.00004000.80000000.ffec00b6.0000=
0000.fff48000.00000000.00002000.800001cc.0000208e.00000000.fff46000.0000000=
0.00002000.800001cc.0180008e.00000000.fff38000.00000000.0000e000.800001cc.0=
000008e.00000000.fff36000.00000000.00002000.800001cc.0000408e.00000000.fff3=
4000.00000000.00002000.800001cc.0100008e.00000000.fff26000.00000000.0000e00=
0.800001cc.0000008e.00000000.fff22000.00000000.00004000.80000000.ffebc0b6.0=
0000000.fff20000.00000000.00002000.800001ff.f140008e.00000000.fff18000.0000=
0000.00002000.80000000.ffec40b6.00000000.ffef8000.00000000.00008000.8000000=
0.ffeae0b6.00000000.f0000000.00000000.00100000.80000000.fff000b6.00000000.4=
0000000.00000000.00800000.80000000.00400036.00000000.00002000.00000000.00bf=
e000.80000000.00002036
        existing:  00000000.00000000.00000800.00000000.fffff800.00000000.00=
000800.00000000
        available:  fffff800.00000000.000007fc.00000000.00000001.00000000.0=
00007ff.00000000.00000000.ffff0000.00000000.0000e000.00000000.00000000.0000=
0000.f0000000.00000000.fff1a000.00000000.00006000.00000000.fff00000.0000000=
0.00018000.00000000.f0800000.00000000.0e800000
        page-size:  00002000
        name: 'virtual-memory'

    Node 0xf005798c
        name: 'associations'

        Node 0xf00a18a4
            slot#3: '/pci@1f,4000/scsi@3/disk@3'
            slot#2: '/pci@1f,4000/scsi@3/disk@2'
            slot#1: '/pci@1f,4000/scsi@3/disk@1'
            slot#0: '/pci@1f,4000/scsi@3/disk@0'
            name: 'slot2disk'

        Node 0xf00a1948
            slot#3: '/pci@1f,4000/ebus@1/i2c@14,600000/bits@40/wo@3'
            slot#2: '/pci@1f,4000/ebus@1/i2c@14,600000/bits@40/wo@2'
            slot#1: '/pci@1f,4000/ebus@1/i2c@14,600000/bits@40/wo@1'
            slot#0: '/pci@1f,4000/ebus@1/i2c@14,600000/bits@40/wo@0'
            name: 'slot2led'

        Node 0xf00a1bfc
            ebus|audio: '/pci@1f,4000/ebus@1/*@14,200000'
            pci-slot#10: '/pci@1f,4000/*@4,*'
            pci-slot#9: '/pci@4,4000/*@2,*'
            pci-slot#8: '/pci@4,4000/*@3,*'
            pci-slot#7: '/pci@4,4000/*@4,*'
            pci-slot#6: '/pci@4,2000/*@1,*'
            pci-slot#5: '/pci@1f,2000/*@1,*'
            pci-slot#4: '/pci@6,2000/*@1,*'
            pci-slot#3: '/pci@6,4000/*@2,*'
            pci-slot#2: '/pci@6,4000/*@3,*'
            pci-slot#1: '/pci@6,4000/*@4,*'
            graphics#2: '/*@1d,0'
            graphics#1: '/*@1e,0'
            cpu-b2: '/*@3,0'
            cpu-b1: '/*@2,0'
            cpu-a2: '/*@1,0'
            cpu-a1: '/*@0,0'
            name: 'slot2dev'

    Node 0xf006ec38
        slot-names:  0000001e.4d6f7468.6572626f.61726400.4d6f7468.6572626f.=
61726400.4d6f7468.6572626f.61726400.50434920.736c6f74.20313000
        available:  82000000.00000000.00017000.00000000.7ffe9000.81000000.0=
0000000.00000900.00000000.0000f700
        bus-range:  00000000.00000000
        version#:  00000004
        implementation#:  00000000
        address:  fffb4000.fffb2000.fffa4000
        #upa-interrupt-proxies:  00000002
        clock-frequency:  01f78a40
        upa-portid:  0000001f
        interrupts:  000007f1.000007ee.000007ef.000007e5.000007e8.000007f2
        ranges:  00000000.00000000.00000000.000001fe.01000000.00000000.0080=
0000.01000000.00000000.00000000.000001fe.02010000.00000000.00010000.0200000=
0.00000000.00000000.000001ff.80000000.00000000.80000000.03000000.00000000.0=
0000000.000001ff.80000000.00000000.80000000
        reg:  000001fe.00004000.00000000.00002000.000001fe.01000000.0000000=
0.00000100.000001fe.00000000.00000000.0000d000
        no-probe-list: '0'
        latency-timer:  00000040
        model: 'SUNW,psycho'
        compatible:  70636931.3038652c.38303030.00706369.636c6173.732c3036.=
30303030.00
        thermal-interrupt: =20
        bus-parity-generated: =20
        #size-cells:  00000002
        #address-cells:  00000003
        device_type: 'pci'
        name: 'pci'

        Node 0xf0071344
            fru: 'motherboard'
            latency-timer:  0000000a
            fast-back-to-back: =20
            devsel-speed:  00000001
            class-code:  00068000
            max-latency:  00000019
            min-grant:  0000000a
            revision-id:  00000001
            device-id:  00001000
            vendor-id:  0000108e
            ranges:  00000010.00000000.82000810.00000000.70000000.01000000.=
00000014.00000000.82000814.00000000.71000000.00800000
            reg:  00000800.00000000.00000000.00000000.00000000.82000810.000=
00000.70000000.00000000.01000000.82000814.00000000.71000000.00000000.008000=
00
            #size-cells:  00000001
            #address-cells:  00000002
            name: 'ebus'

            Node 0xf00718c8
                address:  fff92000.fff90000.fff8e000.fff8c000.fff8b000
                reg:  00000014.00726000.00000004.00000014.00728000.00000004=
=2E00000014.0072a000.00000004.00000014.0072c000.00000004.00000014.0072f000.=
00000004
                name: 'auxio'

            Node 0xf0071988
                interrupts:  000007e5.000007f2
                reg:  00000014.00724000.00000004
                name: 'power'

            Node 0xf0071a18
                freq-syn: 'MC12430'
                reg:  00000014.00504000.00000003
                name: 'SUNW,pll'

            Node 0xf0071aac
                address:  fff94000
                version#:  00000001
                implementation#:  00000000
                model: 'SUNW,sc-marvin'
                reg:  00000014.00500000.00000008
                name: 'sc'

            Node 0xf0071b64
                fru: 'motherboard'
                port-b-ignore-cd: =20
                port-a-ignore-cd: =20
                interrupts:  0000002b
                reg:  00000014.00400000.00000080
                device_type: 'serial'
                name: 'se'

            Node 0xf0073608
                fru: 'motherboard'
                reg:  00000014.003083f8.00000008
                interrupts:  00000029
                port-a-ignore-cd: =20
                keyboard: =20
                device_type: 'serial'
                name: 'su'

            Node 0xf0074ea0
                fru: 'motherboard'
                interrupts:  0000002a
                port-a-ignore-cd: =20
                mouse: =20
                reg:  00000014.003062f8.00000008
                device_type: 'serial'
                name: 'su'

            Node 0xf0074fbc
                fru: 'motherboard'
                interrupts:  000007e2
                reg:  00000014.003043bc.00000010.00000014.00300398.00000002=
=2E00000014.00700000.00000010
                name: 'ecpp'

            Node 0xf00750bc
                fru: 'motherboard'
                manual: =20
                unit:  00000000
                address:  fff7a3f0.fff78000.fff76000
                device_type: 'block'
                interrupts:  000007e7
                reg:  00000014.003023f0.00000008.00000014.00706000.00000010=
=2E00000014.00720000.00000004
                name: 'fdthree'

            Node 0xf0076a68
                fru: 'motherboard'
                address:  fff96000
                reg:  00000014.00000000.00002000
                model: 'mk48t59'
                name: 'eeprom'

            Node 0xf0076b50
                compatible:  69323866.30303874.32006932.38663030.3800
                version:  4f425020.332e3330.2e302032.3030332f.31312f31.3120=
3130.3a343100.504f5354.20362e31.2e302032.3030332f.31312f31.31203130.3a323700
                model: 'SUNW,525-1776'
                reg:  00000010.00000000.00100000.00000010.00000000.00100000
                name: 'flashprom'

            Node 0xf0079c30
                thermisters:  0000009e.00000000.00000005.0000003e.0000004b.=
00000001.00000001.43505530.00000000.9e000000.01000000.05000000.3e000000.4b0=
00000.01000000.01435055.31000000.009e0000.00020000.00050000.003e0000.004b00=
00.00010000.00014350.55320000.00009e00.00000300.00000500.00003e00.00004b00.=
00000100.00000143.50553300.00000090.00000000.00000005.0000005a.00000064.000=
00001.00000001.50533000.00000092.00000000.00000005.0000005a.00000064.000000=
01.00000001.50533100.00000094.00000000.00000005.0000005a.00000064.00000001.=
00000001.50533200.0000009a.00000000.00000005.00000028.00000032.00000001.000=
00001.414d4200
                fru: 'motherboard, power_supply, fan, CPU'
                fan-readback-maxima:  1c202428.2d313539.3d414549.4d51555a.5=
e62666a.6e72767a.7e82878b.8f93979b.9fa3a7ab.afb4b8bc.c0c4c8cc.d0d4d8dc.e1e5=
e9f1.f5fafdff.ffffffff.ffffffff
                fan-readback-minima:  0005090c.1013161a.1d212427.2b2e3235.3=
83c3f43.46494d50.54575b5e.6165686c.6f727679.7d808387.8a8e9195.989b9fa2.a6a9=
acb0.b3b7baba.bababbbc.bebebebe
                ps-temp-factors:  9a96827d.78736e6b.6967645f.5a575553.51504=
e4d.4c4b4947.46454443.4241403f.3e3d3c3c.3b3a3939.38373736.35353433.32323231=
=2E3130302f.2f2e2e2d.2d2c2c2b.2a2a2929.28282727.26262525.25252424.23232322.=
22222121.21202020.1f1f1e1e.1e1d1d1d.1d1c1c1c.1b1b1b1a.1a1a1919.19181818.181=
71717.17161616.16151515.14141413.13131313.12121212.11111111.10101010.0f0f0f=
0f.0f0e0e0e.0e0d0d0d.0d0c0c0c.0c0c0b0b.0b0b0a0a.0a0a0a0a.09090909.08080808.=
07070707.07060606.06060505.05050504.04040404.03030303.03020202.02020101.010=
10100.00000000.00000000.00000000.00000000.00000000.00000000.00000000.000000=
00.0000
                ps-fan-speeds:  1f1f1f1f.1f1f1f1f.1f1f1f1f.1f1f1f1f.1f1f1f1=
f.1f1f1f1f.1f1f1f1f.1f212223.24252626.2728292a.2b2d2e2f.30303030.30303132.3=
3343536.3738393a.3b3c3d3e.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f=
3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f
                cpu-temp-factors:  96969696.96969696.96969696.96969696.9696=
9696.96969696.96949290.8f8e8d8c.8a888786.85848382.81807f7e.7d7c7b7a.7979787=
8.77767574.73727170.706f6f6e.6e6e6d6d.6c6b6a6a.69696867.66656564.64646363.6=
2626161.60605f5f.5e5e5d5d.5c5c5b5b.5b5a5a5a.59595858.57575656.55555454.5353=
5252.52515150.5050504f.4f4f4e4e.4e4d4d4d.4c4c4c4b.4b4b4a4a.4a494949.4848484=
7.47474646.46464545.45444444.44434343.43424242.42414141.4040403f.3f3f3e3e.3=
e3d3d3d.3d3c3c3c.3c3b3b3b.3a3a3a39.39393838.38383737.37373636.36353535.3434=
3433.33333332.32323131.31303030.2f2f2f2e.2e2e2d2d.2d2c2c2c.2b2b2b2a.2a2a292=
9.2928
                cpu-fan-speeds: '11111111111111111111111111113579;<>???????=
??????????????????????????????????????????????????????????????????????'
                activity-led-blink?: =20
                address:  fff7c000
                disk-leds-state:  00000000
                disk-leds-present:  0000000f.00000000.00000000
                panel-leds-state:  00000000
                panel-leds-present:  0000003f
                interrupt-priorities:  00000009.00000009
                interrupts:  000007e8.000007e5
                reg:  00000014.00600000.00000004
                name: 'SUNW,envctrl'

        Node 0xf0089d9c
            fru: 'motherboard'
            latency-timer:  0000000a
            assigned-addresses:  82000910.00000000.00008000.00000000.000070=
20
            hm-rev:  000000c1
            device_type: 'network'
            interrupts:  000007e1
            address-bits:  00000030
            max-frame-size:  00004000
            reg:  00000900.00000000.00000000.00000000.00000000.02000910.000=
00000.00000000.00000000.00007020
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

        Node 0xf0091988
            latency-timer:  00000011
            assigned-addresses:  81001810.00000000.00000400.00000000.000001=
00.82001814.00000000.00010000.00000000.00000100.82001818.00000000.00012000.=
00000000.00001000
            device_type: 'scsi-2'
            fru: 'motherboard'
            clock-frequency:  02625a00
            reg:  00001800.00000000.00000000.00000000.00000000.01001810.000=
00000.00000000.00000000.00000100.02001814.00000000.00000000.00000000.000001=
00.02001818.00000000.00000000.00000000.00001000
            model: 'Symbios,53C875'
            compatible:  70636931.3030302c.6600676c.6d007063.69636c61.73732=
c30.30313030.3000
            name: 'scsi'
            devsel-speed:  00000001
            class-code:  00010000
            interrupts:  000007e0
            max-latency:  00000040
            min-grant:  00000011
            revision-id:  00000003
            device-id:  0000000f
            vendor-id:  00001000

            Node 0xf009689c
                device_type: 'block'
                compatible: 'sd'
                name: 'disk'

            Node 0xf0097fe0
                device_type: 'byte'
                compatible: 'st'
                name: 'tape'

        Node 0xf0098d8c
            interrupt-priorities:  00000004
            latency-timer:  00000011
            assigned-addresses:  81001010.00000000.00000800.00000000.000001=
00.82001014.00000000.00014000.00000000.00000100.82001018.00000000.00016000.=
00000000.00001000
            device_type: 'scsi-2'
            fru: 'motherboard'
            clock-frequency:  02625a00
            reg:  00001000.00000000.00000000.00000000.00000000.01001010.000=
00000.00000000.00000000.00000100.02001014.00000000.00000000.00000000.000001=
00.02001018.00000000.00000000.00000000.00001000
            model: 'Symbios,53C875'
            compatible:  70636931.3030302c.6600676c.6d007063.69636c61.73732=
c30.30313030.3000
            name: 'scsi'
            devsel-speed:  00000001
            class-code:  00010000
            interrupts:  000007e6
            max-latency:  00000040
            min-grant:  00000011
            revision-id:  00000003
            device-id:  0000000f
            vendor-id:  00001000

            Node 0xf009dca0
                device_type: 'block'
                compatible: 'sd'
                name: 'disk'

            Node 0xf009f3e4
                device_type: 'byte'
                compatible: 'st'
                name: 'tape'

    Node 0xf006fa2c
        slot-names:  00000002.50434920.736c6f74.203500
        available:  82800000.00000000.00900000.00000000.7f700000.81800000.0=
0000000.00001000.00000000.0000f000
        bus-range:  00000080.00000081
        clock-frequency:  03ef1480
        version#:  00000004
        implementation#:  00000000
        address:  fffc6000.fffc4000.fffb6000
        upa-portid:  0000001f
        66mhz-capable: =20
        interrupts:  000007f0.000007ee.000007ef.000007e5.000007e8.000007f2
        ranges:  00800000.00000000.00000000.000001fe.01000000.00000000.0080=
0000.01000000.00000000.00000000.000001fe.02000000.00000000.00010000.0200000=
0.00000000.00000000.000001ff.00000000.00000000.80000000.03000000.00000000.0=
0000000.000001ff.00000000.00000000.80000000
        reg:  000001fe.00002000.00000000.00002000.000001fe.01800000.0000000=
0.00000100.000001fe.00000000.00000000.0000d000
        no-probe-list: '0'
        latency-timer:  00000040
        model: 'SUNW,psycho'
        compatible:  70636931.3038652c.38303030.00706369.636c6173.732c3036.=
30303030.00
        thermal-interrupt: =20
        bus-parity-generated: =20
        #size-cells:  00000002
        #address-cells:  00000003
        device_type: 'pci'
        name: 'pci'

        Node 0xf00a03a8
            latency-timer:  00000040
            bus-range:  00000081.00000081
            compatible:  70636938.3038362c.33333500.70636963.6c617373.2c303=
630.34303000.70636900
            #address-cells:  00000003
            #size-cells:  00000002
            reg:  00800800.00000000.00000000.00000000.00000000
            device_type: 'pci'
            name: 'pci'
            66mhz-capable: =20
            fast-back-to-back: =20
            devsel-speed:  00000001
            class-code:  00060400
            revision-id:  0000000a
            device-id:  00000335
            vendor-id:  00008086

            Node 0xf00a0f0c
                latency-timer:  00000040
                assigned-addresses:  82817010.00000000.00100000.00000000.00=
001000.c2817018.00000000.00400000.00000000.00400000.82817030.00000000.00800=
000.00000000.00010000
                reg:  00817000.00000000.00000000.00000000.00000000.02817010=
=2E00000000.00000000.00000000.00001000.42817018.00000000.00000000.00000000.=
00400000.02817030.00000000.00000000.00000000.00010000
                compatible:  70636931.3764332c.31313230.00706369.31376433.2=
c313132.30007063.69636c61.73732c30.31303430.30007261.696400
                name: 'raid'
                66mhz-capable: =20
                devsel-speed:  00000001
                class-code:  00010400
                interrupts:  00000001
                max-latency:  00000000
                min-grant:  00000080
                subsystem-vendor-id:  000017d3
                subsystem-id:  00001120
                revision-id:  00000000
                device-id:  00001120
                vendor-id:  000017d3

    Node 0xf007104c
        address:  fff9fc00.fff9d860.fff9b060
        interrupts:  000007ec.000007ed
        reg:  000001fe.00001c00.00000000.00000020.000001fe.00001860.0000000=
0.00000010.000001fe.00001060.00000000.00000010
        name: 'counter-timer'

    Node 0xf0083230
        ranges:  00000000.00000000.00000000.00000000.00000001.00000000
        reg:  000001c0.00000000.00000000.00000fff
        #size-cells:  00000002
        fru: 'motherboard'
        device_type: 'memory-controller'
        name: 'mc'

        Node 0xf00833e4
            bank-interleave:  00000000.40000000.00000000.000000c0.00000000
            reg:  00000000.00000000.00000000.40000000
            #size-cells:  00000002
            fru: 'motherboard'
            device_type: 'memory-bank'
            name: 'bank'

            Node 0xf0083538
                socket-name: '1901'
                reg:  00000000.00000000.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0083680
                socket-name: '1902'
                reg:  00000000.00000001.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf00837c8
                socket-name: '1903'
                reg:  00000000.00000002.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0083910
                socket-name: '1904'
                reg:  00000000.00000003.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

        Node 0xf0083ae8
            bank-interleave:  00000000.40000000.00000000.000000c0.00000040
            reg:  00000000.40000000.00000000.40000000
            #size-cells:  00000002
            fru: 'motherboard'
            device_type: 'memory-bank'
            name: 'bank'

            Node 0xf0083c3c
                socket-name: '1801'
                reg:  00000000.00000000.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0083d84
                socket-name: '1802'
                reg:  00000000.00000001.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0083ecc
                socket-name: '1803'
                reg:  00000000.00000002.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0084014
                socket-name: '1804'
                reg:  00000000.00000003.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

        Node 0xf00841ec
            bank-interleave:  00000000.40000000.00000000.000000c0.00000080
            reg:  00000000.80000000.00000000.40000000
            #size-cells:  00000002
            fru: 'motherboard'
            device_type: 'memory-bank'
            name: 'bank'

            Node 0xf0084340
                socket-name: '1701'
                reg:  00000000.00000000.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0084488
                socket-name: '1702'
                reg:  00000000.00000001.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf00845d0
                socket-name: '1703'
                reg:  00000000.00000002.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0084718
                socket-name: '1704'
                reg:  00000000.00000003.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

        Node 0xf00848f0
            bank-interleave:  00000000.40000000.00000000.000000c0.000000c0
            reg:  00000000.c0000000.00000000.40000000
            #size-cells:  00000002
            fru: 'motherboard'
            device_type: 'memory-bank'
            name: 'bank'

            Node 0xf0084a44
                socket-name: '1601'
                reg:  00000000.00000000.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0084b8c
                socket-name: '1602'
                reg:  00000000.00000001.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0084cd4
                socket-name: '1603'
                reg:  00000000.00000002.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0084e1c
                socket-name: '1604'
                reg:  00000000.00000003.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

    Node 0xf0085838
        manufacturer#:  00000017
        implementation#:  00000011
        mask#:  000000a0
        sparc-version:  00000009
        ecache-associativity:  00000001
        ecache-line-size:  00000040
        ecache-size:  00400000
        #dtlb-entries:  00000040
        dcache-associativity:  00000001
        dcache-line-size:  00000020
        dcache-size:  00004000
        #itlb-entries:  00000040
        icache-associativity:  00000002
        icache-line-size:  00000020
        icache-size:  00004000
        upa-portid:  00000000
        clock-frequency:  17d78400
        reg:  000001c0.00000000.00000000.00000008
        device_type: 'cpu'
        name: 'SUNW,UltraSPARC-II'

    Node 0xf0085ba4
        manufacturer#:  00000017
        implementation#:  00000011
        mask#:  000000a0
        sparc-version:  00000009
        ecache-associativity:  00000001
        ecache-line-size:  00000040
        ecache-size:  00400000
        #dtlb-entries:  00000040
        dcache-associativity:  00000001
        dcache-line-size:  00000020
        dcache-size:  00004000
        #itlb-entries:  00000040
        icache-associativity:  00000002
        icache-line-size:  00000020
        icache-size:  00004000
        upa-portid:  00000001
        clock-frequency:  17d78400
        reg:  000001c2.00000000.00000000.00000008
        device_type: 'cpu'
        name: 'SUNW,UltraSPARC-II'

    Node 0xf0085f10
        manufacturer#:  00000017
        implementation#:  00000011
        mask#:  000000a0
        sparc-version:  00000009
        ecache-associativity:  00000001
        ecache-line-size:  00000040
        ecache-size:  00400000
        #dtlb-entries:  00000040
        dcache-associativity:  00000001
        dcache-line-size:  00000020
        dcache-size:  00004000
        #itlb-entries:  00000040
        icache-associativity:  00000002
        icache-line-size:  00000020
        icache-size:  00004000
        upa-portid:  00000002
        clock-frequency:  17d78400
        reg:  000001c4.00000000.00000000.00000008
        device_type: 'cpu'
        name: 'SUNW,UltraSPARC-II'

    Node 0xf008627c
        manufacturer#:  00000017
        implementation#:  00000011
        mask#:  000000a0
        sparc-version:  00000009
        ecache-associativity:  00000001
        ecache-line-size:  00000040
        ecache-size:  00400000
        #dtlb-entries:  00000040
        dcache-associativity:  00000001
        dcache-line-size:  00000020
        dcache-size:  00004000
        #itlb-entries:  00000040
        icache-associativity:  00000002
        icache-line-size:  00000020
        icache-size:  00004000
        upa-portid:  00000003
        clock-frequency:  17d78400
        reg:  000001c6.00000000.00000000.00000008
        device_type: 'cpu'
        name: 'SUNW,UltraSPARC-II'

    Node 0xf00865e8
        slot-names:  0000001c.50434920.736c6f74.20390050.43492073.6c6f7420.=
38005043.4920736c.6f742037.00
        available:  82000000.00000000.00900000.00000000.7f700000.81000000.0=
0000000.00001000.00000000.0000f000
        bus-range:  00000000.00000000
        version#:  00000004
        implementation#:  00000000
        address:  fff5e000.fff5c000.fff4e000
        clock-frequency:  01f78a40
        upa-portid:  00000004
        interrupts:  00000131.0000012e.0000012f.00000125.00000128.00000132
        ranges:  00000000.00000000.00000000.000001c8.01000000.00000000.0080=
0000.01000000.00000000.00000000.000001c8.02010000.00000000.00010000.0200000=
0.00000000.00000000.000001c9.80000000.00000000.80000000.03000000.00000000.0=
0000000.000001c9.80000000.00000000.80000000
        reg:  000001c8.00004000.00000000.00002000.000001c8.01000000.0000000=
0.00000100.000001c8.00000000.00000000.0000d000
        no-probe-list: '0'
        latency-timer:  00000040
        model: 'SUNW,psycho'
        compatible:  70636931.3038652c.38303030.00706369.636c6173.732c3036.=
30303030.00
        thermal-interrupt: =20
        bus-parity-generated: =20
        #size-cells:  00000002
        #address-cells:  00000003
        device_type: 'pci'
        name: 'pci'

    Node 0xf0087668
        slot-names:  00000002.50434920.736c6f74.203600
        available:  82800000.00000000.00900000.00000000.7f700000.81800000.0=
0000000.00001000.00000000.0000f000
        bus-range:  00000080.00000080
        clock-frequency:  03ef1480
        version#:  00000004
        implementation#:  00000000
        address:  fff70000.fff6e000.fff60000
        upa-portid:  00000004
        66mhz-capable: =20
        interrupts:  00000130.0000012e.0000012f.00000125.00000128.00000132
        ranges:  00800000.00000000.00000000.000001c8.01000000.00000000.0080=
0000.01000000.00000000.00000000.000001c8.02000000.00000000.00010000.0200000=
0.00000000.00000000.000001c9.00000000.00000000.80000000.03000000.00000000.0=
0000000.000001c9.00000000.00000000.80000000
        reg:  000001c8.00002000.00000000.00002000.000001c8.01800000.0000000=
0.00000100.000001c8.00000000.00000000.0000d000
        no-probe-list: '0'
        latency-timer:  00000040
        model: 'SUNW,psycho'
        compatible:  70636931.3038652c.38303030.00706369.636c6173.732c3036.=
30303030.00
        thermal-interrupt: =20
        bus-parity-generated: =20
        #size-cells:  00000002
        #address-cells:  00000003
        device_type: 'pci'
        name: 'pci'

    Node 0xf00883ac
        slot-names:  0000001c.50434920.736c6f74.20330050.43492073.6c6f7420.=
32005043.4920736c.6f742031.00
        available:  82000000.00000000.00900000.00000000.7f700000.81000000.0=
0000000.00001000.00000000.0000f000
        bus-range:  00000000.00000000
        version#:  00000004
        implementation#:  00000000
        address:  fff36000.fff34000.fff26000
        clock-frequency:  01f78a40
        upa-portid:  00000006
        interrupts:  000001b1.000001ae.000001af.000001a5.000001a8.000001b2
        ranges:  00000000.00000000.00000000.000001cc.01000000.00000000.0080=
0000.01000000.00000000.00000000.000001cc.02010000.00000000.00010000.0200000=
0.00000000.00000000.000001cd.80000000.00000000.80000000.03000000.00000000.0=
0000000.000001cd.80000000.00000000.80000000
        reg:  000001cc.00004000.00000000.00002000.000001cc.01000000.0000000=
0.00000100.000001cc.00000000.00000000.0000d000
        no-probe-list: '0'
        latency-timer:  00000040
        model: 'SUNW,psycho'
        compatible:  70636931.3038652c.38303030.00706369.636c6173.732c3036.=
30303030.00
        thermal-interrupt: =20
        bus-parity-generated: =20
        #size-cells:  00000002
        #address-cells:  00000003
        device_type: 'pci'
        name: 'pci'

    Node 0xf008900c
        slot-names:  00000002.50434920.736c6f74.203400
        available:  82800000.00000000.00900000.00000000.7f700000.81800000.0=
0000000.00001000.00000000.0000f000
        bus-range:  00000080.00000080
        clock-frequency:  03ef1480
        version#:  00000004
        implementation#:  00000000
        address:  fff48000.fff46000.fff38000
        upa-portid:  00000006
        66mhz-capable: =20
        interrupts:  000001b0.000001ae.000001af.000001a5.000001a8.000001b2
        ranges:  00800000.00000000.00000000.000001cc.01000000.00000000.0080=
0000.01000000.00000000.00000000.000001cc.02000000.00000000.00010000.0200000=
0.00000000.00000000.000001cd.00000000.00000000.80000000.03000000.00000000.0=
0000000.000001cd.00000000.00000000.80000000
        reg:  000001cc.00002000.00000000.00002000.000001cc.01800000.0000000=
0.00000100.000001cc.00000000.00000000.0000d000
        no-probe-list: '0'
        latency-timer:  00000040
        model: 'SUNW,psycho'
        compatible:  70636931.3038652c.38303030.00706369.636c6173.732c3036.=
30303030.00
        thermal-interrupt: =20
        bus-parity-generated: =20
        #size-cells:  00000002
        #address-cells:  00000003
        device_type: 'pci'
        name: 'pci'


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="prtconf_2.6.20-rc2.txt"
Content-Transfer-Encoding: quoted-printable

System Configuration:  Sun Microsystems  sun4u
Memory size: 4096 Megabytes
System Peripherals (PROM Nodes):

Node 0xf002a490
    .node:  f002a490
    scsi-initiator-id:  00000007
    reset-reason: 'S-POR'
    energystar-v2: =20
    model: 'SUNW,501-5270'
    idprom:  01800800.2096014b.ffffffff.96014ba9.efffefff.ff00ff00.00000000=
=2E00000000
    compatible: 'sun4u'
    builtin-io-device-port:  0000001f
    device-probe-order: '1b,0,4,9,'
    breakpoint-trap:  0000007f
    #size-cells:  00000002
    name: 'SUNW,Ultra-4'
    clock-frequency:  05f5e100
    banner-name: 'Sun Enterprise 450 (4 X UltraSPARC-II 400MHz)'
    device_type: 'upa'

    Node 0xf002d8d4
        .node:  f002d8d4
        name: 'packages'

        Node 0xf0034e48
            .node:  f0034e48
            iso6429-1983-colors: =20
            name: 'terminal-emulator'

        Node 0xf0037b84
            .node:  f0037b84
            disk-write-fix: =20
            name: 'deblocker'

        Node 0xf0038260
            .node:  f0038260
            name: 'obp-tftp'

        Node 0xf00430e4
            .node:  f00430e4
            name: 'disk-label'

        Node 0xf0066bc8
            .node:  f0066bc8
            name: 'SUNW,builtin-drivers'

        Node 0xf007cb6c
            .node:  f007cb6c
            name: 'sun-keyboard'

    Node 0xf002d944
        .node:  f002d944
        stdin:  fff19710
        stdout:  fff19cd0
        mmu:  fffe9438
        memory:  fffe9638
        bootargs:  00
        bootpath: '/pci@1f,4000/scsi@3/disk@0,0:a'
        stdout-#lines:  ffffffff
        name: 'chosen'

    Node 0xf002d9b0
        .node:  f002d9b0
        version: 'OBP 3.30.0 2003/11/11 10:41'
        model: 'SUNW,3.30'
        decode-complete: =20
        aligned-allocator: =20
        relative-addressing: =20
        name: 'openprom'

        Node 0xf002da40
            .node:  f002da40
            name: 'client-services'

    Node 0xf002dae8
        .node:  f002dae8
        tpe-link-test?: 'true'
        scsi-initiator-id: '7'
        keyboard-click?: 'false'
        keymap: =20
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
        pci0-probe-list: '1,3,2,4'
        upa-port-skip-list: 'none'
        memory-interleave: 'auto'
        disk-led-assoc: '0'
        diag-level: 'min'
        diag-script: 'normal'
        diag-targets: 'none'
        diag-trigger: 'power-reset'
        diag-continue?: 'false'
        diag-passes: '1'
        diag-verbosity: 'tests'
        env-monitor: 'enabled'
        .asr-disable-list: =20
        .asr-status: '18437736870358094097'
        .post-status: '18437736870358094097'
        .post-address: '18446744073441856352'
        .post-flag: '0'
        .rsc-status: '85'
        .obp-flags: '0'
        .obp-state: '6'
        .obp-status: '0'
        mfg-options: 'server-class'
        #power-cycles: '212'
        system-board-serial#: '828M2CD0'
        system-board-date: '35a834d8'
        fcode-debug?: 'false'
        output-device: 'ttya'
        input-device: 'ttya'
        load-base: '16384'
        boot-command: 'boot'
        auto-boot?: 'false'
        auto-boot-on-error?: 'false'
        watchdog-reboot?: 'false'
        diag-file: =20
        diag-device: 'net'
        boot-file: =20
        boot-device: 'disk net'
        local-mac-address?: 'false'
        ansi-terminal?: 'true'
        screen-#columns: '80'
        screen-#rows: '34'
        silent-mode?: 'false'
        use-nvramrc?: 'false'
        nvramrc: =20
        security-mode: 'none'
        security-password: =20
        security-#badlogins: '0'
        oem-logo: =20
        oem-logo?: 'false'
        oem-banner: =20
        oem-banner?: 'false'
        hardware-revision: 'UUUUUUUUUUUUUUU'
        last-hardware-update: 'UUUUUUU'
        .upa-noprobe-mask: '0'
        diag-switch?: 'false'
        name: 'options'

    Node 0xf002db58
        .node:  f002db58
        disk: '/pci@1f,4000/scsi@3/disk@0,0'
        disk0: '/pci@1f,4000/scsi@3/disk@0,0'
        disk1: '/pci@1f,4000/scsi@3/disk@1,0'
        disk2: '/pci@1f,4000/scsi@3/disk@2,0'
        disk3: '/pci@1f,4000/scsi@3/disk@3,0'
        scsi: '/pci@1f,4000/scsi@3'
        diskx0: '/pci@1f,4000/scsi@2/disk@0,0'
        diskx1: '/pci@1f,4000/scsi@2/disk@1,0'
        diskx2: '/pci@1f,4000/scsi@2/disk@2,0'
        diskx3: '/pci@1f,4000/scsi@2/disk@3,0'
        cdrom: '/pci@1f,4000/scsi@2/disk@6,0:f'
        tape: '/pci@1f,4000/scsi@2/tape@4,0'
        scsix: '/pci@1f,4000/scsi@2'
        pci: '/pci@1f,4000'
        pcia: '/pci@1f,2000'
        pcib: '/pci@1f,4000'
        pci0: '/pci@1f,4000'
        pci1: '/pci@1f,2000'
        pci2: '/pci@4,4000'
        pci3: '/pci@4,2000'
        pci4: '/pci@6,4000'
        pci5: '/pci@6,2000'
        flash: '/pci@1f,4000/ebus@1/flashprom@10,0'
        nvram: '/pci@1f,4000/ebus@1/eeprom@14,0'
        parallel: '/pci@1f,4000/ebus@1/ecpp@14,3043bc'
        net: '/pci@1f,4000/network@1,1'
        ebus: '/pci@1f,4000/ebus@1'
        i2c: '/pci@1f,4000/ebus@1/SUNW,envctrl'
        floppy: '/pci@1f,4000/ebus@1/fdthree'
        tty: '/pci@1f,4000/ebus@1/se'
        ttyb: '/pci@1f,4000/ebus@1/se:b'
        ttya: '/pci@1f,4000/ebus@1/se:a'
        keyboard!: '/pci@1f,4000/ebus@1/su@14,3083f8:forcemode'
        keyboard: '/pci@1f,4000/ebus@1/su@14,3083f8'
        mouse: '/pci@1f,4000/ebus@1/su@14,3062f8'
        name: 'aliases'

    Node 0xf0051de8
        .node:  f0051de8
        interleave:  00000000.00000000.00000001.00000000.00000004
        reg:  00000000.00000000.00000001.00000000
        #size-cells:  00000002
        available:  00000000.ffeb6000.00000000.00002000.00000000.ffe98000.0=
0000000.00016000.00000000.ffe00000.00000000.00096000.00000000.00000000.0000=
0000.ffdfe000
        name: 'memory'

    Node 0xf00523c8
        .node:  f00523c8
        translations:  00000000.fffe0000.00000000.00010000.80000000.ffef00b=
6.00000000.fffcc000.00000000.00014000.80000000.ffed40b6.00000000.fffc6000.0=
0000000.00002000.800001fe.0000208e.00000000.fffc4000.00000000.00002000.8000=
01fe.0180008e.00000000.fffb6000.00000000.0000e000.800001fe.0000008e.0000000=
0.fffb4000.00000000.00002000.800001fe.0000408e.00000000.fffb2000.00000000.0=
0002000.800001fe.0100008e.00000000.fffa4000.00000000.0000e000.800001fe.0000=
008e.00000000.fffa0000.00000000.00004000.80000000.ffed00b6.00000000.fff9e00=
0.00000000.00002000.800001fe.0000008e.00000000.fff9c000.00000000.00002000.8=
00001fe.0000008e.00000000.fff9a000.00000000.00002000.800001fe.0000008e.0000=
0000.fff98000.00000000.00002000.800001ff.f100008e.00000000.fff96000.0000000=
0.00002000.800001ff.f100008e.00000000.fff94000.00000000.00002000.800001ff.f=
150008e.00000000.fff92000.00000000.00002000.800001ff.f172608e.00000000.fff9=
0000.00000000.00002000.800001ff.f172808e.00000000.fff8e000.00000000.0000200=
0.800001ff.f172a08e.00000000.fff8c000.00000000.00002000.800001ff.f172c08e.0=
0000000.fff8a000.00000000.00002000.800001ff.f172e08e.00000000.fff88000.0000=
0000.00002000.800001ff.f130808e.00000000.fff82000.00000000.00006000.8000000=
0.ffec80b6.00000000.fff80000.00000000.00002000.80000000.ffdfe0b6.00000000.f=
ff7e000.00000000.00002000.80000000.ffec60b6.00000000.fff7c000.00000000.0000=
2000.800001ff.f160008e.00000000.fff7a000.00000000.00002000.800001ff.f130208=
e.00000000.fff78000.00000000.00002000.800001ff.f170608e.00000000.fff76000.0=
0000000.00002000.800001ff.f172008e.00000000.fff74000.00000000.00002000.8000=
01ff.f130208e.00000000.fff72000.00000000.00002000.800001ff.f130208e.0000000=
0.fff70000.00000000.00002000.800001c8.0000208e.00000000.fff6e000.00000000.0=
0002000.800001c8.0180008e.00000000.fff60000.00000000.0000e000.800001c8.0000=
008e.00000000.fff5e000.00000000.00002000.800001c8.0000408e.00000000.fff5c00=
0.00000000.00002000.800001c8.0100008e.00000000.fff4e000.00000000.0000e000.8=
00001c8.0000008e.00000000.fff4a000.00000000.00004000.80000000.ffec00b6.0000=
0000.fff48000.00000000.00002000.800001cc.0000208e.00000000.fff46000.0000000=
0.00002000.800001cc.0180008e.00000000.fff38000.00000000.0000e000.800001cc.0=
000008e.00000000.fff36000.00000000.00002000.800001cc.0000408e.00000000.fff3=
4000.00000000.00002000.800001cc.0100008e.00000000.fff26000.00000000.0000e00=
0.800001cc.0000008e.00000000.fff22000.00000000.00004000.80000000.ffebc0b6.0=
0000000.fff20000.00000000.00002000.800001ff.f140008e.00000000.fff18000.0000=
0000.00002000.80000000.ffec40b6.00000000.ffef8000.00000000.00008000.8000000=
0.ffeae0b6.00000000.f0000000.00000000.00100000.80000000.fff000b6.00000000.4=
0000000.00000000.00800000.80000000.00400036.00000000.00002000.00000000.00bf=
e000.80000000.00002036
        existing:  00000000.00000000.00000800.00000000.fffff800.00000000.00=
000800.00000000
        available:  fffff800.00000000.000007fc.00000000.00000001.00000000.0=
00007ff.00000000.00000000.ffff0000.00000000.0000e000.00000000.00000000.0000=
0000.f0000000.00000000.fff1a000.00000000.00006000.00000000.fff00000.0000000=
0.00018000.00000000.f0800000.00000000.0e800000
        page-size:  00002000
        name: 'virtual-memory'

    Node 0xf005798c
        .node:  f005798c
        name: 'associations'

        Node 0xf00a18a4
            .node:  f00a18a4
            slot#3: '/pci@1f,4000/scsi@3/disk@3'
            slot#2: '/pci@1f,4000/scsi@3/disk@2'
            slot#1: '/pci@1f,4000/scsi@3/disk@1'
            slot#0: '/pci@1f,4000/scsi@3/disk@0'
            name: 'slot2disk'

        Node 0xf00a1948
            .node:  f00a1948
            slot#3: '/pci@1f,4000/ebus@1/i2c@14,600000/bits@40/wo@3'
            slot#2: '/pci@1f,4000/ebus@1/i2c@14,600000/bits@40/wo@2'
            slot#1: '/pci@1f,4000/ebus@1/i2c@14,600000/bits@40/wo@1'
            slot#0: '/pci@1f,4000/ebus@1/i2c@14,600000/bits@40/wo@0'
            name: 'slot2led'

        Node 0xf00a1bfc
            .node:  f00a1bfc
            ebus|audio: '/pci@1f,4000/ebus@1/*@14,200000'
            pci-slot#10: '/pci@1f,4000/*@4,*'
            pci-slot#9: '/pci@4,4000/*@2,*'
            pci-slot#8: '/pci@4,4000/*@3,*'
            pci-slot#7: '/pci@4,4000/*@4,*'
            pci-slot#6: '/pci@4,2000/*@1,*'
            pci-slot#5: '/pci@1f,2000/*@1,*'
            pci-slot#4: '/pci@6,2000/*@1,*'
            pci-slot#3: '/pci@6,4000/*@2,*'
            pci-slot#2: '/pci@6,4000/*@3,*'
            pci-slot#1: '/pci@6,4000/*@4,*'
            graphics#2: '/*@1d,0'
            graphics#1: '/*@1e,0'
            cpu-b2: '/*@3,0'
            cpu-b1: '/*@2,0'
            cpu-a2: '/*@1,0'
            cpu-a1: '/*@0,0'
            name: 'slot2dev'

    Node 0xf006ec38
        .node:  f006ec38
        slot-names:  0000001e.4d6f7468.6572626f.61726400.4d6f7468.6572626f.=
61726400.4d6f7468.6572626f.61726400.50434920.736c6f74.20313000
        available:  82000000.00000000.00017000.00000000.7ffe9000.81000000.0=
0000000.00000900.00000000.0000f700
        bus-range:  00000000.00000000
        version#:  00000004
        implementation#:  00000000
        address:  fffb4000.fffb2000.fffa4000
        #upa-interrupt-proxies:  00000002
        clock-frequency:  01f78a40
        upa-portid:  0000001f
        interrupts:  000007f1.000007ee.000007ef.000007e5.000007e8.000007f2
        ranges:  00000000.00000000.00000000.000001fe.01000000.00000000.0080=
0000.01000000.00000000.00000000.000001fe.02010000.00000000.00010000.0200000=
0.00000000.00000000.000001ff.80000000.00000000.80000000.03000000.00000000.0=
0000000.000001ff.80000000.00000000.80000000
        reg:  000001fe.00004000.00000000.00002000.000001fe.01000000.0000000=
0.00000100.000001fe.00000000.00000000.0000d000
        no-probe-list: '0'
        latency-timer:  00000040
        model: 'SUNW,psycho'
        compatible:  70636931.3038652c.38303030.00706369.636c6173.732c3036.=
30303030.00
        thermal-interrupt: =20
        bus-parity-generated: =20
        #size-cells:  00000002
        #address-cells:  00000003
        device_type: 'pci'
        name: 'pci'

        Node 0xf0071344
            .node:  f0071344
            fru: 'motherboard'
            latency-timer:  0000000a
            fast-back-to-back: =20
            devsel-speed:  00000001
            class-code:  00068000
            max-latency:  00000019
            min-grant:  0000000a
            revision-id:  00000001
            device-id:  00001000
            vendor-id:  0000108e
            ranges:  00000010.00000000.82000810.00000000.70000000.01000000.=
00000014.00000000.82000814.00000000.71000000.00800000
            reg:  00000800.00000000.00000000.00000000.00000000.82000810.000=
00000.70000000.00000000.01000000.82000814.00000000.71000000.00000000.008000=
00
            #size-cells:  00000001
            #address-cells:  00000002
            name: 'ebus'

            Node 0xf00718c8
                .node:  f00718c8
                address:  fff92000.fff90000.fff8e000.fff8c000.fff8b000
                reg:  00000014.00726000.00000004.00000014.00728000.00000004=
=2E00000014.0072a000.00000004.00000014.0072c000.00000004.00000014.0072f000.=
00000004
                name: 'auxio'

            Node 0xf0071988
                .node:  f0071988
                interrupts:  000007e5.000007f2
                reg:  00000014.00724000.00000004
                name: 'power'

            Node 0xf0071a18
                .node:  f0071a18
                freq-syn: 'MC12430'
                reg:  00000014.00504000.00000003
                name: 'SUNW,pll'

            Node 0xf0071aac
                .node:  f0071aac
                address:  fff94000
                version#:  00000001
                implementation#:  00000000
                model: 'SUNW,sc-marvin'
                reg:  00000014.00500000.00000008
                name: 'sc'

            Node 0xf0071b64
                .node:  f0071b64
                fru: 'motherboard'
                port-b-ignore-cd: =20
                port-a-ignore-cd: =20
                interrupts:  0000002b
                reg:  00000014.00400000.00000080
                device_type: 'serial'
                name: 'se'

            Node 0xf0073608
                .node:  f0073608
                fru: 'motherboard'
                reg:  00000014.003083f8.00000008
                interrupts:  00000029
                port-a-ignore-cd: =20
                keyboard: =20
                device_type: 'serial'
                name: 'su'

            Node 0xf0074ea0
                .node:  f0074ea0
                fru: 'motherboard'
                interrupts:  0000002a
                port-a-ignore-cd: =20
                mouse: =20
                reg:  00000014.003062f8.00000008
                device_type: 'serial'
                name: 'su'

            Node 0xf0074fbc
                .node:  f0074fbc
                fru: 'motherboard'
                interrupts:  000007e2
                reg:  00000014.003043bc.00000010.00000014.00300398.00000002=
=2E00000014.00700000.00000010
                name: 'ecpp'

            Node 0xf00750bc
                .node:  f00750bc
                fru: 'motherboard'
                manual: =20
                unit:  00000000
                address:  fff7a3f0.fff78000.fff76000
                device_type: 'block'
                interrupts:  000007e7
                reg:  00000014.003023f0.00000008.00000014.00706000.00000010=
=2E00000014.00720000.00000004
                name: 'fdthree'

            Node 0xf0076a68
                .node:  f0076a68
                fru: 'motherboard'
                address:  fff96000
                reg:  00000014.00000000.00002000
                model: 'mk48t59'
                name: 'eeprom'

            Node 0xf0076b50
                .node:  f0076b50
                compatible:  69323866.30303874.32006932.38663030.3800
                version:  4f425020.332e3330.2e302032.3030332f.31312f31.3120=
3130.3a343100.504f5354.20362e31.2e302032.3030332f.31312f31.31203130.3a323700
                model: 'SUNW,525-1776'
                reg:  00000010.00000000.00100000.00000010.00000000.00100000
                name: 'flashprom'

            Node 0xf0079c30
                .node:  f0079c30
                thermisters:  0000009e.00000000.00000005.0000003e.0000004b.=
00000001.00000001.43505530.00000000.9e000000.01000000.05000000.3e000000.4b0=
00000.01000000.01435055.31000000.009e0000.00020000.00050000.003e0000.004b00=
00.00010000.00014350.55320000.00009e00.00000300.00000500.00003e00.00004b00.=
00000100.00000143.50553300.00000090.00000000.00000005.0000005a.00000064.000=
00001.00000001.50533000.00000092.00000000.00000005.0000005a.00000064.000000=
01.00000001.50533100.00000094.00000000.00000005.0000005a.00000064.00000001.=
00000001.50533200.0000009a.00000000.00000005.00000028.00000032.00000001.000=
00001.414d4200
                fru: 'motherboard, power_supply, fan, CPU'
                fan-readback-maxima:  1c202428.2d313539.3d414549.4d51555a.5=
e62666a.6e72767a.7e82878b.8f93979b.9fa3a7ab.afb4b8bc.c0c4c8cc.d0d4d8dc.e1e5=
e9f1.f5fafdff.ffffffff.ffffffff
                fan-readback-minima:  0005090c.1013161a.1d212427.2b2e3235.3=
83c3f43.46494d50.54575b5e.6165686c.6f727679.7d808387.8a8e9195.989b9fa2.a6a9=
acb0.b3b7baba.bababbbc.bebebebe
                ps-temp-factors:  9a96827d.78736e6b.6967645f.5a575553.51504=
e4d.4c4b4947.46454443.4241403f.3e3d3c3c.3b3a3939.38373736.35353433.32323231=
=2E3130302f.2f2e2e2d.2d2c2c2b.2a2a2929.28282727.26262525.25252424.23232322.=
22222121.21202020.1f1f1e1e.1e1d1d1d.1d1c1c1c.1b1b1b1a.1a1a1919.19181818.181=
71717.17161616.16151515.14141413.13131313.12121212.11111111.10101010.0f0f0f=
0f.0f0e0e0e.0e0d0d0d.0d0c0c0c.0c0c0b0b.0b0b0a0a.0a0a0a0a.09090909.08080808.=
07070707.07060606.06060505.05050504.04040404.03030303.03020202.02020101.010=
10100.00000000.00000000.00000000.00000000.00000000.00000000.00000000.000000=
00.0000
                ps-fan-speeds:  1f1f1f1f.1f1f1f1f.1f1f1f1f.1f1f1f1f.1f1f1f1=
f.1f1f1f1f.1f1f1f1f.1f212223.24252626.2728292a.2b2d2e2f.30303030.30303132.3=
3343536.3738393a.3b3c3d3e.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f=
3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f.3f3f3f3f
                cpu-temp-factors:  96969696.96969696.96969696.96969696.9696=
9696.96969696.96949290.8f8e8d8c.8a888786.85848382.81807f7e.7d7c7b7a.7979787=
8.77767574.73727170.706f6f6e.6e6e6d6d.6c6b6a6a.69696867.66656564.64646363.6=
2626161.60605f5f.5e5e5d5d.5c5c5b5b.5b5a5a5a.59595858.57575656.55555454.5353=
5252.52515150.5050504f.4f4f4e4e.4e4d4d4d.4c4c4c4b.4b4b4a4a.4a494949.4848484=
7.47474646.46464545.45444444.44434343.43424242.42414141.4040403f.3f3f3e3e.3=
e3d3d3d.3d3c3c3c.3c3b3b3b.3a3a3a39.39393838.38383737.37373636.36353535.3434=
3433.33333332.32323131.31303030.2f2f2f2e.2e2e2d2d.2d2c2c2c.2b2b2b2a.2a2a292=
9.2928
                cpu-fan-speeds: '11111111111111111111111111113579;<>???????=
??????????????????????????????????????????????????????????????????????'
                activity-led-blink?: =20
                address:  fff7c000
                disk-leds-state:  00000000
                disk-leds-present:  0000000f.00000000.00000000
                panel-leds-state:  00000000
                panel-leds-present:  0000003f
                interrupt-priorities:  00000009.00000009
                interrupts:  000007e8.000007e5
                reg:  00000014.00600000.00000004
                name: 'SUNW,envctrl'

        Node 0xf0089d9c
            .node:  f0089d9c
            fru: 'motherboard'
            latency-timer:  0000000a
            assigned-addresses:  82000910.00000000.00008000.00000000.000070=
20
            hm-rev:  000000c1
            device_type: 'network'
            interrupts:  000007e1
            address-bits:  00000030
            max-frame-size:  00004000
            reg:  00000900.00000000.00000000.00000000.00000000.02000910.000=
00000.00000000.00000000.00007020
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

        Node 0xf0091988
            .node:  f0091988
            latency-timer:  00000011
            assigned-addresses:  81001810.00000000.00000400.00000000.000001=
00.82001814.00000000.00010000.00000000.00000100.82001818.00000000.00012000.=
00000000.00001000
            device_type: 'scsi-2'
            fru: 'motherboard'
            clock-frequency:  02625a00
            reg:  00001800.00000000.00000000.00000000.00000000.01001810.000=
00000.00000000.00000000.00000100.02001814.00000000.00000000.00000000.000001=
00.02001818.00000000.00000000.00000000.00001000
            model: 'Symbios,53C875'
            compatible:  70636931.3030302c.6600676c.6d007063.69636c61.73732=
c30.30313030.3000
            name: 'scsi'
            devsel-speed:  00000001
            class-code:  00010000
            interrupts:  000007e0
            max-latency:  00000040
            min-grant:  00000011
            revision-id:  00000003
            device-id:  0000000f
            vendor-id:  00001000

            Node 0xf009689c
                .node:  f009689c
                device_type: 'block'
                compatible: 'sd'
                name: 'disk'

            Node 0xf0097fe0
                .node:  f0097fe0
                device_type: 'byte'
                compatible: 'st'
                name: 'tape'

        Node 0xf0098d8c
            .node:  f0098d8c
            interrupt-priorities:  00000004
            latency-timer:  00000011
            assigned-addresses:  81001010.00000000.00000800.00000000.000001=
00.82001014.00000000.00014000.00000000.00000100.82001018.00000000.00016000.=
00000000.00001000
            device_type: 'scsi-2'
            fru: 'motherboard'
            clock-frequency:  02625a00
            reg:  00001000.00000000.00000000.00000000.00000000.01001010.000=
00000.00000000.00000000.00000100.02001014.00000000.00000000.00000000.000001=
00.02001018.00000000.00000000.00000000.00001000
            model: 'Symbios,53C875'
            compatible:  70636931.3030302c.6600676c.6d007063.69636c61.73732=
c30.30313030.3000
            name: 'scsi'
            devsel-speed:  00000001
            class-code:  00010000
            interrupts:  000007e6
            max-latency:  00000040
            min-grant:  00000011
            revision-id:  00000003
            device-id:  0000000f
            vendor-id:  00001000

            Node 0xf009dca0
                .node:  f009dca0
                device_type: 'block'
                compatible: 'sd'
                name: 'disk'

            Node 0xf009f3e4
                .node:  f009f3e4
                device_type: 'byte'
                compatible: 'st'
                name: 'tape'

    Node 0xf006fa2c
        .node:  f006fa2c
        slot-names:  00000002.50434920.736c6f74.203500
        available:  82800000.00000000.00900000.00000000.7f700000.81800000.0=
0000000.00001000.00000000.0000f000
        bus-range:  00000080.00000081
        clock-frequency:  03ef1480
        version#:  00000004
        implementation#:  00000000
        address:  fffc6000.fffc4000.fffb6000
        upa-portid:  0000001f
        66mhz-capable: =20
        interrupts:  000007f0.000007ee.000007ef.000007e5.000007e8.000007f2
        ranges:  00800000.00000000.00000000.000001fe.01000000.00000000.0080=
0000.01000000.00000000.00000000.000001fe.02000000.00000000.00010000.0200000=
0.00000000.00000000.000001ff.00000000.00000000.80000000.03000000.00000000.0=
0000000.000001ff.00000000.00000000.80000000
        reg:  000001fe.00002000.00000000.00002000.000001fe.01800000.0000000=
0.00000100.000001fe.00000000.00000000.0000d000
        no-probe-list: '0'
        latency-timer:  00000040
        model: 'SUNW,psycho'
        compatible:  70636931.3038652c.38303030.00706369.636c6173.732c3036.=
30303030.00
        thermal-interrupt: =20
        bus-parity-generated: =20
        #size-cells:  00000002
        #address-cells:  00000003
        device_type: 'pci'
        name: 'pci'

        Node 0xf00a03a8
            .node:  f00a03a8
            latency-timer:  00000040
            bus-range:  00000081.00000081
            compatible:  70636938.3038362c.33333500.70636963.6c617373.2c303=
630.34303000.70636900
            #address-cells:  00000003
            #size-cells:  00000002
            reg:  00800800.00000000.00000000.00000000.00000000
            device_type: 'pci'
            name: 'pci'
            66mhz-capable: =20
            fast-back-to-back: =20
            devsel-speed:  00000001
            class-code:  00060400
            revision-id:  0000000a
            device-id:  00000335
            vendor-id:  00008086

            Node 0xf00a0f0c
                .node:  f00a0f0c
                latency-timer:  00000040
                assigned-addresses:  82817010.00000000.00100000.00000000.00=
001000.c2817018.00000000.00400000.00000000.00400000.82817030.00000000.00800=
000.00000000.00010000
                reg:  00817000.00000000.00000000.00000000.00000000.02817010=
=2E00000000.00000000.00000000.00001000.42817018.00000000.00000000.00000000.=
00400000.02817030.00000000.00000000.00000000.00010000
                compatible:  70636931.3764332c.31313230.00706369.31376433.2=
c313132.30007063.69636c61.73732c30.31303430.30007261.696400
                name: 'raid'
                66mhz-capable: =20
                devsel-speed:  00000001
                class-code:  00010400
                interrupts:  00000001
                max-latency:  00000000
                min-grant:  00000080
                subsystem-vendor-id:  000017d3
                subsystem-id:  00001120
                revision-id:  00000000
                device-id:  00001120
                vendor-id:  000017d3

    Node 0xf007104c
        .node:  f007104c
        address:  fff9fc00.fff9d860.fff9b060
        interrupts:  000007ec.000007ed
        reg:  000001fe.00001c00.00000000.00000020.000001fe.00001860.0000000=
0.00000010.000001fe.00001060.00000000.00000010
        name: 'counter-timer'

    Node 0xf0083230
        .node:  f0083230
        ranges:  00000000.00000000.00000000.00000000.00000001.00000000
        reg:  000001c0.00000000.00000000.00000fff
        #size-cells:  00000002
        fru: 'motherboard'
        device_type: 'memory-controller'
        name: 'mc'

        Node 0xf00833e4
            .node:  f00833e4
            bank-interleave:  00000000.40000000.00000000.000000c0.00000000
            reg:  00000000.00000000.00000000.40000000
            #size-cells:  00000002
            fru: 'motherboard'
            device_type: 'memory-bank'
            name: 'bank'

            Node 0xf0083538
                .node:  f0083538
                socket-name: '1901'
                reg:  00000000.00000000.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0083680
                .node:  f0083680
                socket-name: '1902'
                reg:  00000000.00000001.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf00837c8
                .node:  f00837c8
                socket-name: '1903'
                reg:  00000000.00000002.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0083910
                .node:  f0083910
                socket-name: '1904'
                reg:  00000000.00000003.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

        Node 0xf0083ae8
            .node:  f0083ae8
            bank-interleave:  00000000.40000000.00000000.000000c0.00000040
            reg:  00000000.40000000.00000000.40000000
            #size-cells:  00000002
            fru: 'motherboard'
            device_type: 'memory-bank'
            name: 'bank'

            Node 0xf0083c3c
                .node:  f0083c3c
                socket-name: '1801'
                reg:  00000000.00000000.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0083d84
                .node:  f0083d84
                socket-name: '1802'
                reg:  00000000.00000001.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0083ecc
                .node:  f0083ecc
                socket-name: '1803'
                reg:  00000000.00000002.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0084014
                .node:  f0084014
                socket-name: '1804'
                reg:  00000000.00000003.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

        Node 0xf00841ec
            .node:  f00841ec
            bank-interleave:  00000000.40000000.00000000.000000c0.00000080
            reg:  00000000.80000000.00000000.40000000
            #size-cells:  00000002
            fru: 'motherboard'
            device_type: 'memory-bank'
            name: 'bank'

            Node 0xf0084340
                .node:  f0084340
                socket-name: '1701'
                reg:  00000000.00000000.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0084488
                .node:  f0084488
                socket-name: '1702'
                reg:  00000000.00000001.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf00845d0
                .node:  f00845d0
                socket-name: '1703'
                reg:  00000000.00000002.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0084718
                .node:  f0084718
                socket-name: '1704'
                reg:  00000000.00000003.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

        Node 0xf00848f0
            .node:  f00848f0
            bank-interleave:  00000000.40000000.00000000.000000c0.000000c0
            reg:  00000000.c0000000.00000000.40000000
            #size-cells:  00000002
            fru: 'motherboard'
            device_type: 'memory-bank'
            name: 'bank'

            Node 0xf0084a44
                .node:  f0084a44
                socket-name: '1601'
                reg:  00000000.00000000.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0084b8c
                .node:  f0084b8c
                socket-name: '1602'
                reg:  00000000.00000001.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0084cd4
                .node:  f0084cd4
                socket-name: '1603'
                reg:  00000000.00000002.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

            Node 0xf0084e1c
                .node:  f0084e1c
                socket-name: '1604'
                reg:  00000000.00000003.00000000.10000000
                fru: 'memory-module'
                device_type: 'memory-module'
                name: 'dimm'

    Node 0xf0085838
        .node:  f0085838
        manufacturer#:  00000017
        implementation#:  00000011
        mask#:  000000a0
        sparc-version:  00000009
        ecache-associativity:  00000001
        ecache-line-size:  00000040
        ecache-size:  00400000
        #dtlb-entries:  00000040
        dcache-associativity:  00000001
        dcache-line-size:  00000020
        dcache-size:  00004000
        #itlb-entries:  00000040
        icache-associativity:  00000002
        icache-line-size:  00000020
        icache-size:  00004000
        upa-portid:  00000000
        clock-frequency:  17d78400
        reg:  000001c0.00000000.00000000.00000008
        device_type: 'cpu'
        name: 'SUNW,UltraSPARC-II'

    Node 0xf0085ba4
        .node:  f0085ba4
        manufacturer#:  00000017
        implementation#:  00000011
        mask#:  000000a0
        sparc-version:  00000009
        ecache-associativity:  00000001
        ecache-line-size:  00000040
        ecache-size:  00400000
        #dtlb-entries:  00000040
        dcache-associativity:  00000001
        dcache-line-size:  00000020
        dcache-size:  00004000
        #itlb-entries:  00000040
        icache-associativity:  00000002
        icache-line-size:  00000020
        icache-size:  00004000
        upa-portid:  00000001
        clock-frequency:  17d78400
        reg:  000001c2.00000000.00000000.00000008
        device_type: 'cpu'
        name: 'SUNW,UltraSPARC-II'

    Node 0xf0085f10
        .node:  f0085f10
        manufacturer#:  00000017
        implementation#:  00000011
        mask#:  000000a0
        sparc-version:  00000009
        ecache-associativity:  00000001
        ecache-line-size:  00000040
        ecache-size:  00400000
        #dtlb-entries:  00000040
        dcache-associativity:  00000001
        dcache-line-size:  00000020
        dcache-size:  00004000
        #itlb-entries:  00000040
        icache-associativity:  00000002
        icache-line-size:  00000020
        icache-size:  00004000
        upa-portid:  00000002
        clock-frequency:  17d78400
        reg:  000001c4.00000000.00000000.00000008
        device_type: 'cpu'
        name: 'SUNW,UltraSPARC-II'

    Node 0xf008627c
        .node:  f008627c
        manufacturer#:  00000017
        implementation#:  00000011
        mask#:  000000a0
        sparc-version:  00000009
        ecache-associativity:  00000001
        ecache-line-size:  00000040
        ecache-size:  00400000
        #dtlb-entries:  00000040
        dcache-associativity:  00000001
        dcache-line-size:  00000020
        dcache-size:  00004000
        #itlb-entries:  00000040
        icache-associativity:  00000002
        icache-line-size:  00000020
        icache-size:  00004000
        upa-portid:  00000003
        clock-frequency:  17d78400
        reg:  000001c6.00000000.00000000.00000008
        device_type: 'cpu'
        name: 'SUNW,UltraSPARC-II'

    Node 0xf00865e8
        .node:  f00865e8
        slot-names:  0000001c.50434920.736c6f74.20390050.43492073.6c6f7420.=
38005043.4920736c.6f742037.00
        available:  82000000.00000000.00900000.00000000.7f700000.81000000.0=
0000000.00001000.00000000.0000f000
        bus-range:  00000000.00000000
        version#:  00000004
        implementation#:  00000000
        address:  fff5e000.fff5c000.fff4e000
        clock-frequency:  01f78a40
        upa-portid:  00000004
        interrupts:  00000131.0000012e.0000012f.00000125.00000128.00000132
        ranges:  00000000.00000000.00000000.000001c8.01000000.00000000.0080=
0000.01000000.00000000.00000000.000001c8.02010000.00000000.00010000.0200000=
0.00000000.00000000.000001c9.80000000.00000000.80000000.03000000.00000000.0=
0000000.000001c9.80000000.00000000.80000000
        reg:  000001c8.00004000.00000000.00002000.000001c8.01000000.0000000=
0.00000100.000001c8.00000000.00000000.0000d000
        no-probe-list: '0'
        latency-timer:  00000040
        model: 'SUNW,psycho'
        compatible:  70636931.3038652c.38303030.00706369.636c6173.732c3036.=
30303030.00
        thermal-interrupt: =20
        bus-parity-generated: =20
        #size-cells:  00000002
        #address-cells:  00000003
        device_type: 'pci'
        name: 'pci'

    Node 0xf0087668
        .node:  f0087668
        slot-names:  00000002.50434920.736c6f74.203600
        available:  82800000.00000000.00900000.00000000.7f700000.81800000.0=
0000000.00001000.00000000.0000f000
        bus-range:  00000080.00000080
        clock-frequency:  03ef1480
        version#:  00000004
        implementation#:  00000000
        address:  fff70000.fff6e000.fff60000
        upa-portid:  00000004
        66mhz-capable: =20
        interrupts:  00000130.0000012e.0000012f.00000125.00000128.00000132
        ranges:  00800000.00000000.00000000.000001c8.01000000.00000000.0080=
0000.01000000.00000000.00000000.000001c8.02000000.00000000.00010000.0200000=
0.00000000.00000000.000001c9.00000000.00000000.80000000.03000000.00000000.0=
0000000.000001c9.00000000.00000000.80000000
        reg:  000001c8.00002000.00000000.00002000.000001c8.01800000.0000000=
0.00000100.000001c8.00000000.00000000.0000d000
        no-probe-list: '0'
        latency-timer:  00000040
        model: 'SUNW,psycho'
        compatible:  70636931.3038652c.38303030.00706369.636c6173.732c3036.=
30303030.00
        thermal-interrupt: =20
        bus-parity-generated: =20
        #size-cells:  00000002
        #address-cells:  00000003
        device_type: 'pci'
        name: 'pci'

    Node 0xf00883ac
        .node:  f00883ac
        slot-names:  0000001c.50434920.736c6f74.20330050.43492073.6c6f7420.=
32005043.4920736c.6f742031.00
        available:  82000000.00000000.00900000.00000000.7f700000.81000000.0=
0000000.00001000.00000000.0000f000
        bus-range:  00000000.00000000
        version#:  00000004
        implementation#:  00000000
        address:  fff36000.fff34000.fff26000
        clock-frequency:  01f78a40
        upa-portid:  00000006
        interrupts:  000001b1.000001ae.000001af.000001a5.000001a8.000001b2
        ranges:  00000000.00000000.00000000.000001cc.01000000.00000000.0080=
0000.01000000.00000000.00000000.000001cc.02010000.00000000.00010000.0200000=
0.00000000.00000000.000001cd.80000000.00000000.80000000.03000000.00000000.0=
0000000.000001cd.80000000.00000000.80000000
        reg:  000001cc.00004000.00000000.00002000.000001cc.01000000.0000000=
0.00000100.000001cc.00000000.00000000.0000d000
        no-probe-list: '0'
        latency-timer:  00000040
        model: 'SUNW,psycho'
        compatible:  70636931.3038652c.38303030.00706369.636c6173.732c3036.=
30303030.00
        thermal-interrupt: =20
        bus-parity-generated: =20
        #size-cells:  00000002
        #address-cells:  00000003
        device_type: 'pci'
        name: 'pci'

    Node 0xf008900c
        .node:  f008900c
        slot-names:  00000002.50434920.736c6f74.203400
        available:  82800000.00000000.00900000.00000000.7f700000.81800000.0=
0000000.00001000.00000000.0000f000
        bus-range:  00000080.00000080
        clock-frequency:  03ef1480
        version#:  00000004
        implementation#:  00000000
        address:  fff48000.fff46000.fff38000
        upa-portid:  00000006
        66mhz-capable: =20
        interrupts:  000001b0.000001ae.000001af.000001a5.000001a8.000001b2
        ranges:  00800000.00000000.00000000.000001cc.01000000.00000000.0080=
0000.01000000.00000000.00000000.000001cc.02000000.00000000.00010000.0200000=
0.00000000.00000000.000001cd.00000000.00000000.80000000.03000000.00000000.0=
0000000.000001cd.00000000.00000000.80000000
        reg:  000001cc.00002000.00000000.00002000.000001cc.01800000.0000000=
0.00000100.000001cc.00000000.00000000.0000d000
        no-probe-list: '0'
        latency-timer:  00000040
        model: 'SUNW,psycho'
        compatible:  70636931.3038652c.38303030.00706369.636c6173.732c3036.=
30303030.00
        thermal-interrupt: =20
        bus-parity-generated: =20
        #size-cells:  00000002
        #address-cells:  00000003
        device_type: 'pci'
        name: 'pci'


--Qxx1br4bt0+wmkIi--
