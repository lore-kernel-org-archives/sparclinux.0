From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Thu, 06 Jan 2011 00:19:45 +0000
Subject: [PATCH] prtconf: Add Sun Fire V440
Message-Id: <1294273185.6193.37.camel@duncow>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From Frans van Berckel.

Signed-off-by: Richard Mortimer <richm@oldelvet.org.uk>
---
 v440 | 1043 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 1043 insertions(+), 0 deletions(-)

diff --git a/v440 b/v440
new file mode 100644
index 0000000..b5d69d9
--- /dev/null
+++ b/v440
@@ -0,0 +1,1043 @@
+System Configuration:  Sun Microsystems  sun4u
+Memory size: 8192 Megabytes
+System Peripherals (PROM Nodes):
+
+Node 0xf0029e64
+    .node:  f0029e64
+    banner-name: 'Sun Fire V440'
+    model: 'SUNW,501-6344'
+    idprom:  01830003.ba628d61.00000000.628d613b.f1010a00.00000000.00000000.000000fa
+    scsi-initiator-id:  00000007
+    stick-frequency:  00989680
+    clock-frequency:  0ae85bc0
+    breakpoint-trap:  0000007f
+    #size-cells:  00000002
+    name: 'SUNW,Sun-Fire-V440'
+    device_type: 'jbus'
+
+    Node 0xf002cff8
+        .node:  f002cff8
+        name: 'packages'
+
+        Node 0xf0049c80
+            .node:  f0049c80
+            name: 'SUNW,builtin-drivers'
+
+        Node 0xf00560f8
+            .node:  f00560f8
+            disk-write-fix:  
+            name: 'deblocker'
+
+        Node 0xf00565dc
+            .node:  f00565dc
+            name: 'disk-label'
+
+        Node 0xf0056f30
+            .node:  f0056f30
+            iso6429-1983-colors:  
+            name: 'terminal-emulator'
+
+        Node 0xf005eaec
+            .node:  f005eaec
+            source: '/flashprom@2,0:'
+            name: 'dropins'
+
+        Node 0xf008a8d8
+            .node:  f008a8d8
+            name: 'kbd-translator'
+
+        Node 0xf008b6c8
+            .node:  f008b6c8
+            name: 'obp-tftp'
+
+        Node 0xf0090b04
+            .node:  f0090b04
+            name: 'SUNW,i2c-ram-device'
+
+        Node 0xf0091374
+            .node:  f0091374
+            name: 'SUNW,fru-device'
+
+    Node 0xf002d070
+        .node:  f002d070
+        bootargs:  00
+        bootpath: '/pci@1f,700000/scsi@2/disk@0,0:a'
+        mmu:  fff73328
+        memory:  fff73538
+        stdout:  fed9fd58
+        stdin:  feda0210
+        stdout-#lines:  ffffffff
+        name: 'chosen'
+
+    Node 0xf002d0e4
+        .node:  f002d0e4
+        version: 'OBP 4.10.10 2003/08/29 06:25'
+        model: 'SUNW,4.10.10'
+        aligned-allocator:  
+        relative-addressing:  
+        name: 'openprom'
+
+        Node 0xf002d174
+            .node:  f002d174
+            name: 'client-services'
+
+    Node 0xf002d22c
+        .node:  f002d22c
+        test-args:  
+        diag-passes: '1'
+        local-mac-address?: 'true'
+        fcode-debug?: 'false'
+        silent-mode?: 'false'
+        scsi-initiator-id: '7'
+        oem-logo:  
+        oem-logo?: 'false'
+        oem-banner:  
+        oem-banner?: 'false'
+        ansi-terminal?: 'true'
+        screen-#columns: '80'
+        screen-#rows: '34'
+        ttyb-rts-dtr-off: 'false'
+        ttyb-ignore-cd: 'true'
+        ttya-rts-dtr-off: 'false'
+        ttya-ignore-cd: 'true'
+        ttyb-mode: '9600,8,n,1,-'
+        ttya-mode: '9600,8,n,1,-'
+        output-device: 'screen'
+        input-device: 'keyboard'
+        auto-boot-on-error?: 'false'
+        load-base: '16384'
+        auto-boot?: 'true'
+        boot-command: 'boot'
+        diag-file:  
+        diag-device: 'bootdsk mirrdsk'
+        boot-file:  
+        boot-device: '/pci@1f,700000/scsi@2/disk@0,0:a /pci@1f,700000/scsi@2/disk@2,0:a'
+        use-nvramrc?: 'true'
+        nvramrc:  64657661.6c696173.20626f6f.7464736b.202f7063.69403166.2c373030.3030302f.73637369.40322f64.69736b40.332c300a.64657661.6c696173.206d6972.7264736b.202f7063.69403166.2c373030.3030302f.73637369.40322f64.69736b40.312c30
+        security-mode: 'none'
+        security-password:  
+        security-#badlogins: '0'
+        post-trigger: 'none'
+        diag-script: 'none'
+        diag-level: 'off'
+        diag-switch?: 'false'
+        obdiag-trigger: 'error-reset power-on-reset '
+        error-reset-recovery: 'boot'
+        name: 'options'
+
+    Node 0xf002d2a4
+        .node:  f002d2a4
+        screen: '/pci@1d,700000/SUNW,m64B@1'
+        mirrdsk: '/pci@1f,700000/scsi@2/disk@1,0'
+        bootdsk: '/pci@1f,700000/scsi@2/disk@3,0'
+        net: '/pci@1c,600000/network@2'
+        net1: '/pci@1f,700000/network@1'
+        net0: '/pci@1c,600000/network@2'
+        cdrom: '/pci@1e,600000/ide@d/cdrom@0,0:f'
+        ide: '/pci@1e,600000/ide@d'
+        disk3: '/pci@1f,700000/scsi@2/disk@3,0'
+        disk2: '/pci@1f,700000/scsi@2/disk@2,0'
+        disk1: '/pci@1f,700000/scsi@2/disk@1,0'
+        disk0: '/pci@1f,700000/scsi@2/disk@0,0'
+        disk: '/pci@1f,700000/scsi@2/disk@0,0'
+        scsi: '/pci@1f,700000/scsi@2'
+        i2c: '/pci@1e,600000/isa@7/i2c@0,320'
+        sc-control: '/pci@1e,600000/isa@7/rmc-comm@0,3e8'
+        ttyb: '/pci@1e,600000/isa@7/serial@0,2e8'
+        ttya: '/pci@1e,600000/isa@7/serial@0,3f8'
+        pci1f: '/pci@1f,700000'
+        pci1e: '/pci@1e,600000'
+        pci1d: '/pci@1d,700000'
+        pci1c: '/pci@1c,600000'
+        isa: '/pci@1e,600000/isa@7'
+        name: 'aliases'
+
+    Node 0xf003ebd4
+        .node:  f003ebd4
+        reg:  00000000.00000000.00000000.40000000.00000002.00000000.00000000.40000000.00000010.00000000.00000000.40000000.00000012.00000000.00000000.40000000.00000020.00000000.00000000.40000000.00000022.00000000.00000000.40000000.00000030.00000000.00000000.40000000.00000032.00000000.00000000.40000000
+        available:  00000032.3fe94000.00000000.00022000.00000032.3fe00000.00000000.00084000.00000032.3f000000.00000000.00dfc000.00000032.00000000.00000000.3effe000.00000030.00000000.00000000.40000000.00000022.00000000.00000000.40000000.00000020.00000000.00000000.40000000.00000012.00000000.00000000.40000000.00000010.00000000.00000000.40000000.00000002.00000000.00000000.40000000.00000000.00000000.00000000.40000000
+        name: 'memory'
+
+    Node 0xf003f1e0
+        .node:  f003f1e0
+        translations:  00000000.fff70000.00000000.00010000.80000032.3ff700b6.00000000.fff58000.00000000.00018000.80000032.3ff500b6.00000000.fff52000.00000000.00002000.80000400.0fe0208e.00000000.fff50000.00000000.00002000.800007fe.0000008e.00000000.fff4e000.00000000.00002000.80000032.3ff4e0b6.00000000.fff4c000.00000000.00002000.80000032.3ff4a0b6.00000000.fff4a000.00000000.00002000.80000400.0f40008e.00000000.fff48000.00000000.00002000.800007fe.0000208e.00000000.fff46000.00000000.00002000.80000400.0ec0008e.00000000.fff3a000.00000000.0000c000.80000400.0e60008e.00000000.fff38000.00000000.00002000.80000400.0e40008e.00000000.fff30000.00000000.00008000.80000400.0e41008e.00000000.fff2c000.00000000.00004000.80000032.3ff400b6.00000000.fff2a000.00000000.00002000.800007ce.0000008e.00000000.fff1e000.00000000.0000c000.80000400.0ef0008e.00000000.fff16000.00000000.00008000.80000400.0ec1008e.00000000.fff12000.00000000.00004000.80000032.3ff3c0b6.00000000.fff10000.00000000.00002000.800007c6.0000008e.00000000.fff0e000.00000000.00002000.80000032.3effe0b6.00000000.fff0c000.00000000.00002000.80000400.0fc6408e.00000000.fff0a000.00000000.00002000.80000400.0fc0008e.00000000.fff02000.00000000.00008000.80000400.0f41008e.00000000.fff00000.00000000.00002000.800007f6.0000008e.00000000.fef00000.00000000.00100000.800007ff.f000008e.00000000.feef4000.00000000.0000c000.80000400.0f60008e.00000000.feef0000.00000000.00004000.80000032.3ff380b6.00000000.feee4000.00000000.0000c000.80000400.0ff0008e.00000000.feedc000.00000000.00008000.80000400.0fc1008e.00000000.feed8000.00000000.00004000.80000032.3ff300b6.00000000.feed6000.00000000.00002000.80000032.3ff460b6.00000000.feed4000.00000000.00002000.80000032.3ff200b6.00000000.feed2000.00000000.00002000.800007fe.0100008e.00000000.fedd2000.00000000.00100000.800007ff.f000008e.00000000.fedd0000.00000000.00002000.800007fe.0100008e.00000000.fedce000.00000000.00002000.80000032.3ff100b6.00000000.fedcc000.00000000.00002000.80000032.3ff1c0b6.00000000.fedca000.00000000.00002000.800007fe.0100008e.00000000.fedc6000.0000000
0.00004000.80000032.3fdfc0b6.00000000.fedc2000.00000000.00004000.80000032.3fef60b6.00000000.fedc0000.00000000.00002000.800007fe.0100008e.00000000.fed9a000.00000000.00008000.80000032.3feea0b6.00000000.fed92000.00000000.00008000.80000032.3fec00b6.00000000.f00de000.00000000.00002000.80000032.3feba0b6.00000000.f00dc000.00000000.00002000.80000032.3febc0b6.00000000.f00da000.00000000.00002000.80000032.3febe0b6.00000000.f00d8000.00000000.00002000.80000032.3feca0b6.00000000.f00d6000.00000000.00002000.80000032.3fecc0b6.00000000.f00d4000.00000000.00002000.80000032.3fec80b6.00000000.f00d2000.00000000.00002000.80000032.3fece0b6.00000000.f00d0000.00000000.00002000.80000032.3fed00b6.00000000.f00ce000.00000000.00002000.80000032.3fed20b6.00000000.f00cc000.00000000.00002000.80000032.3fed40b6.00000000.f00ca000.00000000.00002000.80000032.3fed60b6.00000000.f00c8000.00000000.00002000.80000032.3fed80b6.00000000.f00c6000.00000000.00002000.80000032.3feda0b6.00000000.f00c4000.00000000.00002000.80000032.3fedc0b6.00000000.f00c2000.00000000.00002000.80000032.3fede0b6.00000000.f00c0000.00000000.00002000.80000032.3fee00b6.00000000.f00be000.00000000.00002000.80000032.3fee20b6.00000000.f00bc000.00000000.00002000.80000032.3fee40b6.00000000.f00ba000.00000000.00002000.80000032.3fee60b6.00000000.f00b8000.00000000.00002000.80000032.3fee80b6.00000000.f00b6000.00000000.00002000.80000032.3fef20b6.00000000.f00b4000.00000000.00002000.80000032.3fef40b6.00000000.f00b0000.00000000.00004000.80000032.3fefa0b6.00000000.f00ae000.00000000.00002000.80000032.3fefe0b6.00000000.f00ac000.00000000.00002000.80000032.3ff060b6.00000000.f00aa000.00000000.00002000.80000032.3ff080b6.00000000.f00a8000.00000000.00002000.80000032.3ff0a0b6.00000000.f00a6000.00000000.00002000.80000032.3ff000b6.00000000.f00a4000.00000000.00002000.80000032.3ff020b6.00000000.f00a2000.00000000.00002000.80000032.3ff040b6.00000000.f00a0000.00000000.00002000.80000032.3ff260b6.00000000.f009e000.00000000.00002000.80000032.3ff120b6.00000000.f009a000.00000000.00004000.80000032.3ff180b6.00000000.f0098000.00
000000.00002000.80000032.3ff140b6.00000000.f0096000.00000000.00002000.80000032.3ff160b6.00000000.f0094000.00000000.00002000.80000032.3ff1e0b6.00000000.f0090000.00000000.00004000.80000032.3ff220b6.00000000.f008e000.00000000.00002000.80000032.3ff2a0b6.00000000.f008c000.00000000.00002000.80000032.3ff480b6.00000000.f008a000.00000000.00002000.80000032.3ff280b6.00000000.f0088000.00000000.00002000.80000032.3ff2c0b6.00000000.f0086000.00000000.00002000.80000032.3ff2e0b6.00000000.f0084000.00000000.00002000.80000032.3ff340b6.00000000.f0082000.00000000.00002000.80000032.3ff440b6.00000000.f0080000.00000000.00002000.80000032.3ff360b6.00000000.f0000000.00000000.00080000.80000032.3ff800b6.00000000.41486000.00000000.02b7a000.80000032.01486036.00000000.40000000.00000000.00c00000.80000032.00000036.00000000.00400000.00000000.00800000.80000032.00000036.00000000.00002000.00000000.003fe000.80000000.00002036
+        existing:  00000000.00000000.00000800.00000000.fffff800.00000000.00000800.00000000
+        available:  fffff800.00000000.000007fc.00000000.00000001.00000000.000007ff.00000000.00000000.ffff0000.00000000.0000e000.00000000.00000000.00000000.f0000000.00000000.feda2000.00000000.0001e000.00000000.f0800000.00000000.0e592000
+        page-size:  00002000
+        name: 'virtual-memory'
+
+    Node 0xf0065280
+        .node:  f0065280
+        clock-divisors:  00000001.00000002.00000020
+        ecache-associativity:  00000004
+        ecache-line-size:  00000040
+        sparc-version:  00000009
+        #dtlb-entries:  00000010
+        dcache-associativity:  00000004
+        dcache-line-size:  00000020
+        dcache-size:  00010000
+        #itlb-entries:  00000010
+        icache-associativity:  00000004
+        icache-line-size:  00000020
+        icache-size:  00008000
+        cpuid:  00000000
+        portid:  00000000
+        reg:  00000400.00000000.00000000.00010000
+        device_type: 'cpu'
+        manufacturer#:  0000003e
+        implementation#:  00000016
+        mask#:  00000024
+        ecache-size:  00100000
+        clock-frequency:  4c5a8240
+        name: 'SUNW,UltraSPARC-IIIi'
+
+    Node 0xf0065a5c
+        .node:  f0065a5c
+        memory-control-register-1:  30000126.3fb01c4e
+        memory-layout:  42302f44.30000000.42302f44.31000000.42312f44.30000000.42312f44.31000000.01ff00ff.0000ff00.ff0000ff.ffff00ff.00800000.00000000.00001718.1c1f7275.797b2c53.545758ae.afb2b353.545758ae.afb2b348.494f50a5.a6aaab48.494f50a5.a6aaab3d.40444599.9ba1a235.37393c92.9396973d.40444599.9ba1a235.37393c92.93969702.0406085e.5f626302.0406085e.5f62630c.0d131469.6a6d6e0c.0d131469.6a6d6e21.2327287e.7f838517.181c1f72.75797b2c.2d313386.878e9021.2327287e.7f838500
+        compatible:  53554e57.2c556c74.72615350.4152432d.49494969.2c6d6300.53554e57.2c6d6300
+        portid:  00000000
+        reg:  00000400.00000000.00000000.00000008
+        device_type: 'memory-controller'
+        name: 'memory-controller'
+
+    Node 0xf0065b98
+        .node:  f0065b98
+        clock-divisors:  00000001.00000002.00000020
+        ecache-associativity:  00000004
+        ecache-line-size:  00000040
+        sparc-version:  00000009
+        #dtlb-entries:  00000010
+        dcache-associativity:  00000004
+        dcache-line-size:  00000020
+        dcache-size:  00010000
+        #itlb-entries:  00000010
+        icache-associativity:  00000004
+        icache-line-size:  00000020
+        icache-size:  00008000
+        cpuid:  00000001
+        portid:  00000001
+        reg:  00000400.00800000.00000000.00010000
+        device_type: 'cpu'
+        manufacturer#:  0000003e
+        implementation#:  00000016
+        mask#:  00000024
+        ecache-size:  00100000
+        clock-frequency:  4c5a8240
+        name: 'SUNW,UltraSPARC-IIIi'
+
+    Node 0xf0065f54
+        .node:  f0065f54
+        memory-control-register-1:  30000126.3fb01c4e
+        memory-layout:  42302f44.30000000.42302f44.31000000.42312f44.30000000.42312f44.31000000.01ff00ff.0000ff00.ff0000ff.ffff00ff.00800000.00000000.00001718.1c1f7275.797b2c53.545758ae.afb2b353.545758ae.afb2b348.494f50a5.a6aaab48.494f50a5.a6aaab3d.40444599.9ba1a235.37393c92.9396973d.40444599.9ba1a235.37393c92.93969702.0406085e.5f626302.0406085e.5f62630c.0d131469.6a6d6e0c.0d131469.6a6d6e21.2327287e.7f838517.181c1f72.75797b2c.2d313386.878e9021.2327287e.7f838500
+        compatible:  53554e57.2c556c74.72615350.4152432d.49494969.2c6d6300.53554e57.2c6d6300
+        portid:  00000001
+        reg:  00000400.00800000.00000000.00000008
+        device_type: 'memory-controller'
+        name: 'memory-controller'
+
+    Node 0xf0066090
+        .node:  f0066090
+        clock-divisors:  00000001.00000002.00000020
+        ecache-associativity:  00000004
+        ecache-line-size:  00000040
+        sparc-version:  00000009
+        #dtlb-entries:  00000010
+        dcache-associativity:  00000004
+        dcache-line-size:  00000020
+        dcache-size:  00010000
+        #itlb-entries:  00000010
+        icache-associativity:  00000004
+        icache-line-size:  00000020
+        icache-size:  00008000
+        cpuid:  00000002
+        portid:  00000002
+        reg:  00000400.01000000.00000000.00010000
+        device_type: 'cpu'
+        manufacturer#:  0000003e
+        implementation#:  00000016
+        mask#:  00000024
+        ecache-size:  00100000
+        clock-frequency:  4c5a8240
+        name: 'SUNW,UltraSPARC-IIIi'
+
+    Node 0xf006644c
+        .node:  f006644c
+        memory-control-register-1:  30000126.3fb01c4e
+        memory-layout:  42302f44.30000000.42302f44.31000000.42312f44.30000000.42312f44.31000000.01ff00ff.0000ff00.ff0000ff.ffff00ff.00800000.00000000.00001718.1c1f7275.797b2c53.545758ae.afb2b353.545758ae.afb2b348.494f50a5.a6aaab48.494f50a5.a6aaab3d.40444599.9ba1a235.37393c92.9396973d.40444599.9ba1a235.37393c92.93969702.0406085e.5f626302.0406085e.5f62630c.0d131469.6a6d6e0c.0d131469.6a6d6e21.2327287e.7f838517.181c1f72.75797b2c.2d313386.878e9021.2327287e.7f838500
+        compatible:  53554e57.2c556c74.72615350.4152432d.49494969.2c6d6300.53554e57.2c6d6300
+        portid:  00000002
+        reg:  00000400.01000000.00000000.00000008
+        device_type: 'memory-controller'
+        name: 'memory-controller'
+
+    Node 0xf0066588
+        .node:  f0066588
+        clock-divisors:  00000001.00000002.00000020
+        ecache-associativity:  00000004
+        ecache-line-size:  00000040
+        sparc-version:  00000009
+        #dtlb-entries:  00000010
+        dcache-associativity:  00000004
+        dcache-line-size:  00000020
+        dcache-size:  00010000
+        #itlb-entries:  00000010
+        icache-associativity:  00000004
+        icache-line-size:  00000020
+        icache-size:  00008000
+        cpuid:  00000003
+        portid:  00000003
+        reg:  00000400.01800000.00000000.00010000
+        device_type: 'cpu'
+        manufacturer#:  0000003e
+        implementation#:  00000016
+        mask#:  00000024
+        ecache-size:  00100000
+        clock-frequency:  4c5a8240
+        name: 'SUNW,UltraSPARC-IIIi'
+
+    Node 0xf0066944
+        .node:  f0066944
+        memory-control-register-1:  30000126.3fb01c4e
+        memory-layout:  42302f44.30000000.42302f44.31000000.42312f44.30000000.42312f44.31000000.01ff00ff.0000ff00.ff0000ff.ffff00ff.00800000.00000000.00001718.1c1f7275.797b2c53.545758ae.afb2b353.545758ae.afb2b348.494f50a5.a6aaab48.494f50a5.a6aaab3d.40444599.9ba1a235.37393c92.9396973d.40444599.9ba1a235.37393c92.93969702.0406085e.5f626302.0406085e.5f62630c.0d131469.6a6d6e0c.0d131469.6a6d6e21.2327287e.7f838517.181c1f72.75797b2c.2d313386.878e9021.2327287e.7f838500
+        compatible:  53554e57.2c556c74.72615350.4152432d.49494969.2c6d6300.53554e57.2c6d6300
+        portid:  00000003
+        reg:  00000400.01800000.00000000.00000008
+        device_type: 'memory-controller'
+        name: 'memory-controller'
+
+    Node 0xf0066a80
+        .node:  f0066a80
+        available:  81000000.00000000.00000900.00000000.0000f700.82000000.00000000.00400000.00000000.bfc00000.82000000.00000000.e0000000.00000000.10000000
+        reg:  00000400.0e600000.00000000.0000b000.00000400.0e410000.00000000.00007020.000007ce.00000000.00000000.00000100.00000400.0e780000.00000000.00010000
+        ranges:  00000000.00000000.00000000.000007ce.00000000.00000000.01000000.01000000.00000000.00000000.000007ce.01000000.00000000.01000000.02000000.00000000.00000000.000007cf.00000000.00000001.00000000.03000000.00000000.00000000.000007cf.00000000.00000001.00000000
+        virtual-dma:  c0000000.20000000
+        #virtual-dma-size-cells:  00000001
+        #virtual-dma-addr-cells:  00000001
+        no-streaming-cache:  
+        clock-frequency:  03ef1480
+        bus-range:  00000000.00000000
+        bus-parity-generated:  
+        no-probe-list: '0'
+        compatible:  70636931.3038652c.61383031.00706369.31303865.2c383030.3100
+        name: 'pci'
+        device_type: 'pci'
+        #address-cells:  00000003
+        #size-cells:  00000002
+        implementation#:  00000023
+        version#:  00000004
+        portid:  0000001c
+        ino-bitmap:  030000f0.00174000
+        interrupt-map:  00000800.00000000.00000000.00000001.f0066a80.00000004.00000800.00000000.00000000.00000002.f0066a80.00000005.00000800.00000000.00000000.00000003.f0066a80.00000006.00000800.00000000.00000000.00000004.f0066a80.00000007.00001000.00000000.00000000.00000001.f0066a80.00000018.00001000.00000000.00000000.00000002.f0066a80.00000019
+        interrupt-map-mask:  00fff800.00000000.00000000.00000007
+        #interrupt-cells:  00000001
+        slot-names:  00000002.50434935.00
+        66mhz-capable:  
+        interrupts:  00000032.00000030.00000031.00000034.0000002e
+
+        Node 0xf00cf208
+            .node:  f00cf208
+            assigned-addresses:  82001010.00000000.00200000.00000000.00200000.82001030.00000000.00100000.00000000.00100000
+            pci-req-removal:  
+            compatible:  70636931.3038652c.61626261.2e323000.70636931.3038652c.61626261.00706369.636c6173.732c3032.30303030.00706369.636c6173.732c3032.303000
+            reg:  00001000.00000000.00000000.00000000.00000000.02001010.00000000.00000000.00000000.00200000
+            version: 'Gigaswift FCode 2.10 02/03/05'
+            address-bits:  00000030
+            max-frame-size:  00004000
+            phy-type: 'mif'
+            model: 'SUNW,pci-ce'
+            device_type: 'network'
+            name: 'network'
+            local-mac-address:  0003ba62.8d61
+            66mhz-capable:  
+            fast-back-to-back:  
+            devsel-speed:  00000002
+            class-code:  00020000
+            interrupts:  00000001.00000002
+            latency-timer:  00000040
+            cache-line-size:  00000010
+            max-latency:  00000040
+            min-grant:  00000040
+            revision-id:  00000020
+            device-id:  0000abba
+            vendor-id:  0000108e
+
+    Node 0xf006f408
+        .node:  f006f408
+        portid:  0000001c
+        reg:  00000400.0e000000.00000000.00000008.00000400.0e410050.00000000.00000010
+        compatible: 'jbus-ppm'
+        name: 'ppm'
+
+    Node 0xf006f4fc
+        .node:  f006f4fc
+        available:  81000000.00000000.00000400.00000000.0000fc00.82000000.00000000.00102000.00000000.0001e000.82000000.00000000.00140000.00000000.00ec0000.82000000.00000000.02000000.00000000.be000000.82000000.00000000.e0000000.00000000.00000000
+        reg:  00000400.0ef00000.00000000.0000b000.00000400.0ec10000.00000000.00007020.000007c6.00000000.00000000.00000100.00000400.0ef80000.00000000.00010000
+        ranges:  00000000.00000000.00000000.000007c6.00000000.00000000.01000000.01000000.00000000.00000000.000007c6.01000000.00000000.01000000.02000000.00000000.00000000.000007c7.00000000.00000001.00000000.03000000.00000000.00000000.000007c7.00000000.00000001.00000000
+        virtual-dma:  c0000000.20000000
+        #virtual-dma-size-cells:  00000001
+        #virtual-dma-addr-cells:  00000001
+        no-streaming-cache:  
+        clock-frequency:  01f78a40
+        bus-range:  00000000.00000000
+        bus-parity-generated:  
+        no-probe-list: '0'
+        compatible:  70636931.3038652c.61383031.00706369.31303865.2c383030.3100
+        name: 'pci'
+        device_type: 'pci'
+        #address-cells:  00000003
+        #size-cells:  00000002
+        implementation#:  00000023
+        version#:  00000004
+        portid:  0000001d
+        ino-bitmap:  00000f0f.00088000
+        interrupt-map:  00001000.00000000.00000000.00000001.f006f4fc.00000000.00001000.00000000.00000000.00000002.f006f4fc.00000001.00001000.00000000.00000000.00000003.f006f4fc.00000002.00001000.00000000.00000000.00000004.f006f4fc.00000003.00000800.00000000.00000000.00000001.f006f4fc.00000008.00000800.00000000.00000000.00000002.f006f4fc.00000009.00000800.00000000.00000000.00000003.f006f4fc.0000000a.00000800.00000000.00000000.00000004.f006f4fc.0000000b
+        interrupt-map-mask:  00fff800.00000000.00000000.00000007
+        #interrupt-cells:  00000001
+        66mhz-capable:  
+        slot-names:  00000006.50434932.00504349.3400
+        interrupts:  00000033.00000030.00000031.00000034.0000002f
+
+        Node 0xf00d5234
+            .node:  f00d5234
+            address:  fdd92000
+            assigned-addresses:  82000810.00000000.01000000.00000000.01000000.81000814.00000000.00000300.00000000.00000100.82000818.00000000.00100000.00000000.00002000.82000830.00000000.00120000.00000000.00020000
+            aty,fcode: '1.69'
+            aty,card#: '109-XXXXX-XX'
+            aty,rom#: '113-XXXXX-100'
+            aty,model: 'ATY,RageXL'
+            model: 'SUNW,370-4362'
+            name: 'SUNW,m64B'
+            pgx_version: '@(#) pgx64.fth 1.12 01/05/04 '
+            reg:  00000800.00000000.00000000.00000000.00000000.02000810.00000000.00000000.00000000.01000000.02000818.00000000.00000000.00000000.00001000.02000830.00000000.00000000.00000000.00020000
+            character-set: 'ISO8859-1'
+            device_type: 'display'
+            linebytes:  00000500
+            v-freq:  0000003c
+            depth:  00000008
+            height:  00000400
+            width:  00000500
+            fb-memory:  00000008
+            aty,flags:  0000001b
+            aty,status:  00000004
+            edid:  00ffffff.ffffff00.26cd0256.e8c90000.29110103.68312078.2a9510a6.5444a125.145054bf.ef80714f.81808140.814f810f.95009040.b3002139.9030621a.274068b0.3600ea40.1100001c.000000ff.00303538.38314d37.41353136.38380000.00fd0037.4b1e5011.000a2020.20202020.000000fc.00504c32.32303157.0a202020.2020004a
+            fcode-rom-offset:  00000000
+            fast-back-to-back:  
+            devsel-speed:  00000001
+            class-code:  00030000
+            interrupts:  00000001
+            latency-timer:  00000040
+            cache-line-size:  00000010
+            max-latency:  00000000
+            min-grant:  00000008
+            revision-id:  00000027
+            device-id:  00004752
+            vendor-id:  00001002
+
+    Node 0xf0077a84
+        .node:  f0077a84
+        available:  81000000.00000000.00000930.00000000.0000f6d0.82000000.00000000.00100000.00000000.00f00000.82000000.00000000.03000000.00000000.bd000000.82000000.00000000.e0000000.00000000.10000000
+        reg:  00000400.0f600000.00000000.0000b000.00000400.0f410000.00000000.00007020.000007fe.00000000.00000000.00000100.00000400.0f780000.00000000.00010000
+        ranges:  00000000.00000000.00000000.000007fe.00000000.00000000.01000000.01000000.00000000.00000000.000007fe.01000000.00000000.01000000.02000000.00000000.00000000.000007ff.00000000.00000001.00000000.03000000.00000000.00000000.000007ff.00000000.00000001.00000000
+        virtual-dma:  c0000000.20000000
+        #virtual-dma-size-cells:  00000001
+        #virtual-dma-addr-cells:  00000001
+        no-streaming-cache:  
+        clock-frequency:  01f78a40
+        bus-range:  00000000.00000000
+        bus-parity-generated:  
+        no-probe-list: '0'
+        compatible:  70636931.3038652c.61383031.00706369.31303865.2c383030.3100
+        name: 'pci'
+        device_type: 'pci'
+        #address-cells:  00000003
+        #size-cells:  00000002
+        implementation#:  00000023
+        version#:  00000004
+        portid:  0000001e
+        interrupt-map:  00001000.00000000.00000000.00000001.f0077a84.0000000c.00001000.00000000.00000000.00000002.f0077a84.0000000d.00001000.00000000.00000000.00000003.f0077a84.0000000e.00001000.00000000.00000000.00000004.f0077a84.0000000f.00001800.00000000.00000000.00000001.f0077a84.00000010.00001800.00000000.00000000.00000002.f0077a84.00000011.00001800.00000000.00000000.00000003.f0077a84.00000012.00001800.00000000.00000000.00000004.f0077a84.00000013.00002000.00000000.00000000.00000001.f0077a84.00000014.00002000.00000000.00000000.00000002.f0077a84.00000015.00002000.00000000.00000000.00000003.f0077a84.00000016.00002000.00000000.00000000.00000004.f0077a84.00000017.00004000.00000000.00000000.00000001.f0077a84.00000020.00005000.00000000.00000000.00000001.f0077a84.00000021.00005800.00000000.00000000.00000001.f0077a84.00000025.00006800.00000000.00000000.00000001.f0077a84.00000026
+        ino-bitmap:  ccfff000.001713e7
+        interrupt-map-mask:  00fff800.00000000.00000000.00000007
+        #interrupt-cells:  00000001
+        slot-names:  0000001c.50434930.00504349.31005043.493300
+        interrupts:  00000032.00000030.00000031.00000034.0000002c
+
+        Node 0xf0091b7c
+            .node:  f0091b7c
+            assigned-addresses:  81003810.00000000.00000000.00000000.00010000.82003814.00000000.00000000.00000000.00100000.82003818.00000000.00000000.00000000.00100000
+            interrupt-map:  00000000.00000320.00000001.f0077a84.0000001b.00000000.00000800.00000001.f0077a84.0000001a.00000000.000003f8.00000001.f0077a84.00000022.00000000.000002e8.00000001.f0077a84.00000022.00000000.000003e8.00000001.f0077a84.00000022
+            interrupt-map-mask:  00000003.00ffffff.0000000f
+            #interrupt-cells:  00000001
+            ranges:  00000000.00000000.81003810.00000000.00000000.00010000.00000001.00000000.82003814.00000000.00000000.00100000.00000002.00000000.82003818.00000000.f0000000.00100000
+            reg:  00003800.00000000.00000000.00000000.00000000.81003810.00000000.00000000.00000000.00010000.82003814.00000000.00000000.00000000.00100000.82003818.00000000.f0000000.00000000.00100000
+            #size-cells:  00000001
+            #address-cells:  00000002
+            name: 'isa'
+            devsel-speed:  00000001
+            class-code:  00060100
+            latency-timer:  00000000
+            cache-line-size:  00000000
+            max-latency:  00000000
+            min-grant:  00000000
+            revision-id:  00000000
+            device-id:  00001533
+            vendor-id:  000010b9
+
+            Node 0xf0092b70
+                .node:  f0092b70
+                model: 'SUNW,525-1970'
+                version:  4f425020.342e3130.2e313020.32303033.2f30382f.32392030.363a3235.2053756e.20466972.65205634.3430004f.42444941.4720342e.31302e31.30203230.30332f30.382f3239.2030363a.32362020.00504f53.5420342e.31302e39.20323030.332f3038.2f303520.31333a31.3500
+                name: 'flashprom'
+                compatible: 'isa-flashprom'
+                reg:  00000002.00000000.00100000.00000000.00000290.00000001
+
+            Node 0xf009386c
+                .node:  f009386c
+                address:  feed2070
+                reg:  00000000.00000070.00000002
+                compatible: 'isa-m5819p'
+                model: 'm5819p'
+                name: 'rtc'
+
+            Node 0xf00946c4
+                .node:  f00946c4
+                interrupts:  00000001
+                reg:  00000000.00000320.00000002
+                device_type: 'i2c'
+                compatible: 'pcf8584'
+                #size-cells:  00000000
+                #address-cells:  00000002
+                name: 'i2c'
+
+                Node 0xf00958d4
+                    .node:  f00958d4
+                    revision-id:  00000015
+                    reg:  00000000.00000016
+                    compatible: 'SUNW,i2c-imax'
+                    name: 'i2c-bridge'
+
+                Node 0xf0095a1c
+                    .node:  f0095a1c
+                    revision-id:  00000015
+                    reg:  00000000.00000018
+                    compatible: 'SUNW,i2c-imax'
+                    name: 'i2c-bridge'
+
+                Node 0xf0095b64
+                    .node:  f0095b64
+                    reg:  00000000.00000030
+                    compatible: 'i2c-max1617'
+                    name: 'temperature'
+
+                Node 0xf0095d3c
+                    .node:  f0095d3c
+                    reg:  00000000.00000042
+                    compatible: 'i2c-pca9555'
+                    name: 'gpio'
+
+                Node 0xf0095dfc
+                    .node:  f0095dfc
+                    reg:  00000000.00000044
+                    compatible: 'i2c-pca9555'
+                    name: 'gpio'
+
+                Node 0xf0095ebc
+                    .node:  f0095ebc
+                    reg:  00000000.00000046
+                    compatible: 'i2c-pca9555'
+                    name: 'gpio'
+
+                Node 0xf0095f7c
+                    .node:  f0095f7c
+                    reg:  00000000.00000048
+                    compatible: 'i2c-pca9555'
+                    name: 'gpio'
+
+                Node 0xf009603c
+                    .node:  f009603c
+                    reg:  00000000.0000005c
+                    compatible: 'i2c-adm1026'
+                    name: 'hardware-monitor'
+
+                Node 0xf0096120
+                    .node:  f0096120
+                    reg:  00000000.00000064
+                    compatible: 'i2c-max1617'
+                    name: 'temperature'
+
+                Node 0xf00962f8
+                    .node:  f00962f8
+                    reg:  00000000.00000080
+                    compatible: 'i2c-max1617'
+                    name: 'temperature'
+
+                Node 0xf00964d0
+                    .node:  f00964d0
+                    reg:  00000000.00000090
+                    compatible: 'i2c-max1617'
+                    name: 'temperature'
+
+                Node 0xf00966a8
+                    .node:  f00966a8
+                    reg:  00000000.0000009c
+                    compatible: 'i2c-lm75'
+                    name: 'temperature-sensor'
+
+                Node 0xf0096864
+                    .node:  f0096864
+                    reg:  00000000.000000a2
+                    compatible: 'i2c-at24c64'
+                    device_type: 'fru-prom'
+                    name: 'motherboard-fru-prom'
+
+                Node 0xf0096b18
+                    .node:  f0096b18
+                    reg:  00000000.000000a4
+                    compatible: 'i2c-at24c64'
+                    device_type: 'fru-prom'
+                    name: 'power-supply-fru-prom'
+
+                Node 0xf0096dcc
+                    .node:  f0096dcc
+                    reg:  00000000.000000a6
+                    compatible: 'i2c-at24c64'
+                    device_type: 'fru-prom'
+                    name: 'rmc-fru-prom'
+
+                Node 0xf0097078
+                    .node:  f0097078
+                    reg:  00000000.000000a8
+                    compatible: 'i2c-at24c64'
+                    device_type: 'fru-prom'
+                    name: 'scsi-fru-prom'
+
+                Node 0xf0097324
+                    .node:  f0097324
+                    reg:  00000000.000000b0
+                    compatible: 'i2c-at24c64'
+                    device_type: 'fru-prom'
+                    name: 'power-supply-fru-prom'
+
+                Node 0xf00975d8
+                    .node:  f00975d8
+                    reg:  00000000.000000b6
+                    compatible: 'i2c-at34c02'
+                    name: 'dimm-spd'
+
+                Node 0xf0097798
+                    .node:  f0097798
+                    reg:  00000000.000000b8
+                    compatible: 'i2c-at34c02'
+                    name: 'dimm-spd'
+
+                Node 0xf0097958
+                    .node:  f0097958
+                    reg:  00000000.000000ba
+                    compatible: 'i2c-at34c02'
+                    name: 'dimm-spd'
+
+                Node 0xf0097b18
+                    .node:  f0097b18
+                    reg:  00000000.000000bc
+                    compatible: 'i2c-at34c02'
+                    name: 'dimm-spd'
+
+                Node 0xf0097cd8
+                    .node:  f0097cd8
+                    reg:  00000000.000000be
+                    compatible: 'i2c-at24c64'
+                    device_type: 'fru-prom'
+                    name: 'cpu-fru-prom'
+
+                Node 0xf0097f84
+                    .node:  f0097f84
+                    reg:  00000000.000000c6
+                    compatible: 'i2c-at34c02'
+                    name: 'dimm-spd'
+
+                Node 0xf0098144
+                    .node:  f0098144
+                    reg:  00000000.000000c8
+                    compatible: 'i2c-at34c02'
+                    name: 'dimm-spd'
+
+                Node 0xf0098304
+                    .node:  f0098304
+                    reg:  00000000.000000ca
+                    compatible: 'i2c-at34c02'
+                    name: 'dimm-spd'
+
+                Node 0xf00984c4
+                    .node:  f00984c4
+                    reg:  00000000.000000cc
+                    compatible: 'i2c-at34c02'
+                    name: 'dimm-spd'
+
+                Node 0xf0098684
+                    .node:  f0098684
+                    reg:  00000000.000000ce
+                    compatible: 'i2c-at24c64'
+                    device_type: 'fru-prom'
+                    name: 'cpu-fru-prom'
+
+                Node 0xf0098930
+                    .node:  f0098930
+                    reg:  00000000.000000d6
+                    compatible: 'i2c-at34c02'
+                    name: 'dimm-spd'
+
+                Node 0xf0098af0
+                    .node:  f0098af0
+                    reg:  00000000.000000d8
+                    compatible: 'i2c-at34c02'
+                    name: 'dimm-spd'
+
+                Node 0xf0098cb0
+                    .node:  f0098cb0
+                    reg:  00000000.000000da
+                    compatible: 'i2c-at34c02'
+                    name: 'dimm-spd'
+
+                Node 0xf0098e70
+                    .node:  f0098e70
+                    reg:  00000000.000000dc
+                    compatible: 'i2c-at34c02'
+                    name: 'dimm-spd'
+
+                Node 0xf0099030
+                    .node:  f0099030
+                    reg:  00000000.000000de
+                    compatible: 'i2c-at24c64'
+                    device_type: 'fru-prom'
+                    name: 'cpu-fru-prom'
+
+                Node 0xf00992dc
+                    .node:  f00992dc
+                    reg:  00000000.000000e6
+                    compatible: 'i2c-at34c02'
+                    name: 'dimm-spd'
+
+                Node 0xf009949c
+                    .node:  f009949c
+                    reg:  00000000.000000e8
+                    compatible: 'i2c-at34c02'
+                    name: 'dimm-spd'
+
+                Node 0xf009965c
+                    .node:  f009965c
+                    reg:  00000000.000000ea
+                    compatible: 'i2c-at34c02'
+                    name: 'dimm-spd'
+
+                Node 0xf009981c
+                    .node:  f009981c
+                    reg:  00000000.000000ec
+                    compatible: 'i2c-at34c02'
+                    name: 'dimm-spd'
+
+                Node 0xf00999dc
+                    .node:  f00999dc
+                    reg:  00000000.000000ee
+                    compatible: 'i2c-at24c64'
+                    device_type: 'fru-prom'
+                    name: 'cpu-fru-prom'
+
+                Node 0xf0099c88
+                    .node:  f0099c88
+                    reg:  00000000.000000d2
+                    compatible: 'i2c-ics951601'
+                    name: 'clock-generator'
+
+            Node 0xf0099dc4
+                .node:  f0099dc4
+                button:  
+                interrupts:  00000001
+                reg:  00000000.00000800.00000030
+                compatible:  616c6931.35333564.2b2d706f.77657200.61637069.2d706f77.657200
+                name: 'power'
+
+            Node 0xf0099f2c
+                .node:  f0099f2c
+                ignore-cd:  
+                reg:  00000000.000003f8.00000008
+                interrupts:  00000001
+                compatible:  73753136.35353000.737500
+                device_type: 'serial'
+                name: 'serial'
+
+            Node 0xf009b968
+                .node:  f009b968
+                ignore-cd:  
+                reg:  00000000.000002e8.00000008
+                interrupts:  00000001
+                compatible:  73753136.35353000.737500
+                device_type: 'serial'
+                name: 'serial'
+
+            Node 0xf009d3a4
+                .node:  f009d3a4
+                reg:  00000000.000003e8.00000008
+                interrupts:  00000001
+                compatible: 'rmc_comm'
+                device_type: 'serial'
+                name: 'rmc-comm'
+
+        Node 0xf00a01cc
+            .node:  f00a01cc
+            assigned-addresses:  81003010.00000000.00000000.00000000.00000010
+            ranges:  00000000.00000000.00003000.00000000.00000000.00000100.00000001.00000000.81003010.00000000.00000600.00000100.00000002.00000000.81003014.00000000.00000000.00000100
+            reg:  00003000.00000000.00000000.00000000.00000000.81003010.00000000.00000600.00000000.00000010
+            compatible:  70636931.3062392c.37313031.2e300070.63693130.62392c37.31303100.70636963.6c617373.2c303030.30303000.70636963.6c617373.2c303030.3000
+            #address-cells:  00000002
+            #size-cells:  00000001
+            name: 'pmu'
+            devsel-speed:  00000001
+            class-code:  00000000
+            latency-timer:  00000000
+            cache-line-size:  00000000
+            max-latency:  00000000
+            min-grant:  00000000
+            revision-id:  00000000
+            device-id:  00007101
+            vendor-id:  000010b9
+
+            Node 0xf00a0dbc
+                .node:  f00a0dbc
+                register-mask:  00000000.00000002.00000000.00000001
+                reg:  80000000.0000008a.00000001.80000000.0000009c.00000001
+                compatible: 'pmugpio'
+                name: 'gpio'
+
+        Node 0xf00a0f78
+            .node:  f00a0f78
+            assigned-addresses:  82005010.00000000.01000000.00000000.01000000
+            sunw,find-fcode:  f00a62fc
+            maximum-frame#:  0000ffff
+            reg:  00005000.00000000.00000000.00000000.00000000.02005010.00000000.00000000.00000000.01000000
+            #size-cells:  00000000
+            #address-cells:  00000001
+            compatible:  70636931.3062392c.35323337.2e330070.63693130.62392c35.32333700.70636963.6c617373.2c306330.33313000.70636963.6c617373.2c306330.3300
+            name: 'usb'
+            fast-back-to-back:  
+            devsel-speed:  00000001
+            class-code:  000c0310
+            interrupts:  00000001
+            latency-timer:  00000040
+            cache-line-size:  00000000
+            max-latency:  00000050
+            min-grant:  00000000
+            revision-id:  00000003
+            device-id:  00005237
+            vendor-id:  000010b9
+
+        Node 0xf00a7198
+            .node:  f00a7198
+            assigned-addresses:  82005810.00000000.02000000.00000000.01000000
+            sunw,find-fcode:  f00ac51c
+            maximum-frame#:  0000ffff
+            reg:  00005800.00000000.00000000.00000000.00000000.02005810.00000000.00000000.00000000.01000000
+            #size-cells:  00000000
+            #address-cells:  00000001
+            compatible:  70636931.3062392c.35323337.2e330070.63693130.62392c35.32333700.70636963.6c617373.2c306330.33313000.70636963.6c617373.2c306330.3300
+            name: 'usb'
+            fast-back-to-back:  
+            devsel-speed:  00000001
+            class-code:  000c0310
+            interrupts:  00000001
+            latency-timer:  00000040
+            cache-line-size:  00000000
+            max-latency:  00000050
+            min-grant:  00000000
+            revision-id:  00000003
+            device-id:  00005237
+            vendor-id:  000010b9
+
+        Node 0xf00ad3b8
+            .node:  f00ad3b8
+            assigned-addresses:  81006810.00000000.00000900.00000000.00000008.81006814.00000000.00000918.00000000.00000008.81006818.00000000.00000910.00000000.00000008.8100681c.00000000.00000908.00000000.00000008.81006820.00000000.00000920.00000000.00000010
+            reg:  00006800.00000000.00000000.00000000.00000000.01006810.00000000.00000000.00000000.00000008.01006814.00000000.00000000.00000000.00000004.01006818.00000000.00000000.00000000.00000008.0100681c.00000000.00000000.00000000.00000004.01006820.00000000.00000000.00000000.00000010
+            compatible:  70636931.3062392c.35323239.2e633400.70636931.3062392c.35323239.00706369.636c6173.732c3031.30316666.00706369.636c6173.732c3031.303100
+            #address-cells:  00000002
+            device_type: 'ide'
+            name: 'ide'
+            fast-back-to-back:  
+            devsel-speed:  00000001
+            class-code:  000101ff
+            interrupts:  00000001
+            latency-timer:  00000040
+            cache-line-size:  00000000
+            max-latency:  00000004
+            min-grant:  00000002
+            revision-id:  000000c4
+            device-id:  00005229
+            vendor-id:  000010b9
+
+            Node 0xf00aff94
+                .node:  f00aff94
+                device_type: 'block'
+                name: 'disk'
+                compatible: 'ide-disk'
+
+            Node 0xf00b0648
+                .node:  f00b0648
+                device_type: 'block'
+                name: 'cdrom'
+                compatible: 'ide-cdrom'
+
+    Node 0xf00800c4
+        .node:  f00800c4
+        portid:  0000001e
+        reg:  00000400.0f000000.00000000.00000008.00000400.0f410050.00000000.00000010
+        compatible: 'jbus-ppm'
+        name: 'ppm'
+
+    Node 0xf00801b8
+        .node:  f00801b8
+        available:  81000000.00000000.00000500.00000000.0000fb00.82000000.00000000.00440000.00000000.000c0000.82000000.00000000.00700000.00000000.bf900000.82000000.00000000.e0000000.00000000.00000000
+        reg:  00000400.0ff00000.00000000.0000b000.00000400.0fc10000.00000000.00007020.000007f6.00000000.00000000.00000100.00000400.0ff80000.00000000.00010000
+        ranges:  00000000.00000000.00000000.000007f6.00000000.00000000.01000000.01000000.00000000.00000000.000007f6.01000000.00000000.01000000.02000000.00000000.00000000.000007f7.00000000.00000001.00000000.03000000.00000000.00000000.000007f7.00000000.00000001.00000000
+        virtual-dma:  c0000000.20000000
+        #virtual-dma-size-cells:  00000001
+        #virtual-dma-addr-cells:  00000001
+        no-streaming-cache:  
+        clock-frequency:  03ef1480
+        bus-range:  00000000.00000000
+        bus-parity-generated:  
+        no-probe-list: '0'
+        compatible:  70636931.3038652c.61383031.00706369.31303865.2c383030.3100
+        name: 'pci'
+        device_type: 'pci'
+        #address-cells:  00000003
+        #size-cells:  00000002
+        implementation#:  00000023
+        version#:  00000004
+        portid:  0000001f
+        interrupt-map:  00000800.00000000.00000000.00000001.f00801b8.0000001c.00000800.00000000.00000000.00000002.f00801b8.0000001d.00001000.00000000.00000000.00000001.f00801b8.00000023.00001000.00000000.00000000.00000002.f00801b8.00000024
+        ino-bitmap:  30000000.00080018
+        interrupt-map-mask:  00fff800.00000000.00000000.00000007
+        #interrupt-cells:  00000001
+        interrupts:  00000033.00000030.00000031.00000034.0000002d
+
+        Node 0xf00b1008
+            .node:  f00b1008
+            assigned-addresses:  82000810.00000000.00200000.00000000.00200000.82000830.00000000.00100000.00000000.00100000
+            pci-req-removal:  
+            compatible:  70636931.3038652c.61626261.2e323000.70636931.3038652c.61626261.00706369.636c6173.732c3032.30303030.00706369.636c6173.732c3032.303000
+            reg:  00000800.00000000.00000000.00000000.00000000.02000810.00000000.00000000.00000000.00200000
+            version: 'Gigaswift FCode 2.10 02/03/05'
+            address-bits:  00000030
+            max-frame-size:  00004000
+            phy-type: 'mif'
+            model: 'SUNW,pci-ce'
+            device_type: 'network'
+            name: 'network'
+            local-mac-address:  0003ba62.8d62
+            66mhz-capable:  
+            fast-back-to-back:  
+            devsel-speed:  00000002
+            class-code:  00020000
+            interrupts:  00000001.00000002
+            latency-timer:  00000040
+            cache-line-size:  00000010
+            max-latency:  00000040
+            min-grant:  00000040
+            revision-id:  00000020
+            device-id:  0000abba
+            vendor-id:  0000108e
+
+        Node 0xf00b6fd0
+            .node:  f00b6fd0
+            firmware-version: '1.03.11.01'
+            mpt-version: '1.02'
+            assigned-addresses:  81001010.00000000.00000300.00000000.00000100.83001014.00000000.00400000.00000000.00010000.8300101c.00000000.00410000.00000000.00010000.82001030.00000000.00500000.00000000.00100000
+            compatible:  70636931.3030302c.33302e31.3030302e.31303030.2e370070.63693130.30302c33.302e3130.30302e31.30303000.70636931.3030302c.31303030.00706369.31303030.2c33302e.37007063.69313030.302c3330.00706369.636c6173.732c3031.30303030.00706369.636c6173.732c3031.303000
+            model: 'LSI,1030'
+            reg:  00001000.00000000.00000000.00000000.00000000.01001010.00000000.00000000.00000000.00000100.03001014.00000000.00000000.00000000.00010000.0300101c.00000000.00000000.00000000.00010000.02001030.00000000.00000000.00000000.00100000
+            version: 'LSI1030 SCSI Host Adapter FCode Driver: 1.8 03/04/17'
+            device_type: 'scsi-2'
+            name: 'scsi'
+            fcode-rom-offset:  00000000
+            66mhz-capable:  
+            devsel-speed:  00000001
+            class-code:  00010000
+            interrupts:  00000001
+            latency-timer:  00000040
+            cache-line-size:  00000010
+            max-latency:  00000006
+            min-grant:  00000010
+            subsystem-id:  00001000
+            subsystem-vendor-id:  00001000
+            revision-id:  00000007
+            device-id:  00000030
+            vendor-id:  00001000
+
+            Node 0xf00c1be8
+                .node:  f00c1be8
+                device_type: 'block'
+                compatible: 'sd'
+                name: 'disk'
+
+            Node 0xf00c2778
+                .node:  f00c2778
+                device_type: 'byte'
+                compatible: 'st'
+                name: 'tape'
+
+        Node 0xf00c34d0
+            .node:  f00c34d0
+            assigned-addresses:  81001110.00000000.00000400.00000000.00000100.83001114.00000000.00420000.00000000.00010000.8300111c.00000000.00430000.00000000.00010000.82001130.00000000.00600000.00000000.00100000
+            compatible:  70636931.3030302c.33302e31.3030302e.31303030.2e370070.63693130.30302c33.302e3130.30302e31.30303000.70636931.3030302c.31303030.00706369.31303030.2c33302e.37007063.69313030.302c3330.00706369.636c6173.732c3031.30303030.00706369.636c6173.732c3031.303000
+            model: 'LSI,1030'
+            reg:  00001100.00000000.00000000.00000000.00000000.01001110.00000000.00000000.00000000.00000100.03001114.00000000.00000000.00000000.00010000.0300111c.00000000.00000000.00000000.00010000.02001130.00000000.00000000.00000000.00100000
+            version: 'LSI1030 SCSI Host Adapter FCode Driver: 1.8 03/04/17'
+            device_type: 'scsi-2'
+            name: 'scsi'
+            fcode-rom-offset:  00000000
+            66mhz-capable:  
+            devsel-speed:  00000001
+            class-code:  00010000
+            interrupts:  00000002
+            latency-timer:  00000040
+            cache-line-size:  00000010
+            max-latency:  00000006
+            min-grant:  00000010
+            subsystem-id:  00001000
+            subsystem-vendor-id:  00001000
+            revision-id:  00000007
+            device-id:  00000030
+            vendor-id:  00001000
+
+            Node 0xf00cd8a8
+                .node:  f00cd8a8
+                device_type: 'block'
+                compatible: 'sd'
+                name: 'disk'
+
+            Node 0xf00ce438
+                .node:  f00ce438
+                device_type: 'byte'
+                compatible: 'st'
+                name: 'tape'
+
+    Node 0xf008868c
+        .node:  f008868c
+        #address-cells:  00000002
+        #size-cells:  00000000
+        reg:  00000400.0fc64000.00000000.00000010
+        compatible: 'jbus-i2c'
+        device_type: 'i2c'
+        name: 'i2c'
+
+        Node 0xf0089984
+            .node:  f0089984
+            reg:  00000000.00000050
+            compatible: 'i2c-at24c64'
+            device_type: 'nvram'
+            name: 'nvram'
+
+        Node 0xf008a2b4
+            .node:  f008a2b4
+            device_type: 'idprom'
+            reg:  00000000.00000050
+            name: 'idprom'
+
-- 
1.4.4.4



