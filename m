From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Thu, 06 Jan 2011 00:21:19 +0000
Subject: [PATCH] prtconf: Add Sun Fire V120
Message-Id: <1294273279.6193.40.camel@duncow>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: Richard Mortimer <richm@oldelvet.org.uk>
---
 v120 |  703 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 703 insertions(+), 0 deletions(-)

diff --git a/v120 b/v120
new file mode 100644
index 0000000..a23a921
--- /dev/null
+++ b/v120
@@ -0,0 +1,703 @@
+System Configuration:  Sun Microsystems  sun4u
+Memory size: 2048 Megabytes
+System Peripherals (PROM Nodes):
+
+Node 0xf002a63c
+    .node:  f002a63c
+    interrupt-map:  0000003c.00000000.00000000.f00692e8.80000033
+    interrupt-map-mask:  0000003e.00000000.00000000
+    #interrupt-cells:  00000001
+    idprom:  01830003.ba2d9e0c.000003ba.2d9e0c82.00000000.00000000.00000000.00000000
+    scsi-initiator-id:  00000007
+    reset-reason: 'S-POR'
+    breakpoint-trap:  0000007f
+    #size-cells:  00000002
+    model: 'SUNW,375-0132'
+    name: 'SUNW,UltraAX-i2'
+    clock-frequency:  05f5e100
+    banner-name: 'Sun Fire V120 (UltraSPARC-IIe 648MHz)'
+    compatible: 'sun4u'
+    device_type: 'upa'
+    stick-frequency:  00a98ac7
+
+    Node 0xf002d8cc
+        .node:  f002d8cc
+        name: 'packages'
+
+        Node 0xf0035e10
+            .node:  f0035e10
+            iso6429-1983-colors:  
+            name: 'terminal-emulator'
+
+        Node 0xf0038e4c
+            .node:  f0038e4c
+            disk-write-fix:  
+            name: 'deblocker'
+
+        Node 0xf0039594
+            .node:  f0039594
+            name: 'obp-tftp'
+
+        Node 0xf0044a48
+            .node:  f0044a48
+            name: 'disk-label'
+
+        Node 0xf00596d4
+            .node:  f00596d4
+            name: 'SUNW,builtin-drivers'
+
+        Node 0xf0062dc8
+            .node:  f0062dc8
+            source: '/pci@1f,0/pci@1,1/ebus@c/flashprom@10,0:'
+            name: 'dropins'
+
+        Node 0xf0074e1c
+            .node:  f0074e1c
+            name: 'kbd-translator'
+
+    Node 0xf002d93c
+        .node:  f002d93c
+        mmu:  fffe7ae0
+        memory:  fffe7ce0
+        bootargs:  00
+        bootpath: '/pci@1f,0/pci@1/scsi@8/disk@1,0:a'
+        stdout:  fffb7718
+        stdin:  fffb79e0
+        stdout-#lines:  ffffffff
+        name: 'chosen'
+
+    Node 0xf002d9a8
+        .node:  f002d9a8
+        version: 'OBP 4.0.12 2002/01/08 13:01'
+        model: 'SUNW,4.0'
+        aligned-allocator:  
+        relative-addressing:  
+        name: 'openprom'
+
+        Node 0xf002da38
+            .node:  f002da38
+            name: 'client-services'
+
+    Node 0xf002dae0
+        .node:  f002dae0
+        ras-shutdown-enabled?: 'false'
+        shutdown-temp: '75'
+        warning-temp: '70'
+        env-monitor: 'disabled'
+        diag-passes: '1'
+        diag-continue?: '0'
+        diag-targets: '0'
+        diag-verbosity: '0'
+        keyboard-click?: 'false'
+        keymap:  
+        scsi-initiator-id: '7'
+        #power-cycles: '0'
+        system-board-serial#:  
+        system-board-date:  
+        ttyb-rts-dtr-off: 'false'
+        ttyb-ignore-cd: 'true'
+        ttya-rts-dtr-off: 'false'
+        ttya-ignore-cd: 'true'
+        ttyb-mode: '9600,8,n,1,-'
+        ttya-mode: '9600,8,n,1,-'
+        pcia-probe-list: '8,5,6,7'
+        pcib-probe-list: '7,c,3,d,5'
+        mfg-mode: 'off'
+        diag-level: 'max'
+        fcode-debug?: 'false'
+        output-device: 'ttya'
+        input-device: 'ttya'
+        load-base: '16384'
+        auto-boot-retry?: 'false'
+        boot-command: 'boot'
+        auto-boot?: 'true'
+        watchdog-reboot?: 'false'
+        diag-file:  
+        diag-device: 'disk1:a disk:a'
+        boot-file:  
+        boot-device: 'disk1:a disk:a'
+        local-mac-address?: 'false'
+        net-timeout: '0'
+        ansi-terminal?: 'true'
+        screen-#columns: '80'
+        screen-#rows: '34'
+        silent-mode?: 'false'
+        use-nvramrc?: 'false'
+        nvramrc:  
+        security-mode: 'none'
+        security-password:  
+        security-#badlogins: '0'
+        oem-logo:  
+        oem-logo?: 'false'
+        oem-banner:  
+        oem-banner?: 'false'
+        hardware-revision:  
+        last-hardware-update:  
+        diag-switch?: 'false'
+        name: 'options'
+
+    Node 0xf002db50
+        .node:  f002db50
+        lom: '/pci@1f,0/pci@1,1/ebus@c/SUNW,lomh@14,200000'
+        dload: '/pci@1f,0/pci@1,1/network@c,1:,'
+        net2: '/pci@1f,0/pci@1,1/network@5,1'
+        net: '/pci@1f,0/pci@1,1/network@c,1'
+        diskx: '/pci@1f,0/pci@1/scsi@8,1/disk@0,0'
+        diskx3: '/pci@1f,0/pci@1/scsi@8,1/disk@3,0'
+        diskx2: '/pci@1f,0/pci@1/scsi@8,1/disk@2,0'
+        diskx1: '/pci@1f,0/pci@1/scsi@8,1/disk@1,0'
+        diskx0: '/pci@1f,0/pci@1/scsi@8,1/disk@0,0'
+        scsix: '/pci@1f,0/pci@1/scsi@8,1'
+        disk: '/pci@1f,0/pci@1/scsi@8/disk@0,0'
+        disk3: '/pci@1f,0/pci@1/scsi@8/disk@3,0'
+        disk2: '/pci@1f,0/pci@1/scsi@8/disk@2,0'
+        disk1: '/pci@1f,0/pci@1/scsi@8/disk@1,0'
+        disk0: '/pci@1f,0/pci@1/scsi@8/disk@0,0'
+        scsi: '/pci@1f,0/pci@1/scsi@8'
+        cdrom: '/pci@1f,0/pci@1,1/ide@d/cdrom@0,0:f'
+        ide: '/pci@1f,0/pci@1,1/ide@d'
+        ttyb: '/pci@1f,0/pci@1,1/isa@7/serial@0,2e8'
+        ttya: '/pci@1f,0/pci@1,1/isa@7/serial@0,3f8'
+        name: 'aliases'
+
+    Node 0xf004fb38
+        .node:  f004fb38
+        reg:  00000000.00000000.00000000.20000000.00000000.40000000.00000000.20000000.00000000.80000000.00000000.20000000.00000000.c0000000.00000000.20000000
+        available:  00000000.dfea0000.00000000.00018000.00000000.dfe80000.00000000.0001a000.00000000.df000000.00000000.00e00000.00000000.c0000000.00000000.1effe000.00000000.80000000.00000000.20000000.00000000.40000000.00000000.20000000.00000000.00000000.00000000.20000000
+        name: 'memory'
+
+    Node 0xf005011c
+        .node:  f005011c
+        translations:  00000000.fffe0000.00000000.00010000.80000000.dfef00b6.00000000.fffdc000.00000000.00004000.80000000.dfee40b6.00000000.fffd6000.00000000.00002000.80000000.dfee00b6.00000000.fffd4000.00000000.00002000.800001ff.f120008e.00000000.fffd2000.00000000.00002000.80000000.dfedc0b6.00000000.fffce000.00000000.00004000.80000000.dfed20b6.00000000.fffcc000.00000000.00002000.800001ff.f100008e.00000000.fffca000.00000000.00002000.800001fe.0200408e.00000000.fffc8000.00000000.00002000.80000000.deffe0b6.00000000.fffc6000.00000000.00002000.80000000.dfece0b6.00000000.fffc4000.00000000.00002000.80000000.dfede0b6.00000000.fffc2000.00000000.00002000.800001fe.0200008e.00000000.fffbe000.00000000.00002000.800001fe.0200208e.00000000.fffae000.00000000.00010000.80000000.dfeb80b6.00000000.fff82000.00000000.00010000.800001fe.0000008e.00000000.fff7c000.00000000.00006000.80000000.dfed60b6.00000000.fff7a000.00000000.00002000.800001fe.0100008e.00000000.fff78000.00000000.00002000.800001fe.0100008e.00000000.f0000000.00000000.00100000.80000000.dff000b6.00000000.40000000.00000000.00800000.80000000.df000036.00000000.00400000.00000000.00800000.80000000.df000036.00000000.00002000.00000000.003fe000.80000000.00002036
+        existing:  00000000.00000000.00000800.00000000.fffff800.00000000.00000800.00000000
+        available:  fffff800.00000000.000007fc.00000000.00000001.00000000.000007ff.00000000.00000000.ffff0000.00000000.0000e000.00000000.00000000.00000000.f0000000.00000000.fffc0000.00000000.00002000.00000000.fff92000.00000000.0001c000.00000000.fff00000.00000000.00078000.00000000.f0f80000.00000000.0e080000.00000000.f0800000.00000000.00700000
+        page-size:  00002000
+        name: 'virtual-memory'
+
+    Node 0xf00692e8
+        .node:  f00692e8
+        bus-range:  00000000.00000002
+        virtual-dma:  c0000000.20000000
+        reg:  000001fe.00000000.00000000.00010000.000001fe.01000000.00000000.00000100
+        ranges:  00000000.00000000.00000000.000001fe.01000000.00000000.01000000.01000000.00000000.00000000.000001fe.02000000.00000000.01000000.02000000.00000000.00000000.000001ff.00000000.00000001.00000000.03000000.00000000.00000000.000001ff.00000000.00000001.00000000
+        #virtual-dma-size-cells:  00000001
+        #virtual-dma-addr-cells:  00000001
+        clock-frequency:  03ef1480
+        latency-timer:  
+        button-interrupt:  
+        no-streaming-cache:  
+        66mhz-capable:  
+        interrupts:  00000030.0000002e.0000002f.00000025
+        upa-portid:  0000001f
+        bus-parity-generated:  
+        compatible: 'pci108e,a001'
+        model: 'SUNW,sabre'
+        name: 'pci'
+        device_type: 'pci'
+        #address-cells:  00000003
+        #size-cells:  00000002
+
+        Node 0xf0072174
+            .node:  f0072174
+            available:  81000000.00000000.00000430.00000000.00bffbd0.82000000.00000000.e0428000.00000000.00018000.82000000.00000000.e0460000.00000000.003a0000.82000000.00000000.e4c00000.00000000.00400000.82000000.00000000.e6000000.00000000.1a000000
+            bus-range:  00000001.00000001
+            interrupt-map:  00016000.00000000.00000000.00000001.f00692e8.0000001d.00016000.00000000.00000000.00000002.f00692e8.00000006.00016000.00000000.00000000.00000004.f00692e8.00000024.00012800.00000000.00000000.00000002.f00692e8.0000001c.00012800.00000000.00000000.00000004.f00692e8.00000026.00016800.00000000.00000000.00000001.f00692e8.0000000c.00013800.00000000.00000000.00000004.f00692e8.0000002b.00013800.00000000.00000000.00000005.f00692e8.00000025
+            interrupt-map-mask:  00fff800.00000000.00000000.00000007
+            #interrupt-cells:  00000001
+            compatible:  70636931.3038652c.35303030.00706369.636c6173.732c3036.30343030.00
+            66mhz-capable:  
+            fast-back-to-back:  
+            devsel-speed:  00000001
+            class-code:  00060400
+            revision-id:  00000013
+            device-id:  00005000
+            vendor-id:  0000108e
+            reg:  00000900.00000000.00000000.00000000.00000000
+            clock-frequency:  01f78a40
+            slot-names:  00000000
+            no-probe-list: '0'
+            model: 'SUNW,simba'
+            name: 'pci'
+            device_type: 'pci'
+            #address-cells:  00000003
+            #size-cells:  00000002
+
+            Node 0xf0075b68
+                .node:  f0075b68
+                interrupt-map:  00000014.00200000.00000001.f0072174.0000002a
+                interrupt-map-mask:  0000001f.00ffffff.00000003
+                #interrupt-cells:  00000001
+                ranges:  00000010.00000000.82016010.00000000.f0000000.01000000.00000014.00000000.82016014.00000000.f1000000.00800000
+                reg:  00016000.00000000.00000000.00000000.00000000.82016010.00000000.f0000000.00000000.01000000.82016014.00000000.f1000000.00000000.00800000
+                #size-cells:  00000001
+                #address-cells:  00000002
+                name: 'ebus'
+                max-latency:  00000019
+                min-grant:  0000000a
+                class-code:  00068000
+                revision-id:  00000001
+                devsel-speed:  00000001
+                fast-back-to-back:  
+                device-id:  00001100
+                vendor-id:  0000108e
+
+                Node 0xf00767a0
+                    .node:  f00767a0
+                    model: 'SUNW,525-1889'
+                    version: 'CORE 1.0.12 2002/01/08 13:00'
+                    name: 'flashprom'
+                    reg:  00000010.00000000.00100000
+
+                Node 0xf00771dc
+                    .node:  f00771dc
+                    model: 'mk48t59'
+                    address:  fffcc000
+                    reg:  00000014.00000000.00002000
+                    device_type: 'nvram'
+                    name: 'eeprom'
+
+                Node 0xf0077cd0
+                    .node:  f0077cd0
+                    device_type: 'idprom'
+                    name: 'idprom'
+
+                Node 0xf0077ea8
+                    .node:  f0077ea8
+                    reg:  00000014.00200000.00000004
+                    interrupts:  00000001
+                    device_type: 'block'
+                    name: 'SUNW,lomh'
+
+            Node 0xf0079354
+                .node:  f0079354
+                name: 'pmu'
+                ranges:  00000000.00000000.00011800.00000000.00000000.00000100.00000001.00000000.81011810.00000000.00004000.00000100.00000002.00000000.81011814.00000000.00000000.00000100
+                reg:  00011800.00000000.00000000.00000000.00000000.81011810.00000000.00004000.00000000.00000010
+                compatible:  70636931.3062392c.37313031.00706369.636c6173.732c3030.30303030.00
+                #address-cells:  00000002
+                #size-cells:  00000001
+                devsel-speed:  00000001
+                class-code:  00000000
+                max-latency:  00000000
+                min-grant:  00000000
+                revision-id:  00000000
+                device-id:  00007101
+                vendor-id:  000010b9
+
+                Node 0xf0079b1c
+                    .node:  f0079b1c
+                    reg:  00000000.00000000.00000100.00000001.00000000.00000100
+                    #address-cells:  00000002
+                    #size-cells:  00000000
+                    interrupts:  00000001
+                    compatible: 'i2c-smbus'
+                    name: 'i2c'
+
+                    Node 0xf007afb4
+                        .node:  f007afb4
+                        compatible: 'i2c-max1617'
+                        name: 'temperature'
+                        reg:  00000000.00000030
+
+                    Node 0xf007b25c
+                        .node:  f007b25c
+                        compatible: 'i2c-at34c02'
+                        name: 'dimm'
+                        reg:  00000000.000000a8
+
+                    Node 0xf007b314
+                        .node:  f007b314
+                        compatible: 'i2c-at34c02'
+                        name: 'dimm'
+                        reg:  00000000.000000aa
+
+                    Node 0xf007b3cc
+                        .node:  f007b3cc
+                        compatible: 'i2c-at34c02'
+                        name: 'dimm'
+                        reg:  00000000.000000ac
+
+                    Node 0xf007b484
+                        .node:  f007b484
+                        compatible: 'i2c-at34c02'
+                        name: 'dimm'
+                        reg:  00000000.000000ae
+
+                    Node 0xf007b53c
+                        .node:  f007b53c
+                        reg:  00000000.000000a0
+                        #address-cells:  00000001
+                        compatible: 'i2c-at24c64'
+                        device_type: 'nvram'
+                        name: 'i2c-nvram'
+
+                        Node 0xf007c054
+                            .node:  f007c054
+                            reg:  00001fd8.00000028
+                            device_type: 'idprom'
+                            name: 'idprom'
+
+                    Node 0xf007c308
+                        .node:  f007c308
+                        reg:  00000000.000000a2
+                        #address-cells:  00000001
+                        compatible: 'i2c-at24c64'
+                        name: 'motherboard-fru'
+
+                Node 0xf007cea0
+                    .node:  f007cea0
+                    compatible: 'SUNW,smbus-fan-control'
+                    register-mask:  00000000.00000002
+                    reg:  00000000.000000c8.00000004.80000000.000000ba.00000001
+                    name: 'fan-control'
+
+            Node 0xf007d090
+                .node:  f007d090
+                reg:  00011800.00000000.00000000.00000000.00000000.81011810.00000000.00004000.00000000.00000010
+                name: 'lomp'
+
+            Node 0xf007d2b8
+                .node:  f007d2b8
+                cache-line-size:  00000000
+                latency-timer:  00000000
+                #size-cells:  00000001
+                #address-cells:  00000002
+                name: 'isa'
+                ranges:  00000000.00000000.81013810.00000000.00000000.00010000
+                reg:  00013800.00000000.00000000.00000000.00000000.81013810.00000000.00000000.00000000.00010000.82013814.00000000.00000000.00000000.00100000
+                devsel-speed:  00000001
+                class-code:  00060100
+                max-latency:  00000000
+                min-grant:  00000000
+                subsystem-id:  00001533
+                subsystem-vendor-id:  000010b9
+                revision-id:  00000000
+                device-id:  00001533
+                vendor-id:  000010b9
+
+                Node 0xf007de64
+                    .node:  f007de64
+                    compatible: 'acpi-power'
+                    button:  
+                    interrupts:  00000005
+                    reg:  00000000.00002000.00000008
+                    name: 'power'
+
+                Node 0xf007dff8
+                    .node:  f007dff8
+                    port-a-ignore-cd:  
+                    nohupcl:  00
+                    interrupt-priorities:  0000000c.0000000c
+                    reg:  00000000.000003f8.00000008
+                    compatible:  73753136.35353000.737500
+                    device_type: 'serial'
+                    name: 'serial'
+                    interrupts:  00000004
+
+                Node 0xf007fce4
+                    .node:  f007fce4
+                    port-b-ignore-cd:  
+                    nohupcl:  00
+                    interrupt-priorities:  0000000c.0000000c
+                    reg:  00000000.000002e8.00000008
+                    compatible:  73753136.35353000.737500
+                    device_type: 'serial'
+                    name: 'serial'
+                    interrupts:  00000004
+
+            Node 0xf0081b80
+                .node:  f0081b80
+                local-mac-address:  0003ba2d.9e0c
+                assigned-addresses:  82016110.00000000.e0400000.00000000.00020000.82016130.00000000.e0800000.00000000.00400000
+                shared-pins: 'mii'
+                interrupts:  00000002
+                model: 'SUNW,pci-eri'
+                version: '1.7'
+                compatible:  70636931.3038652c.31313031.00706369.636c6173.732c3032.30303030.00
+                device_type: 'network'
+                address-bits:  00000030
+                max-frame-size:  00004000
+                reg:  00016100.00000000.00000000.00000000.00000000.02016110.00000000.00000000.00000000.00008000
+                name: 'network'
+                fast-back-to-back:  
+                devsel-speed:  00000001
+                class-code:  00020000
+                max-latency:  00000005
+                min-grant:  0000000a
+                revision-id:  00000001
+                device-id:  00001101
+                vendor-id:  0000108e
+
+            Node 0xf0089aac
+                .node:  f0089aac
+                assigned-addresses:  82016310.00000000.e2000000.00000000.01000000.82016330.00000000.e1000000.00000000.00400000
+                sunw,find-fcode:  f008ec6c
+                maximum-frame#:  0000ffff
+                reg:  00016300.00000000.00000000.00000000.00000000.02016310.00000000.00000000.00000000.01000000
+                #size-cells:  00000000
+                #address-cells:  00000001
+                compatible:  70636931.3038652c.31313033.2e310070.63693130.38652c31.31303300.70636963.6c617373.2c306330.33313000.70636963.6c617373.2c306330.3300
+                name: 'usb'
+                interrupts:  00000004
+                fast-back-to-back:  
+                devsel-speed:  00000001
+                class-code:  000c0310
+                max-latency:  00000005
+                min-grant:  0000000a
+                revision-id:  00000001
+                device-id:  00001103
+                vendor-id:  0000108e
+
+            Node 0xf008fa10
+                .node:  f008fa10
+                assigned-addresses:  81016810.00000000.00000400.00000000.00000008.81016814.00000000.00000418.00000000.00000008.81016818.00000000.00000410.00000000.00000008.8101681c.00000000.00000408.00000000.00000008.81016820.00000000.00000420.00000000.00000010
+                reg:  00016800.00000000.00000000.00000000.00000000.01016810.00000000.00000000.00000000.00000008.01016814.00000000.00000000.00000000.00000004.01016818.00000000.00000000.00000000.00000008.0101681c.00000000.00000000.00000000.00000004.01016820.00000000.00000000.00000000.00000010
+                compatible:  70636931.3062392c.35323239.00706369.636c6173.732c3031.30316666.00
+                #address-cells:  00000002
+                device_type: 'ide'
+                name: 'ide'
+                fast-back-to-back:  
+                devsel-speed:  00000001
+                class-code:  000101ff
+                interrupts:  00000001
+                max-latency:  00000004
+                min-grant:  00000002
+                revision-id:  000000c3
+                device-id:  00005229
+                vendor-id:  000010b9
+
+                Node 0xf0092284
+                    .node:  f0092284
+                    device_type: 'block'
+                    name: 'disk'
+                    compatible: 'ide-disk'
+
+                Node 0xf0092930
+                    .node:  f0092930
+                    device_type: 'block'
+                    name: 'cdrom'
+                    compatible: 'ide-cdrom'
+
+            Node 0xf009360c
+                .node:  f009360c
+                local-mac-address:  0003ba2d.9e0d
+                assigned-addresses:  82012910.00000000.e0440000.00000000.00020000.82012930.00000000.e4000000.00000000.00400000
+                shared-pins: 'mii'
+                model: 'SUNW,pci-eri'
+                version: '1.7'
+                compatible:  70636931.3038652c.31313031.00706369.636c6173.732c3032.30303030.00
+                device_type: 'network'
+                address-bits:  00000030
+                max-frame-size:  00004000
+                reg:  00012900.00000000.00000000.00000000.00000000.02012910.00000000.00000000.00000000.00008000
+                name: 'network'
+                fast-back-to-back:  
+                devsel-speed:  00000001
+                class-code:  00020000
+                interrupts:  00000002
+                max-latency:  00000005
+                min-grant:  0000000a
+                revision-id:  00000001
+                device-id:  00001101
+                vendor-id:  0000108e
+
+            Node 0xf009b560
+                .node:  f009b560
+                assigned-addresses:  82012b10.00000000.e5000000.00000000.01000000.82012b30.00000000.e4800000.00000000.00400000
+                sunw,find-fcode:  f00a0724
+                maximum-frame#:  0000ffff
+                reg:  00012b00.00000000.00000000.00000000.00000000.02012b10.00000000.00000000.00000000.01000000
+                #size-cells:  00000000
+                #address-cells:  00000001
+                compatible:  70636931.3038652c.31313033.2e310070.63693130.38652c31.31303300.70636963.6c617373.2c306330.33313000.70636963.6c617373.2c306330.3300
+                name: 'usb'
+                fast-back-to-back:  
+                devsel-speed:  00000001
+                class-code:  000c0310
+                interrupts:  00000004
+                max-latency:  00000005
+                min-grant:  0000000a
+                revision-id:  00000001
+                device-id:  00001103
+                vendor-id:  0000108e
+
+        Node 0xf007340c
+            .node:  f007340c
+            available:  81000000.00000000.00c00240.00000000.00000040.81000000.00000000.00c00300.00000000.003ffd00.82000000.00000000.00001000.00000000.00001000.82000000.00000000.0000e000.00000000.bfff2000
+            bus-range:  00000002.00000002
+            interrupt-map:  00022800.00000000.00000000.00000001.f00692e8.00000015.00022800.00000000.00000000.00000002.f00692e8.00000005.00022800.00000000.00000000.00000003.f00692e8.00000014.00022800.00000000.00000000.00000004.f00692e8.00000004.00024000.00000000.00000000.00000001.f00692e8.00000020
+            interrupt-map-mask:  00fff800.00000000.00000000.00000007
+            #interrupt-cells:  00000001
+            compatible:  70636931.3038652c.35303030.00706369.636c6173.732c3036.30343030.00
+            66mhz-capable:  
+            fast-back-to-back:  
+            devsel-speed:  00000001
+            class-code:  00060400
+            revision-id:  00000013
+            device-id:  00005000
+            vendor-id:  0000108e
+            reg:  00000800.00000000.00000000.00000000.00000000
+            clock-frequency:  01f78a40
+            slot-names:  00000000
+            no-probe-list: '0'
+            model: 'SUNW,simba'
+            name: 'pci'
+            device_type: 'pci'
+            #address-cells:  00000003
+            #size-cells:  00000002
+
+            Node 0xf00a13e8
+                .node:  f00a13e8
+                assigned-addresses:  81024010.00000000.00c00000.00000000.00000100.83024014.00000000.00002000.00000000.00002000.8302401c.00000000.00004000.00000000.00002000
+                device_type: 'scsi-2'
+                clock-frequency:  02625a00
+                reg:  00024000.00000000.00000000.00000000.00000000.01024010.00000000.00000000.00000000.00000100.03024014.00000000.00000000.00000000.00000400.0302401c.00000000.00000000.00000000.00002000
+                model: 'Symbios,53C896'
+                compatible: 'glm'
+                name: 'scsi'
+                devsel-speed:  00000001
+                class-code:  00010000
+                interrupts:  00000001
+                max-latency:  00000040
+                min-grant:  00000011
+                subsystem-id:  00001000
+                subsystem-vendor-id:  00001000
+                revision-id:  00000007
+                device-id:  0000000b
+                vendor-id:  00001000
+
+                Node 0xf00a4fb8
+                    .node:  f00a4fb8
+                    device_type: 'block'
+                    compatible: 'sd'
+                    name: 'disk'
+
+                Node 0xf00a65a4
+                    .node:  f00a65a4
+                    device_type: 'byte'
+                    compatible: 'st'
+                    name: 'tape'
+
+            Node 0xf00a726c
+                .node:  f00a726c
+                assigned-addresses:  81024110.00000000.00c00100.00000000.00000100.83024114.00000000.00006000.00000000.00002000.8302411c.00000000.00008000.00000000.00002000
+                device_type: 'scsi-2'
+                clock-frequency:  02625a00
+                reg:  00024100.00000000.00000000.00000000.00000000.01024110.00000000.00000000.00000000.00000100.03024114.00000000.00000000.00000000.00000400.0302411c.00000000.00000000.00000000.00002000
+                model: 'Symbios,53C896'
+                compatible: 'glm'
+                name: 'scsi'
+                devsel-speed:  00000001
+                class-code:  00010000
+                interrupts:  00000001
+                max-latency:  00000040
+                min-grant:  00000011
+                subsystem-id:  00001000
+                subsystem-vendor-id:  00001000
+                revision-id:  00000007
+                device-id:  0000000b
+                vendor-id:  00001000
+
+                Node 0xf00aae3c
+                    .node:  f00aae3c
+                    device_type: 'block'
+                    compatible: 'sd'
+                    name: 'disk'
+
+                Node 0xf00ac428
+                    .node:  f00ac428
+                    device_type: 'byte'
+                    compatible: 'st'
+                    name: 'tape'
+
+            Node 0xf00ad0f0
+                .node:  f00ad0f0
+                assigned-addresses:  81022820.00000000.00c00200.00000000.00000020
+                reg:  00022800.00000000.00000000.00000000.00000000.01022820.00000000.00000000.00000000.00000020
+                compatible:  70636931.3130362c.33303338.00706369.31313036.2c333033.38007063.69636c61.73732c30.63303330.3000
+                name: 'usb'
+                devsel-speed:  00000001
+                class-code:  000c0300
+                interrupts:  00000001
+                max-latency:  00000000
+                min-grant:  00000000
+                subsystem-id:  00003038
+                subsystem-vendor-id:  00001106
+                revision-id:  00000061
+                device-id:  00003038
+                vendor-id:  00001106
+
+            Node 0xf00ad39c
+                .node:  f00ad39c
+                assigned-addresses:  81022920.00000000.00c00220.00000000.00000020
+                reg:  00022900.00000000.00000000.00000000.00000000.01022920.00000000.00000000.00000000.00000020
+                compatible:  70636931.3130362c.33303338.00706369.31313036.2c333033.38007063.69636c61.73732c30.63303330.3000
+                name: 'usb'
+                devsel-speed:  00000001
+                class-code:  000c0300
+                interrupts:  00000002
+                max-latency:  00000000
+                min-grant:  00000000
+                subsystem-id:  00003038
+                subsystem-vendor-id:  00001106
+                revision-id:  00000061
+                device-id:  00003038
+                vendor-id:  00001106
+
+            Node 0xf00ad648
+                .node:  f00ad648
+                assigned-addresses:  82022a10.00000000.0000a000.00000000.00002000
+                reg:  00022a00.00000000.00000000.00000000.00000000.02022a10.00000000.00000000.00000000.00002000
+                compatible:  70636931.3130362c.33313034.00706369.31313036.2c333130.34007063.69636c61.73732c30.63303332.3000
+                name: 'usb'
+                devsel-speed:  00000001
+                class-code:  000c0320
+                interrupts:  00000003
+                max-latency:  00000000
+                min-grant:  00000000
+                subsystem-id:  00003104
+                subsystem-vendor-id:  00001106
+                revision-id:  00000063
+                device-id:  00003104
+                vendor-id:  00001106
+
+            Node 0xf00ad8f4
+                .node:  f00ad8f4
+                assigned-addresses:  82022b10.00000000.0000c000.00000000.00002000.81022b14.00000000.00c00280.00000000.00000080
+                reg:  00022b00.00000000.00000000.00000000.00000000.02022b10.00000000.00000000.00000000.00002000.01022b14.00000000.00000000.00000000.00000080
+                compatible:  70636931.3130362c.33303434.00706369.31313036.2c333034.34007063.69636c61.73732c30.63303031.3000
+                name: 'firewire'
+                devsel-speed:  00000001
+                class-code:  000c0010
+                interrupts:  00000001
+                max-latency:  00000020
+                min-grant:  00000000
+                subsystem-id:  00003044
+                subsystem-vendor-id:  00001106
+                revision-id:  00000046
+                device-id:  00003044
+                vendor-id:  00001106
+
+    Node 0xf0074a44
+        .node:  f0074a44
+        manufacturer#:  00000017
+        implementation#:  00000013
+        mask#:  00000033
+        clock-frequency:  269fb200
+        sparc-version:  00000009
+        ecache-associativity:  00000004
+        ecache-line-size:  00000040
+        #dtlb-entries:  00000040
+        dcache-associativity:  00000001
+        dcache-line-size:  00000020
+        dcache-size:  00004000
+        #itlb-entries:  00000040
+        icache-associativity:  00000002
+        icache-line-size:  00000020
+        icache-size:  00004000
+        ecache-size:  00080000
+        upa-portid:  00000000
+        name: 'SUNW,UltraSPARC-IIe'
+        reg:  000001c0.00000000.00000000.00000008
+        device_type: 'cpu'
+
-- 
1.4.4.4



