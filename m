From: Anatoly Pugachev <matorola@gmail.com>
Date: Thu, 07 Jul 2016 10:27:09 +0000
Subject: prtconfs: Add SPARC S7-2
Message-Id: <20160707102709.GB3485@yogzotot>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

SPARC S7-2 prtconf, taken from Solaris 11 HCL
http://www.oracle.com/webfolder/technetwork/hcl/data/systems/prtconf/oracle_america_inc/sol_11_3/73340.txt

Signed-off-by: Anatoly Pugachev <matorola@gmail.com>                                                                                                
---

diff --git a/S7-2 b/S7-2
new file mode 100644
index 0000000..4107ef8
--- /dev/null
+++ b/S7-2
@@ -0,0 +1,2011 @@
+System Configuration:  Oracle Corporation  sun4v
+Memory size: 260352 Megabytes
+System Peripherals (PROM Nodes):
+
+Node 0xf02296e8
+    idprom:  01860010.e0b2b52a.00000000.b2b52a77.00000000.00000000.00000000.00000000
+    scsi-initiator-id:  00000007
+    pcie-ari-supported:  
+    #priqs-per-pcibus:  00000010
+    #priqs-per-cpu:  00000010
+    priq-eq-sizes:  00000003
+    non-ios-perf-counters:  'ORCL,sn-non-ios-pr'
+    ios-perf-counters:  'ORCL,sn-ios-pr'
+    storage-variant:  '8dbp'
+    product-name:  'SPARC SN-1'
+    banner-name:  'SPARC SN-1'
+    name:  'ORCL,SPARC-SN-1'
+    stick-frequency:  3b9aca00
+    hv-api-groups:  00000000.00000001.00000100.00000003.00000101.00000105.00000108.00000107.0000011d.00000006.00000118
+    breakpoint-trap:  0000007f
+    device_type:  'sun4v'
+    compatible: 'sun4v'
+    #address-cells:  00000002
+    #size-cells:  00000002
+
+    Node 0xf022cbfc
+        name:  'packages'
+
+        Node 0xf023a10c
+            builtin-drivers:  636c6173.73303130.38303200.6e766d65.00706369.65783130.38652c32.3138382e.31303865.2e300073.69627300.6962706f.72740069.62706f72.74007576.6e696300.75766e69.63007063.69313030.302c3730.00706369.31303030.2c373000.70636965.78313030.302c3732.00706369.31303030.2c373000.70636965.78313030.302c3732.2e313030.302e3732.00706369.31303030.2c373000.70636965.78313030.302c3837.2e313030.302e3837.00706369.31303030.2c373000.70636965.78313030.302c3732.2e313038.652e3632.37330070.63693130.30302c37.30007063.69657831.3030302c.39372e31.3030302e.39300070.63693130.30302c37.30007063.69657800.73756e34.762d7670.63690063.6c617373.30363034.30300063.6c617373.30363034.3030004f.52434c2c.6d34696f.732d7072.0073756e.34762d70.6572662d.636e7400.70636965.78383038.362c3135.32382e31.3038652e.34383438.006f7068.69720070.63696578.38303836.2c313531.352e3130.38652e34.38343800.6f706869.72007063.69657838.3038362c.31353231.2e313038.652e3762.3161006f.70686972.00706369.65783830.38362c31.3538362e.31303865.2e343835.3700666f.72747669.6c6c6500.70636965.78383038.362c3135.38362e31.3038652e.37623165.00666f72.7476696c.6c650070.63696578.38303836.2c313538.392e3130.38652e37.62316500.666f7274.76696c6c.65007063.69657838.3038362c.31353836.2e313038.652e3000.666f7274.76696c6c.65007063.69657838.3038362c.31353839.2e313038.652e3000.666f7274.76696c6c.65007063.69657838.3038362c.31353463.2e313038.652e3438.35370066.6f727476.696c6c65.2d766600.70636965.78383038.362c3135.34632e31.3038652e.3000666f.72747669.6c6c652d.76660070.63696578.31393132.2c313400.78686369.00706369.65783130.34632c38.32343100.78686369.00646576.69636500.75736264.65766963.65007573.622c636c.61737339.00687562.00757362.69662c63.6c617373.39006875.62007573.6269662c.636c6173.73332e31.2e310075.73626b62.64007573.6269662c.636c6173.73380075.73627374.6f726167.65007063.69316130.332c3230.30302e31.6130332e.32303030.00617374.2d677261.70686963.73007063.69313032.622c3532.322e3139.61322e31.3032006d.6174726f.782d6772.61706869.63730070.63696578.31303262.2c353232.2e313961.322e3130.32006d61.74726f78.2d677261.70686963.73007063.69657831.3032622c.35323200.6d617472.6f782d67.72617068.69637300
+            name:  'SUNW,builtin-drivers'
+
+        Node 0xf02626a0
+            lba64:  
+            disk-write-fix:  
+            name:  'deblocker'
+
+        Node 0xf0262d9c
+            gpt:  
+            supported-labels:  67707400.73756e00.6d627200
+            name:  'disk-label'
+
+        Node 0xf0265f80
+            iso6429-1983-colors:  
+            name:  'terminal-emulator'
+
+        Node 0xf0277424
+            source:  '/flashprom:'
+            name:  'dropins'
+
+        Node 0xf0278234
+            name:  'SUNW,asr'
+
+        Node 0xf027d42c
+            name:  'kbd-translator'
+
+        Node 0xf027eb60
+            name:  'obp-tftp'
+
+        Node 0xf028f534
+            name:  'vdisk-helper-pkg'
+
+        Node 0xf0295064
+            name:  'vnet-helper-pkg'
+
+        Node 0xf0357cf8
+            name:  'zfs-file-system'
+
+        Node 0xf035b604
+            name:  'hsfs-file-system'
+
+    Node 0xf022cc74
+        fs-package:  'hsfs-file-system'
+        whoami:  '/platform/sun4v/kernel/sparcv9/unix'
+        impl-arch-name:  'sun4v'
+        elfheader-length:  0033a000
+        elfheader-address:  50000000
+        archfs:  fedc95b8
+        archive-fstype:  'hsfs'
+        bootarchive:  '/ramdisk-root'
+        zfs-bootfs:  'rpool/40'
+        bootfs:  fedcbee0
+        fstype:  'zfs'
+        tboot-list:  'fallback-miniroot'
+        bootargs:  00
+        bootpath:  '/pci@302/pci@2/pci@0/pci@14/LSI,sas@0/disk@w5000cca02f026545,0:a'
+        openboot-reserved:  40000000
+        mmu:  fff04b38
+        memory:  fff04d48
+        stdout:  fee25cb8
+        stdin:  fee2d0e8
+        stdout-#lines:  ffffffff
+        name:  'chosen'
+        root-uuid-chk:  '1'
+        root-be-uuid:  'b0a4b044-696d-4f67-bf6f-92c71ec19deb'
+
+    Node 0xf022cce8
+        version: 'OBP 4.40.2.build_05 2016/05/05 13:41'
+        model:  'SUNW,4.40.2.build_05'
+        aligned-allocator:  
+        relative-addressing:  
+        name:  'openprom'
+
+        Node 0xf022cd78
+            name:  'client-services'
+
+    Node 0xf022ce30
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
+        auto-boot-on-error?:  'false'
+        load-base:  '16384'
+        auto-boot?:  'true'
+        os-root-device:  
+        network-boot-arguments:  
+        boot-command:  'boot'
+        boot-file:  
+        boot-device:  '/pci@302/pci@2/pci@0/pci@14/LSI,sas@0/disk@w5000cca02f026545,0:a'
+        multipath-boot?:  'false'
+        boot-device-index:  '0'
+        use-nvramrc?:  'true'
+        nvramrc:  64657661.6c696173.20686374.735f6469.736b202f.70636940.3330322f.70636940.322f7063.6940302f.70636940.31342f4c.53492c73.61734030.2f646973.6b407735.30303063.63613032.66303236.3534352c.303a610a.00
+        error-reset-recovery:  'boot'
+        name:  'options'
+
+    Node 0xf022cea8
+        fallback-miniroot:  '/pci@300/pci@1/pci@0/pci@2/usb@0/hub@2/storage@1/disk@0'
+        rcdrom:  '/pci@300/pci@1/pci@0/pci@2/usb@0/hub@2/storage@1/disk@0'
+        hcts_disk:  '/pci@302/pci@2/pci@0/pci@14/LSI,sas@0/disk@w5000cca02f026545,0:a'
+        disk7:  '/pci@302/pci@2/pci@0/pci@14/LSI,sas@0/disk@p4'
+        disk6:  '/pci@302/pci@2/pci@0/pci@14/LSI,sas@0/disk@p5'
+        disk5:  '/pci@302/pci@2/pci@0/pci@14/LSI,sas@0/disk@p7'
+        disk4:  '/pci@302/pci@2/pci@0/pci@14/LSI,sas@0/disk@p6'
+        disk3:  '/pci@302/pci@2/pci@0/pci@14/LSI,sas@0/disk@p0'
+        disk2:  '/pci@302/pci@2/pci@0/pci@14/LSI,sas@0/disk@p1'
+        disk1:  '/pci@302/pci@2/pci@0/pci@14/LSI,sas@0/disk@p3'
+        disk:  '/pci@302/pci@2/pci@0/pci@14/LSI,sas@0/disk@p2'
+        disk0:  '/pci@302/pci@2/pci@0/pci@14/LSI,sas@0/disk@p2'
+        sas0:  '/pci@302/pci@2/pci@0/pci@14/LSI,sas@0'
+        sas:  '/pci@302/pci@2/pci@0/pci@14/LSI,sas@0'
+        nvme3:  '/pci@302/pci@2/pci@0/pci@7/nvme@0/disk@1'
+        nvme2:  '/pci@302/pci@2/pci@0/pci@6/nvme@0/disk@1'
+        nvme1:  '/pci@300/pci@2/pci@0/pci@5/nvme@0/disk@1'
+        nvme0:  '/pci@300/pci@2/pci@0/pci@4/nvme@0/disk@1'
+        net3:  '/pci@300/pci@1/pci@0/pci@1/network@0,3'
+        net2:  '/pci@300/pci@1/pci@0/pci@1/network@0,2'
+        net1:  '/pci@300/pci@1/pci@0/pci@1/network@0,1'
+        net:  '/pci@300/pci@1/pci@0/pci@1/network@0'
+        net0:  '/pci@300/pci@1/pci@0/pci@1/network@0'
+        virtual-console:  '/virtual-devices/console@1'
+        name:  'aliases'
+
+    Node 0xf0240efc
+        reg:  00000000.50000000.0000001f.a0000000.00004000.00000000.0000001f.f0000000
+        available:  0000401f.e91f0000.00000000.0028e000.0000401f.e0000000.00000000.090a0000.00004000.00000000.0000001f.c0000000.00000000.90000000.0000001f.60000000.00000000.8fdb6000.00000000.00002000.00000000.50400000.00000000.3f9b4000
+        name:  'memory'
+
+    Node 0xf0241508
+        translations:  00000000.00002000.00000000.009fe000.80000000.50402540.00000000.00a00000.00000000.00580000.8000401f.ef198540.00000000.01402000.00000000.0006c000.8000401f.e9182540.00000000.10000000.00000000.10000000.8000401f.d0000540.00000000.20000000.00000000.10000000.8000401f.c0000540.00000000.51000000.00000000.05c4e000.8000401f.e954a540.00000000.f0000000.00000000.00400000.80000000.50000550.00000000.f0400000.00000000.00760000.8000401f.ef730550.00000000.febd8000.00000000.0008a000.8000401f.e947e550.00000000.fec62000.00000000.00018000.8000401f.e950a550.00000000.fec7a000.00000000.00060000.8000401f.e90a0550.00000000.fecda000.00000000.00040000.80020201.20040950.00000000.fed1a000.00000000.0000a000.8000401f.effda550.00000000.fed24000.00000000.00002000.8000401f.e9508550.00000000.fed26000.00000000.00010000.8000401f.e9522550.00000000.fed36000.00000000.00018000.8000401f.ef718550.00000000.fed4e000.00000000.0000c000.8000401f.efe90550.00000000.fed5a000.00000000.00010000.80020201.20000950.00000000.fed6a000.00000000.00068000.8000401f.efea2550.00000000.fedd2000.00000000.00004000.8000401f.effc0550.00000000.fedd6000.00000000.00036000.8000401f.eff0a550.00000000.fee0c000.00000000.00012000.8000401f.effc4550.00000000.fee1e000.00000000.00002000.80020001.10000950.00000000.fee20000.00000000.00004000.8000401f.effd6550.00000000.fee24000.00000000.0000c000.8000401f.effe4550.00000000.fee30000.00000000.00080000.8000401f.eff40550.00000000.feeb0000.00000000.0000a000.8000401f.efff0550.00000000.feeba000.00000000.00004000.8000401f.efffc550.00000000.feebe000.00000000.00002000.80000000.8fdb4550.00000000.feec0000.00000000.00002000.8000401f.efffa550.00000000.feec2000.00000000.00006000.80000000.8fdb8550.00000000.feecc000.00000000.00002000.80000000.8fdbe550.00000000.feece000.00000000.00114000.80000000.8fec0550.00000000.fefe2000.00000000.0001e000.80000000.8ffda550.00000000.fff00000.00000000.00010000.80000000.501f0550
+        existing:  00000000.00000000.00000800.00000000.fffff800.00000000.00000800.00000000
+        available:  fffff800.00000000.000007fc.00000000.00000001.00000000.000007ff.00000000.00000000.ffff0000.00000000.0000e000.00000000.56c4e000.00000000.993b2000.00000000.30000000.00000000.21000000.00000000.0146e000.00000000.0eb92000.00000000.00f80000.00000000.00482000.00000000.00000000.00000000.00a00000.00000000.f2200000.00000000.0c9d8000
+        page-size:  00002000
+        name:  'virtual-memory'
+
+    Node 0xf026e3dc
+        compatible: 'SUNW,iscsi-hba'
+        name:  'iscsi-hba'
+
+        Node 0xf0275b34
+            lba64:  
+            device_type:  'block'
+            compatible: 'sd'
+            name:  'disk'
+
+    Node 0xf0276e50
+        reg:  c0000000.00000000.00000000.00000000
+        device_type:  'block'
+        name:  'reboot-memory'
+
+    Node 0xf029b084
+        interrupt-map:  00000001.00000001.f029b084.00000011
+        interrupt-map-mask:  0000001f.00ffffff.00000003
+        #interrupt-cells:  00000001
+        reg:  c0000100.00000000.00000000.00000000
+        #address-cells:  00000001
+        #size-cells:  00000000
+        device_type:  'virtual-devices'
+        compatible: 'SUNW,sun4v-virtual-devices' + 'SUNW,virtual-devices'
+        name:  'virtual-devices'
+
+        Node 0xf029c16c
+            name:  'flashprom'
+            reg:  00000000
+
+        Node 0xf029c740
+            rng-#units:  00000002
+            compatible: 'ORCL,m7-rng'
+            reg:  0000000e
+            name:  'random-number-generator'
+
+        Node 0xf029cdc4
+            #interrupts:  0000003f
+            compatible: 'ORCL,sun4v-dax'
+            reg:  0000000a
+            name:  'dax'
+
+        Node 0xf029d234
+            reg:  00000001
+            device_type:  'serial'
+            compatible: 'SUNW,sun4v-console'
+            name:  'console'
+            interrupts:  00000001
+
+        Node 0xf029db0c
+            #address-cells:  00000001
+            #size-cells:  00000000
+            reg:  00000200
+            compatible: 'SUNW,sun4v-channel-devices'
+            device_type:  'channel-devices'
+            name:  'channel-devices'
+
+            Node 0xf029e9ec
+                compatible: 'SUNW,sun4v-channel'
+                reg:  00000000
+                name:  'virtual-channel'
+
+            Node 0xf029eac0
+                compatible: 'SUNW,sun4v-channel'
+                reg:  00000003
+                name:  'virtual-channel'
+
+            Node 0xf029eb94
+                compatible: 'SUNW,sun4v-channel'
+                reg:  00000001
+                name:  'virtual-channel-client'
+
+            Node 0xf029ec6c
+                compatible: 'SUNW,sun4v-channel'
+                reg:  00000002
+                name:  'virtual-channel-client'
+
+            Node 0xf029ed44
+                compatible: 'SUNW,sun4v-pciv-comm'
+                reg:  00000000
+                name:  'pciv-communication'
+
+            Node 0xf029ee18
+                compatible: 'SUNW,sun4v-domain-service'
+                reg:  00000000
+                name:  'virtual-domain-service'
+
+    Node 0xf029f038
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000000.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f1a4
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000001.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f310
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000002.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f47c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000003.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f5e8
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000004.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f754
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000005.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f8c0
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000006.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029fa2c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000007.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029fb98
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000008.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029fd04
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000009.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029fe70
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000000a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029ffdc
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000000b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0148
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000000c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a02b4
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000000d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0420
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000000e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a058c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000000f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a06f8
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000010.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0864
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000011.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a09d0
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000012.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0b3c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000013.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0ca8
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000014.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0e14
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000015.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0f80
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000016.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a10ec
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000017.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1258
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000018.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a13c4
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000019.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1530
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000001a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a169c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000001b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1808
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000001c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1974
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000001d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1ae0
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000001e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1c4c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000001f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1db8
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000020.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1f24
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000021.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2090
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000022.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a21fc
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000023.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2368
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000024.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a24d4
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000025.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2640
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000026.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a27ac
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000027.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2918
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000028.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2a84
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000029.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2bf0
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000002a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2d5c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000002b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2ec8
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000002c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3034
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000002d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a31a0
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000002e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a330c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000002f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3478
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000030.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a35e4
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000031.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3750
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000032.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a38bc
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000033.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3a28
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000034.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3b94
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000035.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3d00
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000036.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3e6c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000037.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3fd8
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000038.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4144
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000039.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a42b0
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000003a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a441c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000003b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4588
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000003c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a46f4
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000003d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4860
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000003e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a49cc
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000003f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4b38
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000040.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4ca4
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000041.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4e10
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000042.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4f7c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000043.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a50e8
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000044.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5254
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000045.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a53c0
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000046.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a552c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000047.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5698
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000048.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5804
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000049.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5970
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000004a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5adc
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000004b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5c48
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000004c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5db4
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000004d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5f20
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000004e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a608c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000004f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a61f8
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000050.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a6364
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000051.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a64d0
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000052.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a663c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000053.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a67a8
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000054.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a6914
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000055.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a6a80
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000056.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a6bec
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000057.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a6d58
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000058.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a6ec4
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000059.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7030
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000005a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a719c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000005b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7308
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000005c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7474
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000005d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a75e0
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000005e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a774c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000005f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a78b8
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000060.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7a24
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000061.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7b90
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000062.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7cfc
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000063.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7e68
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000064.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7fd4
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000065.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a8140
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000066.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a82ac
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000067.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a8418
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000068.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a8584
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000069.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a86f0
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000006a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a885c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000006b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a89c8
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000006c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a8b34
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000006d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a8ca0
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000006e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a8e0c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000006f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a8f78
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000070.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a90e4
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000071.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9250
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000072.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a93bc
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000073.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9528
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000074.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9694
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000075.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9800
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000076.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a996c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000077.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9ad8
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000078.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9c44
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000079.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9db0
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000007a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9f1c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000007b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aa088
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000007c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aa1f4
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000007d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aa360
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000007e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aa4cc
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-S7' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000007f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aa63c
+        interrupt-map:  00000800.00000000.00000000.00000001.f02aa63c.00000002.00000800.00000000.00000000.00000002.f02aa63c.00000003.00000800.00000000.00000000.00000003.f02aa63c.00000004.00000800.00000000.00000000.00000004.f02aa63c.00000001.00001000.00000000.00000000.00000001.f02aa63c.00000003.00001000.00000000.00000000.00000002.f02aa63c.00000004.00001000.00000000.00000000.00000003.f02aa63c.00000001.00001000.00000000.00000000.00000004.f02aa63c.00000002
+        interrupt-map-mask:  00fff800.00000000.00000000.00000007
+        #interrupt-cells:  00000001
+        interrupts:  0000003f.0000003e
+        available:  81000000.00000000.02000000.00000000.0e000000.82000000.00000000.10300000.00000000.6ed00000.c3000000.00000001.40000000.0000000c.c0000000
+        level1-hotplug-slot-count:  00000005
+        level2-hotplug-slot-count:  00000006
+        ranges:  01000000.00000000.00000000.8002007e.00000000.00000000.10000000.02000000.00000000.00100000.80020000.00100000.00000000.7ef00000.03000000.00000001.00000000.80020001.00000000.0000000d.00000000
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
+        available-bus-range:  00000000.000000ff
+        bus-range:  00000000.00000061
+        bus-parity-generated:  
+        #address-cells:  00000003
+        #size-cells:  00000002
+        name:  'pci'
+        compatible: 'SUNW,sun4v-pci'
+        device_type:  'pciex'
+        virtual-dma:  80000000.80000000
+
+        Node 0xf02c888c
+            ranges:  82000000.00000000.00100000.82000000.00000000.00100000.00000000.00200000.c3000000.00000001.00000000.c3000000.00000001.00000000.00000000.20000000
+            bus-range:  00000001.00000004
+            compatible: 'pciex108e,828e.1' + 'pciex108e,828e' + 'pciexclass,060400' + 'pciexclass,0604'
+            reg:  00000800.00000000.00000000.00000000.00000000
+            #address-cells:  00000003
+            #size-cells:  00000002
+            device_type:  'pciex'
+            name:  'pci'
+            port-type:  'Root-Port'
+            cache-line-size:  00000000
+            class-code:  00060400
+            revision-id:  00000001
+            device-id:  0000828e
+            vendor-id:  0000108e
+
+            Node 0xf02cb5b4
+                ranges:  82000000.00000000.00100000.82000000.00000000.00100000.00000000.00200000.c3000000.00000001.00000000.c3000000.00000001.00000000.00000000.20000000
+                bus-range:  00000002.00000004
+                compatible: 'pciex111d,80ba.3' + 'pciex111d,80ba' + 'pciexclass,060400' + 'pciexclass,0604'
+                reg:  00010000.00000000.00000000.00000000.00000000
+                #address-cells:  00000003
+                #size-cells:  00000002
+                device_type:  'pciex'
+                name:  'pci'
+                port-type:  'Upstream-Port'
+                cache-line-size:  00000010
+                class-code:  00060400
+                revision-id:  00000003
+                device-id:  000080ba
+                vendor-id:  0000111d
+
+                Node 0xf02ce2e0
+                    available:  c3000000.00000001.00fa0000.00000000.00060000.c3000000.00000001.02a80000.00000000.0d580000
+                    ranges:  82000000.00000000.00100000.82000000.00000000.00100000.00000000.00200000.c3000000.00000001.00000000.c3000000.00000001.00000000.00000000.10000000
+                    bus-range:  00000003.00000003
+                    ari-enabled:  
+                    compatible: 'pciex111d,80ba.3' + 'pciex111d,80ba' + 'pciexclass,060400' + 'pciexclass,0604'
+                    reg:  00020800.00000000.00000000.00000000.00000000
+                    #address-cells:  00000003
+                    #size-cells:  00000002
+                    device_type:  'pciex'
+                    name:  'pci'
+                    port-type:  'Downstream-Port'
+                    cache-line-size:  00000010
+                    class-code:  00060400
+                    revision-id:  00000003
+                    device-id:  000080ba
+                    vendor-id:  0000111d
+
+                    Node 0xf02d1030
+                        local-mac-address:  0010e0b2.b52a
+                        mac-addresses:  0010e0b2.b52a
+                        vf-assigned-addresses:  c3030000.00000001.00810000.00000000.00010000.c3030003.00000001.00a10000.00000000.00004000
+                        assigned-addresses:  c3030010.00000001.00000000.00000000.00800000.c303001c.00000001.00800000.00000000.00008000.82030030.00000000.00100000.00000000.00080000
+                        vf-reg:  43030000.00000000.00000000.00000000.00010000.43030003.00000000.00000000.00000000.00004000
+                        reg:  00030000.00000000.00000000.00000000.00000000.43030010.00000000.00000000.00000000.00800000.4303001c.00000000.00000000.00000000.00008000.02030030.00000000.00000000.00000000.00080000
+                        compatible: 'pciex8086,1589.108e.7b1e.2' + 'pciex8086,1589.108e.7b1e' + 'pciex8086,1589.2' + 'pciex8086,1589' + 'pciexclass,020000' + 'pciexclass,0200'
+                        address-bits:  00000030
+                        max-frame-size:  00002400
+                        device_type:  'network'
+                        name:  'network'
+                        vf-stride:  00000001
+                        first-vf-offset:  00000010
+                        total-vfs:  00000020
+                        initial-vfs:  00000020
+                        #vfs:  00000020
+                        port-type:  'PCIE-Endpoint'
+                        interrupts:  00000001
+                        cache-line-size:  00000010
+                        class-code:  00020000
+                        subsystem-id:  00007b1e
+                        subsystem-vendor-id:  0000108e
+                        revision-id:  00000002
+                        device-id:  00001589
+                        vendor-id:  00008086
+
+                    Node 0xf02dcf1c
+                        local-mac-address:  0010e0b2.b52b
+                        mac-addresses:  0010e0b2.b52b
+                        vf-assigned-addresses:  c3030100.00000001.00a90000.00000000.00010000.c3030103.00000001.00c90000.00000000.00004000
+                        assigned-addresses:  c3030110.00000001.01000000.00000000.00800000.c303011c.00000001.00808000.00000000.00008000.82030130.00000000.00180000.00000000.00080000
+                        vf-reg:  43030100.00000000.00000000.00000000.00010000.43030103.00000000.00000000.00000000.00004000
+                        reg:  00030100.00000000.00000000.00000000.00000000.43030110.00000000.00000000.00000000.00800000.4303011c.00000000.00000000.00000000.00008000.02030130.00000000.00000000.00000000.00080000
+                        compatible: 'pciex8086,1589.108e.0.2' + 'pciex8086,1589.108e.0' + 'pciex8086,1589.2' + 'pciex8086,1589' + 'pciexclass,020000' + 'pciexclass,0200'
+                        address-bits:  00000030
+                        max-frame-size:  00002400
+                        device_type:  'network'
+                        name:  'network'
+                        vf-stride:  00000001
+                        first-vf-offset:  0000002f
+                        total-vfs:  00000020
+                        initial-vfs:  00000020
+                        #vfs:  00000020
+                        port-type:  'PCIE-Endpoint'
+                        interrupts:  00000002
+                        cache-line-size:  00000010
+                        class-code:  00020000
+                        subsystem-vendor-id:  0000108e
+                        revision-id:  00000002
+                        device-id:  00001589
+                        vendor-id:  00008086
+
+                    Node 0xf02e8dd0
+                        local-mac-address:  0010e0b2.b52c
+                        mac-addresses:  0010e0b2.b52c
+                        vf-assigned-addresses:  c3030200.00000001.00d20000.00000000.00010000.c3030203.00000001.00f20000.00000000.00004000
+                        assigned-addresses:  c3030210.00000001.01800000.00000000.00800000.c303021c.00000001.00d10000.00000000.00008000.82030230.00000000.00200000.00000000.00080000
+                        vf-reg:  43030200.00000000.00000000.00000000.00010000.43030203.00000000.00000000.00000000.00004000
+                        reg:  00030200.00000000.00000000.00000000.00000000.43030210.00000000.00000000.00000000.00800000.4303021c.00000000.00000000.00000000.00008000.02030230.00000000.00000000.00000000.00080000
+                        compatible: 'pciex8086,1589.108e.0.2' + 'pciex8086,1589.108e.0' + 'pciex8086,1589.2' + 'pciex8086,1589' + 'pciexclass,020000' + 'pciexclass,0200'
+                        address-bits:  00000030
+                        max-frame-size:  00002400
+                        device_type:  'network'
+                        name:  'network'
+                        vf-stride:  00000001
+                        first-vf-offset:  0000004e
+                        total-vfs:  00000020
+                        initial-vfs:  00000020
+                        #vfs:  00000020
+                        port-type:  'PCIE-Endpoint'
+                        interrupts:  00000003
+                        cache-line-size:  00000010
+                        class-code:  00020000
+                        subsystem-vendor-id:  0000108e
+                        revision-id:  00000002
+                        device-id:  00001589
+                        vendor-id:  00008086
+
+                    Node 0xf02f4c84
+                        local-mac-address:  0010e0b2.b52d
+                        mac-addresses:  0010e0b2.b52d
+                        vf-assigned-addresses:  c3030300.00000001.02800000.00000000.00010000.c3030303.00000001.02a00000.00000000.00004000
+                        assigned-addresses:  c3030310.00000001.02000000.00000000.00800000.c303031c.00000001.00d18000.00000000.00008000.82030330.00000000.00280000.00000000.00080000
+                        vf-reg:  43030300.00000000.00000000.00000000.00010000.43030303.00000000.00000000.00000000.00004000
+                        reg:  00030300.00000000.00000000.00000000.00000000.43030310.00000000.00000000.00000000.00800000.4303031c.00000000.00000000.00000000.00008000.02030330.00000000.00000000.00000000.00080000
+                        compatible: 'pciex8086,1589.108e.0.2' + 'pciex8086,1589.108e.0' + 'pciex8086,1589.2' + 'pciex8086,1589' + 'pciexclass,020000' + 'pciexclass,0200'
+                        address-bits:  00000030
+                        max-frame-size:  00002400
+                        device_type:  'network'
+                        name:  'network'
+                        vf-stride:  00000001
+                        first-vf-offset:  0000006d
+                        total-vfs:  00000020
+                        initial-vfs:  00000020
+                        #vfs:  00000020
+                        port-type:  'PCIE-Endpoint'
+                        interrupts:  00000004
+                        cache-line-size:  00000010
+                        class-code:  00020000
+                        subsystem-vendor-id:  0000108e
+                        revision-id:  00000002
+                        device-id:  00001589
+                        vendor-id:  00008086
+
+                Node 0xf0300c3c
+                    available:  c3000000.00000001.10012000.00000000.0ffee000
+                    ranges:  c3000000.00000001.10000000.c3000000.00000001.10000000.00000000.10000000
+                    bus-range:  00000004.00000004
+                    compatible: 'pciex111d,80ba.3' + 'pciex111d,80ba' + 'pciexclass,060400' + 'pciexclass,0604'
+                    reg:  00021000.00000000.00000000.00000000.00000000
+                    #address-cells:  00000003
+                    #size-cells:  00000002
+                    device_type:  'pciex'
+                    name:  'pci'
+                    port-type:  'Downstream-Port'
+                    cache-line-size:  00000010
+                    class-code:  00060400
+                    revision-id:  00000003
+                    device-id:  000080ba
+                    vendor-id:  0000111d
+
+                    Node 0xf030396c
+                        assigned-addresses:  83040010.00000001.10000000.00000000.00010000.83040018.00000001.10010000.00000000.00002000
+                        device_type:  'xchi'
+                        reg:  00040000.00000000.00000000.00000000.00000000.03040010.00000000.00000000.00000000.00002000
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
+                        Node 0xf034a0b4
+                            device_type:  'usb_hub'
+                            configuration#:  00000001
+                            intr-in-size:  00000002
+                            intr-in-interval:  00000008
+                            intr-in-pipe:  00000001
+                            serial$:  00
+                            device$:  00
+                            vendor$:  00
+                            compatible: 'usb451,8046.100' + 'usb451,8046' + 'usb451,class9.0.3' + 'usb451,class9.0' + 'usb451,class9' + 'usb,class9.0.3' + 'usb,class9.0' + 'usb,class9' + 'usb,device'
+                            vendor-id:  00000451
+                            device-id:  00008046
+                            release:  00000100
+                            name:  'hub'
+                            class:  00000009
+                            subclass:  00000000
+                            protocol:  00000003
+                            ultra-speed:  00
+                            assigned-address:  00000001
+                            reg:  00000004
+                            #size-cells:  00000000
+                            #address-cells:  00000001
+
+                        Node 0xf034afcc
+                            device_type:  'scsi-usb'
+                            configuration#:  00000001
+                            bulk-out-size:  00000200
+                            bulk-out-pipe:  00000002
+                            bulk-in-size:  00000200
+                            bulk-in-pipe:  00000001
+                            serial$:  '14F0022700947623'
+                            device$:  'Real SSD eUSB 2GB'
+                            vendor$:  'Micron Technology'
+                            compatible: 'usb634,1270.1112' + 'usb634,1270' + 'usbif634,class8.6.50' + 'usbif634,class8.6' + 'usbif634,class8' + 'usbif,class8.6.50' + 'usbif,class8.6' + 'usbif,class8' + 'usb,device'
+                            vendor-id:  00000634
+                            device-id:  00001270
+                            release:  00001112
+                            name:  'storage'
+                            class:  00000008
+                            subclass:  00000006
+                            protocol:  00000050
+                            high-speed:  00
+                            assigned-address:  00000002
+                            reg:  00000001
+                            #size-cells:  00000000
+                            #address-cells:  00000002
+
+                            Node 0xf034e128
+                                compatible: 'sd' + 'disk'
+                                device_type:  'block'
+                                name:  'disk'
+
+                        Node 0xf034ec7c
+                            hub20-dev:  00000003
+                            device_type:  'usb_hub'
+                            configuration#:  00000001
+                            intr-in-size:  00000001
+                            intr-in-interval:  0000000c
+                            intr-in-pipe:  00000001
+                            serial$:  'AB0D1079D416'
+                            device$:  00
+                            vendor$:  00
+                            compatible: 'usb451,8044.100' + 'usb451,8044' + 'usb451,class9.0.2' + 'usb451,class9.0' + 'usb451,class9' + 'usb,class9.0.2' + 'usb,class9.0' + 'usb,class9' + 'usb,device'
+                            vendor-id:  00000451
+                            device-id:  00008044
+                            release:  00000100
+                            name:  'hub'
+                            class:  00000009
+                            subclass:  00000000
+                            protocol:  00000002
+                            high-speed:  00
+                            assigned-address:  00000003
+                            reg:  00000002
+                            #size-cells:  00000000
+                            #address-cells:  00000001
+
+                            Node 0xf034fbc0
+                                device_type:  'scsi-usb'
+                                configuration#:  00000001
+                                bulk-out-size:  00000200
+                                bulk-out-pipe:  00000004
+                                bulk-in-size:  00000200
+                                bulk-in-pipe:  00000003
+                                serial$:  '01230123011'
+                                device$:  'P3rS  '
+                                vendor$:  'Oracle'
+                                compatible: 'usb430,a103.200' + 'usb430,a103' + 'usbif430,class8.6.50' + 'usbif430,class8.6' + 'usbif430,class8' + 'usbif,class8.6.50' + 'usbif,class8.6' + 'usbif,class8' + 'usb,device'
+                                vendor-id:  00000430
+                                device-id:  0000a103
+                                release:  00000200
+                                name:  'storage'
+                                class:  00000008
+                                subclass:  00000006
+                                protocol:  00000050
+                                high-speed:  00
+                                assigned-address:  00000004
+                                reg:  00000001
+                                #size-cells:  00000000
+                                #address-cells:  00000002
+
+                                Node 0xf0352cfc
+                                    compatible: 'sd' + 'disk'
+                                    device_type:  'block'
+                                    name:  'disk'
+
+                            Node 0xf0353850
+                                device_type:  'usb_device'
+                                reg:  00000002
+                                #size-cells:  00000000
+                                #address-cells:  00000002
+                                compatible: 'usbdevice'
+                                name:  'device'
+
+                                Node 0xf035439c
+                                    configuration#:  00000001
+                                    intr-in-size:  00000008
+                                    intr-in-interval:  00000001
+                                    intr-in-pipe:  00000001
+                                    serial$:  00
+                                    device$:  56697274.75616c20.45746820.44657669.63650000
+                                    vendor$:  53756e4d.6963726f.0000
+                                    compatible: 'usb430,a4a2.100' + 'usb430,a4a2' + 'usb430,class2.0.0' + 'usb430,class2.0' + 'usb430,class2' + 'usb,class2.0.0' + 'usb,class2.0' + 'usb,class2' + 'usb,device'
+                                    vendor-id:  00000430
+                                    device-id:  0000a4a2
+                                    release:  00000100
+                                    name:  'network'
+                                    class:  00000002
+                                    subclass:  00000000
+                                    protocol:  00000000
+                                    full-speed:  00
+                                    assigned-address:  00000005
+                                    reg:  00000000.00000000
+
+                                Node 0xf035470c
+                                    configuration#:  00000001
+                                    bulk-in-size:  00000040
+                                    bulk-in-pipe:  00000003
+                                    bulk-out-size:  00000040
+                                    bulk-out-pipe:  00000002
+                                    serial$:  00
+                                    device$:  56697274.75616c20.45746820.44657669.63650000
+                                    vendor$:  53756e4d.6963726f.0000
+                                    compatible: 'usb430,a4a2.100' + 'usb430,a4a2' + 'usb430,class2.0.0' + 'usb430,class2.0' + 'usb430,class2' + 'usb,class2.0.0' + 'usb,class2.0' + 'usb,class2' + 'usb,device'
+                                    vendor-id:  00000430
+                                    device-id:  0000a4a2
+                                    release:  00000100
+                                    name:  'network'
+                                    class:  00000002
+                                    subclass:  00000000
+                                    protocol:  00000000
+                                    full-speed:  00
+                                    assigned-address:  00000005
+                                    reg:  00000001.00000000
+
+        Node 0xf0310e44
+            ranges:  81000000.00000000.00000000.81000000.00000000.00000000.00000000.02000000.82000000.00000000.00300000.82000000.00000000.00300000.00000000.10000000.c3000000.00000001.20000000.c3000000.00000001.20000000.00000000.20000000
+            bus-range:  00000005.00000061
+            compatible: 'pciex108e,828e.1' + 'pciex108e,828e' + 'pciexclass,060400' + 'pciexclass,0604'
+            reg:  00001000.00000000.00000000.00000000.00000000
+            #address-cells:  00000003
+            #size-cells:  00000002
+            device_type:  'pciex'
+            name:  'pci'
+            port-type:  'Root-Port'
+            cache-line-size:  00000000
+            class-code:  00060400
+            revision-id:  00000001
+            device-id:  0000828e
+            vendor-id:  0000108e
+
+            Node 0xf0313b6c
+                ranges:  81000000.00000000.00000000.81000000.00000000.00000000.00000000.02000000.82000000.00000000.00300000.82000000.00000000.00300000.00000000.10000000.c3000000.00000001.20000000.c3000000.00000001.20000000.00000000.20000000
+                bus-range:  00000006.00000061
+                compatible: 'pciex111d,80ba.3' + 'pciex111d,80ba' + 'pciexclass,060400' + 'pciexclass,0604'
+                reg:  00050000.00000000.00000000.00000000.00000000
+                #address-cells:  00000003
+                #size-cells:  00000002
+                device_type:  'pciex'
+                name:  'pci'
+                port-type:  'Upstream-Port'
+                cache-line-size:  00000010
+                class-code:  00060400
+                revision-id:  00000003
+                device-id:  000080ba
+                vendor-id:  0000111d
+
+                Node 0xf0316898
+                    slot-names:  00000001.2f535953.2f444250.2f4e564d.453000
+                    available:  81000000.00000000.00000000.00000000.01000000.82000000.00000000.00300000.00000000.08000000.c3000000.00000001.20000000.00000000.10000000
+                    ranges:  81000000.00000000.00000000.81000000.00000000.00000000.00000000.01000000.82000000.00000000.00300000.82000000.00000000.00300000.00000000.08000000.c3000000.00000001.20000000.c3000000.00000001.20000000.00000000.10000000
+                    bus-range:  00000007.00000033
+                    slot-implemented?:  
+                    hotplug-capable:  
+                    compatible: 'pciex111d,80ba.108e.4268.3' + 'pciex111d,80ba.108e.4268' + 'pciex111d,80ba.3' + 'pciex111d,80ba' + 'pciexclass,060400' + 'pciexclass,0604'
+                    reg:  00062000.00000000.00000000.00000000.00000000
+                    physical-slot#:  00000000
+                    #address-cells:  00000003
+                    #size-cells:  00000002
+                    device_type:  'pciex'
+                    name:  'pci'
+                    port-type:  'Downstream-Port'
+                    cache-line-size:  00000010
+                    class-code:  00060400
+                    subsystem-vendor-id:  0000108e
+                    subsystem-id:  00004268
+                    revision-id:  00000003
+                    device-id:  000080ba
+                    vendor-id:  0000111d
+
+                Node 0xf03197fc
+                    slot-names:  00000001.2f535953.2f444250.2f4e564d.453100
+                    available:  81000000.00000000.01000000.00000000.01000000.82000000.00000000.08300000.00000000.08000000.c3000000.00000001.30000000.00000000.10000000
+                    ranges:  81000000.00000000.01000000.81000000.00000000.01000000.00000000.01000000.82000000.00000000.08300000.82000000.00000000.08300000.00000000.08000000.c3000000.00000001.30000000.c3000000.00000001.30000000.00000000.10000000
+                    bus-range:  00000034.00000060
+                    slot-implemented?:  
+                    hotplug-capable:  
+                    compatible: 'pciex111d,80ba.108e.4268.3' + 'pciex111d,80ba.108e.4268' + 'pciex111d,80ba.3' + 'pciex111d,80ba' + 'pciexclass,060400' + 'pciexclass,0604'
+                    reg:  00062800.00000000.00000000.00000000.00000000
+                    physical-slot#:  00000000
+                    #address-cells:  00000003
+                    #size-cells:  00000002
+                    device_type:  'pciex'
+                    name:  'pci'
+                    port-type:  'Downstream-Port'
+                    cache-line-size:  00000010
+                    class-code:  00060400
+                    subsystem-vendor-id:  0000108e
+                    subsystem-id:  00004268
+                    revision-id:  00000003
+                    device-id:  000080ba
+                    vendor-id:  0000111d
+
+                Node 0xf031c760
+                    slot-names:  00000001.2f535953.2f4d422f.52495345.52332f50.43494533.00
+                    bus-range:  00000061.00000061
+                    slot-implemented?:  
+                    compatible: 'pciex111d,80ba.3' + 'pciex111d,80ba' + 'pciexclass,060400' + 'pciexclass,0604'
+                    reg:  00069800.00000000.00000000.00000000.00000000
+                    physical-slot#:  00000003
+                    #address-cells:  00000003
+                    #size-cells:  00000002
+                    device_type:  'pciex'
+                    name:  'pci'
+                    port-type:  'Downstream-Port'
+                    cache-line-size:  00000010
+                    class-code:  00060400
+                    revision-id:  00000003
+                    device-id:  000080ba
+                    vendor-id:  0000111d
+
+    Node 0xf02b9704
+        interrupt-map:  00000800.00000000.00000000.00000001.f02b9704.00000002.00000800.00000000.00000000.00000002.f02b9704.00000003.00000800.00000000.00000000.00000003.f02b9704.00000004.00000800.00000000.00000000.00000004.f02b9704.00000001.00001000.00000000.00000000.00000001.f02b9704.00000003.00001000.00000000.00000000.00000002.f02b9704.00000004.00001000.00000000.00000000.00000003.f02b9704.00000001.00001000.00000000.00000000.00000004.f02b9704.00000002
+        interrupt-map-mask:  00fff800.00000000.00000000.00000007
+        #interrupt-cells:  00000001
+        interrupts:  0000003f.0000003e
+        available:  81000000.00000000.02001000.00000000.0dfff000.82000000.00000000.10200000.00000000.6ee00000.c3000000.00000001.30000000.0000000c.d0000000
+        level1-hotplug-slot-count:  00000005
+        level2-hotplug-slot-count:  00000006
+        ranges:  01000000.00000000.00000000.8002027e.00000000.00000000.10000000.02000000.00000000.00100000.80020200.00100000.00000000.7ef00000.03000000.00000001.00000000.80020201.00000000.0000000d.00000000
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
+        pcie-ber-factor:  00000064
+        available-bus-range:  00000000.000000ff
+        bus-range:  00000000.00000061
+        bus-parity-generated:  
+        #address-cells:  00000003
+        #size-cells:  00000002
+        name:  'pci'
+        compatible: 'SUNW,sun4v-pci'
+        device_type:  'pciex'
+        virtual-dma:  80000000.80000000
+
+        Node 0xf031f7c4
+            bus-range:  00000001.00000004
+            compatible: 'pciex108e,828e.1' + 'pciex108e,828e' + 'pciexclass,060400' + 'pciexclass,0604'
+            reg:  00000800.00000000.00000000.00000000.00000000
+            #address-cells:  00000003
+            #size-cells:  00000002
+            device_type:  'pciex'
+            name:  'pci'
+            port-type:  'Root-Port'
+            cache-line-size:  00000000
+            class-code:  00060400
+            revision-id:  00000001
+            device-id:  0000828e
+            vendor-id:  0000108e
+
+            Node 0xf03224ec
+                bus-range:  00000002.00000004
+                compatible: 'pciex111d,80ba.3' + 'pciex111d,80ba' + 'pciexclass,060400' + 'pciexclass,0604'
+                reg:  00010000.00000000.00000000.00000000.00000000
+                #address-cells:  00000003
+                #size-cells:  00000002
+                device_type:  'pciex'
+                name:  'pci'
+                port-type:  'Upstream-Port'
+                cache-line-size:  00000010
+                class-code:  00060400
+                revision-id:  00000003
+                device-id:  000080ba
+                vendor-id:  0000111d
+
+                Node 0xf0325218
+                    slot-names:  00000001.2f535953.2f4d422f.52495345.52312f50.43494531.00
+                    bus-range:  00000003.00000003
+                    slot-implemented?:  
+                    compatible: 'pciex111d,80ba.3' + 'pciex111d,80ba' + 'pciexclass,060400' + 'pciexclass,0604'
+                    reg:  00028800.00000000.00000000.00000000.00000000
+                    physical-slot#:  00000001
+                    #address-cells:  00000003
+                    #size-cells:  00000002
+                    device_type:  'pciex'
+                    name:  'pci'
+                    port-type:  'Downstream-Port'
+                    cache-line-size:  00000010
+                    class-code:  00060400
+                    revision-id:  00000003
+                    device-id:  000080ba
+                    vendor-id:  0000111d
+
+                Node 0xf0327ff8
+                    slot-names:  00000001.2f535953.2f4d422f.52495345.52322f50.43494532.00
+                    bus-range:  00000004.00000004
+                    slot-implemented?:  
+                    compatible: 'pciex111d,80ba.3' + 'pciex111d,80ba' + 'pciexclass,060400' + 'pciexclass,0604'
+                    reg:  00029000.00000000.00000000.00000000.00000000
+                    physical-slot#:  00000002
+                    #address-cells:  00000003
+                    #size-cells:  00000002
+                    device_type:  'pciex'
+                    name:  'pci'
+                    port-type:  'Downstream-Port'
+                    cache-line-size:  00000010
+                    class-code:  00060400
+                    revision-id:  00000003
+                    device-id:  000080ba
+                    vendor-id:  0000111d
+
+        Node 0xf032ae98
+            ranges:  81000000.00000000.00000000.81000000.00000000.00000000.00000000.02001000.82000000.00000000.00100000.82000000.00000000.00100000.00000000.10100000.c3000000.00000001.00000000.c3000000.00000001.00000000.00000000.30000000
+            bus-range:  00000005.00000061
+            compatible: 'pciex108e,828e.1' + 'pciex108e,828e' + 'pciexclass,060400' + 'pciexclass,0604'
+            reg:  00001000.00000000.00000000.00000000.00000000
+            #address-cells:  00000003
+            #size-cells:  00000002
+            device_type:  'pciex'
+            name:  'pci'
+            port-type:  'Root-Port'
+            cache-line-size:  00000000
+            class-code:  00060400
+            revision-id:  00000001
+            device-id:  0000828e
+            vendor-id:  0000108e
+
+            Node 0xf032dbc0
+                ranges:  81000000.00000000.00000000.81000000.00000000.00000000.00000000.02001000.82000000.00000000.00100000.82000000.00000000.00100000.00000000.10100000.c3000000.00000001.00000000.c3000000.00000001.00000000.00000000.30000000
+                bus-range:  00000006.00000061
+                compatible: 'pciex111d,80ba.3' + 'pciex111d,80ba' + 'pciexclass,060400' + 'pciexclass,0604'
+                reg:  00050000.00000000.00000000.00000000.00000000
+                #address-cells:  00000003
+                #size-cells:  00000002
+                device_type:  'pciex'
+                name:  'pci'
+                port-type:  'Upstream-Port'
+                cache-line-size:  00000010
+                class-code:  00060400
+                revision-id:  00000003
+                device-id:  000080ba
+                vendor-id:  0000111d
+
+                Node 0xf03308ec
+                    slot-names:  00000001.2f535953.2f444250.2f4e564d.453200
+                    available:  81000000.00000000.00000000.00000000.01000000.82000000.00000000.00100000.00000000.08000000.c3000000.00000001.00000000.00000000.10000000
+                    ranges:  81000000.00000000.00000000.81000000.00000000.00000000.00000000.01000000.82000000.00000000.00100000.82000000.00000000.00100000.00000000.08000000.c3000000.00000001.00000000.c3000000.00000001.00000000.00000000.10000000
+                    bus-range:  00000007.00000033
+                    slot-implemented?:  
+                    hotplug-capable:  
+                    compatible: 'pciex111d,80ba.108e.4268.3' + 'pciex111d,80ba.108e.4268' + 'pciex111d,80ba.3' + 'pciex111d,80ba' + 'pciexclass,060400' + 'pciexclass,0604'
+                    reg:  00063000.00000000.00000000.00000000.00000000
+                    physical-slot#:  00000000
+                    #address-cells:  00000003
+                    #size-cells:  00000002
+                    device_type:  'pciex'
+                    name:  'pci'
+                    port-type:  'Downstream-Port'
+                    cache-line-size:  00000010
+                    class-code:  00060400
+                    subsystem-vendor-id:  0000108e
+                    subsystem-id:  00004268
+                    revision-id:  00000003
+                    device-id:  000080ba
+                    vendor-id:  0000111d
+
+                Node 0xf0333850
+                    slot-names:  00000001.2f535953.2f444250.2f4e564d.453300
+                    available:  81000000.00000000.01000000.00000000.01000000.82000000.00000000.08100000.00000000.08000000.c3000000.00000001.10000000.00000000.10000000
+                    ranges:  81000000.00000000.01000000.81000000.00000000.01000000.00000000.01000000.82000000.00000000.08100000.82000000.00000000.08100000.00000000.08000000.c3000000.00000001.10000000.c3000000.00000001.10000000.00000000.10000000
+                    bus-range:  00000034.00000060
+                    slot-implemented?:  
+                    hotplug-capable:  
+                    compatible: 'pciex111d,80ba.108e.4268.3' + 'pciex111d,80ba.108e.4268' + 'pciex111d,80ba.3' + 'pciex111d,80ba' + 'pciexclass,060400' + 'pciexclass,0604'
+                    reg:  00063800.00000000.00000000.00000000.00000000
+                    physical-slot#:  00000000
+                    #address-cells:  00000003
+                    #size-cells:  00000002
+                    device_type:  'pciex'
+                    name:  'pci'
+                    port-type:  'Downstream-Port'
+                    cache-line-size:  00000010
+                    class-code:  00060400
+                    subsystem-vendor-id:  0000108e
+                    subsystem-id:  00004268
+                    revision-id:  00000003
+                    device-id:  000080ba
+                    vendor-id:  0000111d
+
+                Node 0xf03367b4
+                    slot-names:  00000001.2f535953.2f4d422f.52495345.52332f50.43494534.00
+                    available:  81000000.00000000.02000100.00000000.00000f00.c3000000.00000001.20010000.00000000.00030000.c3000000.00000001.20580000.00000000.0fa80000
+                    ranges:  81000000.00000000.02000000.81000000.00000000.02000000.00000000.00001000.82000000.00000000.10100000.82000000.00000000.10100000.00000000.00100000.c3000000.00000001.20000000.c3000000.00000001.20000000.00000000.10000000
+                    bus-range:  00000061.00000061
+                    ari-enabled:  
+                    slot-implemented?:  
+                    compatible: 'pciex111d,80ba.3' + 'pciex111d,80ba' + 'pciexclass,060400' + 'pciexclass,0604'
+                    reg:  0006a000.00000000.00000000.00000000.00000000
+                    physical-slot#:  00000004
+                    #address-cells:  00000003
+                    #size-cells:  00000002
+                    device_type:  'pciex'
+                    name:  'pci'
+                    port-type:  'Downstream-Port'
+                    cache-line-size:  00000010
+                    class-code:  00060400
+                    revision-id:  00000003
+                    device-id:  000080ba
+                    vendor-id:  0000111d
+
+                    Node 0xf0339554
+                        firmware-version:  '9.00.00.00'
+                        mpt-version:  '2.05'
+                        local-wwid:  500605b0.0a0232d0
+                        vf-assigned-addresses:  83610000.00000001.20080000.00000000.00010000.83610002.00000001.20180000.00000000.00040000
+                        assigned-addresses:  81610010.00000000.02000000.00000000.00000100.83610014.00000001.20000000.00000000.00010000.8361001c.00000001.20040000.00000000.00040000.82610030.00000000.10100000.00000000.00100000
+                        vf-reg:  03610000.00000000.00000000.00000000.00010000.03610002.00000000.00000000.00000000.00040000
+                        compatible: 'pciex1000,97' + 'pci1000,97'
+                        model:  'LSI,3008'
+                        reg:  00610000.00000000.00000000.00000000.00000000.01610010.00000000.00000000.00000000.00000100.03610014.00000000.00000000.00000000.00010000.0361001c.00000000.00000000.00000000.00040000.02610030.00000000.00000000.00000000.00100000
+                        version: '1.00.65'
+                        wide:  00000010
+                        device_type:  'scsi-sas'
+                        name:  'LSI,sas'
+                        #address-cells:  00000004
+                        fcode-rom-offset:  00050c00
+                        vf-stride:  00000001
+                        first-vf-offset:  00000001
+                        total-vfs:  00000010
+                        initial-vfs:  00000010
+                        #vfs:  00000010
+                        port-type:  'PCIE-Endpoint'
+                        interrupts:  00000001
+                        cache-line-size:  00000010
+                        class-code:  00010700
+                        subsystem-id:  000030e0
+                        subsystem-vendor-id:  00001000
+                        revision-id:  00000002
+                        device-id:  00000097
+                        vendor-id:  00001000
+
+                        Node 0xf0348038
+                            compatible: 'st'
+                            device_type:  'byte'
+                            name:  'tape'
+
+                        Node 0xf0348d9c
+                            lba64:  
+                            compatible: 'sd'
+                            device_type:  'block'
+                            name:  'disk'
+
+    Node 0xf035ac90
+        alloc-size:  00000000
+        address:  51000000
+        size:  05c4e000
+        compatible: 'SUNW,ramdisk'
+        device_type:  'block'
+        name:  'ramdisk-root'
+
+
+
