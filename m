From: Alex <alexvm12e@mail.ru>
Date: Mon, 04 Oct 2010 13:36:15 +0000
Subject: Re: sun4v_intr_settarget() return HV_EINVAL
Message-Id: <201010041736.16001.alexvm12e@mail.ru>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_PhdqMxW/prem6B1"
List-Id: <sparclinux.vger.kernel.org>
References: <201009291530.45792.alexvm12e@mail.ru>
In-Reply-To: <201009291530.45792.alexvm12e@mail.ru>
To: sparclinux@vger.kernel.org

--Boundary-00=_PhdqMxW/prem6B1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> It's not enough, I need to see the entire openfirmware device tree.
>
> Please get a copy of prtconf, built it from source if you have to, so
> you can dump the information that I need.

OK, prtconf from sparc-utils-1.9 (see attached file, please).

Thanks,
Alex.

--Boundary-00=_PhdqMxW/prem6B1
Content-Type: text/plain;
  charset="KOI8-R";
  name="prtconf_2.6.30.5.TXT"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="prtconf_2.6.30.5.TXT"


System Configuration:  Sun Microsystems  sun4u
Memory size: 156 Megabytes
System Peripherals (PROM Nodes):

Node 0xf0229da8
    :  f0229da8
    :  018300e0.815f2cab.00000000.f9edf0df.00000000.00000000.00000000.00000000
    :  00000007
    banner-name: 'Sun Fire T1000'
    name: 'SUNW,Sun-Fire-T1000'
    :  05f5e100
    :  0000007f
    device_type: 'sun4v'
    compatible: 'sun4v'
    :  00000002
    :  00000002

    Node 0xf022cf90
        :  f022cf90
        name: 'packages'

        Node 0xf0248d14
            :  f0248d14
            name: 'SUNW,builtin-drivers'

        Node 0xf0257c3c
            :  f0257c3c
            :  
            name: 'deblocker'

        Node 0xf0258120
            :  f0258120
            name: 'disk-label'

        Node 0xf0258a74
            :  f0258a74
            :  
            name: 'terminal-emulator'

        Node 0xf02606b8
            :  f02606b8
            source: '/flashprom:'
            name: 'dropins'

        Node 0xf02615c8
            :  f02615c8
            name: 'SUNW,asr'

        Node 0xf0264974
            :  f0264974
            name: 'obp-tftp'

    Node 0xf022d008
        :  f022d008
        :  00
        bootpath: '/virtual-devices@100/disk@0:a'
        :  fff74080
        :  fff74290
        :  fef3baa0
        :  fef3bca8
        :  ffffffff
        name: 'chosen'

    Node 0xf022d07c
        :  f022d07c
        version: 'OBP 4.x.build_122***PROTOTYPE BUILD*** 2009/03/18 13:50'
        model: 'SUNW,4.x.build_122***PROTOTYPE BUILD***[greddy obp #0]'
        :  
        :  
        name: 'openprom'

        Node 0xf022d10c
            :  f022d10c
            name: 'client-services'

    Node 0xf022d1c4
        :  f022d1c4
        ttya-rts-dtr-off: 'false'
        ttya-ignore-cd: 'true'
        :  
        :  
        security-mode: 'none'
        :  
        security-#badlogins: '0'
        verbosity: 'min'
        pci-mem64?: 'false'
        diag-switch?: 'false'
        local-mac-address?: 'true'
        fcode-debug?: 'true'
        scsi-initiator-id: '7'
        :  
        oem-logo?: 'false'
        :  
        oem-banner?: 'false'
        ansi-terminal?: 'true'
        screen-#columns: '80'
        screen-#rows: '34'
        ttya-mode: '9600,8,n,1,-'
        output-device: 'virtual-console'
        input-device: 'virtual-console'
        auto-boot-on-error?: 'false'
        load-base: '16384'
        auto-boot?: 'false'
        :  
        boot-command: 'boot'
        :  
        boot-device: 'vdisk'
        multipath-boot?: 'false'
        boot-device-index: '0'
        use-nvramrc?: 'false'
        :  
        error-reset-recovery: 'boot'
        name: 'options'

    Node 0xf022d23c
        :  f022d23c
        virtual-console: '/virtual-devices/console@1'
        disk: '/pci@7c0/scsi@1/disk@0'
        scsi: '/pci@7c0/scsi@1'
        ttyb: '/virtual-devices/console@4'
        nvram: '/virtual-devices/nvram@3'
        ttya: '/virtual-devices/console@1'
        snet: '/virtual-devices/network@0'
        vdisk: '/virtual-devices/disk@0'
        name: 'aliases'

    Node 0xf023efcc
        :  f023efcc
        :  00000000.01000000.00000000.09c00000
        :  00000000.0aaba000.00000000.00008000.00000000.01400000.00000000.096b8000
        name: 'memory'

    Node 0xf023f5d8
        :  f023f5d8
        :  00000000.00002000.00000000.009fe000.80000000.01402740.00000000.40000000.00000000.00800000.80000000.01800740.00000000.f0000000.00000000.00400000.80000000.01000750.00000000.fef3a000.00000000.00006000.80000000.0aac4750.00000000.fef40000.00000000.000c0000.80000000.0ab2a750.00000000.fff02000.00000000.00054000.80000000.0aacc750.00000000.fff56000.00000000.00002000.80000000.0abea750.00000000.fff5c000.00000000.0000a000.80000000.0ab20750.00000000.fff66000.00000000.0000a000.80000000.0abee750.00000000.fff70000.00000000.00010000.80000000.011f0750
        :  00000000.00000000.00000800.00000000.fffff800.00000000.00000800.00000000
        :  fffff800.00000000.000007fc.00000000.00000001.00000000.000007ff.00000000.00000000.ffff0000.00000000.0000e000.00000000.00000000.00000000.f0000000.00000000.fff00000.00000000.00002000.00000000.f0a00000.00000000.0e53a000
        :  00002000
        name: 'virtual-memory'

    Node 0xf026a6b8
        :  f026a6b8
        :  00000001.00000001.f026a6b8.00000011.00000000.00000001.f026a6b8.00000000.00000002.00000001.f026a6b8.0000003f
        :  0000001f.00ffffff.00000003
        :  00000001
        :  c0000100.00000000.00000000.00000000
        :  00000001
        :  00000000
        device_type: 'virtual-devices'
        :  53554e57.2c73756e.34762d76.69727475.616c2d64.65766963.65730053.554e572c.76697274.75616c2d.64657669.63657300
        name: 'virtual-devices'

        Node 0xf026b770
            :  f026b770
            :  
            :  00000001
            device_type: 'serial'
            :  71636e00.53554e57.2c73756e.34762d63.6f6e736f.6c6500
            name: 'console'
            :  00000001

        Node 0xf026bf40
            :  f026bf40
            :  00000001
            :  00000000
            :  00000200
            compatible: 'SUNW,sun4v-channel-devices'
            device_type: 'channel-devices'
            name: 'channel-devices'

            Node 0xf026ce48
                :  f026ce48
                compatible: 'SUNW,sun4v-channel'
                :  00000000
                name: 'virtual-channel'

            Node 0xf026cf1c
                :  f026cf1c
                compatible: 'SUNW,sun4v-console-concentrator'
                :  00000000
                name: 'virtual-console-concentrator'

            Node 0xf026d008
                :  f026d008
                compatible: 'SUNW,sun4v-disk-server'
                :  00000000
                name: 'virtual-disk-server'

        Node 0xf026d11c
            :  f026d11c
            device_type: 'block'
            :  00000000
            name: 'disk'
            compatible: 'SUNW,legion-disk'
            :  00000001

        Node 0xf026d8f8
            :  f026d8f8
            :  00000002
            name: 'snet'
            :  00000001

    Node 0xf026dac8
        :  f026dac8
        :  05f5e100
        :  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        :  c0000000.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf026dbf8
        :  f026dbf8
        :  05f5e100
        :  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        :  c0000001.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf026dd28
        :  f026dd28
        :  05f5e100
        :  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        :  c0000002.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf026de58
        :  f026de58
        :  05f5e100
        :  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        :  c0000003.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf026df88
        :  f026df88
        :  05f5e100
        :  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        :  c0000004.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf026e0b8
        :  f026e0b8
        :  05f5e100
        :  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        :  c0000005.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf026e1e8
        :  f026e1e8
        :  05f5e100
        :  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        :  c0000006.00000000.00000000.00000000
        name: 'cpu'

    Node 0xf026e318
        :  f026e318
        :  05f5e100
        :  53554e57.2c556c74.72615350.4152432d.54310053.554e572c.73756e34.762d6370.75007375.6e347600
        device_type: 'cpu'
        :  c0000007.00000000.00000000.00000000
        name: 'cpu'




--Boundary-00=_PhdqMxW/prem6B1--
