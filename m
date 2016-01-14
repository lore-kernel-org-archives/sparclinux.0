From: Anatoly Pugachev <matorola@gmail.com>
Date: Thu, 14 Jan 2016 17:17:57 +0000
Subject: prtconfs: Add SPARC M7-16 prtconf
Message-Id: <20160114171756.GA3354@yogzotot>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

prtconf M7-16 , taken from solaris 11 HCL
http://www.oracle.com/webfolder/technetwork/hcl/data/systems/prtconf/oracle_america_inc/sol_11_3/72838.txt

Signed-off-by: Anatoly Pugachev <matorola@gmail.com>
---
 /dev/null => M7-16 | 1655 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1655 insertions(+)

diff --git a/M7-16 b/M7-16
new file mode 100644
index 0000000..cbff61e
--- /dev/null
+++ b/M7-16
@@ -0,0 +1,1655 @@
+System Configuration:  Oracle Corporation  sun4v
+Memory size: 96256 Megabytes
+System Peripherals (PROM Nodes):
+
+Node 0xf02296b8
+    idprom:  01860010.e05db2b0.00000000.5db2a067.00000000.00000000.00000000.00000000
+    scsi-initiator-id:  00000007
+    #priqs-per-pcibus:  00000010
+    #priqs-per-cpu:  00000010
+    priq-eq-sizes:  00000003
+    non-ios-perf-counters:  'ORCL,mr-non-ios-pr'
+    ios-perf-counters:  'ORCL,mr-ios-pr'
+    product-name:  'SPARC M7-16'
+    banner-name:  'SPARC M7-16'
+    name:  'ORCL,SPARC-M7-16'
+    stick-frequency:  3b9aca00
+    hv-api-groups:  00000000.00000001.00000100.00000003.00000101.00000105.00000108.00000107.0000011d.00000118
+    breakpoint-trap:  0000007f
+    device_type:  'sun4v'
+    compatible: 'sun4v'
+    #address-cells:  00000002
+    #size-cells:  00000002
+
+    Node 0xf022cbcc
+        name:  'packages'
+
+        Node 0xf0239990
+            builtin-drivers:  636c6173.73303130.38303200.6e766d65.00706369.31303030.2c373000.70636931.3030302c.37300070.63696578.31303030.2c373200.70636931.3030302c.37300070.63696578.31303030.2c37322e.31303030.2e373200.70636931.3030302c.37300070.63696578.31303030.2c38372e.31303030.2e383700.70636931.3030302c.37300070.63696578.31303030.2c37322e.31303865.2e363237.33007063.69313030.302c3730.00706369.65783130.30302c39.372e3130.30302e39.30007063.69313030.302c3730.00706369.65780073.756e3476.2d767063.6900636c.61737330.36303430.3000636c.61737330.36303430.30004f52.434c2c6d.34696f73.2d707200.73756e34.762d7065.72662d63.6e740070.63696578.38303836.2c313532.382e3130.38652e34.38343800.6f706869.72007063.69657838.3038362c.31353135.2e313038.652e3438.3438006f.70686972.00706369.65783830.38362c31.3532312e.31303865.2e376231.61006f70.68697200.70636965.78313931.322c3134.00786863.69007063.69657831.3034632c.38323431.00786863.69006465.76696365.00757362.64657669.63650075.73622c63.6c617373.39006875.62007573.6269662c.636c6173.73390068.75620075.73626966.2c636c61.7373332e.312e3100.7573626b.62640075.73626966.2c636c61.73733800.75736273.746f7261.67650070.63693161.30332c32.3030302e.31613033.2e323030.30006173.742d6772.61706869.63730070.63693130.32622c35.32322e31.3961322e.31303200.6d617472.6f782d67.72617068.69637300.70636965.78313032.622c3532.322e3139.61322e31.3032006d.6174726f.782d6772.61706869.63730070.63696578.31303262.2c353232.006d6174.726f782d.67726170.68696373.00
+            name:  'SUNW,builtin-drivers'
+
+        Node 0xf026185c
+            lba64:  
+            disk-write-fix:  
+            name:  'deblocker'
+
+        Node 0xf0261f58
+            gpt:  
+            supported-labels:  67707400.73756e00.6d627200
+            name:  'disk-label'
+
+        Node 0xf026513c
+            iso6429-1983-colors:  
+            name:  'terminal-emulator'
+
+        Node 0xf02765b8
+            source:  '/flashprom:'
+            name:  'dropins'
+
+        Node 0xf02773c8
+            name:  'SUNW,asr'
+
+        Node 0xf027b868
+            name:  'kbd-translator'
+
+        Node 0xf027cf9c
+            name:  'obp-tftp'
+
+        Node 0xf028d970
+            name:  'vdisk-helper-pkg'
+
+        Node 0xf0293180
+            name:  'vnet-helper-pkg'
+
+        Node 0xf0359fa4
+            name:  'zfs-file-system'
+
+        Node 0xf035d8b4
+            name:  'hsfs-file-system'
+
+    Node 0xf022cc44
+        fs-package:  'hsfs-file-system'
+        whoami:  '/platform/sun4v/kernel/sparcv9/unix'
+        impl-arch-name:  'sun4v'
+        elfheader-length:  0031c000
+        elfheader-address:  50000000
+        archfs:  fed9a278
+        archive-fstype:  'hsfs'
+        bootarchive:  '/ramdisk-root'
+        zfs-bootfs:  'rpool/170'
+        bootfs:  fed9caf8
+        fstype:  'zfs'
+        boot-pool-list:  '/@304/@2/@0/@1/@0,0'
+        tboot-list:  '/@304/@1/@0/@2/@0/@2/@0,0'
+        bootargs:  00
+        bootpath:  '/pci@301/pci@1/LSI,sas@0/disk@w5000c50020c1ca75,0:a'
+        openboot-reserved:  40000000
+        mmu:  fff04b38
+        memory:  fff04d48
+        stdout:  fedafb80
+        stdin:  fee77c20
+        stdout-#lines:  ffffffff
+        name:  'chosen'
+        root-uuid-chk:  '1'
+        root-be-uuid:  '2c044d2b-c4ea-498e-9716-c97acbe5bbe9'
+
+    Node 0xf022ccb8
+        version: 'OBP 4.37.1.build_01 2015/02/12 11:59'
+        model:  'SUNW,4.37.1.build_01'
+        aligned-allocator:  
+        relative-addressing:  
+        name:  'openprom'
+
+        Node 0xf022cd48
+            name:  'client-services'
+
+    Node 0xf022ce00
+        ttya-rts-dtr-off:  'false'
+        ttya-ignore-cd:  'true'
+        keyboard-layout:  
+        reboot-command:  
+        security-mode:  'none'
+        security-password:  
+        security-#badlogins:  '0'
+        verbosity:  'min'
+        diag-switch?:  'false'
+        local-mac-address?:  'true'
+        fcode-debug?:  'false'
+        scsi-initiator-id:  '7'
+        oem-logo:  
+        oem-logo?:  'false'
+        oem-banner:  
+        oem-banner?:  'false'
+        ansi-terminal?:  'true'
+        screen-#columns:  '80'
+        screen-#rows:  '34'
+        ttya-mode:  '9600,8,n,1,-'
+        output-device:  'virtual-console'
+        input-device:  'virtual-console'
+        auto-boot-on-error?:  'true'
+        load-base:  '16384'
+        auto-boot?:  'true'
+        os-root-device:  
+        network-boot-arguments:  
+        boot-command:  'boot'
+        boot-file:  
+        boot-device:  '/pci@301/pci@1/LSI,sas@0/disk@w5000c50020c1ca75,0:a'
+        multipath-boot?:  'false'
+        boot-device-index:  '0'
+        use-nvramrc?:  'true'
+        nvramrc:  64657661.6c696173.20733131.7533202f.70636940.3330312f.70636940.312f4c53.492c7361.7340302f.6469736b.40773530.30306335.30303230.63316361.37352c30.3a610a64.6576616c.69617320.6e657430.202f7063.69403330.332f7063.6940312f.6e657477.6f726b40.300a6465.76616c69.6173206e.6574202f.70636940.3330332f.70636940.312f6e65.74776f72.6b40300a.64657661.6c696173.20646973.6b202f70.63694033.30312f70.63694031.2f4c5349.2c736173.40302f64.69736b40.77353030.30633530.30323063.31636137.353a610a.0a646576.616c6961.73206469.736b202f.70636940.3330312f.70636940.312f4c53.492c7361.7340302f.6469736b.40773530.30306335.30303230.63316361.37353a61.200a0a64.6576616c.69617320.6469736b.202f7063.69403330.362f7063.6940312f.4c53492c.73617340.302f6469.736b4077.35303030.63353030.32306331.63613735.0a
+        error-reset-recovery:  'boot'
+        name:  'options'
+
+    Node 0xf022ce78
+        screen:  '/pci@304/pci@1/pci@0/pci@4/display@0'
+        rcdrom:  '/pci@304/pci@1/pci@0/pci@2/usb@0/storage@2/disk@0'
+        disk:  '/pci@306/pci@1/LSI,sas@0/disk@w5000c50020c1ca75'
+        net:  '/pci@303/pci@1/network@0'
+        net0:  '/pci@303/pci@1/network@0'
+        s11u3:  '/pci@301/pci@1/LSI,sas@0/disk@w5000c50020c1ca75,0:a'
+        primary-vds0:  '/virtual-devices@100/channel-devices@200/virtual-disk-server@0'
+        primary-vsw0:  '/virtual-devices@100/channel-devices@200/virtual-network-switch@0'
+        primary-vcc0:  '/virtual-devices@100/channel-devices@200/virtual-console-concentrator@0'
+        virtual-console:  '/virtual-devices/console@1'
+        name:  'aliases'
+
+    Node 0xf0240674
+        reg:  00000000.50000000.00000017.80000000
+        available:  00000017.c9e18000.00000000.002a4000.00000017.c0000000.00000000.09cd0000.00000000.90000000.00000017.10000000.00000000.8fd80000.00000000.00034000.00000000.50400000.00000000.3f900000
+        name:  'memory'
+
+    Node 0xf0240c80
+        translations:  00000000.00002000.00000000.009fe000.80000000.50402740.00000000.00a00000.00000000.00580000.80000017.cf938740.00000000.01402000.00000000.00068000.80000017.c9dae740.00000000.10000000.00000000.10000000.80000017.b0000740.00000000.20000000.00000000.10000000.80000017.a0000740.00000000.51000000.00000000.057e6000.80000017.ca152740.00000000.f0000000.00000000.00400000.80000000.50000750.00000000.fec0e000.00000000.00078000.80000017.ca0bc750.00000000.fec86000.00000000.0005c000.80000017.c9cd0750.00000000.fece2000.00000000.00008000.80000017.ca134750.00000000.fecea000.00000000.00024000.80000017.cfeb8750.00000000.fed0e000.00000000.00040000.80020011.00040950.00000000.fed4e000.00000000.00004000.80020011.00000950.00000000.fed52000.00000000.0003a000.80000017.cfee0750.00000000.fed8c000.00000000.0001a000.80000017.cff1e750.00000000.feda6000.00000000.00008000.80000017.cff3a750.00000000.fedae000.00000000.00036000.80000017.cff4a750.00000000.fede4000.00000000.0000a000.80000017.cffea750.00000000.fedee000.00000000.00004000.80000017.cff1a750.00000000.fedf2000.00000000.00002000.80000017.cff38750.00000000.fedf4000.00000000.00008000.80000017.cff42750.00000000.fedfc000.00000000.00012000.80000017.cff80750.00000000.fee0e000.00000000.00002000.80020041.00000950.00000000.fee10000.00000000.00050000.80000017.cff92750.00000000.fee60000.00000000.00002000.80020044.80000950.00000000.fee62000.00000000.00004000.80020040.01000950.00000000.fee66000.00000000.00008000.80000017.cffe2750.00000000.fee6e000.00000000.0000c000.80000017.cfff4750.00000000.fee7a000.00000000.00004000.80000000.8fdb4750.00000000.fee7e000.00000000.00080000.80000000.8fd00750.00000000.feefe000.00000000.0000e000.80000000.8fdb8750.00000000.fef10000.00000000.00002000.80000000.8fdc6750.00000000.fef12000.00000000.0000a000.80000000.8ffc8750.00000000.fef1c000.00000000.000c0000.80000000.8fe40750.00000000.fefdc000.00000000.0000c000.80000000.8ffd2750.00000000.fefe8000.00000000.00018000.80000000.8ffe0750.00000000.fff00000.00000000.00010000.80000000.501f0750
+        existing:  00000000.00000000.00000800.00000000.fffff800.00000000.00000800.00000000
+        available:  fffff800.00000000.000007fc.00000000.00000001.00000000.000007ff.00000000.00000000.ffff0000.00000000.0000e000.00000000.567e6000.00000000.9981a000.00000000.30000000.00000000.21000000.00000000.0146a000.00000000.0eb96000.00000000.00f80000.00000000.00482000.00000000.00000000.00000000.00a00000.00000000.f2200000.00000000.0ca0e000
+        page-size:  00002000
+        name:  'virtual-memory'
+
+    Node 0xf026d570
+        compatible: 'SUNW,iscsi-hba'
+        name:  'iscsi-hba'
+
+        Node 0xf0274cc8
+            lba64:  
+            device_type:  'block'
+            compatible: 'sd'
+            name:  'disk'
+
+    Node 0xf0275fe4
+        reg:  c0000000.00000000.00000000.00000000
+        device_type:  'block'
+        name:  'reboot-memory'
+
+    Node 0xf0298e80
+        interrupt-map:  00000001.00000001.f0298e80.00000011
+        interrupt-map-mask:  0000001f.00ffffff.00000003
+        #interrupt-cells:  00000001
+        reg:  c0000100.00000000.00000000.00000000
+        #address-cells:  00000001
+        #size-cells:  00000000
+        device_type:  'virtual-devices'
+        compatible: 'SUNW,sun4v-virtual-devices' + 'SUNW,virtual-devices'
+        name:  'virtual-devices'
+
+        Node 0xf0299f40
+            name:  'flashprom'
+            reg:  00000000
+
+        Node 0xf029a514
+            rng-#units:  00000001
+            compatible: 'ORCL,m7-rng'
+            reg:  0000000e
+            name:  'random-number-generator'
+
+        Node 0xf029ab98
+            #interrupts:  0000003f
+            compatible: 'ORCL,sun4v-dax'
+            reg:  0000000a
+            name:  'dax'
+
+        Node 0xf029b008
+            reg:  00000001
+            device_type:  'serial'
+            compatible: 'SUNW,sun4v-console'
+            name:  'console'
+            interrupts:  00000001
+
+        Node 0xf029b7d8
+            #address-cells:  00000001
+            #size-cells:  00000000
+            reg:  00000200
+            compatible: 'SUNW,sun4v-channel-devices'
+            device_type:  'channel-devices'
+            name:  'channel-devices'
+
+            Node 0xf029c6b8
+                compatible: 'SUNW,sun4v-channel'
+                reg:  00000000
+                name:  'virtual-channel'
+
+            Node 0xf029c78c
+                compatible: 'SUNW,sun4v-console-concentrator'
+                reg:  00000000
+                name:  'virtual-console-concentrator'
+
+            Node 0xf029c8e0
+                compatible: 'SUNW,sun4v-network-switch'
+                reg:  00000000
+                name:  'virtual-network-switch'
+
+            Node 0xf029ca20
+                compatible: 'SUNW,sun4v-disk-server'
+                reg:  00000000
+                name:  'virtual-disk-server'
+
+            Node 0xf029cb58
+                compatible: 'SUNW,sun4v-channel'
+                reg:  00000001
+                name:  'virtual-channel-client'
+
+            Node 0xf029cc30
+                compatible: 'SUNW,sun4v-channel'
+                reg:  00000002
+                name:  'virtual-channel-client'
+
+            Node 0xf029cd08
+                compatible: 'SUNW,sun4v-pciv-comm'
+                reg:  00000000
+                name:  'pciv-communication'
+
+            Node 0xf029cddc
+                compatible: 'SUNW,sun4v-domain-service'
+                reg:  00000000
+                name:  'virtual-domain-service'
+
+            Node 0xf029cebc
+                compatible: 'SUNW,sun4v-channel'
+                reg:  00000003
+                name:  'virtual-channel'
+
+    Node 0xf029d0c0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000000.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029d220
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000001.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029d380
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000002.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029d4e0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000003.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029d640
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000004.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029d7a0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000005.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029d900
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000006.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029da60
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000007.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029dbc0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000008.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029dd20
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000009.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029de80
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000000a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029dfe0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000000b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029e140
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000000c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029e2a0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000000d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029e400
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000000e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029e560
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000000f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029e6c0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000010.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029e820
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000011.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029e980
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000012.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029eae0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000013.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029ec40
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000014.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029eda0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000015.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029ef00
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000016.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f060
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000017.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f1c0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000018.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f320
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000019.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f480
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000001a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f5e0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000001b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f740
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000001c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f8a0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000001d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029fa00
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000001e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029fb60
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000001f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029fcc0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000020.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029fe20
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000021.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029ff80
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000022.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a00e0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000023.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0240
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000024.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a03a0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000025.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0500
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000026.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0660
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000027.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a07c0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000028.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0920
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000029.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0a80
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000002a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0be0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000002b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0d40
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000002c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0ea0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000002d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1000
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000002e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1160
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000002f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a12c0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000030.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1420
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000031.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1580
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000032.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a16e0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000033.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1840
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000034.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a19a0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000035.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1b00
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000036.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1c60
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000037.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1dc0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000038.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1f20
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000039.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2080
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000003a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a21e0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000003b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2340
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000003c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a24a0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000003d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2600
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000003e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2760
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000003f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a28c0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000040.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2a20
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000041.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2b80
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000042.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2ce0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000043.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2e40
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000044.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2fa0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000045.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3100
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000046.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3260
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000047.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a33c0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000048.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3520
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000049.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3680
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000004a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a37e0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000004b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3940
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000004c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3aa0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000004d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3c00
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000004e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3d60
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000004f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3ec0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000050.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4020
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000051.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4180
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000052.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a42e0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000053.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4440
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000054.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a45a0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000055.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4700
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000056.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4860
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000057.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a49c0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000058.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4b20
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000059.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4c80
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000005a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4de0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000005b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4f40
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000005c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a50a0
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000005d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5200
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000005e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5360
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000005f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a54c4
+        interrupt-map:  00000800.00000000.00000000.00000001.f02a54c4.00000002.00000800.00000000.00000000.00000002.f02a54c4.00000003.00000800.00000000.00000000.00000003.f02a54c4.00000004.00000800.00000000.00000000.00000004.f02a54c4.00000001
+        interrupt-map-mask:  00fff800.00000000.00000000.00000007
+        #interrupt-cells:  00000001
+        interrupts:  0000003f.0000003e
+        available:  81000000.00000000.08000000.00000000.08000000.82000000.00000000.70000000.00000000.0f000000.c3000000.00000007.f0000000.00000000.10000000
+        level1-hotplug-slot-count:  00000001
+        level2-hotplug-slot-count:  00000006
+        ranges:  01000000.00000000.00000000.8002007e.00000000.00000000.10000000.02000000.00000000.00000000.80020000.00000000.00000000.7f000000.03000000.00000001.00000000.80020001.00000000.00000007.00000000
+        reg:  c0000300.00000000.00000000.00000000
+        iommu-pagesizes:  000000ff
+        iommu-address-ranges:  00000000.80000000.00000000.40000000.00000000.c0000000.00000000.40000000.a0000000.00000000.01000000.00000000.c0000000.00000000.01000000.00000000
+        msi-eq-to-devino:  00000000.00000038.00000006
+        #msi-eqs:  00000038
+        msix-data-width:  00000020
+        msi-eq-size:  00000080
+        msi-ranges:  00000000.00000400
+        msi-data-mask:  000003ff
+        #msi:  00000400
+        msi-address-ranges:  00000000.7f000000.00800000.e0000000.3f000000.00800000
+        pcie-ber-factor:  00000064
+        hotplug-mem64size:  00000006.f0000000
+        hotplug-memsize:  70000000
+        available-bus-range:  00000000.000000ff
+        bus-range:  00000000.000000e0
+        bus-parity-generated:  
+        #address-cells:  00000003
+        #size-cells:  00000002
+        name:  'pci'
+        compatible: 'SUNW,sun4v-pci'
+        device_type:  'pciex'
+        virtual-dma:  80000000.80000000
+
+        Node 0xf02e2558
+            slot-names:  00000001.2f535953.2f434d49.4f55302f.50434945.3200
+            available:  81000000.00000000.00000000.00000000.08000000.82000000.00000000.00000000.00000000.70000000.c3000000.00000001.00000000.00000006.f0000000
+            ranges:  81000000.00000000.00000000.81000000.00000000.00000000.00000000.08000000.82000000.00000000.00000000.82000000.00000000.00000000.00000000.70000000.c3000000.00000001.00000000.c3000000.00000001.00000000.00000006.f0000000
+            bus-range:  00000001.000000e0
+            slot-implemented?:  
+            hotplug-capable:  
+            compatible: 'pciex108e,818e.1' + 'pciex108e,818e' + 'pciexclass,060400' + 'pciexclass,0604'
+            reg:  00000800.00000000.00000000.00000000.00000000
+            physical-slot#:  00000002
+            #address-cells:  00000003
+            #size-cells:  00000002
+            device_type:  'pciex'
+            name:  'pci'
+            port-type:  'Root-Port'
+            cache-line-size:  00000000
+            class-code:  00060400
+            revision-id:  00000001
+            device-id:  0000818e
+            vendor-id:  0000108e
+
+    Node 0xf02b4870
+        interrupt-map:  00000800.00000000.00000000.00000001.f02b4870.00000002.00000800.00000000.00000000.00000002.f02b4870.00000003.00000800.00000000.00000000.00000003.f02b4870.00000004.00000800.00000000.00000000.00000004.f02b4870.00000001
+        interrupt-map-mask:  00fff800.00000000.00000000.00000007
+        #interrupt-cells:  00000001
+        interrupts:  0000003f.0000003e
+        available:  81000000.00000000.08000000.00000000.08000000.82000000.00000000.70000000.00000000.0f000000.c3000000.00000007.f0000000.00000000.10000000
+        level1-hotplug-slot-count:  00000001
+        level2-hotplug-slot-count:  00000006
+        ranges:  01000000.00000000.00000000.8002007e.10000000.00000000.10000000.02000000.00000000.00000000.80020010.00000000.00000000.7f000000.03000000.00000001.00000000.80020011.00000000.00000007.00000000
+        reg:  c0000301.00000000.00000000.00000000
+        iommu-pagesizes:  000000ff
+        iommu-address-ranges:  00000000.80000000.00000000.40000000.00000000.c0000000.00000000.40000000.a0000000.00000000.01000000.00000000.c0000000.00000000.01000000.00000000
+        msi-eq-to-devino:  00000000.00000038.00000006
+        #msi-eqs:  00000038
+        msix-data-width:  00000020
+        msi-eq-size:  00000080
+        msi-ranges:  00000000.00000400
+        msi-data-mask:  000003ff
+        #msi:  00000400
+        msi-address-ranges:  00000000.7f000000.00800000.e0000000.3f000000.00800000
+        pcie-ber-factor:  00000064
+        hotplug-mem64size:  00000006.f0000000
+        hotplug-memsize:  70000000
+        available-bus-range:  00000000.000000ff
+        bus-range:  00000000.000000e0
+        bus-parity-generated:  
+        #address-cells:  00000003
+        #size-cells:  00000002
+        name:  'pci'
+        compatible: 'SUNW,sun4v-pci'
+        device_type:  'pciex'
+        virtual-dma:  80000000.80000000
+
+        Node 0xf02e5450
+            slot-names:  00000001.2f535953.2f434d49.4f55302f.50434945.3300
+            available:  81000000.00000000.00000100.00000000.07ffff00.82000000.00000000.00080000.00000000.6ff80000.c3000000.00000001.00004000.00000000.0003c000.c3000000.00000001.004c0000.00000006.efb40000
+            ranges:  81000000.00000000.00000000.81000000.00000000.00000000.00000000.08000000.82000000.00000000.00000000.82000000.00000000.00000000.00000000.70000000.c3000000.00000001.00000000.c3000000.00000001.00000000.00000006.f0000000
+            bus-range:  00000001.000000e0
+            slot-implemented?:  
+            hotplug-capable:  
+            compatible: 'pciex108e,818e.1' + 'pciex108e,818e' + 'pciexclass,060400' + 'pciexclass,0604'
+            reg:  00000800.00000000.00000000.00000000.00000000
+            physical-slot#:  00000003
+            #address-cells:  00000003
+            #size-cells:  00000002
+            device_type:  'pciex'
+            name:  'pci'
+            port-type:  'Root-Port'
+            cache-line-size:  00000000
+            class-code:  00060400
+            revision-id:  00000001
+            device-id:  0000818e
+            vendor-id:  0000108e
+
+            Node 0xf02e8144
+                firmware-version:  '11.05.02.00'
+                mpt-version:  '2.00'
+                local-wwid:  500605b0.07f8d440
+                vf-assigned-addresses:  83010000.00000001.00080000.00000000.00004000.83010002.00000001.000c0000.00000000.00040000
+                assigned-addresses:  81010010.00000000.00000000.00000000.00000100.83010014.00000001.00000000.00000000.00004000.8301001c.00000001.00040000.00000000.00040000.82010030.00000000.00000000.00000000.00080000
+                vf-reg:  03010000.00000000.00000000.00000000.00004000.03010002.00000000.00000000.00000000.00040000
+                compatible: 'pciex1000,72' + 'pci1000,72'
+                model:  'LSI,2008'
+                reg:  00010000.00000000.00000000.00000000.00000000.01010010.00000000.00000000.00000000.00000100.03010014.00000000.00000000.00000000.00004000.0301001c.00000000.00000000.00000000.00040000.02010030.00000000.00000000.00000000.00080000
+                version: '1.00.60'
+                wide:  00000010
+                device_type:  'scsi-sas'
+                name:  'LSI,sas'
+                #address-cells:  00000004
+                fcode-rom-offset:  00042400
+                vf-stride:  00000001
+                first-vf-offset:  00000001
+                total-vfs:  00000010
+                initial-vfs:  00000010
+                #vfs:  00000010
+                port-type:  'PCIE-Endpoint'
+                interrupts:  00000001
+                cache-line-size:  00000010
+                class-code:  00010700
+                subsystem-id:  000030b0
+                subsystem-vendor-id:  00001000
+                revision-id:  00000003
+                device-id:  00000072
+                vendor-id:  00001000
+
+                Node 0xf02f6e18
+                    compatible: 'st'
+                    device_type:  'byte'
+                    name:  'tape'
+
+                Node 0xf02f7b7c
+                    lba64:  
+                    compatible: 'sd'
+                    device_type:  'block'
+                    name:  'disk'
+
+    Node 0xf02c3c1c
+        interrupt-map:  00000800.00000000.00000000.00000001.f02c3c1c.00000002.00000800.00000000.00000000.00000002.f02c3c1c.00000003.00000800.00000000.00000000.00000003.f02c3c1c.00000004.00000800.00000000.00000000.00000004.f02c3c1c.00000001
+        interrupt-map-mask:  00fff800.00000000.00000000.00000007
+        #interrupt-cells:  00000001
+        interrupts:  0000003f.0000003e
+        available:  81000000.00000000.08000000.00000000.08000000.82000000.00000000.70000000.00000000.0f000000.c3000000.00000007.f0000000.00000000.10000000
+        level1-hotplug-slot-count:  00000001
+        level2-hotplug-slot-count:  00000006
+        ranges:  01000000.00000000.00000000.8002007e.30000000.00000000.10000000.02000000.00000000.00000000.80020030.00000000.00000000.7f000000.03000000.00000001.00000000.80020031.00000000.00000007.00000000
+        reg:  c0000303.00000000.00000000.00000000
+        iommu-pagesizes:  000000ff
+        iommu-address-ranges:  00000000.80000000.00000000.40000000.00000000.c0000000.00000000.40000000.a0000000.00000000.01000000.00000000.c0000000.00000000.01000000.00000000
+        msi-eq-to-devino:  00000000.00000038.00000006
+        #msi-eqs:  00000038
+        msix-data-width:  00000020
+        msi-eq-size:  00000080
+        msi-ranges:  00000000.00000400
+        msi-data-mask:  000003ff
+        #msi:  00000400
+        msi-address-ranges:  00000000.7f000000.00800000.e0000000.3f000000.00800000
+        pcie-ber-factor:  00000064
+        hotplug-mem64size:  00000006.f0000000
+        hotplug-memsize:  70000000
+        available-bus-range:  00000000.000000ff
+        bus-range:  00000000.000000e0
+        bus-parity-generated:  
+        #address-cells:  00000003
+        #size-cells:  00000002
+        name:  'pci'
+        compatible: 'SUNW,sun4v-pci'
+        device_type:  'pciex'
+        virtual-dma:  80000000.80000000
+
+        Node 0xf02f8d50
+            slot-names:  00000001.2f535953.2f434d49.4f55302f.50434945.3100
+            available:  81000000.00000000.00000000.00000000.08000000.82000000.00000000.00110000.00000000.00070000.82000000.00000000.00680000.00000000.6f980000.c3000000.00000001.00100000.00000006.eff00000
+            ranges:  81000000.00000000.00000000.81000000.00000000.00000000.00000000.08000000.82000000.00000000.00000000.82000000.00000000.00000000.00000000.70000000.c3000000.00000001.00000000.c3000000.00000001.00000000.00000006.f0000000
+            bus-range:  00000001.000000e0
+            slot-implemented?:  
+            hotplug-capable:  
+            compatible: 'pciex108e,818e.1' + 'pciex108e,818e' + 'pciexclass,060400' + 'pciexclass,0604'
+            reg:  00000800.00000000.00000000.00000000.00000000
+            physical-slot#:  00000001
+            #address-cells:  00000003
+            #size-cells:  00000002
+            device_type:  'pciex'
+            name:  'pci'
+            port-type:  'Root-Port'
+            cache-line-size:  00000000
+            class-code:  00060400
+            revision-id:  00000001
+            device-id:  0000818e
+            vendor-id:  0000108e
+
+            Node 0xf02fba44
+                vf-assigned-addresses:  c3010000.00000001.00000000.00000000.00004000.c3010003.00000001.00020000.00000000.00004000
+                assigned-addresses:  82010010.00000000.00000000.00000000.00100000.8201001c.00000000.00100000.00000000.00004000.82010030.00000000.00180000.00000000.00080000
+                vf-reg:  43010000.00000000.00000000.00000000.00004000.43010003.00000000.00000000.00000000.00004000
+                local-mac-address:  a0369f44.97a4
+                version: 'Sun Quad Port GbE PCIe 2.0 Low Profile Adapter, UTP FCode 3.15 01/23/2013'
+                phy-type:  'mif'
+                reg:  00010000.00000000.00000000.00000000.00000000.02010010.00000000.00000000.00000000.00100000.0201001c.00000000.00000000.00000000.00004000.02010030.00000000.00000000.00000000.00080000
+                board-model:  '7070195'
+                model:  'SUNW,pcie-igb'
+                compatible: 'pciex8086,1521.108e.7b18.1' + 'pciex8086,1521.108e.7b18' + 'pciex8086,1521.1' + 'pciex8086,1521' + 'pciexclass,020000' + 'pciexclass,0200'
+                address-bits:  00000030
+                max-frame-size:  00002400
+                network-interface-type:  'ethernet'
+                device_type:  'network'
+                name:  'network'
+                fcode-rom-offset:  00004800
+                vf-stride:  00000004
+                first-vf-offset:  00000180
+                total-vfs:  00000008
+                initial-vfs:  00000008
+                #vfs:  00000008
+                port-type:  'PCIE-Endpoint'
+                interrupts:  00000001
+                cache-line-size:  00000010
+                class-code:  00020000
+                subsystem-id:  00007b18
+                subsystem-vendor-id:  0000108e
+                revision-id:  00000001
+                device-id:  00001521
+                vendor-id:  00008086
+
+            Node 0xf0305228
+                vf-assigned-addresses:  c3010100.00000001.00040000.00000000.00004000.c3010103.00000001.00060000.00000000.00004000
+                assigned-addresses:  82010110.00000000.00200000.00000000.00100000.8201011c.00000000.00104000.00000000.00004000.82010130.00000000.00300000.00000000.00080000
+                vf-reg:  43010100.00000000.00000000.00000000.00004000.43010103.00000000.00000000.00000000.00004000
+                local-mac-address:  a0369f44.97a5
+                version: 'Sun Quad Port GbE PCIe 2.0 Low Profile Adapter, UTP FCode 3.15 01/23/2013'
+                phy-type:  'mif'
+                reg:  00010100.00000000.00000000.00000000.00000000.02010110.00000000.00000000.00000000.00100000.0201011c.00000000.00000000.00000000.00004000.02010130.00000000.00000000.00000000.00080000
+                board-model:  '7070195'
+                model:  'SUNW,pcie-igb'
+                compatible: 'pciex8086,1521.108e.7b18.1' + 'pciex8086,1521.108e.7b18' + 'pciex8086,1521.1' + 'pciex8086,1521' + 'pciexclass,020000' + 'pciexclass,0200'
+                address-bits:  00000030
+                max-frame-size:  00002400
+                network-interface-type:  'ethernet'
+                device_type:  'network'
+                name:  'network'
+                fcode-rom-offset:  00004800
+                vf-stride:  00000004
+                first-vf-offset:  00000180
+                total-vfs:  00000008
+                initial-vfs:  00000008
+                #vfs:  00000008
+                port-type:  'PCIE-Endpoint'
+                interrupts:  00000002
+                cache-line-size:  00000010
+                class-code:  00020000
+                subsystem-id:  00007b18
+                subsystem-vendor-id:  0000108e
+                revision-id:  00000001
+                device-id:  00001521
+                vendor-id:  00008086
+
+            Node 0xf030ea0c
+                vf-assigned-addresses:  c3010200.00000001.00080000.00000000.00004000.c3010203.00000001.000a0000.00000000.00004000
+                assigned-addresses:  82010210.00000000.00400000.00000000.00100000.8201021c.00000000.00108000.00000000.00004000.82010230.00000000.00380000.00000000.00080000
+                vf-reg:  43010200.00000000.00000000.00000000.00004000.43010203.00000000.00000000.00000000.00004000
+                local-mac-address:  a0369f44.97a6
+                version: 'Sun Quad Port GbE PCIe 2.0 Low Profile Adapter, UTP FCode 3.15 01/23/2013'
+                phy-type:  'mif'
+                reg:  00010200.00000000.00000000.00000000.00000000.02010210.00000000.00000000.00000000.00100000.0201021c.00000000.00000000.00000000.00004000.02010230.00000000.00000000.00000000.00080000
+                board-model:  '7070195'
+                model:  'SUNW,pcie-igb'
+                compatible: 'pciex8086,1521.108e.7b18.1' + 'pciex8086,1521.108e.7b18' + 'pciex8086,1521.1' + 'pciex8086,1521' + 'pciexclass,020000' + 'pciexclass,0200'
+                address-bits:  00000030
+                max-frame-size:  00002400
+                network-interface-type:  'ethernet'
+                device_type:  'network'
+                name:  'network'
+                fcode-rom-offset:  00004800
+                vf-stride:  00000004
+                first-vf-offset:  00000180
+                total-vfs:  00000008
+                initial-vfs:  00000008
+                #vfs:  00000008
+                port-type:  'PCIE-Endpoint'
+                interrupts:  00000003
+                cache-line-size:  00000010
+                class-code:  00020000
+                subsystem-id:  00007b18
+                subsystem-vendor-id:  0000108e
+                revision-id:  00000001
+                device-id:  00001521
+                vendor-id:  00008086
+
+            Node 0xf03181f0
+                vf-assigned-addresses:  c3010300.00000001.000c0000.00000000.00004000.c3010303.00000001.000e0000.00000000.00004000
+                assigned-addresses:  82010310.00000000.00500000.00000000.00100000.8201031c.00000000.0010c000.00000000.00004000.82010330.00000000.00600000.00000000.00080000
+                vf-reg:  43010300.00000000.00000000.00000000.00004000.43010303.00000000.00000000.00000000.00004000
+                local-mac-address:  a0369f44.97a7
+                version: 'Sun Quad Port GbE PCIe 2.0 Low Profile Adapter, UTP FCode 3.15 01/23/2013'
+                phy-type:  'mif'
+                reg:  00010300.00000000.00000000.00000000.00000000.02010310.00000000.00000000.00000000.00100000.0201031c.00000000.00000000.00000000.00004000.02010330.00000000.00000000.00000000.00080000
+                board-model:  '7070195'
+                model:  'SUNW,pcie-igb'
+                compatible: 'pciex8086,1521.108e.7b18.1' + 'pciex8086,1521.108e.7b18' + 'pciex8086,1521.1' + 'pciex8086,1521' + 'pciexclass,020000' + 'pciexclass,0200'
+                address-bits:  00000030
+                max-frame-size:  00002400
+                network-interface-type:  'ethernet'
+                device_type:  'network'
+                name:  'network'
+                fcode-rom-offset:  00004800
+                vf-stride:  00000004
+                first-vf-offset:  00000180
+                total-vfs:  00000008
+                initial-vfs:  00000008
+                #vfs:  00000008
+                port-type:  'PCIE-Endpoint'
+                interrupts:  00000004
+                cache-line-size:  00000010
+                class-code:  00020000
+                subsystem-id:  00007b18
+                subsystem-vendor-id:  0000108e
+                revision-id:  00000001
+                device-id:  00001521
+                vendor-id:  00008086
+
+    Node 0xf02d2fc8
+        interrupt-map:  00000800.00000000.00000000.00000001.f02d2fc8.00000002.00000800.00000000.00000000.00000002.f02d2fc8.00000003.00000800.00000000.00000000.00000003.f02d2fc8.00000004.00000800.00000000.00000000.00000004.f02d2fc8.00000001.00001000.00000000.00000000.00000001.f02d2fc8.00000003.00001000.00000000.00000000.00000002.f02d2fc8.00000004.00001000.00000000.00000000.00000003.f02d2fc8.00000001.00001000.00000000.00000000.00000004.f02d2fc8.00000002
+        interrupt-map-mask:  00fff800.00000000.00000000.00000007
+        #interrupt-cells:  00000001
+        interrupts:  0000003f.0000003e
+        available:  81000000.00000000.04000000.00000000.0c000000.82000000.00000000.38000000.00000000.47000000.c3000000.00000004.78000000.00000000.08000000.c3000000.00000004.90000000.00000003.70000000
+        level1-hotplug-slot-count:  00000002
+        level2-hotplug-slot-count:  00000006
+        ranges:  01000000.00000000.00000000.8002007e.40000000.00000000.10000000.02000000.00000000.00000000.80020040.00000000.00000000.7f000000.03000000.00000001.00000000.80020041.00000000.00000007.00000000
+        reg:  c0000304.00000000.00000000.00000000
+        iommu-pagesizes:  000000ff
+        iommu-address-ranges:  00000000.80000000.00000000.40000000.00000000.c0000000.00000000.40000000.a0000000.00000000.01000000.00000000.c0000000.00000000.01000000.00000000
+        msi-eq-to-devino:  00000000.00000038.00000006
+        #msi-eqs:  00000038
+        msix-data-width:  00000020
+        msi-eq-size:  00000080
+        msi-ranges:  00000000.00000400
+        msi-data-mask:  000003ff
+        #msi:  00000400
+        msi-address-ranges:  00000000.7f000000.00800000.e0000000.3f000000.00800000
+        pcie-ber-factor:  00000064
+        hotplug-mem64size:  00000006.f0000000
+        hotplug-memsize:  70000000
+        available-bus-range:  00000000.000000ff
+        bus-range:  00000000.00000071
+        bus-parity-generated:  
+        #address-cells:  00000003
+        #size-cells:  00000002
+        name:  'pci'
+        compatible: 'SUNW,sun4v-pci'
+        device_type:  'pciex'
+        virtual-dma:  80000000.80000000
+
+        Node 0xf0321bec
+            slot-names:  00000001.2f535953.2f535050.302f5350.4d3000
+            available:  81000000.00000000.00000000.00000000.04000000.82000000.00000000.02000000.00000000.36000000.c3000000.00000001.10000000.00000003.68000000
+            ranges:  81000000.00000000.00000000.81000000.00000000.00000000.00000000.04000000.82000000.00000000.00000000.82000000.00000000.00000000.00000000.38000000.c3000000.00000001.00000000.c3000000.00000001.00000000.00000003.78000000
+            bus-range:  00000001.00000070
+            slot-implemented?:  
+            hotplug-capable:  
+            compatible: 'pciex108e,818e.1' + 'pciex108e,818e' + 'pciexclass,060400' + 'pciexclass,0604'
+            reg:  00000800.00000000.00000000.00000000.00000000
+            physical-slot#:  00000000
+            #address-cells:  00000003
+            #size-cells:  00000002
+            device_type:  'pciex'
+            name:  'pci'
+            port-type:  'Root-Port'
+            cache-line-size:  00000000
+            class-code:  00060400
+            revision-id:  00000001
+            device-id:  0000818e
+            vendor-id:  0000108e
+
+            Node 0xf03248e0
+                ranges:  82000000.00000000.00000000.82000000.00000000.00000000.00000000.02000000.c3000000.00000001.00000000.c3000000.00000001.00000000.00000000.10000000
+                bus-range:  00000002.00000004
+                compatible: 'pciex111d,8091.2' + 'pciex111d,8091' + 'pciexclass,060400' + 'pciexclass,0604'
+                reg:  00010000.00000000.00000000.00000000.00000000
+                #address-cells:  00000003
+                #size-cells:  00000002
+                device_type:  'pciex'
+                name:  'pci'
+                port-type:  'Upstream-Port'
+                cache-line-size:  00000010
+                class-code:  00060400
+                revision-id:  00000002
+                device-id:  00008091
+                vendor-id:  0000111d
+
+                Node 0xf0327564
+                    available:  c3000000.00000001.00012000.00000000.0ffee000
+                    ranges:  c3000000.00000001.00000000.c3000000.00000001.00000000.00000000.10000000
+                    bus-range:  00000003.00000003
+                    compatible: 'pciex111d,8091.2' + 'pciex111d,8091' + 'pciexclass,060400' + 'pciexclass,0604'
+                    reg:  00021000.00000000.00000000.00000000.00000000
+                    #address-cells:  00000003
+                    #size-cells:  00000002
+                    device_type:  'pciex'
+                    name:  'pci'
+                    port-type:  'Downstream-Port'
+                    cache-line-size:  00000010
+                    class-code:  00060400
+                    revision-id:  00000002
+                    device-id:  00008091
+                    vendor-id:  0000111d
+
+                    Node 0xf032a1ec
+                        assigned-addresses:  83030010.00000001.00000000.00000000.00010000.83030018.00000001.00010000.00000000.00002000
+                        device_type:  'xchi'
+                        reg:  00030000.00000000.00000000.00000000.00000000.03030010.00000000.00000000.00000000.00002000
+                        compatible: 'pciex104c,8241.2' + 'pciex104c,8241' + 'pciexclass,0c0330' + 'pciexclass,0c03'
+                        #size-cells:  00000000
+                        #address-cells:  00000001
+                        name:  'usb'
+                        port-type:  'PCIE-Endpoint'
+                        interrupts:  00000001
+                        cache-line-size:  00000010
+                        class-code:  000c0330
+                        revision-id:  00000002
+                        device-id:  00008241
+                        vendor-id:  0000104c
+
+                        Node 0xf0351f8c
+                            device_type:  'usb_device'
+                            reg:  00000001
+                            #size-cells:  00000000
+                            #address-cells:  00000002
+                            compatible: 'usbdevice'
+                            name:  'device'
+
+                            Node 0xf0352ad8
+                                configuration#:  00000001
+                                intr-in-size:  00000008
+                                intr-in-interval:  00000001
+                                intr-in-pipe:  00000001
+                                serial$:  00
+                                device$:  56697274.75616c20.45746820.44657669.63650000
+                                vendor$:  53756e4d.6963726f.0000
+                                compatible: 'usb430,a4a2.100' + 'usb430,a4a2' + 'usb430,class2.0.0' + 'usb430,class2.0' + 'usb430,class2' + 'usb,class2.0.0' + 'usb,class2.0' + 'usb,class2' + 'usb,device'
+                                vendor-id:  00000430
+                                device-id:  0000a4a2
+                                release:  00000100
+                                name:  'network'
+                                class:  00000002
+                                subclass:  00000000
+                                protocol:  00000000
+                                full-speed:  00
+                                assigned-address:  00000001
+                                reg:  00000000.00000000
+
+                            Node 0xf0352e48
+                                configuration#:  00000001
+                                bulk-in-size:  00000040
+                                bulk-in-pipe:  00000003
+                                bulk-out-size:  00000040
+                                bulk-out-pipe:  00000002
+                                serial$:  00
+                                device$:  56697274.75616c20.45746820.44657669.63650000
+                                vendor$:  53756e4d.6963726f.0000
+                                compatible: 'usb430,a4a2.100' + 'usb430,a4a2' + 'usb430,class2.0.0' + 'usb430,class2.0' + 'usb430,class2' + 'usb,class2.0.0' + 'usb,class2.0' + 'usb,class2' + 'usb,device'
+                                vendor-id:  00000430
+                                device-id:  0000a4a2
+                                release:  00000100
+                                name:  'network'
+                                class:  00000002
+                                subclass:  00000000
+                                protocol:  00000000
+                                full-speed:  00
+                                assigned-address:  00000001
+                                reg:  00000001.00000000
+
+                        Node 0xf0353214
+                            device_type:  'scsi-usb'
+                            configuration#:  00000001
+                            bulk-out-size:  00000200
+                            bulk-out-pipe:  00000004
+                            bulk-in-size:  00000200
+                            bulk-in-pipe:  00000003
+                            serial$:  '01230123011'
+                            device$:  'P3rS  '
+                            vendor$:  'Oracle'
+                            compatible: 'usb430,a103.200' + 'usb430,a103' + 'usbif430,class8.6.50' + 'usbif430,class8.6' + 'usbif430,class8' + 'usbif,class8.6.50' + 'usbif,class8.6' + 'usbif,class8' + 'usb,device'
+                            vendor-id:  00000430
+                            device-id:  0000a103
+                            release:  00000200
+                            name:  'storage'
+                            class:  00000008
+                            subclass:  00000006
+                            protocol:  00000050
+                            high-speed:  00
+                            assigned-address:  00000002
+                            reg:  00000002
+                            #size-cells:  00000000
+                            #address-cells:  00000002
+
+                            Node 0xf0356350
+                                compatible: 'sd' + 'disk'
+                                device_type:  'block'
+                                name:  'disk'
+
+                Node 0xf0337500
+                    available:  82000000.00000000.01004000.00000000.0000c000.82000000.00000000.01020000.00000000.007e0000
+                    ranges:  82000000.00000000.00000000.82000000.00000000.00000000.00000000.02000000
+                    bus-range:  00000004.00000004
+                    compatible: 'pciex111d,8091.2' + 'pciex111d,8091' + 'pciexclass,060400' + 'pciexclass,0604'
+                    reg:  00022000.00000000.00000000.00000000.00000000
+                    #address-cells:  00000003
+                    #size-cells:  00000002
+                    device_type:  'pciex'
+                    name:  'pci'
+                    port-type:  'Downstream-Port'
+                    cache-line-size:  00000010
+                    class-code:  00060400
+                    revision-id:  00000002
+                    device-id:  00008091
+                    vendor-id:  0000111d
+
+                    Node 0xf033a188
+                        assigned-addresses:  82040010.00000000.00000000.00000000.01000000.82040014.00000000.01000000.00000000.00004000.82040018.00000000.01800000.00000000.00800000.82040030.00000000.01010000.00000000.00010000
+                        compatible: 'pciex102b,522.19a2.102.5' + 'pciex102b,522.19a2.102' + 'pciex102b,522.5' + 'pciex102b,522' + 'pciexclass,030000' + 'pciexclass,0300'
+                        reg:  00040000.00000000.00000000.00000000.00000000.02040010.00000000.00000000.00000000.01000000.02040014.00000000.00000000.00000000.00004000.02040018.00000000.00000000.00000000.00800000.02040030.00000000.00000000.00000000.00010000
+                        device_type:  'display'
+                        name:  'display'
+                        port-type:  'Legacy-PCIE-Endpoint'
+                        interrupts:  00000001
+                        cache-line-size:  00000010
+                        class-code:  00030000
+                        subsystem-id:  00000102
+                        subsystem-vendor-id:  000019a2
+                        revision-id:  00000005
+                        device-id:  00000522
+                        vendor-id:  0000102b
+
+        Node 0xf033e2d8
+            available:  c3000000.00000004.80012000.00000000.0ffee000
+            ranges:  c3000000.00000004.80000000.c3000000.00000004.80000000.00000000.10000000
+            bus-range:  00000071.00000071
+            compatible: 'pciex108e,818e.1' + 'pciex108e,818e' + 'pciexclass,060400' + 'pciexclass,0604'
+            reg:  00001000.00000000.00000000.00000000.00000000
+            #address-cells:  00000003
+            #size-cells:  00000002
+            device_type:  'pciex'
+            name:  'pci'
+            port-type:  'Root-Port'
+            cache-line-size:  00000000
+            class-code:  00060400
+            revision-id:  00000001
+            device-id:  0000818e
+            vendor-id:  0000108e
+
+            Node 0xf0340f58
+                assigned-addresses:  83710010.00000004.80000000.00000000.00010000.83710018.00000004.80010000.00000000.00002000
+                device_type:  'xchi'
+                reg:  00710000.00000000.00000000.00000000.00000000.03710010.00000000.00000000.00000000.00002000
+                compatible: 'pciex104c,8241.2' + 'pciex104c,8241' + 'pciexclass,0c0330' + 'pciexclass,0c03'
+                #size-cells:  00000000
+                #address-cells:  00000001
+                name:  'usb'
+                port-type:  'PCIE-Endpoint'
+                interrupts:  00000001
+                cache-line-size:  00000010
+                class-code:  000c0330
+                revision-id:  00000002
+                device-id:  00008241
+                vendor-id:  0000104c
+
+                Node 0xf034e2e4
+                    device_type:  'scsi-usb'
+                    configuration#:  00000001
+                    bulk-out-size:  00000200
+                    bulk-out-pipe:  00000002
+                    bulk-in-size:  00000200
+                    bulk-in-pipe:  00000001
+                    serial$:  '3E461706162343160514'
+                    device$:  '2048MB'
+                    vendor$:  'Viking Technology'
+                    compatible: 'usb90c,1000.5206' + 'usb90c,1000' + 'usbif90c,class8.6.50' + 'usbif90c,class8.6' + 'usbif90c,class8' + 'usbif,class8.6.50' + 'usbif,class8.6' + 'usbif,class8' + 'usb,device'
+                    vendor-id:  0000090c
+                    device-id:  00001000
+                    release:  00005206
+                    name:  'storage'
+                    class:  00000008
+                    subclass:  00000006
+                    protocol:  00000050
+                    high-speed:  00
+                    assigned-address:  00000001
+                    reg:  00000001
+                    #size-cells:  00000000
+                    #address-cells:  00000002
+
+                    Node 0xf0351438
+                        compatible: 'sd' + 'disk'
+                        device_type:  'block'
+                        name:  'disk'
+
+    Node 0xf035cf40
+        alloc-size:  00000000
+        address:  51000000
+        size:  057e6000
+        compatible: 'SUNW,ramdisk'
+        device_type:  'block'
+        name:  'ramdisk-root'
+
+
