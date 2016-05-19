From: Anatoly Pugachev <matorola@gmail.com>
Date: Thu, 19 May 2016 13:04:42 +0000
Subject: prtconfs: Add SPARC T7-2
Message-Id: <20160519130442.GA28886@yogzotot>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


    adding SPARC T7-2 Server, prtconf taken from Solaris 11 HCL
http://www.oracle.com/webfolder/technetwork/hcl/data/systems/prtconf/oracle_america_inc/sol_11_3/72782.txt

Signed-off-by: Anatoly Pugachev <matorola@gmail.com>
---
 T7-2 | 5353 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 5353 insertions(+)

diff --git a/T7-2 b/T7-2
new file mode 100644
index 0000000..9967b96
--- /dev/null
+++ b/T7-2
@@ -0,0 +1,5353 @@
+System Configuration:  Oracle Corporation  sun4v
+Memory size: 260096 Megabytes
+System Peripherals (PROM Nodes):
+
+Node 0xf02296b8
+    idprom:  01860010.e05d3df2.00000000.5d3df277.00000000.00000000.00000000.00000000
+    scsi-initiator-id:  00000007
+    #priqs-per-pcibus:  00000010
+    #priqs-per-cpu:  00000010
+    priq-eq-sizes:  00000003
+    non-ios-perf-counters:  'ORCL,mr-non-ios-pr'
+    ios-perf-counters:  'ORCL,mr-ios-pr'
+    product-name:  'SPARC T7-2'
+    banner-name:  'SPARC T7-2'
+    name:  'ORCL,SPARC-T7-2'
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
+        Node 0xf0239970
+            builtin-drivers:  636c6173.73303130.38303200.6e766d65.00706369.31303030.2c373000.70636931.3030302c.37300070.63696578.31303030.2c373200.70636931.3030302c.37300070.63696578.31303030.2c37322e.31303030.2e373200.70636931.3030302c.37300070.63696578.31303030.2c38372e.31303030.2e383700.70636931.3030302c.37300070.63696578.31303030.2c37322e.31303865.2e363237.33007063.69313030.302c3730.00706369.65783130.30302c39.372e3130.30302e39.30007063.69313030.302c3730.00706369.65780073.756e3476.2d767063.6900636c.61737330.36303430.3000636c.61737330.36303430.30004f52.434c2c6d.34696f73.2d707200.73756e34.762d7065.72662d63.6e740070.63696578.38303836.2c313532.382e3130.38652e34.38343800.6f706869.72007063.69657838.3038362c.31353135.2e313038.652e3438.3438006f.70686972.00706369.65783830.38362c31.3532312e.31303865.2e376231.61006f70.68697200.70636965.78313931.322c3134.00786863.69007063.69657831.3034632c.38323431.00786863.69006465.76696365.00757362.64657669.63650075.73622c63.6c617373.39006875.62007573.6269662c.636c6173.73390068.75620075.73626966.2c636c61.7373332e.312e3100.7573626b.62640075.73626966.2c636c61.73733800.75736273.746f7261.67650070.63693161.30332c32.3030302e.31613033.2e323030.30006173.742d6772.61706869.63730070.63693130.32622c35.32322e31.3961322e.31303200.6d617472.6f782d67.72617068.69637300.70636965.78313032.622c3532.322e3139.61322e31.3032006d.6174726f.782d6772.61706869.63730070.63696578.31303262.2c353232.006d6174.726f782d.67726170.68696373.00
+            name:  'SUNW,builtin-drivers'
+
+        Node 0xf02616b0
+            lba64:  
+            disk-write-fix:  
+            name:  'deblocker'
+
+        Node 0xf0261dac
+            gpt:  
+            supported-labels:  67707400.73756e00.6d627200
+            name:  'disk-label'
+
+        Node 0xf0264f90
+            iso6429-1983-colors:  
+            name:  'terminal-emulator'
+
+        Node 0xf027640c
+            source:  '/flashprom:'
+            name:  'dropins'
+
+        Node 0xf027721c
+            name:  'SUNW,asr'
+
+        Node 0xf027b9ec
+            name:  'kbd-translator'
+
+        Node 0xf027d120
+            name:  'obp-tftp'
+
+        Node 0xf03fd514
+            name:  'zfs-file-system'
+
+        Node 0xf0400e20
+            name:  'hsfs-file-system'
+
+    Node 0xf022cc44
+        fs-package:  'hsfs-file-system'
+        whoami:  '/platform/sun4v/kernel/sparcv9/unix'
+        impl-arch-name:  'sun4v'
+        elfheader-length:  00302000
+        elfheader-address:  50000000
+        archfs:  fea80270
+        archive-fstype:  'hsfs'
+        bootarchive:  '/ramdisk-root'
+        zfs-bootfs:  'rpool/40'
+        bootfs:  fea864e8
+        fstype:  'zfs'
+        boot-pool-list:  '/@308/@1/@0/@1/@3/@0,0'
+        tboot-list:  '/@308/@1/@0/@1/@1/@0,0'
+        bootargs:  00
+        bootpath:  '/pci@301/pci@1/scsi@0/disk@w5000cca0566d4d79,0:a'
+        openboot-reserved:  40000000
+        mmu:  fff04b38
+        memory:  fff04d48
+        stdout:  feb697d8
+        stdin:  feb75e48
+        stdout-#lines:  ffffffff
+        name:  'chosen'
+
+    Node 0xf022ccb8
+        version: 'OBP 4.37.0.build_23 2014/12/11 14:00'
+        model:  'SUNW,4.37.0.build_23'
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
+        oem-logo:  'AutoTest'
+        oem-logo?:  'false'
+        oem-banner:  
+        oem-banner?:  'false'
+        ansi-terminal?:  'true'
+        screen-#columns:  '80'
+        screen-#rows:  '34'
+        ttya-mode:  '9600,8,n,1,-'
+        output-device:  'virtual-console'
+        input-device:  'virtual-console'
+        auto-boot-on-error?:  'false'
+        load-base:  '16384'
+        auto-boot?:  'false'
+        os-root-device:  
+        network-boot-arguments:  
+        boot-command:  'boot'
+        boot-file:  
+        boot-device:  '/pci@301/pci@1/scsi@0/disk@w5000cca0566d4d79,0:a'
+        multipath-boot?:  'false'
+        boot-device-index:  '0'
+        use-nvramrc?:  'false'
+        nvramrc:  
+        error-reset-recovery:  'boot'
+        name:  'options'
+
+    Node 0xf022ce78
+        screen:  '/pci@309/pci@1/display@0'
+        cdrom:  '/pci@308/pci@1/usb@0/hub@5/device@4/storage@0/disk@0'
+        net3:  '/pci@302/pci@1/network@0,1'
+        net2:  '/pci@302/pci@1/network@0'
+        disk5:  '/pci@303/pci@1/scsi@0/disk@p1'
+        disk4:  '/pci@303/pci@1/scsi@0/disk@p0'
+        scsi1:  '/pci@303/pci@1/scsi@0'
+        net1:  '/pci@300/pci@1/network@0,1'
+        net:  '/pci@300/pci@1/network@0'
+        net0:  '/pci@300/pci@1/network@0'
+        disk3:  '/pci@301/pci@1/scsi@0/disk@p3'
+        disk2:  '/pci@301/pci@1/scsi@0/disk@p2'
+        disk1:  '/pci@301/pci@1/scsi@0/disk@p1'
+        disk:  '/pci@301/pci@1/scsi@0/disk@p0'
+        disk0:  '/pci@301/pci@1/scsi@0/disk@p0'
+        scsi:  '/pci@301/pci@1/scsi@0'
+        scsi0:  '/pci@301/pci@1/scsi@0'
+        virtual-console:  '/virtual-devices/console@1'
+        name:  'aliases'
+
+    Node 0xf0240654
+        reg:  00000000.50000000.0000001f.a0000000.00004000.00000000.0000001f.e0000000
+        available:  0000401f.da5a0000.00000000.002aa000.0000401f.d0000000.00000000.0a45c000.00004000.00000000.0000001f.b0000000.00000000.90000000.0000001f.60000000.00000000.8f764000.00000000.00002000.00000000.50400000.00000000.3f362000
+        name:  'memory'
+
+    Node 0xf0240c60
+        translations:  00000000.00002000.00000000.009fe000.80000000.50402740.00000000.00a00000.00000000.00580000.8000401f.df8b0740.00000000.01402000.00000000.00066000.8000401f.da538740.00000000.10000000.00000000.10000000.8000401f.c0000740.00000000.20000000.00000000.10000000.8000401f.b0000740.00000000.51000000.00000000.04ff8000.8000401f.da8b8740.00000000.f0000000.00000000.00400000.80000000.50000750.00000000.f0400000.00000000.00010000.8000401f.dfe30750.00000000.fe8bc000.00000000.00058000.8000401f.da84a750.00000000.fe914000.00000000.0005a000.8000401f.da45c750.00000000.fe96e000.00000000.00008000.8000401f.da8a2750.00000000.fe976000.00000000.00024000.8000401f.dfec6750.00000000.fe99a000.00000000.00040000.80020001.00040950.00000000.fe9da000.00000000.00010000.80020001.00000950.00000000.fe9ea000.00000000.00080000.8000401f.dfe40750.00000000.fea6a000.00000000.00006000.8000401f.dfeea750.00000000.fea70000.00000000.000ec000.8000401f.dfef4750.00000000.feb5c000.00000000.00002000.80020241.00000950.00000000.feb5e000.00000000.00006000.8000401f.dffe0750.00000000.feb64000.00000000.00004000.80020040.01000950.00000000.feb68000.00000000.00002000.8000401f.dffe6750.00000000.feb6a000.00000000.00004000.8000401f.dffea750.00000000.feb6e000.00000000.00002000.8000401f.dffe8750.00000000.feb70000.00000000.00004000.8000401f.dfff2750.00000000.feb74000.00000000.00004000.8000401f.dfffc750.00000000.feb78000.00000000.00002000.80000000.8f762750.00000000.feb7a000.00000000.00002000.8000401f.dfff6750.00000000.feb7c000.00000000.00004000.80000000.8f766750.00000000.feb84000.00000000.0040a000.80000000.8fb66750.00000000.fef8e000.00000000.0000a000.80000000.8ff84750.00000000.fef98000.00000000.00068000.80000000.8ff90750.00000000.fff00000.00000000.00010000.80000000.501f0750.00000000.fff10000.00000000.00002000.8000401f.dfffa750.00000000.fff12000.00000000.00002000.8000401f.dfff8750.00000000.fff14000.00000000.00004000.8000401f.dffee750
+        existing:  00000000.00000000.00000800.00000000.fffff800.00000000.00000800.00000000
+        available:  fffff800.00000000.000007fc.00000000.00000001.00000000.000007ff.00000000.00000000.ffff0000.00000000.0000e000.00000000.55ff8000.00000000.9a008000.00000000.30000000.00000000.21000000.00000000.01468000.00000000.0eb98000.00000000.00f80000.00000000.00482000.00000000.00000000.00000000.00a00000.00000000.f2200000.00000000.0c6bc000
+        page-size:  00002000
+        name:  'virtual-memory'
+
+    Node 0xf026d3c4
+        compatible: 'SUNW,iscsi-hba'
+        name:  'iscsi-hba'
+
+        Node 0xf0274b1c
+            lba64:  
+            device_type:  'block'
+            compatible: 'sd'
+            name:  'disk'
+
+    Node 0xf0275e38
+        reg:  c0000000.00000000.00000000.00000000
+        device_type:  'block'
+        name:  'reboot-memory'
+
+    Node 0xf028daf4
+        interrupt-map:  00000001.00000001.f028daf4.00000011
+        interrupt-map-mask:  0000001f.00ffffff.00000003
+        #interrupt-cells:  00000001
+        reg:  c0000100.00000000.00000000.00000000
+        #address-cells:  00000001
+        #size-cells:  00000000
+        device_type:  'virtual-devices'
+        compatible: 'SUNW,sun4v-virtual-devices' + 'SUNW,virtual-devices'
+        name:  'virtual-devices'
+
+        Node 0xf028ebb4
+            name:  'flashprom'
+            reg:  00000000
+
+        Node 0xf028f188
+            rng-#units:  00000002
+            compatible: 'ORCL,m7-rng'
+            reg:  0000000e
+            name:  'random-number-generator'
+
+        Node 0xf028f80c
+            #interrupts:  0000003f
+            compatible: 'ORCL,sun4v-dax'
+            reg:  0000000a
+            name:  'dax'
+
+        Node 0xf028fc7c
+            reg:  00000001
+            device_type:  'serial'
+            compatible: 'SUNW,sun4v-console'
+            name:  'console'
+            interrupts:  00000001
+
+        Node 0xf029044c
+            #address-cells:  00000001
+            #size-cells:  00000000
+            reg:  00000200
+            compatible: 'SUNW,sun4v-channel-devices'
+            device_type:  'channel-devices'
+            name:  'channel-devices'
+
+            Node 0xf029132c
+                compatible: 'SUNW,sun4v-channel'
+                reg:  00000000
+                name:  'virtual-channel'
+
+            Node 0xf0291400
+                compatible: 'SUNW,sun4v-channel'
+                reg:  00000003
+                name:  'virtual-channel'
+
+            Node 0xf02914d4
+                compatible: 'SUNW,sun4v-channel'
+                reg:  00000001
+                name:  'virtual-channel-client'
+
+            Node 0xf02915ac
+                compatible: 'SUNW,sun4v-channel'
+                reg:  00000002
+                name:  'virtual-channel-client'
+
+            Node 0xf0291684
+                compatible: 'SUNW,sun4v-pciv-comm'
+                reg:  00000000
+                name:  'pciv-communication'
+
+            Node 0xf0291758
+                compatible: 'SUNW,sun4v-domain-service'
+                reg:  00000000
+                name:  'virtual-domain-service'
+
+    Node 0xf0291978
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000000.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0291ad8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000001.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0291c38
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000002.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0291d98
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000003.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0291ef8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000004.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0292058
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000005.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02921b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000006.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0292318
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000007.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0292478
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000008.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02925d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000009.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0292738
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000000a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0292898
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000000b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02929f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000000c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0292b58
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000000d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0292cb8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000000e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0292e18
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000000f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0292f78
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000010.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02930d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000011.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0293238
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000012.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0293398
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000013.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02934f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000014.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0293658
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000015.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02937b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000016.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0293918
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000017.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0293a78
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000018.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0293bd8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000019.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0293d38
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000001a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0293e98
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000001b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0293ff8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000001c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0294158
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000001d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02942b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000001e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0294418
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000001f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0294578
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000020.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02946d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000021.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0294838
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000022.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0294998
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000023.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0294af8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000024.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0294c58
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000025.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0294db8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000026.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0294f18
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000027.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0295078
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000028.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02951d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000029.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0295338
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000002a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0295498
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000002b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02955f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000002c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0295758
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000002d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02958b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000002e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0295a18
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000002f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0295b78
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000030.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0295cd8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000031.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0295e38
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000032.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0295f98
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000033.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02960f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000034.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0296258
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000035.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02963b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000036.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0296518
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000037.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0296678
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000038.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02967d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000039.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0296938
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000003a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0296a98
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000003b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0296bf8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000003c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0296d58
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000003d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0296eb8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000003e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0297018
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000003f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0297178
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000040.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02972d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000041.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0297438
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000042.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0297598
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000043.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02976f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000044.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0297858
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000045.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02979b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000046.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0297b18
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000047.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0297c78
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000048.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0297dd8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000049.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0297f38
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000004a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0298098
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000004b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02981f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000004c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0298358
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000004d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02984b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000004e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0298618
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000004f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0298778
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000050.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02988d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000051.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0298a38
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000052.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0298b98
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000053.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0298cf8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000054.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0298e58
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000055.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0298fb8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000056.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0299118
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000057.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0299278
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000058.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02993d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000059.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0299538
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000005a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0299698
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000005b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02997f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000005c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0299958
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000005d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0299ab8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000005e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0299c18
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000005f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0299d78
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000060.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf0299ed8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000061.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029a038
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000062.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029a198
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000063.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029a2f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000064.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029a458
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000065.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029a5b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000066.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029a718
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000067.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029a878
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000068.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029a9d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000069.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029ab38
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000006a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029ac98
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000006b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029adf8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000006c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029af58
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000006d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029b0b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000006e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029b218
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000006f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029b378
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000070.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029b4d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000071.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029b638
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000072.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029b798
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000073.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029b8f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000074.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029ba58
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000075.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029bbb8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000076.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029bd18
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000077.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029be78
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000078.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029bfd8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000079.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029c138
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000007a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029c298
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000007b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029c3f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000007c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029c558
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000007d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029c6b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000007e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029c818
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000007f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029c978
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000080.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029cad8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000081.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029cc38
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000082.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029cd98
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000083.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029cef8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000084.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029d058
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000085.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029d1b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000086.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029d318
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000087.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029d478
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000088.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029d5d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000089.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029d738
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000008a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029d898
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000008b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029d9f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000008c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029db58
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000008d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029dcb8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000008e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029de18
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000008f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029df78
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000090.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029e0d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000091.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029e238
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000092.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029e398
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000093.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029e4f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000094.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029e658
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000095.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029e7b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000096.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029e918
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000097.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029ea78
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000098.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029ebd8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000099.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029ed38
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000009a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029ee98
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000009b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029eff8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000009c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f158
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000009d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f2b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000009e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f418
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000009f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f578
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000a0.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f6d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000a1.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f838
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000a2.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f998
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000a3.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029faf8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000a4.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029fc58
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000a5.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029fdb8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000a6.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029ff18
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000a7.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0078
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000a8.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a01d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000a9.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0338
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000aa.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0498
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000ab.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a05f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000ac.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0758
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000ad.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a08b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000ae.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0a18
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000af.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0b78
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000b0.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0cd8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000b1.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0e38
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000b2.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0f98
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000b3.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a10f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000b4.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1258
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000b5.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a13b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000b6.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1518
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000b7.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1678
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000b8.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a17d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000b9.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1938
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000ba.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1a98
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000bb.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1bf8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000bc.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1d58
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000bd.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1eb8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000be.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2018
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000bf.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2178
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000c0.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a22d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000c1.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2438
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000c2.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2598
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000c3.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a26f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000c4.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2858
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000c5.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a29b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000c6.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2b18
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000c7.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2c78
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000c8.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2dd8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000c9.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2f38
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000ca.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3098
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000cb.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a31f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000cc.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3358
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000cd.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a34b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000ce.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3618
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000cf.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3778
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000d0.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a38d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000d1.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3a38
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000d2.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3b98
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000d3.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3cf8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000d4.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3e58
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000d5.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3fb8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000d6.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4118
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000d7.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4278
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000d8.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a43d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000d9.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4538
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000da.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4698
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000db.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a47f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000dc.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4958
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000dd.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4ab8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000de.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4c18
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000df.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4d78
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000e0.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4ed8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000e1.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5038
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000e2.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5198
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000e3.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a52f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000e4.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5458
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000e5.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a55b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000e6.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5718
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000e7.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5878
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000e8.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a59d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000e9.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5b38
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000ea.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5c98
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000eb.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5df8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000ec.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5f58
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000ed.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a60b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000ee.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a6218
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000ef.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a6378
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000f0.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a64d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000f1.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a6638
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000f2.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a6798
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000f3.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a68f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000f4.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a6a58
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000f5.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a6bb8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000f6.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a6d18
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000f7.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a6e78
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000f8.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a6fd8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000f9.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7138
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000fa.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7298
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000fb.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a73f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000fc.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7558
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000fd.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a76b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000fe.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7818
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00000ff.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7978
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000100.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7ad8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000101.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7c38
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000102.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7d98
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000103.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7ef8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000104.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a8058
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000105.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a81b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000106.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a8318
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000107.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a8478
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000108.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a85d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000109.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a8738
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000010a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a8898
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000010b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a89f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000010c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a8b58
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000010d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a8cb8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000010e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a8e18
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000010f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a8f78
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000110.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a90d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000111.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9238
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000112.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9398
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000113.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a94f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000114.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9658
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000115.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a97b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000116.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9918
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000117.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9a78
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000118.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9bd8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000119.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9d38
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000011a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9e98
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000011b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9ff8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000011c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aa158
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000011d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aa2b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000011e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aa418
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000011f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aa578
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000120.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aa6d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000121.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aa838
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000122.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aa998
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000123.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aaaf8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000124.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aac58
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000125.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aadb8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000126.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aaf18
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000127.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ab078
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000128.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ab1d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000129.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ab338
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000012a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ab498
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000012b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ab5f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000012c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ab758
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000012d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ab8b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000012e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aba18
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000012f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02abb78
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000130.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02abcd8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000131.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02abe38
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000132.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02abf98
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000133.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ac0f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000134.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ac258
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000135.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ac3b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000136.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ac518
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000137.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ac678
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000138.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ac7d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000139.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ac938
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000013a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aca98
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000013b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02acbf8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000013c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02acd58
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000013d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aceb8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000013e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ad018
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000013f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ad178
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000140.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ad2d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000141.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ad438
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000142.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ad598
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000143.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ad6f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000144.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ad858
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000145.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ad9b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000146.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02adb18
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000147.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02adc78
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000148.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02addd8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000149.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02adf38
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000014a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ae098
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000014b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ae1f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000014c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ae358
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000014d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ae4b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000014e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ae618
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000014f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ae778
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000150.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ae8d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000151.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aea38
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000152.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aeb98
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000153.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aecf8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000154.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aee58
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000155.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aefb8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000156.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02af118
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000157.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02af278
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000158.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02af3d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000159.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02af538
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000015a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02af698
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000015b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02af7f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000015c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02af958
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000015d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02afab8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000015e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02afc18
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000015f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02afd78
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000160.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02afed8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000161.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b0038
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000162.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b0198
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000163.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b02f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000164.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b0458
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000165.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b05b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000166.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b0718
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000167.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b0878
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000168.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b09d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000169.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b0b38
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000016a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b0c98
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000016b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b0df8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000016c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b0f58
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000016d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b10b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000016e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b1218
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000016f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b1378
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000170.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b14d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000171.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b1638
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000172.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b1798
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000173.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b18f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000174.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b1a58
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000175.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b1bb8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000176.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b1d18
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000177.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b1e78
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000178.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b1fd8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000179.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b2138
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000017a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b2298
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000017b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b23f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000017c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b2558
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000017d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b26b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000017e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b2818
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000017f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b2978
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000180.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b2ad8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000181.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b2c38
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000182.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b2d98
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000183.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b2ef8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000184.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b3058
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000185.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b31b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000186.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b3318
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000187.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b3478
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000188.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b35d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000189.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b3738
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000018a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b3898
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000018b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b39f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000018c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b3b58
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000018d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b3cb8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000018e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b3e18
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000018f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b3f78
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000190.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b40d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000191.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b4238
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000192.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b4398
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000193.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b44f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000194.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b4658
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000195.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b47b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000196.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b4918
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000197.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b4a78
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000198.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b4bd8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000199.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b4d38
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000019a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b4e98
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000019b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b4ff8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000019c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b5158
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000019d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b52b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000019e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b5418
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000019f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b5578
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001a0.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b56d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001a1.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b5838
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001a2.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b5998
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001a3.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b5af8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001a4.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b5c58
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001a5.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b5db8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001a6.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b5f18
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001a7.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b6078
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001a8.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b61d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001a9.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b6338
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001aa.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b6498
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001ab.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b65f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001ac.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b6758
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001ad.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b68b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001ae.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b6a18
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001af.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b6b78
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001b0.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b6cd8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001b1.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b6e38
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001b2.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b6f98
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001b3.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b70f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001b4.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b7258
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001b5.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b73b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001b6.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b7518
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001b7.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b7678
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001b8.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b77d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001b9.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b7938
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001ba.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b7a98
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001bb.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b7bf8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001bc.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b7d58
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001bd.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b7eb8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001be.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b8018
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001bf.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b8178
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001c0.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b82d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001c1.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b8438
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001c2.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b8598
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001c3.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b86f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001c4.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b8858
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001c5.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b89b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001c6.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b8b18
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001c7.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b8c78
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001c8.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b8dd8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001c9.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b8f38
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001ca.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b9098
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001cb.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b91f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001cc.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b9358
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001cd.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b94b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001ce.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b9618
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001cf.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b9778
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001d0.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b98d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001d1.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b9a38
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001d2.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b9b98
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001d3.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b9cf8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001d4.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b9e58
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001d5.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02b9fb8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001d6.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ba118
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001d7.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ba278
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001d8.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ba3d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001d9.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ba538
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001da.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ba698
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001db.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ba7f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001dc.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02ba958
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001dd.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02baab8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001de.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bac18
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001df.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bad78
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001e0.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02baed8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001e1.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bb038
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001e2.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bb198
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001e3.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bb2f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001e4.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bb458
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001e5.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bb5b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001e6.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bb718
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001e7.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bb878
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001e8.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bb9d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001e9.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bbb38
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001ea.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bbc98
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001eb.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bbdf8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001ec.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bbf58
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001ed.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bc0b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001ee.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bc218
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001ef.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bc378
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001f0.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bc4d8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001f1.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bc638
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001f2.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bc798
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001f3.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bc8f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001f4.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bca58
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001f5.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bcbb8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001f6.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bcd18
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001f7.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bce78
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001f8.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bcfd8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001f9.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bd138
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001fa.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bd298
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001fb.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bd3f8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001fc.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bd558
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001fd.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bd6b8
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001fe.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bd818
+        clock-frequency:  f65c15b0
+        clock-frequency64:  00000000.f65c15b0
+        compatible: 'SPARC-M7' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c00001ff.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02bd97c
+        interrupt-map:  00000800.00000000.00000000.00000001.f02bd97c.00000002.00000800.00000000.00000000.00000002.f02bd97c.00000003.00000800.00000000.00000000.00000003.f02bd97c.00000004.00000800.00000000.00000000.00000004.f02bd97c.00000001.00001000.00000000.00000000.00000001.f02bd97c.00000003.00001000.00000000.00000000.00000002.f02bd97c.00000004.00001000.00000000.00000000.00000003.f02bd97c.00000001.00001000.00000000.00000000.00000004.f02bd97c.00000002
+        interrupt-map-mask:  00fff800.00000000.00000000.00000007
+        #interrupt-cells:  00000001
+        interrupts:  0000003f.0000003e
+        available:  81000000.00000000.00001000.00000000.0ffff000.82000000.00000000.00100000.00000000.7ef00000.c3000000.00000001.10000000.00000006.f0000000
+        level1-hotplug-slot-count:  00000002
+        level2-hotplug-slot-count:  00000006
+        ranges:  01000000.00000000.00000000.8002007e.00000000.00000000.10000000.02000000.00000000.00000000.80020000.00000000.00000000.7f000000.03000000.00000001.00000000.80020001.00000000.00000007.00000000
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
+        pcie-ber-factor:  0000006e
+        hotplug-mem64size:  00000006.f0000000
+        hotplug-memsize:  70000000
+        available-bus-range:  00000000.000000ff
+        bus-range:  00000000.00000002
+        bus-parity-generated:  
+        #address-cells:  00000003
+        #size-cells:  00000002
+        name:  'pci'
+        compatible: 'SUNW,sun4v-pci'
+        device_type:  'pciex'
+        virtual-dma:  80000000.80000000
+
+        Node 0xf0356028
+            available:  81000000.00000000.00000100.00000000.00000f00.c3000000.00000001.00010000.00000000.00030000.c3000000.00000001.00080000.00000000.0ff80000
+            ranges:  81000000.00000000.00000000.81000000.00000000.00000000.00000000.00001000.82000000.00000000.00000000.82000000.00000000.00000000.00000000.00100000.c3000000.00000001.00000000.c3000000.00000001.00000000.00000000.10000000
+            bus-range:  00000001.00000001
+            compatible: 'pciex108e,818e.1' + 'pciex108e,818e' + 'pciexclass,060400' + 'pciexclass,0604'
+            reg:  00000800.00000000.00000000.00000000.00000000
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
+            Node 0xf0358ca8
+                firmware-version:  '5.00.03.00'
+                mpt-version:  '2.05'
+                local-wwid:  50800200.01b7dd80
+                assigned-addresses:  81010010.00000000.00000000.00000000.00000100.83010014.00000001.00000000.00000000.00010000.8301001c.00000001.00040000.00000000.00040000.82010030.00000000.00000000.00000000.00100000
+                compatible: 'pciex1000,97' + 'pci1000,97'
+                model:  'LSI,3008'
+                reg:  00010000.00000000.00000000.00000000.00000000.01010010.00000000.00000000.00000000.00000100.03010014.00000000.00000000.00000000.00010000.0301001c.00000000.00000000.00000000.00040000.02010030.00000000.00000000.00000000.00100000
+                version: '1.00.64'
+                wide:  00000010
+                device_type:  'scsi-sas'
+                name:  'scsi'
+                #address-cells:  00000004
+                port-type:  'PCIE-Endpoint'
+                interrupts:  00000001
+                cache-line-size:  00000010
+                class-code:  00010700
+                subsystem-id:  00000090
+                subsystem-vendor-id:  00001000
+                revision-id:  00000002
+                device-id:  00000097
+                vendor-id:  00001000
+
+                Node 0xf036e5e4
+                    device_type:  'byte'
+                    compatible: 'st'
+                    name:  'tape'
+
+                Node 0xf036f5ec
+                    lba64:  
+                    device_type:  'block'
+                    compatible: 'sd'
+                    name:  'disk'
+
+        Node 0xf0372150
+            slot-names:  00000001.2f535953.2f4d422f.50434945.3400
+            bus-range:  00000002.00000002
+            slot-implemented?:  
+            compatible: 'pciex108e,818e.1' + 'pciex108e,818e' + 'pciexclass,060400' + 'pciexclass,0604'
+            reg:  00001000.00000000.00000000.00000000.00000000
+            physical-slot#:  00000004
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
+    Node 0xf02ccd50
+        interrupt-map:  00000800.00000000.00000000.00000001.f02ccd50.00000002.00000800.00000000.00000000.00000002.f02ccd50.00000003.00000800.00000000.00000000.00000003.f02ccd50.00000004.00000800.00000000.00000000.00000004.f02ccd50.00000001.00001000.00000000.00000000.00000001.f02ccd50.00000003.00001000.00000000.00000000.00000002.f02ccd50.00000004.00001000.00000000.00000000.00000003.f02ccd50.00000001.00001000.00000000.00000000.00000004.f02ccd50.00000002
+        interrupt-map-mask:  00fff800.00000000.00000000.00000007
+        #interrupt-cells:  00000001
+        interrupts:  0000003f.0000003e
+        available:  81000000.00000000.00001000.00000000.0ffff000.82000000.00000000.00000000.00000000.7f000000.c3000000.00000001.10000000.00000006.f0000000
+        level1-hotplug-slot-count:  00000002
+        level2-hotplug-slot-count:  00000006
+        ranges:  01000000.00000000.00000000.8002007e.10000000.00000000.10000000.02000000.00000000.00000000.80020010.00000000.00000000.7f000000.03000000.00000001.00000000.80020011.00000000.00000007.00000000
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
+        pcie-ber-factor:  0000006e
+        hotplug-mem64size:  00000006.f0000000
+        hotplug-memsize:  70000000
+        available-bus-range:  00000000.000000ff
+        bus-range:  00000000.00000003
+        bus-parity-generated:  
+        #address-cells:  00000003
+        #size-cells:  00000002
+        name:  'pci'
+        compatible: 'SUNW,sun4v-pci'
+        device_type:  'pciex'
+        virtual-dma:  80000000.80000000
+
+        Node 0xf0374f4c
+            available:  81000000.00000000.00000040.00000000.00000fc0.c3000000.00000001.00508000.00000000.000f8000.c3000000.00000001.00900000.00000000.0f700000
+            ranges:  81000000.00000000.00000000.81000000.00000000.00000000.00000000.00001000.c3000000.00000001.00000000.c3000000.00000001.00000000.00000000.10000000
+            bus-range:  00000001.00000002
+            compatible: 'pciex108e,818e.1' + 'pciex108e,818e' + 'pciexclass,060400' + 'pciexclass,0604'
+            reg:  00000800.00000000.00000000.00000000.00000000
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
+            Node 0xf0377bcc
+                local-mac-address:  0010e05d.3df2
+                mac-addresses:  0010e05d.3df2
+                vf-assigned-addresses:  83010000.00000001.00204000.00000000.00004000.83010003.00000001.00304000.00000000.00004000
+                assigned-addresses:  c3010010.00000001.00000000.00000000.00200000.81010018.00000000.00000000.00000000.00000020.c3010020.00000001.00200000.00000000.00004000
+                vf-reg:  03010000.00000000.00000000.00000000.00004000.03010003.00000000.00000000.00000000.00004000
+                compatible: 'pciex8086,1528.108e.4848.1' + 'pciex8086,1528.108e.4848' + 'pciex8086,1528.1' + 'pciex8086,1528' + 'pciexclass,020000' + 'pciexclass,0200'
+                reg:  00010000.00000000.00000000.00000000.00000000.43010010.00000000.00000000.00000000.00200000.01010018.00000000.00000000.00000000.00000020.43010020.00000000.00000000.00000000.00004000
+                max-frame-size:  00010000
+                address-bits:  00000030
+                device_type:  'network'
+                name:  'network'
+                vf-stride:  00000002
+                first-vf-offset:  00000180
+                total-vfs:  00000040
+                initial-vfs:  00000040
+                #vfs:  00000040
+                port-type:  'PCIE-Endpoint'
+                interrupts:  00000002
+                cache-line-size:  00000010
+                class-code:  00020000
+                subsystem-id:  00004848
+                subsystem-vendor-id:  0000108e
+                revision-id:  00000001
+                device-id:  00001528
+                vendor-id:  00008086
+
+            Node 0xf0382734
+                local-mac-address:  0010e05d.3df3
+                mac-addresses:  0010e05d.3df3
+                vf-assigned-addresses:  83010100.00000001.00408000.00000000.00004000.83010103.00000001.00800000.00000000.00004000
+                assigned-addresses:  c3010110.00000001.00600000.00000000.00200000.81010118.00000000.00000020.00000000.00000020.c3010120.00000001.00404000.00000000.00004000
+                vf-reg:  03010100.00000000.00000000.00000000.00004000.03010103.00000000.00000000.00000000.00004000
+                compatible: 'pciex8086,1528.108e.4848.1' + 'pciex8086,1528.108e.4848' + 'pciex8086,1528.1' + 'pciex8086,1528' + 'pciexclass,020000' + 'pciexclass,0200'
+                reg:  00010100.00000000.00000000.00000000.00000000.43010110.00000000.00000000.00000000.00200000.01010118.00000000.00000000.00000000.00000020.43010120.00000000.00000000.00000000.00004000
+                max-frame-size:  00010000
+                address-bits:  00000030
+                device_type:  'network'
+                name:  'network'
+                vf-stride:  00000002
+                first-vf-offset:  00000180
+                total-vfs:  00000040
+                initial-vfs:  00000040
+                #vfs:  00000040
+                port-type:  'PCIE-Endpoint'
+                interrupts:  00000001
+                cache-line-size:  00000010
+                class-code:  00020000
+                subsystem-id:  00004848
+                subsystem-vendor-id:  0000108e
+                revision-id:  00000001
+                device-id:  00001528
+                vendor-id:  00008086
+
+        Node 0xf038d3b4
+            slot-names:  00000001.2f535953.2f4d422f.50434945.3300
+            bus-range:  00000003.00000003
+            slot-implemented?:  
+            compatible: 'pciex108e,818e.1' + 'pciex108e,818e' + 'pciexclass,060400' + 'pciexclass,0604'
+            reg:  00001000.00000000.00000000.00000000.00000000
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
+    Node 0xf02dc124
+        interrupt-map:  00000800.00000000.00000000.00000001.f02dc124.00000002.00000800.00000000.00000000.00000002.f02dc124.00000003.00000800.00000000.00000000.00000003.f02dc124.00000004.00000800.00000000.00000000.00000004.f02dc124.00000001
+        interrupt-map-mask:  00fff800.00000000.00000000.00000007
+        #interrupt-cells:  00000001
+        interrupts:  0000003f.0000003e
+        available:  81000000.00000000.00000000.00000000.10000000.82000000.00000000.00000000.00000000.7f000000.c3000000.00000001.00000000.00000007.00000000
+        level1-hotplug-slot-count:  00000001
+        level2-hotplug-slot-count:  00000006
+        ranges:  01000000.00000000.00000000.8002007e.20000000.00000000.10000000.02000000.00000000.00000000.80020020.00000000.00000000.7f000000.03000000.00000001.00000000.80020021.00000000.00000007.00000000
+        reg:  c0000307.00000000.00000000.00000000
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
+        pcie-ber-factor:  0000006e
+        hotplug-mem64size:  00000006.f0000000
+        hotplug-memsize:  70000000
+        available-bus-range:  00000000.000000ff
+        bus-range:  00000000.00000001
+        bus-parity-generated:  
+        #address-cells:  00000003
+        #size-cells:  00000002
+        name:  'pci'
+        compatible: 'SUNW,sun4v-pci'
+        device_type:  'pciex'
+        virtual-dma:  80000000.80000000
+
+        Node 0xf03901b0
+            slot-names:  00000001.2f535953.2f4d422f.50434945.3200
+            bus-range:  00000001.00000001
+            slot-implemented?:  
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
+    Node 0xf02eb4f8
+        interrupt-map:  00000800.00000000.00000000.00000001.f02eb4f8.00000002.00000800.00000000.00000000.00000002.f02eb4f8.00000003.00000800.00000000.00000000.00000003.f02eb4f8.00000004.00000800.00000000.00000000.00000004.f02eb4f8.00000001
+        interrupt-map-mask:  00fff800.00000000.00000000.00000007
+        #interrupt-cells:  00000001
+        interrupts:  0000003f.0000003e
+        available:  81000000.00000000.00000000.00000000.10000000.82000000.00000000.00000000.00000000.7f000000.c3000000.00000001.00000000.00000007.00000000
+        level1-hotplug-slot-count:  00000001
+        level2-hotplug-slot-count:  00000006
+        ranges:  01000000.00000000.00000000.8002007e.30000000.00000000.10000000.02000000.00000000.00000000.80020030.00000000.00000000.7f000000.03000000.00000001.00000000.80020031.00000000.00000007.00000000
+        reg:  c0000306.00000000.00000000.00000000
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
+        pcie-ber-factor:  0000006e
+        hotplug-mem64size:  00000006.f0000000
+        hotplug-memsize:  70000000
+        available-bus-range:  00000000.000000ff
+        bus-range:  00000000.00000001
+        bus-parity-generated:  
+        #address-cells:  00000003
+        #size-cells:  00000002
+        name:  'pci'
+        compatible: 'SUNW,sun4v-pci'
+        device_type:  'pciex'
+        virtual-dma:  80000000.80000000
+
+        Node 0xf0392fac
+            slot-names:  00000001.2f535953.2f4d422f.50434945.3100
+            bus-range:  00000001.00000001
+            slot-implemented?:  
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
+    Node 0xf02fa8cc
+        interrupt-map:  00000800.00000000.00000000.00000001.f02fa8cc.00000002.00000800.00000000.00000000.00000002.f02fa8cc.00000003.00000800.00000000.00000000.00000003.f02fa8cc.00000004.00000800.00000000.00000000.00000004.f02fa8cc.00000001.00001000.00000000.00000000.00000001.f02fa8cc.00000003.00001000.00000000.00000000.00000002.f02fa8cc.00000004.00001000.00000000.00000000.00000003.f02fa8cc.00000001.00001000.00000000.00000000.00000004.f02fa8cc.00000002
+        interrupt-map-mask:  00fff800.00000000.00000000.00000007
+        #interrupt-cells:  00000001
+        interrupts:  0000003f.0000003e
+        available:  81000000.00000000.00000000.00000000.10000000.82000000.00000000.02000000.00000000.7d000000.c3000000.00000001.00000000.00000007.00000000
+        level1-hotplug-slot-count:  00000001
+        level2-hotplug-slot-count:  00000006
+        ranges:  01000000.00000000.00000000.8002007e.40000000.00000000.10000000.02000000.00000000.00000000.80020040.00000000.00000000.7f000000.03000000.00000001.00000000.80020041.00000000.00000007.00000000
+        reg:  c0000309.00000000.00000000.00000000
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
+        pcie-ber-factor:  0000006e
+        hotplug-mem64size:  00000006.f0000000
+        hotplug-memsize:  70000000
+        available-bus-range:  00000000.000000ff
+        bus-range:  00000000.00000001
+        bus-parity-generated:  
+        #address-cells:  00000003
+        #size-cells:  00000002
+        name:  'pci'
+        compatible: 'SUNW,sun4v-pci'
+        device_type:  'pciex'
+        virtual-dma:  80000000.80000000
+
+        Node 0xf0395da8
+            available:  82000000.00000000.01004000.00000000.0000c000.82000000.00000000.01020000.00000000.007e0000
+            ranges:  82000000.00000000.00000000.82000000.00000000.00000000.00000000.02000000
+            bus-range:  00000001.00000001
+            compatible: 'pciex108e,818e.1' + 'pciex108e,818e' + 'pciexclass,060400' + 'pciexclass,0604'
+            reg:  00000800.00000000.00000000.00000000.00000000
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
+            Node 0xf0398a28
+                assigned-addresses:  82010010.00000000.00000000.00000000.01000000.82010014.00000000.01000000.00000000.00004000.82010018.00000000.01800000.00000000.00800000.82010030.00000000.01010000.00000000.00010000
+                compatible: 'pciex102b,522.19a2.102.5' + 'pciex102b,522.19a2.102' + 'pciex102b,522.5' + 'pciex102b,522' + 'pciexclass,030000' + 'pciexclass,0300'
+                reg:  00010000.00000000.00000000.00000000.00000000.02010010.00000000.00000000.00000000.01000000.02010014.00000000.00000000.00000000.00004000.02010018.00000000.00000000.00000000.00800000.02010030.00000000.00000000.00000000.00010000
+                device_type:  'display'
+                name:  'display'
+                port-type:  'Legacy-PCIE-Endpoint'
+                interrupts:  00000001
+                cache-line-size:  00000010
+                class-code:  00030000
+                subsystem-id:  00000102
+                subsystem-vendor-id:  000019a2
+                revision-id:  00000005
+                device-id:  00000522
+                vendor-id:  0000102b
+
+    Node 0xf0309ca0
+        interrupt-map:  00000800.00000000.00000000.00000001.f0309ca0.00000002.00000800.00000000.00000000.00000002.f0309ca0.00000003.00000800.00000000.00000000.00000003.f0309ca0.00000004.00000800.00000000.00000000.00000004.f0309ca0.00000001.00001000.00000000.00000000.00000001.f0309ca0.00000003.00001000.00000000.00000000.00000002.f0309ca0.00000004.00001000.00000000.00000000.00000003.f0309ca0.00000001.00001000.00000000.00000000.00000004.f0309ca0.00000002
+        interrupt-map-mask:  00fff800.00000000.00000000.00000007
+        #interrupt-cells:  00000001
+        interrupts:  0000003f.0000003e
+        available:  81000000.00000000.00001000.00000000.0ffff000.82000000.00000000.00100000.00000000.7ef00000.c3000000.00000001.10000000.00000006.f0000000
+        level1-hotplug-slot-count:  00000002
+        level2-hotplug-slot-count:  00000006
+        ranges:  01000000.00000000.00000000.8002027e.00000000.00000000.10000000.02000000.00000000.00000000.80020200.00000000.00000000.7f000000.03000000.00000001.00000000.80020201.00000000.00000007.00000000
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
+        pcie-ber-factor:  0000006e
+        hotplug-mem64size:  00000006.f0000000
+        hotplug-memsize:  70000000
+        available-bus-range:  00000000.000000ff
+        bus-range:  00000000.00000002
+        bus-parity-generated:  
+        #address-cells:  00000003
+        #size-cells:  00000002
+        name:  'pci'
+        compatible: 'SUNW,sun4v-pci'
+        device_type:  'pciex'
+        virtual-dma:  80000000.80000000
+
+        Node 0xf039ca50
+            available:  81000000.00000000.00000100.00000000.00000f00.c3000000.00000001.00010000.00000000.00030000.c3000000.00000001.00080000.00000000.0ff80000
+            ranges:  81000000.00000000.00000000.81000000.00000000.00000000.00000000.00001000.82000000.00000000.00000000.82000000.00000000.00000000.00000000.00100000.c3000000.00000001.00000000.c3000000.00000001.00000000.00000000.10000000
+            bus-range:  00000001.00000001
+            compatible: 'pciex108e,818e.1' + 'pciex108e,818e' + 'pciexclass,060400' + 'pciexclass,0604'
+            reg:  00000800.00000000.00000000.00000000.00000000
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
+            Node 0xf039f6d0
+                firmware-version:  '5.00.03.00'
+                mpt-version:  '2.05'
+                local-wwid:  50800200.01b7dd81
+                assigned-addresses:  81010010.00000000.00000000.00000000.00000100.83010014.00000001.00000000.00000000.00010000.8301001c.00000001.00040000.00000000.00040000.82010030.00000000.00000000.00000000.00100000
+                compatible: 'pciex1000,97' + 'pci1000,97'
+                model:  'LSI,3008'
+                reg:  00010000.00000000.00000000.00000000.00000000.01010010.00000000.00000000.00000000.00000100.03010014.00000000.00000000.00000000.00010000.0301001c.00000000.00000000.00000000.00040000.02010030.00000000.00000000.00000000.00100000
+                version: '1.00.64'
+                wide:  00000010
+                device_type:  'scsi-sas'
+                name:  'scsi'
+                #address-cells:  00000004
+                port-type:  'PCIE-Endpoint'
+                interrupts:  00000001
+                cache-line-size:  00000010
+                class-code:  00010700
+                subsystem-id:  00000090
+                subsystem-vendor-id:  00001000
+                revision-id:  00000002
+                device-id:  00000097
+                vendor-id:  00001000
+
+                Node 0xf03b500c
+                    device_type:  'byte'
+                    compatible: 'st'
+                    name:  'tape'
+
+                Node 0xf03b6014
+                    lba64:  
+                    device_type:  'block'
+                    compatible: 'sd'
+                    name:  'disk'
+
+        Node 0xf03b8758
+            slot-names:  00000001.2f535953.2f4d422f.50434945.3600
+            bus-range:  00000002.00000002
+            slot-implemented?:  
+            compatible: 'pciex108e,818e.1' + 'pciex108e,818e' + 'pciexclass,060400' + 'pciexclass,0604'
+            reg:  00001000.00000000.00000000.00000000.00000000
+            physical-slot#:  00000006
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
+    Node 0xf0319074
+        interrupt-map:  00000800.00000000.00000000.00000001.f0319074.00000002.00000800.00000000.00000000.00000002.f0319074.00000003.00000800.00000000.00000000.00000003.f0319074.00000004.00000800.00000000.00000000.00000004.f0319074.00000001
+        interrupt-map-mask:  00fff800.00000000.00000000.00000007
+        #interrupt-cells:  00000001
+        interrupts:  0000003f.0000003e
+        available:  81000000.00000000.00000000.00000000.10000000.82000000.00000000.00000000.00000000.7f000000.c3000000.00000001.00000000.00000007.00000000
+        level1-hotplug-slot-count:  00000001
+        level2-hotplug-slot-count:  00000006
+        ranges:  01000000.00000000.00000000.8002027e.10000000.00000000.10000000.02000000.00000000.00000000.80020210.00000000.00000000.7f000000.03000000.00000001.00000000.80020211.00000000.00000007.00000000
+        reg:  c0000305.00000000.00000000.00000000
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
+        pcie-ber-factor:  0000006e
+        hotplug-mem64size:  00000006.f0000000
+        hotplug-memsize:  70000000
+        available-bus-range:  00000000.000000ff
+        bus-range:  00000000.00000001
+        bus-parity-generated:  
+        #address-cells:  00000003
+        #size-cells:  00000002
+        name:  'pci'
+        compatible: 'SUNW,sun4v-pci'
+        device_type:  'pciex'
+        virtual-dma:  80000000.80000000
+
+        Node 0xf03bb554
+            slot-names:  00000001.2f535953.2f4d422f.50434945.3800
+            bus-range:  00000001.00000001
+            slot-implemented?:  
+            compatible: 'pciex108e,818e.1' + 'pciex108e,818e' + 'pciexclass,060400' + 'pciexclass,0604'
+            reg:  00000800.00000000.00000000.00000000.00000000
+            physical-slot#:  00000008
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
+    Node 0xf0328448
+        interrupt-map:  00000800.00000000.00000000.00000001.f0328448.00000002.00000800.00000000.00000000.00000002.f0328448.00000003.00000800.00000000.00000000.00000003.f0328448.00000004.00000800.00000000.00000000.00000004.f0328448.00000001
+        interrupt-map-mask:  00fff800.00000000.00000000.00000007
+        #interrupt-cells:  00000001
+        interrupts:  0000003f.0000003e
+        available:  81000000.00000000.00000000.00000000.10000000.82000000.00000000.00000000.00000000.7f000000.c3000000.00000001.00000000.00000007.00000000
+        level1-hotplug-slot-count:  00000001
+        level2-hotplug-slot-count:  00000006
+        ranges:  01000000.00000000.00000000.8002027e.20000000.00000000.10000000.02000000.00000000.00000000.80020220.00000000.00000000.7f000000.03000000.00000001.00000000.80020221.00000000.00000007.00000000
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
+        pcie-ber-factor:  0000006e
+        hotplug-mem64size:  00000006.f0000000
+        hotplug-memsize:  70000000
+        available-bus-range:  00000000.000000ff
+        bus-range:  00000000.00000001
+        bus-parity-generated:  
+        #address-cells:  00000003
+        #size-cells:  00000002
+        name:  'pci'
+        compatible: 'SUNW,sun4v-pci'
+        device_type:  'pciex'
+        virtual-dma:  80000000.80000000
+
+        Node 0xf03be350
+            slot-names:  00000001.2f535953.2f4d422f.50434945.3700
+            bus-range:  00000001.00000001
+            slot-implemented?:  
+            compatible: 'pciex108e,818e.1' + 'pciex108e,818e' + 'pciexclass,060400' + 'pciexclass,0604'
+            reg:  00000800.00000000.00000000.00000000.00000000
+            physical-slot#:  00000007
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
+    Node 0xf033781c
+        interrupt-map:  00000800.00000000.00000000.00000001.f033781c.00000002.00000800.00000000.00000000.00000002.f033781c.00000003.00000800.00000000.00000000.00000003.f033781c.00000004.00000800.00000000.00000000.00000004.f033781c.00000001.00001000.00000000.00000000.00000001.f033781c.00000003.00001000.00000000.00000000.00000002.f033781c.00000004.00001000.00000000.00000000.00000003.f033781c.00000001.00001000.00000000.00000000.00000004.f033781c.00000002
+        interrupt-map-mask:  00fff800.00000000.00000000.00000007
+        #interrupt-cells:  00000001
+        interrupts:  0000003f.0000003e
+        available:  81000000.00000000.00001000.00000000.0ffff000.82000000.00000000.00000000.00000000.7f000000.c3000000.00000001.10000000.00000006.f0000000
+        level1-hotplug-slot-count:  00000002
+        level2-hotplug-slot-count:  00000006
+        ranges:  01000000.00000000.00000000.8002027e.30000000.00000000.10000000.02000000.00000000.00000000.80020230.00000000.00000000.7f000000.03000000.00000001.00000000.80020231.00000000.00000007.00000000
+        reg:  c0000302.00000000.00000000.00000000
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
+        pcie-ber-factor:  0000006e
+        hotplug-mem64size:  00000006.f0000000
+        hotplug-memsize:  70000000
+        available-bus-range:  00000000.000000ff
+        bus-range:  00000000.00000003
+        bus-parity-generated:  
+        #address-cells:  00000003
+        #size-cells:  00000002
+        name:  'pci'
+        compatible: 'SUNW,sun4v-pci'
+        device_type:  'pciex'
+        virtual-dma:  80000000.80000000
+
+        Node 0xf03c114c
+            available:  81000000.00000000.00000040.00000000.00000fc0.c3000000.00000001.00508000.00000000.000f8000.c3000000.00000001.00900000.00000000.0f700000
+            ranges:  81000000.00000000.00000000.81000000.00000000.00000000.00000000.00001000.c3000000.00000001.00000000.c3000000.00000001.00000000.00000000.10000000
+            bus-range:  00000001.00000002
+            compatible: 'pciex108e,818e.1' + 'pciex108e,818e' + 'pciexclass,060400' + 'pciexclass,0604'
+            reg:  00000800.00000000.00000000.00000000.00000000
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
+            Node 0xf03c3dcc
+                local-mac-address:  0010e05d.3df4
+                mac-addresses:  0010e05d.3df4
+                vf-assigned-addresses:  83010000.00000001.00204000.00000000.00004000.83010003.00000001.00304000.00000000.00004000
+                assigned-addresses:  c3010010.00000001.00000000.00000000.00200000.81010018.00000000.00000000.00000000.00000020.c3010020.00000001.00200000.00000000.00004000
+                vf-reg:  03010000.00000000.00000000.00000000.00004000.03010003.00000000.00000000.00000000.00004000
+                compatible: 'pciex8086,1528.108e.4848.1' + 'pciex8086,1528.108e.4848' + 'pciex8086,1528.1' + 'pciex8086,1528' + 'pciexclass,020000' + 'pciexclass,0200'
+                reg:  00010000.00000000.00000000.00000000.00000000.43010010.00000000.00000000.00000000.00200000.01010018.00000000.00000000.00000000.00000020.43010020.00000000.00000000.00000000.00004000
+                max-frame-size:  00010000
+                address-bits:  00000030
+                device_type:  'network'
+                name:  'network'
+                vf-stride:  00000002
+                first-vf-offset:  00000180
+                total-vfs:  00000040
+                initial-vfs:  00000040
+                #vfs:  00000040
+                port-type:  'PCIE-Endpoint'
+                interrupts:  00000002
+                cache-line-size:  00000010
+                class-code:  00020000
+                subsystem-id:  00004848
+                subsystem-vendor-id:  0000108e
+                revision-id:  00000001
+                device-id:  00001528
+                vendor-id:  00008086
+
+            Node 0xf03ce934
+                local-mac-address:  0010e05d.3df5
+                mac-addresses:  0010e05d.3df5
+                vf-assigned-addresses:  83010100.00000001.00408000.00000000.00004000.83010103.00000001.00800000.00000000.00004000
+                assigned-addresses:  c3010110.00000001.00600000.00000000.00200000.81010118.00000000.00000020.00000000.00000020.c3010120.00000001.00404000.00000000.00004000
+                vf-reg:  03010100.00000000.00000000.00000000.00004000.03010103.00000000.00000000.00000000.00004000
+                compatible: 'pciex8086,1528.108e.4848.1' + 'pciex8086,1528.108e.4848' + 'pciex8086,1528.1' + 'pciex8086,1528' + 'pciexclass,020000' + 'pciexclass,0200'
+                reg:  00010100.00000000.00000000.00000000.00000000.43010110.00000000.00000000.00000000.00200000.01010118.00000000.00000000.00000000.00000020.43010120.00000000.00000000.00000000.00004000
+                max-frame-size:  00010000
+                address-bits:  00000030
+                device_type:  'network'
+                name:  'network'
+                vf-stride:  00000002
+                first-vf-offset:  00000180
+                total-vfs:  00000040
+                initial-vfs:  00000040
+                #vfs:  00000040
+                port-type:  'PCIE-Endpoint'
+                interrupts:  00000001
+                cache-line-size:  00000010
+                class-code:  00020000
+                subsystem-id:  00004848
+                subsystem-vendor-id:  0000108e
+                revision-id:  00000001
+                device-id:  00001528
+                vendor-id:  00008086
+
+        Node 0xf03d95b4
+            slot-names:  00000001.2f535953.2f4d422f.50434945.3500
+            bus-range:  00000003.00000003
+            slot-implemented?:  
+            compatible: 'pciex108e,818e.1' + 'pciex108e,818e' + 'pciexclass,060400' + 'pciexclass,0604'
+            reg:  00001000.00000000.00000000.00000000.00000000
+            physical-slot#:  00000005
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
+    Node 0xf0346bf0
+        interrupt-map:  00000800.00000000.00000000.00000001.f0346bf0.00000002.00000800.00000000.00000000.00000002.f0346bf0.00000003.00000800.00000000.00000000.00000003.f0346bf0.00000004.00000800.00000000.00000000.00000004.f0346bf0.00000001.00001000.00000000.00000000.00000001.f0346bf0.00000003.00001000.00000000.00000000.00000002.f0346bf0.00000004.00001000.00000000.00000000.00000003.f0346bf0.00000001.00001000.00000000.00000000.00000004.f0346bf0.00000002
+        interrupt-map-mask:  00fff800.00000000.00000000.00000007
+        #interrupt-cells:  00000001
+        interrupts:  0000003f.0000003e
+        available:  81000000.00000000.00000000.00000000.10000000.82000000.00000000.00000000.00000000.7f000000.c3000000.00000001.10000000.00000006.f0000000
+        level1-hotplug-slot-count:  00000001
+        level2-hotplug-slot-count:  00000006
+        ranges:  01000000.00000000.00000000.8002027e.40000000.00000000.10000000.02000000.00000000.00000000.80020240.00000000.00000000.7f000000.03000000.00000001.00000000.80020241.00000000.00000007.00000000
+        reg:  c0000308.00000000.00000000.00000000
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
+        pcie-ber-factor:  0000006e
+        hotplug-mem64size:  00000006.f0000000
+        hotplug-memsize:  70000000
+        available-bus-range:  00000000.000000ff
+        bus-range:  00000000.00000001
+        bus-parity-generated:  
+        #address-cells:  00000003
+        #size-cells:  00000002
+        name:  'pci'
+        compatible: 'SUNW,sun4v-pci'
+        device_type:  'pciex'
+        virtual-dma:  80000000.80000000
+
+        Node 0xf03dc3b0
+            available:  c3000000.00000001.00012000.00000000.0ffee000
+            ranges:  c3000000.00000001.00000000.c3000000.00000001.00000000.00000000.10000000
+            bus-range:  00000001.00000001
+            compatible: 'pciex108e,818e.1' + 'pciex108e,818e' + 'pciexclass,060400' + 'pciexclass,0604'
+            reg:  00000800.00000000.00000000.00000000.00000000
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
+            Node 0xf03df030
+                assigned-addresses:  83010010.00000001.00000000.00000000.00010000.83010018.00000001.00010000.00000000.00002000
+                device_type:  'xchi'
+                reg:  00010000.00000000.00000000.00000000.00000000.03010010.00000000.00000000.00000000.00002000
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
+                Node 0xf03ec3a8
+                    device_type:  'usb_hub'
+                    configuration#:  00000001
+                    intr-in-size:  00000002
+                    intr-in-interval:  00000008
+                    intr-in-pipe:  00000001
+                    serial$:  00
+                    device$:  00
+                    vendor$:  00
+                    compatible: 'usb451,8046.100' + 'usb451,8046' + 'usb451,class9.0.3' + 'usb451,class9.0' + 'usb451,class9' + 'usb,class9.0.3' + 'usb,class9.0' + 'usb,class9' + 'usb,device'
+                    vendor-id:  00000451
+                    device-id:  00008046
+                    release:  00000100
+                    name:  'hub'
+                    class:  00000009
+                    subclass:  00000000
+                    protocol:  00000003
+                    ultra-speed:  00
+                    assigned-address:  00000001
+                    reg:  00000005
+                    #size-cells:  00000000
+                    #address-cells:  00000001
+
+                    Node 0xf03f4070
+                        device_type:  'usb_device'
+                        reg:  00000004
+                        #size-cells:  00000000
+                        #address-cells:  00000002
+                        compatible: 'usbdevice'
+                        name:  'device'
+
+                        Node 0xf03f4bbc
+                            #address-cells:  00000002
+                            #size-cells:  00000000
+                            device_type:  'scsi-usb'
+                            configuration#:  00000001
+                            bulk-out-size:  00000400
+                            bulk-out-pipe:  00000003
+                            bulk-in-size:  00000400
+                            bulk-in-pipe:  00000003
+                            serial$:  '2C890F7172306368131516845B434437C'
+                            device$:  'TUSB9261 USB3.0 to SATA Bridge'
+                            vendor$:  'Texas Instruments'
+                            compatible: 'usb451,9261.100' + 'usb451,9261' + 'usbif451,class8.6.50' + 'usbif451,class8.6' + 'usbif451,class8' + 'usbif,class8.6.50' + 'usbif,class8.6' + 'usbif,class8' + 'usb,device'
+                            vendor-id:  00000451
+                            device-id:  00009261
+                            release:  00000100
+                            name:  'storage'
+                            class:  00000008
+                            subclass:  00000006
+                            protocol:  00000050
+                            ultra-speed:  00
+                            assigned-address:  00000006
+                            reg:  00000000.00000000
+
+                            Node 0xf03f7d34
+                                compatible: 'sd' + 'disk'
+                                device_type:  'block'
+                                name:  'disk'
+
+                        Node 0xf03f8888
+                            configuration#:  00000001
+                            intr-out-size:  00000009
+                            intr-out-interval:  00000002
+                            intr-out-pipe:  00000001
+                            intr-in-size:  00000009
+                            intr-in-interval:  00000002
+                            intr-in-pipe:  00000001
+                            serial$:  '2C890F7172306368131516845B434437C'
+                            device$:  'TUSB9261 USB3.0 to SATA Bridge'
+                            vendor$:  'Texas Instruments'
+                            compatible: 'usb451,9261.100' + 'usb451,9261' + 'usbif451,class3.0.0' + 'usbif451,class3.0' + 'usbif451,class3' + 'usbif,class3.0.0' + 'usbif,class3.0' + 'usbif,class3' + 'usb,device'
+                            vendor-id:  00000451
+                            device-id:  00009261
+                            release:  00000100
+                            name:  'hid'
+                            class:  00000003
+                            subclass:  00000000
+                            protocol:  00000000
+                            ultra-speed:  00
+                            assigned-address:  00000006
+                            reg:  00000001.00000000
+
+                Node 0xf03ed2c0
+                    hub20-dev:  00000002
+                    device_type:  'usb_hub'
+                    configuration#:  00000001
+                    intr-in-size:  00000001
+                    intr-in-interval:  0000000c
+                    intr-in-pipe:  00000001
+                    serial$:  '2D010059130E'
+                    device$:  00
+                    vendor$:  00
+                    compatible: 'usb451,8044.100' + 'usb451,8044' + 'usb451,class9.0.2' + 'usb451,class9.0' + 'usb451,class9' + 'usb,class9.0.2' + 'usb,class9.0' + 'usb,class9' + 'usb,device'
+                    vendor-id:  00000451
+                    device-id:  00008044
+                    release:  00000100
+                    name:  'hub'
+                    class:  00000009
+                    subclass:  00000000
+                    protocol:  00000002
+                    high-speed:  00
+                    assigned-address:  00000002
+                    reg:  00000001
+                    #size-cells:  00000000
+                    #address-cells:  00000001
+
+                    Node 0xf03ef138
+                        device_type:  'usb_device'
+                        reg:  00000002
+                        #size-cells:  00000000
+                        #address-cells:  00000002
+                        compatible: 'usbdevice'
+                        name:  'device'
+
+                        Node 0xf03efc84
+                            configuration#:  00000001
+                            intr-in-size:  00000008
+                            intr-in-interval:  00000001
+                            intr-in-pipe:  00000001
+                            serial$:  00
+                            device$:  56697274.75616c20.45746820.44657669.63650000
+                            vendor$:  53756e4d.6963726f.0000
+                            compatible: 'usb430,a4a2.100' + 'usb430,a4a2' + 'usb430,class2.0.0' + 'usb430,class2.0' + 'usb430,class2' + 'usb,class2.0.0' + 'usb,class2.0' + 'usb,class2' + 'usb,device'
+                            vendor-id:  00000430
+                            device-id:  0000a4a2
+                            release:  00000100
+                            name:  'network'
+                            class:  00000002
+                            subclass:  00000000
+                            protocol:  00000000
+                            full-speed:  00
+                            assigned-address:  00000004
+                            reg:  00000000.00000000
+
+                        Node 0xf03efff4
+                            configuration#:  00000001
+                            bulk-in-size:  00000040
+                            bulk-in-pipe:  00000003
+                            bulk-out-size:  00000040
+                            bulk-out-pipe:  00000002
+                            serial$:  00
+                            device$:  56697274.75616c20.45746820.44657669.63650000
+                            vendor$:  53756e4d.6963726f.0000
+                            compatible: 'usb430,a4a2.100' + 'usb430,a4a2' + 'usb430,class2.0.0' + 'usb430,class2.0' + 'usb430,class2' + 'usb,class2.0.0' + 'usb,class2.0' + 'usb,class2' + 'usb,device'
+                            vendor-id:  00000430
+                            device-id:  0000a4a2
+                            release:  00000100
+                            name:  'network'
+                            class:  00000002
+                            subclass:  00000000
+                            protocol:  00000000
+                            full-speed:  00
+                            assigned-address:  00000004
+                            reg:  00000001.00000000
+
+                    Node 0xf03f03c0
+                        device_type:  'scsi-usb'
+                        configuration#:  00000001
+                        bulk-out-size:  00000200
+                        bulk-out-pipe:  00000002
+                        bulk-in-size:  00000200
+                        bulk-in-pipe:  00000001
+                        serial$:  '4BF0022700536181'
+                        device$:  'Real SSD eUSB 2GB'
+                        vendor$:  'Micron Technology'
+                        compatible: 'usb634,1270.1111' + 'usb634,1270' + 'usbif634,class8.6.50' + 'usbif634,class8.6' + 'usbif634,class8' + 'usbif,class8.6.50' + 'usbif,class8.6' + 'usbif,class8' + 'usb,device'
+                        vendor-id:  00000634
+                        device-id:  00001270
+                        release:  00001111
+                        name:  'storage'
+                        class:  00000008
+                        subclass:  00000006
+                        protocol:  00000050
+                        high-speed:  00
+                        assigned-address:  00000005
+                        reg:  00000003
+                        #size-cells:  00000000
+                        #address-cells:  00000002
+
+                        Node 0xf03f351c
+                            compatible: 'sd' + 'disk'
+                            device_type:  'block'
+                            name:  'disk'
+
+                Node 0xf03ee204
+                    hub20-dev:  00000003
+                    device_type:  'usb_hub'
+                    configuration#:  00000001
+                    intr-in-size:  00000001
+                    intr-in-interval:  0000000c
+                    intr-in-pipe:  00000001
+                    serial$:  00
+                    device$:  00
+                    vendor$:  00
+                    compatible: 'usb4b4,6560.b' + 'usb4b4,6560' + 'usb4b4,class9.0.2' + 'usb4b4,class9.0' + 'usb4b4,class9' + 'usb,class9.0.2' + 'usb,class9.0' + 'usb,class9' + 'usb,device'
+                    vendor-id:  000004b4
+                    device-id:  00006560
+                    release:  0000000b
+                    name:  'hub'
+                    class:  00000009
+                    subclass:  00000000
+                    protocol:  00000002
+                    high-speed:  00
+                    assigned-address:  00000003
+                    reg:  00000004
+                    #size-cells:  00000000
+                    #address-cells:  00000001
+
+    Node 0xf04004ac
+        alloc-size:  00000000
+        address:  51000000
+        size:  04ff8000
+        compatible: 'SUNW,ramdisk'
+        device_type:  'block'
+        name:  'ramdisk-root'
+
+
