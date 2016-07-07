From: Anatoly Pugachev <matorola@gmail.com>
Date: Thu, 07 Jul 2016 10:25:30 +0000
Subject: prtconfs: Add SPARC S7-2L
Message-Id: <20160707102529.GA3485@yogzotot>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

SPARC S7-2L prtconf, taken from Solaris 11 HCL
http://www.oracle.com/webfolder/technetwork/hcl/data/systems/prtconf/oracle_america_inc/sol_11_3/73339.txt

Signed-off-by: Anatoly Pugachev <matorola@gmail.com>
---

diff --git a/S7-2L b/S7-2L
new file mode 100644
index 0000000..fa358d0
--- /dev/null
+++ b/S7-2L
@@ -0,0 +1,2080 @@
+System Configuration:  Oracle Corporation  sun4v
+Memory size: 260352 Megabytes
+System Peripherals (PROM Nodes):
+
+Node 0xf02296e8
+    idprom:  01860010.e08a3cc6.00000000.8a3cc677.00000000.00000000.00000000.00000000
+    scsi-initiator-id:  00000007
+    pcie-ari-supported:  
+    #priqs-per-pcibus:  00000010
+    #priqs-per-cpu:  00000010
+    priq-eq-sizes:  00000003
+    non-ios-perf-counters:  'ORCL,sn-non-ios-pr'
+    ios-perf-counters:  'ORCL,sn-ios-pr'
+    storage-variant:  '8dbp'
+    product-name:  'SPARC SN-2'
+    banner-name:  'SPARC SN-2'
+    name:  'ORCL,SPARC-SN-2'
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
+            builtin-drivers:  636c6173.73303130.38303200.6e766d65.00706369.31303030.2c373000.70636931.3030302c.37300070.63696578.31303030.2c373200.70636931.3030302c.37300070.63696578.31303030.2c37322e.31303030.2e373200.70636931.3030302c.37300070.63696578.31303030.2c38372e.31303030.2e383700.70636931.3030302c.37300070.63696578.31303030.2c37322e.31303865.2e363237.33007063.69313030.302c3730.00706369.65783130.30302c39.372e3130.30302e39.30007063.69313030.302c3730.00706369.65780073.756e3476.2d767063.6900636c.61737330.36303430.3000636c.61737330.36303430.30004f52.434c2c6d.34696f73.2d707200.73756e34.762d7065.72662d63.6e740070.63696578.38303836.2c313532.382e3130.38652e34.38343800.6f706869.72007063.69657838.3038362c.31353135.2e313038.652e3438.3438006f.70686972.00706369.65783830.38362c31.3532312e.31303865.2e376231.61006f70.68697200.70636965.78383038.362c3135.38362e31.3038652e.34383537.00666f72.7476696c.6c650070.63696578.38303836.2c313538.362e3130.38652e37.62316500.666f7274.76696c6c.65007063.69657838.3038362c.31353839.2e313038.652e3762.31650066.6f727476.696c6c65.00706369.65783830.38362c31.3538362e.31303865.2e300066.6f727476.696c6c65.00706369.65783830.38362c31.3538392e.31303865.2e300066.6f727476.696c6c65.00706369.65783830.38362c31.3534632e.31303865.2e343835.3700666f.72747669.6c6c652d.76660070.63696578.38303836.2c313534.632e3130.38652e30.00666f72.7476696c.6c652d76.66007063.69657831.3931322c.31340078.68636900.70636965.78313034.632c3832.34310078.68636900.64657669.63650075.73626465.76696365.00757362.2c636c61.73733900.68756200.75736269.662c636c.61737339.00687562.00757362.69662c63.6c617373.332e312e.31007573.626b6264.00757362.69662c63.6c617373.38007573.6273746f.72616765.00706369.31613033.2c323030.302e3161.30332e32.30303000.6173742d.67726170.68696373.00706369.31303262.2c353232.2e313961.322e3130.32006d61.74726f78.2d677261.70686963.73007063.69657831.3032622c.3532322e.31396132.2e313032.006d6174.726f782d.67726170.68696373.00706369.65783130.32622c35.3232006d.6174726f.782d6772.61706869.637300
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
+        Node 0xf027d34c
+            name:  'kbd-translator'
+
+        Node 0xf027ea80
+            name:  'obp-tftp'
+
+        Node 0xf028f454
+            name:  'vdisk-helper-pkg'
+
+        Node 0xf0294f84
+            name:  'vnet-helper-pkg'
+
+        Node 0xf0365108
+            name:  'zfs-file-system'
+
+        Node 0xf0368a14
+            name:  'hsfs-file-system'
+
+    Node 0xf022cc74
+        fs-package:  'hsfs-file-system'
+        whoami:  '/platform/sun4v/kernel/sparcv9/unix'
+        impl-arch-name:  'sun4v'
+        elfheader-length:  00338000
+        elfheader-address:  50000000
+        archfs:  fed880d8
+        archive-fstype:  'hsfs'
+        bootarchive:  '/ramdisk-root'
+        zfs-bootfs:  'rpool/40'
+        bootfs:  fed8e500
+        fstype:  'zfs'
+        tboot-list:  'fallback-miniroot'
+        bootargs:  00
+        bootpath:  '/pci@302/pci@2/pci@0/pci@17/LSI,sas@0/disk@w5000cca05610977d,0:a'
+        openboot-reserved:  40000000
+        mmu:  fff04b38
+        memory:  fff04d48
+        stdout:  fedd7b60
+        stdin:  fee2b0e8
+        stdout-#lines:  ffffffff
+        name:  'chosen'
+        root-uuid-chk:  '1'
+        root-be-uuid:  'e5b18bb3-7b1a-4f8e-8a38-b1bd60b11041'
+
+    Node 0xf022cce8
+        version: 'OBP 4.40.2.build_01 2016/04/06 15:04'
+        model:  'SUNW,4.40.2.build_01'
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
+        boot-device:  '/pci@302/pci@2/pci@0/pci@17/LSI,sas@0/disk@w5000cca05610977d,0:a'
+        multipath-boot?:  'false'
+        boot-device-index:  '0'
+        use-nvramrc?:  'true'
+        nvramrc:  64657661.6c696173.206c746f.6d5f7331.32202f70.63694033.30322f70.63694032.2f706369.40302f70.63694031.372f4c53.492c7361.7340302f.6469736b.40773530.30306363.61303536.31656334.39312c30.3a610a64.6576616c.69617320.6c746f6d.5f737463.7a6f6e65.73202f70.63694033.30322f70.63694032.2f706369.40302f70.63694031.372f4c53.492c7361.7340302f.6469736b.40773530.30306363.61303266.30326565.37312c30.3a610a64.6576616c.69617320.7331305f.6469736b.202f7063.69403330.322f7063.6940322f.70636940.302f7063.69403137.2f4c5349.2c736173.40302f64.69736b40.77353030.30636361.30313632.31393664.642c303a.610a6465.76616c69.61732068.63747320.2f706369.40333032.2f706369.40322f70.63694030.2f706369.4031372f.4c53492c.73617340.302f6469.736b4077.35303030.63636130.35363130.39373764.2c303a61.0a00
+        error-reset-recovery:  'boot'
+        name:  'options'
+
+    Node 0xf022cea8
+        fallback-miniroot:  '/pci@300/pci@1/pci@0/pci@2/usb@0/hub@2/storage@1/disk@0'
+        rcdrom:  '/pci@300/pci@1/pci@0/pci@2/usb@0/hub@2/storage@1/disk@0'
+        hcts:  '/pci@302/pci@2/pci@0/pci@17/LSI,sas@0/disk@w5000cca05610977d,0:a'
+        s10_disk:  '/pci@302/pci@2/pci@0/pci@17/LSI,sas@0/disk@w5000cca0162196dd,0:a'
+        ltom_stczones:  '/pci@302/pci@2/pci@0/pci@17/LSI,sas@0/disk@w5000cca02f02ee71,0:a'
+        ltom_s12:  '/pci@302/pci@2/pci@0/pci@17/LSI,sas@0/disk@w5000cca0561ec491,0:a'
+        disk7:  '/pci@302/pci@2/pci@0/pci@17/LSI,sas@0/disk@p4'
+        disk6:  '/pci@302/pci@2/pci@0/pci@17/LSI,sas@0/disk@p5'
+        disk5:  '/pci@302/pci@2/pci@0/pci@17/LSI,sas@0/disk@p7'
+        disk4:  '/pci@302/pci@2/pci@0/pci@17/LSI,sas@0/disk@p6'
+        disk3:  '/pci@302/pci@2/pci@0/pci@17/LSI,sas@0/disk@p0'
+        disk2:  '/pci@302/pci@2/pci@0/pci@17/LSI,sas@0/disk@p1'
+        disk1:  '/pci@302/pci@2/pci@0/pci@17/LSI,sas@0/disk@p3'
+        disk:  '/pci@302/pci@2/pci@0/pci@17/LSI,sas@0/disk@p2'
+        disk0:  '/pci@302/pci@2/pci@0/pci@17/LSI,sas@0/disk@p2'
+        sas0:  '/pci@302/pci@2/pci@0/pci@17/LSI,sas@0'
+        sas:  '/pci@302/pci@2/pci@0/pci@17/LSI,sas@0'
+        nvme1:  '/pci@302/pci@2/pci@0/pci@5/nvme@0/disk@1'
+        nvme0:  '/pci@302/pci@2/pci@0/pci@4/nvme@0/disk@1'
+        nvme3:  '/pci@300/pci@2/pci@0/pci@7/nvme@0/disk@1'
+        nvme2:  '/pci@300/pci@2/pci@0/pci@6/nvme@0/disk@1'
+        net3:  '/pci@300/pci@1/pci@0/pci@1/network@0,3'
+        net2:  '/pci@300/pci@1/pci@0/pci@1/network@0,2'
+        net1:  '/pci@300/pci@1/pci@0/pci@1/network@0,1'
+        net:  '/pci@300/pci@1/pci@0/pci@1/network@0'
+        net0:  '/pci@300/pci@1/pci@0/pci@1/network@0'
+        cdrom:  '/pci@300/pci@1/pci@0/pci@2/usb@0/device@7/storage@0/disk@0'
+        virtual-console:  '/virtual-devices/console@1'
+        name:  'aliases'
+
+    Node 0xf0240efc
+        reg:  00000000.50000000.0000001f.a0000000.00004000.00000000.0000001f.f0000000
+        available:  0000401f.e91da000.00000000.002a8000.0000401f.e0000000.00000000.0908a000.00004000.00000000.0000001f.c0000000.00000000.90000000.0000001f.60000000.00000000.8fdb6000.00000000.00002000.00000000.50400000.00000000.3f9b0000
+        name:  'memory'
+
+    Node 0xf0241508
+        translations:  00000000.00002000.00000000.009fe000.80000000.50402540.00000000.00a00000.00000000.00580000.8000401f.ef158540.00000000.01402000.00000000.0006c000.8000401f.e916c540.00000000.10000000.00000000.10000000.8000401f.d0000540.00000000.20000000.00000000.10000000.8000401f.c0000540.00000000.51000000.00000000.05c26000.8000401f.e9532540.00000000.f0000000.00000000.00400000.80000000.50000550.00000000.f0400000.00000000.00770000.8000401f.ef700550.00000000.fec02000.00000000.00090000.8000401f.e9482550.00000000.fec92000.00000000.00060000.8000401f.e908a550.00000000.fecf2000.00000000.00008000.8000401f.e9512550.00000000.fecfa000.00000000.00020000.8000401f.ef6d8550.00000000.fed1a000.00000000.0000a000.8000401f.effde550.00000000.fed24000.00000000.00004000.8000401f.ef6f8550.00000000.fed28000.00000000.00010000.80020201.20000950.00000000.fed38000.00000000.00096000.8000401f.efe74550.00000000.fedce000.00000000.00008000.8000401f.effc0550.00000000.fedd6000.00000000.00036000.8000401f.eff0a550.00000000.fee0c000.00000000.00012000.8000401f.effc8550.00000000.fee1e000.00000000.00002000.80020001.10000950.00000000.fee20000.00000000.00004000.8000401f.effda550.00000000.fee24000.00000000.0000a000.8000401f.effe8550.00000000.fee2e000.00000000.00080000.8000401f.eff40550.00000000.feeae000.00000000.00008000.8000401f.efff2550.00000000.feeb6000.00000000.00004000.8000401f.efffc550.00000000.feeba000.00000000.00006000.80000000.8fdb0550.00000000.feec0000.00000000.00002000.8000401f.efffa550.00000000.feec2000.00000000.00006000.80000000.8fdb8550.00000000.feecc000.00000000.00002000.80000000.8fdbe550.00000000.feece000.00000000.00114000.80000000.8fec0550.00000000.fefe2000.00000000.0001e000.80000000.8ffda550.00000000.fff00000.00000000.00010000.80000000.501f0550.00000000.fff10000.00000000.00002000.8000401f.ef6fc550
+        existing:  00000000.00000000.00000800.00000000.fffff800.00000000.00000800.00000000
+        available:  fffff800.00000000.000007fc.00000000.00000001.00000000.000007ff.00000000.00000000.ffff0000.00000000.0000e000.00000000.56c26000.00000000.993da000.00000000.30000000.00000000.21000000.00000000.0146e000.00000000.0eb92000.00000000.00f80000.00000000.00482000.00000000.00000000.00000000.00a00000.00000000.f2200000.00000000.0ca02000
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
+    Node 0xf029afa4
+        interrupt-map:  00000001.00000001.f029afa4.00000011
+        interrupt-map-mask:  0000001f.00ffffff.00000003
+        #interrupt-cells:  00000001
+        reg:  c0000100.00000000.00000000.00000000
+        #address-cells:  00000001
+        #size-cells:  00000000
+        device_type:  'virtual-devices'
+        compatible: 'SUNW,sun4v-virtual-devices' + 'SUNW,virtual-devices'
+        name:  'virtual-devices'
+
+        Node 0xf029c08c
+            name:  'flashprom'
+            reg:  00000000
+
+        Node 0xf029c660
+            rng-#units:  00000002
+            compatible: 'ORCL,m7-rng'
+            reg:  0000000e
+            name:  'random-number-generator'
+
+        Node 0xf029cce4
+            #interrupts:  0000003f
+            compatible: 'ORCL,sun4v-dax'
+            reg:  0000000a
+            name:  'dax'
+
+        Node 0xf029d154
+            reg:  00000001
+            device_type:  'serial'
+            compatible: 'SUNW,sun4v-console'
+            name:  'console'
+            interrupts:  00000001
+
+        Node 0xf029da2c
+            #address-cells:  00000001
+            #size-cells:  00000000
+            reg:  00000200
+            compatible: 'SUNW,sun4v-channel-devices'
+            device_type:  'channel-devices'
+            name:  'channel-devices'
+
+            Node 0xf029e90c
+                compatible: 'SUNW,sun4v-channel'
+                reg:  00000000
+                name:  'virtual-channel'
+
+            Node 0xf029e9e0
+                compatible: 'SUNW,sun4v-channel'
+                reg:  00000003
+                name:  'virtual-channel'
+
+            Node 0xf029eab4
+                compatible: 'SUNW,sun4v-channel'
+                reg:  00000001
+                name:  'virtual-channel-client'
+
+            Node 0xf029eb8c
+                compatible: 'SUNW,sun4v-channel'
+                reg:  00000002
+                name:  'virtual-channel-client'
+
+            Node 0xf029ec64
+                compatible: 'SUNW,sun4v-pciv-comm'
+                reg:  00000000
+                name:  'pciv-communication'
+
+            Node 0xf029ed38
+                compatible: 'SUNW,sun4v-domain-service'
+                reg:  00000000
+                name:  'virtual-domain-service'
+
+    Node 0xf029ef58
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000000.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f0c4
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000001.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f230
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000002.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f39c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000003.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f508
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000004.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f674
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000005.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f7e0
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000006.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029f94c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000007.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029fab8
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000008.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029fc24
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000009.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029fd90
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000000a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf029fefc
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000000b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0068
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000000c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a01d4
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000000d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0340
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000000e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a04ac
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000000f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0618
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000010.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0784
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000011.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a08f0
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000012.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0a5c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000013.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0bc8
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000014.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0d34
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000015.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a0ea0
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000016.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a100c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000017.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1178
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000018.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a12e4
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000019.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1450
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000001a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a15bc
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000001b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1728
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000001c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1894
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000001d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1a00
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000001e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1b6c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000001f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1cd8
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000020.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1e44
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000021.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a1fb0
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000022.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a211c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000023.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2288
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000024.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a23f4
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000025.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2560
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000026.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a26cc
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000027.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2838
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000028.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a29a4
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000029.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2b10
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000002a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2c7c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000002b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2de8
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000002c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a2f54
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000002d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a30c0
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000002e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a322c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000002f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3398
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000030.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3504
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000031.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3670
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000032.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a37dc
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000033.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3948
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000034.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3ab4
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000035.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3c20
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000036.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3d8c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000037.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a3ef8
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000038.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4064
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000039.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a41d0
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000003a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a433c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000003b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a44a8
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000003c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4614
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000003d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4780
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000003e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a48ec
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000003f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4a58
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000040.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4bc4
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000041.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4d30
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000042.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a4e9c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000043.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5008
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000044.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5174
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000045.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a52e0
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000046.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a544c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000047.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a55b8
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000048.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5724
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000049.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5890
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000004a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a59fc
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000004b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5b68
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000004c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5cd4
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000004d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5e40
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000004e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a5fac
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000004f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a6118
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000050.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a6284
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000051.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a63f0
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000052.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a655c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000053.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a66c8
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000054.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a6834
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000055.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a69a0
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000056.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a6b0c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000057.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a6c78
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000058.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a6de4
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000059.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a6f50
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000005a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a70bc
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000005b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7228
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000005c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7394
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000005d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7500
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000005e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a766c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000005f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a77d8
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000060.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7944
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000061.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7ab0
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000062.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7c1c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000063.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7d88
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000064.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a7ef4
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000065.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a8060
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000066.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a81cc
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000067.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a8338
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000068.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a84a4
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000069.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a8610
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000006a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a877c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000006b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a88e8
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000006c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a8a54
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000006d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a8bc0
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000006e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a8d2c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000006f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a8e98
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000070.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9004
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000071.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9170
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000072.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a92dc
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000073.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9448
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000074.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a95b4
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000075.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9720
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000076.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a988c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000077.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a99f8
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000078.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9b64
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c0000079.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9cd0
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000007a.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9e3c
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000007b.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02a9fa8
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000007c.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aa114
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000007d.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aa280
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000007e.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aa3ec
+        clock-frequency:  fe4e8a00
+        clock-frequency64:  00000000.fe4e8a00
+        compatible: 'SPARC-SN' + 'SPARC-3e42' + 'SPARC-3e40' + 'SUNW,sun4v-cpu' + 'sun4v'
+        device_type:  'cpu'
+        reg:  c000007f.00000000.00000000.00000000
+        name:  'cpu'
+
+    Node 0xf02aa55c
+        interrupt-map:  00000800.00000000.00000000.00000001.f02aa55c.00000002.00000800.00000000.00000000.00000002.f02aa55c.00000003.00000800.00000000.00000000.00000003.f02aa55c.00000004.00000800.00000000.00000000.00000004.f02aa55c.00000001.00001000.00000000.00000000.00000001.f02aa55c.00000003.00001000.00000000.00000000.00000002.f02aa55c.00000004.00001000.00000000.00000000.00000003.f02aa55c.00000001.00001000.00000000.00000000.00000004.f02aa55c.00000002
+        interrupt-map-mask:  00fff800.00000000.00000000.00000007
+        #interrupt-cells:  00000001
+        interrupts:  0000003f.0000003e
+        available:  81000000.00000000.02000000.00000000.0e000000.82000000.00000000.10300000.00000000.6ed00000.c3000000.00000001.40000000.0000000c.c0000000
+        level1-hotplug-slot-count:  00000007
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
+        bus-range:  00000000.00000049
+        bus-parity-generated:  
+        #address-cells:  00000003
+        #size-cells:  00000002
+        name:  'pci'
+        compatible: 'SUNW,sun4v-pci'
+        device_type:  'pciex'
+        virtual-dma:  80000000.80000000
+
+        Node 0xf02c88c0
+            ranges:  82000000.00000000.00100000.82000000.00000000.00100000.00000000.00200000.c3000000.00000001.00000000.c3000000.00000001.00000000.00000000.20000000
+            bus-range:  00000001.00000005
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
+            Node 0xf02cb5e8
+                ranges:  82000000.00000000.00100000.82000000.00000000.00100000.00000000.00200000.c3000000.00000001.00000000.c3000000.00000001.00000000.00000000.20000000
+                bus-range:  00000002.00000005
+                compatible: 'pciex111d,80bf.3' + 'pciex111d,80bf' + 'pciexclass,060400' + 'pciexclass,0604'
+                reg:  00010000.00000000.00000000.00000000.00000000
+                #address-cells:  00000003
+                #size-cells:  00000002
+                device_type:  'pciex'
+                name:  'pci'
+                port-type:  'Upstream-Port'
+                cache-line-size:  00000010
+                class-code:  00060400
+                revision-id:  00000003
+                device-id:  000080bf
+                vendor-id:  0000111d
+
+                Node 0xf02ce314
+                    available:  c3000000.00000001.00fa0000.00000000.00060000.c3000000.00000001.02a80000.00000000.0d580000
+                    ranges:  82000000.00000000.00100000.82000000.00000000.00100000.00000000.00200000.c3000000.00000001.00000000.c3000000.00000001.00000000.00000000.10000000
+                    bus-range:  00000003.00000003
+                    ari-enabled:  
+                    compatible: 'pciex111d,80bf.3' + 'pciex111d,80bf' + 'pciexclass,060400' + 'pciexclass,0604'
+                    reg:  00020800.00000000.00000000.00000000.00000000
+                    #address-cells:  00000003
+                    #size-cells:  00000002
+                    device_type:  'pciex'
+                    name:  'pci'
+                    port-type:  'Downstream-Port'
+                    cache-line-size:  00000010
+                    class-code:  00060400
+                    revision-id:  00000003
+                    device-id:  000080bf
+                    vendor-id:  0000111d
+
+                    Node 0xf02d1064
+                        local-mac-address:  0010e08a.3cc6
+                        mac-addresses:  0010e08a.3cc6
+                        vf-assigned-addresses:  c3030000.00000001.00810000.00000000.00010000.c3030003.00000001.00a10000.00000000.00004000
+                        assigned-addresses:  c3030010.00000001.00000000.00000000.00800000.c303001c.00000001.00800000.00000000.00008000.82030030.00000000.00100000.00000000.00080000
+                        vf-reg:  43030000.00000000.00000000.00000000.00010000.43030003.00000000.00000000.00000000.00004000
+                        reg:  00030000.00000000.00000000.00000000.00000000.43030010.00000000.00000000.00000000.00800000.4303001c.00000000.00000000.00000000.00008000.02030030.00000000.00000000.00000000.00080000
+                        compatible: 'pciex8086,1586.108e.7b1e.2' + 'pciex8086,1586.108e.7b1e' + 'pciex8086,1586.2' + 'pciex8086,1586' + 'pciexclass,020000' + 'pciexclass,0200'
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
+                        device-id:  00001586
+                        vendor-id:  00008086
+
+                    Node 0xf02dd358
+                        local-mac-address:  0010e08a.3cc7
+                        mac-addresses:  0010e08a.3cc7
+                        vf-assigned-addresses:  c3030100.00000001.00a90000.00000000.00010000.c3030103.00000001.00c90000.00000000.00004000
+                        assigned-addresses:  c3030110.00000001.01000000.00000000.00800000.c303011c.00000001.00808000.00000000.00008000.82030130.00000000.00180000.00000000.00080000
+                        vf-reg:  43030100.00000000.00000000.00000000.00010000.43030103.00000000.00000000.00000000.00004000
+                        reg:  00030100.00000000.00000000.00000000.00000000.43030110.00000000.00000000.00000000.00800000.4303011c.00000000.00000000.00000000.00008000.02030130.00000000.00000000.00000000.00080000
+                        compatible: 'pciex8086,1586.108e.0.2' + 'pciex8086,1586.108e.0' + 'pciex8086,1586.2' + 'pciex8086,1586' + 'pciexclass,020000' + 'pciexclass,0200'
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
+                        device-id:  00001586
+                        vendor-id:  00008086
+
+                    Node 0xf02e9614
+                        local-mac-address:  0010e08a.3cc8
+                        mac-addresses:  0010e08a.3cc8
+                        vf-assigned-addresses:  c3030200.00000001.00d20000.00000000.00010000.c3030203.00000001.00f20000.00000000.00004000
+                        assigned-addresses:  c3030210.00000001.01800000.00000000.00800000.c303021c.00000001.00d10000.00000000.00008000.82030230.00000000.00200000.00000000.00080000
+                        vf-reg:  43030200.00000000.00000000.00000000.00010000.43030203.00000000.00000000.00000000.00004000
+                        reg:  00030200.00000000.00000000.00000000.00000000.43030210.00000000.00000000.00000000.00800000.4303021c.00000000.00000000.00000000.00008000.02030230.00000000.00000000.00000000.00080000
+                        compatible: 'pciex8086,1586.108e.0.2' + 'pciex8086,1586.108e.0' + 'pciex8086,1586.2' + 'pciex8086,1586' + 'pciexclass,020000' + 'pciexclass,0200'
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
+                        device-id:  00001586
+                        vendor-id:  00008086
+
+                    Node 0xf02f58d0
+                        local-mac-address:  0010e08a.3cc9
+                        mac-addresses:  0010e08a.3cc9
+                        vf-assigned-addresses:  c3030300.00000001.02800000.00000000.00010000.c3030303.00000001.02a00000.00000000.00004000
+                        assigned-addresses:  c3030310.00000001.02000000.00000000.00800000.c303031c.00000001.00d18000.00000000.00008000.82030330.00000000.00280000.00000000.00080000
+                        vf-reg:  43030300.00000000.00000000.00000000.00010000.43030303.00000000.00000000.00000000.00004000
+                        reg:  00030300.00000000.00000000.00000000.00000000.43030310.00000000.00000000.00000000.00800000.4303031c.00000000.00000000.00000000.00008000.02030330.00000000.00000000.00000000.00080000
+                        compatible: 'pciex8086,1586.108e.0.2' + 'pciex8086,1586.108e.0' + 'pciex8086,1586.2' + 'pciex8086,1586' + 'pciexclass,020000' + 'pciexclass,0200'
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
+                        device-id:  00001586
+                        vendor-id:  00008086
+
+                Node 0xf0301c90
+                    available:  c3000000.00000001.10012000.00000000.0ffee000
+                    ranges:  c3000000.00000001.10000000.c3000000.00000001.10000000.00000000.10000000
+                    bus-range:  00000004.00000004
+                    compatible: 'pciex111d,80bf.3' + 'pciex111d,80bf' + 'pciexclass,060400' + 'pciexclass,0604'
+                    reg:  00021000.00000000.00000000.00000000.00000000
+                    #address-cells:  00000003
+                    #size-cells:  00000002
+                    device_type:  'pciex'
+                    name:  'pci'
+                    port-type:  'Downstream-Port'
+                    cache-line-size:  00000010
+                    class-code:  00060400
+                    revision-id:  00000003
+                    device-id:  000080bf
+                    vendor-id:  0000111d
+
+                    Node 0xf03049c0
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
+                        Node 0xf0353a44
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
+                            reg:  00000006
+                            #size-cells:  00000000
+                            #address-cells:  00000001
+
+                        Node 0xf035495c
+                            device_type:  'usb_device'
+                            reg:  00000007
+                            #size-cells:  00000000
+                            #address-cells:  00000002
+                            compatible: 'usbdevice'
+                            name:  'device'
+
+                            Node 0xf03554a8
+                                #address-cells:  00000002
+                                #size-cells:  00000000
+                                device_type:  'scsi-usb'
+                                configuration#:  00000001
+                                bulk-out-size:  00000400
+                                bulk-out-pipe:  00000003
+                                bulk-in-size:  00000400
+                                bulk-in-pipe:  00000003
+                                serial$:  'B440AC8AAED7640B075057712B434437C'
+                                device$:  'TUSB9261 USB3.0 to SATA Bridge'
+                                vendor$:  'Texas Instruments'
+                                compatible: 'usb451,9261.100' + 'usb451,9261' + 'usbif451,class8.6.50' + 'usbif451,class8.6' + 'usbif451,class8' + 'usbif,class8.6.50' + 'usbif,class8.6' + 'usbif,class8' + 'usb,device'
+                                vendor-id:  00000451
+                                device-id:  00009261
+                                release:  00000100
+                                name:  'storage'
+                                class:  00000008
+                                subclass:  00000006
+                                protocol:  00000050
+                                ultra-speed:  00
+                                assigned-address:  00000002
+                                reg:  00000000.00000000
+
+                                Node 0xf0358620
+                                    compatible: 'sd' + 'disk'
+                                    device_type:  'block'
+                                    name:  'disk'
+
+                            Node 0xf0359174
+                                configuration#:  00000001
+                                intr-out-size:  00000009
+                                intr-out-interval:  00000002
+                                intr-out-pipe:  00000001
+                                intr-in-size:  00000009
+                                intr-in-interval:  00000002
+                                intr-in-pipe:  00000001
+                                serial$:  'B440AC8AAED7640B075057712B434437C'
+                                device$:  'TUSB9261 USB3.0 to SATA Bridge'
+                                vendor$:  'Texas Instruments'
+                                compatible: 'usb451,9261.100' + 'usb451,9261' + 'usbif451,class3.0.0' + 'usbif451,class3.0' + 'usbif451,class3' + 'usbif,class3.0.0' + 'usbif,class3.0' + 'usbif,class3' + 'usb,device'
+                                vendor-id:  00000451
+                                device-id:  00009261
+                                release:  00000100
+                                name:  'hid'
+                                class:  00000003
+                                subclass:  00000000
+                                protocol:  00000000
+                                ultra-speed:  00
+                                assigned-address:  00000002
+                                reg:  00000001.00000000
+
+                        Node 0xf03595d8
+                            device_type:  'scsi-usb'
+                            configuration#:  00000001
+                            bulk-out-size:  00000200
+                            bulk-out-pipe:  00000002
+                            bulk-in-size:  00000200
+                            bulk-in-pipe:  00000001
+                            serial$:  '11F0022700051868'
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
+                            assigned-address:  00000003
+                            reg:  00000001
+                            #size-cells:  00000000
+                            #address-cells:  00000002
+
+                            Node 0xf035c734
+                                compatible: 'sd' + 'disk'
+                                device_type:  'block'
+                                name:  'disk'
+
+                        Node 0xf035d288
+                            hub20-dev:  00000004
+                            device_type:  'usb_hub'
+                            configuration#:  00000001
+                            intr-in-size:  00000001
+                            intr-in-interval:  0000000c
+                            intr-in-pipe:  00000001
+                            serial$:  'C70128797733'
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
+                            assigned-address:  00000004
+                            reg:  00000002
+                            #size-cells:  00000000
+                            #address-cells:  00000001
+
+                            Node 0xf035e1cc
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
+                                assigned-address:  00000005
+                                reg:  00000001
+                                #size-cells:  00000000
+                                #address-cells:  00000002
+
+                                Node 0xf0361308
+                                    compatible: 'sd' + 'disk'
+                                    device_type:  'block'
+                                    name:  'disk'
+
+                Node 0xf0311d20
+                    slot-names:  00000001.2f535953.2f4d422f.50434945.3100
+                    bus-range:  00000005.00000005
+                    slot-implemented?:  
+                    compatible: 'pciex111d,80bf.3' + 'pciex111d,80bf' + 'pciexclass,060400' + 'pciexclass,0604'
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
+                    device-id:  000080bf
+                    vendor-id:  0000111d
+
+        Node 0xf0314c78
+            ranges:  81000000.00000000.00000000.81000000.00000000.00000000.00000000.02000000.82000000.00000000.00300000.82000000.00000000.00300000.00000000.10000000.c3000000.00000001.20000000.c3000000.00000001.20000000.00000000.20000000
+            bus-range:  00000006.00000049
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
+            Node 0xf03179a0
+                ranges:  81000000.00000000.00000000.81000000.00000000.00000000.00000000.02000000.82000000.00000000.00300000.82000000.00000000.00300000.00000000.10000000.c3000000.00000001.20000000.c3000000.00000001.20000000.00000000.20000000
+                bus-range:  00000007.00000049
+                compatible: 'pciex111d,80bf.3' + 'pciex111d,80bf' + 'pciexclass,060400' + 'pciexclass,0604'
+                reg:  00060000.00000000.00000000.00000000.00000000
+                #address-cells:  00000003
+                #size-cells:  00000002
+                device_type:  'pciex'
+                name:  'pci'
+                port-type:  'Upstream-Port'
+                cache-line-size:  00000010
+                class-code:  00060400
+                revision-id:  00000003
+                device-id:  000080bf
+                vendor-id:  0000111d
+
+                Node 0xf031a6cc
+                    slot-names:  00000001.2f535953.2f444250.2f4e564d.453200
+                    available:  81000000.00000000.00000000.00000000.01000000.82000000.00000000.00300000.00000000.08000000.c3000000.00000001.20000000.00000000.10000000
+                    ranges:  81000000.00000000.00000000.81000000.00000000.00000000.00000000.01000000.82000000.00000000.00300000.82000000.00000000.00300000.00000000.08000000.c3000000.00000001.20000000.c3000000.00000001.20000000.00000000.10000000
+                    bus-range:  00000008.00000027
+                    slot-implemented?:  
+                    hotplug-capable:  
+                    compatible: 'pciex111d,80bf.108e.4268.3' + 'pciex111d,80bf.108e.4268' + 'pciex111d,80bf.3' + 'pciex111d,80bf' + 'pciexclass,060400' + 'pciexclass,0604'
+                    reg:  00073000.00000000.00000000.00000000.00000000
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
+                    device-id:  000080bf
+                    vendor-id:  0000111d
+
+                Node 0xf031d630
+                    slot-names:  00000001.2f535953.2f444250.2f4e564d.453300
+                    available:  81000000.00000000.01000000.00000000.01000000.82000000.00000000.08300000.00000000.08000000.c3000000.00000001.30000000.00000000.10000000
+                    ranges:  81000000.00000000.01000000.81000000.00000000.01000000.00000000.01000000.82000000.00000000.08300000.82000000.00000000.08300000.00000000.08000000.c3000000.00000001.30000000.c3000000.00000001.30000000.00000000.10000000
+                    bus-range:  00000028.00000047
+                    slot-implemented?:  
+                    hotplug-capable:  
+                    compatible: 'pciex111d,80bf.108e.4268.3' + 'pciex111d,80bf.108e.4268' + 'pciex111d,80bf.3' + 'pciex111d,80bf' + 'pciexclass,060400' + 'pciexclass,0604'
+                    reg:  00073800.00000000.00000000.00000000.00000000
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
+                    device-id:  000080bf
+                    vendor-id:  0000111d
+
+                Node 0xf0320594
+                    slot-names:  00000001.2f535953.2f4d422f.50434945.3400
+                    bus-range:  00000048.00000048
+                    slot-implemented?:  
+                    compatible: 'pciex111d,80bf.3' + 'pciex111d,80bf' + 'pciexclass,060400' + 'pciexclass,0604'
+                    reg:  0007a000.00000000.00000000.00000000.00000000
+                    physical-slot#:  00000004
+                    #address-cells:  00000003
+                    #size-cells:  00000002
+                    device_type:  'pciex'
+                    name:  'pci'
+                    port-type:  'Downstream-Port'
+                    cache-line-size:  00000010
+                    class-code:  00060400
+                    revision-id:  00000003
+                    device-id:  000080bf
+                    vendor-id:  0000111d
+
+                Node 0xf0323374
+                    slot-names:  00000001.2f535953.2f4d422f.50434945.3500
+                    bus-range:  00000049.00000049
+                    slot-implemented?:  
+                    compatible: 'pciex111d,80bf.3' + 'pciex111d,80bf' + 'pciexclass,060400' + 'pciexclass,0604'
+                    reg:  0007a800.00000000.00000000.00000000.00000000
+                    physical-slot#:  00000005
+                    #address-cells:  00000003
+                    #size-cells:  00000002
+                    device_type:  'pciex'
+                    name:  'pci'
+                    port-type:  'Downstream-Port'
+                    cache-line-size:  00000010
+                    class-code:  00060400
+                    revision-id:  00000003
+                    device-id:  000080bf
+                    vendor-id:  0000111d
+
+    Node 0xf02b9624
+        interrupt-map:  00000800.00000000.00000000.00000001.f02b9624.00000002.00000800.00000000.00000000.00000002.f02b9624.00000003.00000800.00000000.00000000.00000003.f02b9624.00000004.00000800.00000000.00000000.00000004.f02b9624.00000001.00001000.00000000.00000000.00000001.f02b9624.00000003.00001000.00000000.00000000.00000002.f02b9624.00000004.00001000.00000000.00000000.00000003.f02b9624.00000001.00001000.00000000.00000000.00000004.f02b9624.00000002
+        interrupt-map-mask:  00fff800.00000000.00000000.00000007
+        #interrupt-cells:  00000001
+        interrupts:  0000003f.0000003e
+        available:  81000000.00000000.02001000.00000000.0dfff000.82000000.00000000.10200000.00000000.6ee00000.c3000000.00000001.30000000.0000000c.d0000000
+        level1-hotplug-slot-count:  00000006
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
+        bus-range:  00000000.00000054
+        bus-parity-generated:  
+        #address-cells:  00000003
+        #size-cells:  00000002
+        name:  'pci'
+        compatible: 'SUNW,sun4v-pci'
+        device_type:  'pciex'
+        virtual-dma:  80000000.80000000
+
+        Node 0xf03263d8
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
+            Node 0xf0329100
+                bus-range:  00000002.00000004
+                compatible: 'pciex111d,80bf.3' + 'pciex111d,80bf' + 'pciexclass,060400' + 'pciexclass,0604'
+                reg:  00010000.00000000.00000000.00000000.00000000
+                #address-cells:  00000003
+                #size-cells:  00000002
+                device_type:  'pciex'
+                name:  'pci'
+                port-type:  'Upstream-Port'
+                cache-line-size:  00000010
+                class-code:  00060400
+                revision-id:  00000003
+                device-id:  000080bf
+                vendor-id:  0000111d
+
+                Node 0xf032be2c
+                    slot-names:  00000001.2f535953.2f4d422f.50434945.3200
+                    bus-range:  00000003.00000003
+                    slot-implemented?:  
+                    compatible: 'pciex111d,80bf.3' + 'pciex111d,80bf' + 'pciexclass,060400' + 'pciexclass,0604'
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
+                    device-id:  000080bf
+                    vendor-id:  0000111d
+
+                Node 0xf032ec0c
+                    slot-names:  00000001.2f535953.2f4d422f.50434945.3300
+                    bus-range:  00000004.00000004
+                    slot-implemented?:  
+                    compatible: 'pciex111d,80bf.3' + 'pciex111d,80bf' + 'pciexclass,060400' + 'pciexclass,0604'
+                    reg:  00029800.00000000.00000000.00000000.00000000
+                    physical-slot#:  00000003
+                    #address-cells:  00000003
+                    #size-cells:  00000002
+                    device_type:  'pciex'
+                    name:  'pci'
+                    port-type:  'Downstream-Port'
+                    cache-line-size:  00000010
+                    class-code:  00060400
+                    revision-id:  00000003
+                    device-id:  000080bf
+                    vendor-id:  0000111d
+
+        Node 0xf0331aac
+            ranges:  81000000.00000000.00000000.81000000.00000000.00000000.00000000.02001000.82000000.00000000.00100000.82000000.00000000.00100000.00000000.10100000.c3000000.00000001.00000000.c3000000.00000001.00000000.00000000.30000000
+            bus-range:  00000005.00000054
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
+            Node 0xf03347d4
+                ranges:  81000000.00000000.00000000.81000000.00000000.00000000.00000000.02001000.82000000.00000000.00100000.82000000.00000000.00100000.00000000.10100000.c3000000.00000001.00000000.c3000000.00000001.00000000.00000000.30000000
+                bus-range:  00000006.00000054
+                compatible: 'pciex111d,80bf.3' + 'pciex111d,80bf' + 'pciexclass,060400' + 'pciexclass,0604'
+                reg:  00050000.00000000.00000000.00000000.00000000
+                #address-cells:  00000003
+                #size-cells:  00000002
+                device_type:  'pciex'
+                name:  'pci'
+                port-type:  'Upstream-Port'
+                cache-line-size:  00000010
+                class-code:  00060400
+                revision-id:  00000003
+                device-id:  000080bf
+                vendor-id:  0000111d
+
+                Node 0xf0337500
+                    slot-names:  00000001.2f535953.2f444250.2f4e564d.453000
+                    available:  81000000.00000000.00000000.00000000.01000000.82000000.00000000.00100000.00000000.08000000.c3000000.00000001.00000000.00000000.10000000
+                    ranges:  81000000.00000000.00000000.81000000.00000000.00000000.00000000.01000000.82000000.00000000.00100000.82000000.00000000.00100000.00000000.08000000.c3000000.00000001.00000000.c3000000.00000001.00000000.00000000.10000000
+                    bus-range:  00000007.0000002c
+                    slot-implemented?:  
+                    hotplug-capable:  
+                    compatible: 'pciex111d,80bf.108e.4268.3' + 'pciex111d,80bf.108e.4268' + 'pciex111d,80bf.3' + 'pciex111d,80bf' + 'pciexclass,060400' + 'pciexclass,0604'
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
+                    device-id:  000080bf
+                    vendor-id:  0000111d
+
+                Node 0xf033a464
+                    slot-names:  00000001.2f535953.2f444250.2f4e564d.453100
+                    available:  81000000.00000000.01000000.00000000.01000000.82000000.00000000.08100000.00000000.08000000.c3000000.00000001.10000000.00000000.10000000
+                    ranges:  81000000.00000000.01000000.81000000.00000000.01000000.00000000.01000000.82000000.00000000.08100000.82000000.00000000.08100000.00000000.08000000.c3000000.00000001.10000000.c3000000.00000001.10000000.00000000.10000000
+                    bus-range:  0000002d.00000052
+                    slot-implemented?:  
+                    hotplug-capable:  
+                    compatible: 'pciex111d,80bf.108e.4268.3' + 'pciex111d,80bf.108e.4268' + 'pciex111d,80bf.3' + 'pciex111d,80bf' + 'pciexclass,060400' + 'pciexclass,0604'
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
+                    device-id:  000080bf
+                    vendor-id:  0000111d
+
+                Node 0xf033d3c8
+                    slot-names:  00000001.2f535953.2f4d422f.50434945.3600
+                    bus-range:  00000053.00000053
+                    slot-implemented?:  
+                    compatible: 'pciex111d,80bf.3' + 'pciex111d,80bf' + 'pciexclass,060400' + 'pciexclass,0604'
+                    reg:  0006b000.00000000.00000000.00000000.00000000
+                    physical-slot#:  00000006
+                    #address-cells:  00000003
+                    #size-cells:  00000002
+                    device_type:  'pciex'
+                    name:  'pci'
+                    port-type:  'Downstream-Port'
+                    cache-line-size:  00000010
+                    class-code:  00060400
+                    revision-id:  00000003
+                    device-id:  000080bf
+                    vendor-id:  0000111d
+
+                Node 0xf03401a8
+                    slot-names:  00000001.2f535953.2f4d422f.50434945.3700
+                    available:  81000000.00000000.02000100.00000000.00000f00.c3000000.00000001.20110000.00000000.0fef0000
+                    ranges:  81000000.00000000.02000000.81000000.00000000.02000000.00000000.00001000.82000000.00000000.10100000.82000000.00000000.10100000.00000000.00100000.c3000000.00000001.20000000.c3000000.00000001.20000000.00000000.10000000
+                    bus-range:  00000054.00000054
+                    ari-enabled:  
+                    slot-implemented?:  
+                    compatible: 'pciex111d,80bf.3' + 'pciex111d,80bf' + 'pciexclass,060400' + 'pciexclass,0604'
+                    reg:  0006b800.00000000.00000000.00000000.00000000
+                    physical-slot#:  00000007
+                    #address-cells:  00000003
+                    #size-cells:  00000002
+                    device_type:  'pciex'
+                    name:  'pci'
+                    port-type:  'Downstream-Port'
+                    cache-line-size:  00000010
+                    class-code:  00060400
+                    revision-id:  00000003
+                    device-id:  000080bf
+                    vendor-id:  0000111d
+
+                    Node 0xf0342f48
+                        firmware-version:  '4.00.00.00'
+                        mpt-version:  '2.05'
+                        local-wwid:  500605b0.0a108680
+                        vf-assigned-addresses:  83540000.00000001.20010000.00000000.00010000
+                        assigned-addresses:  81540010.00000000.02000000.00000000.00000100.83540014.00000001.20000000.00000000.00010000.82540030.00000000.10100000.00000000.00100000
+                        vf-reg:  03540000.00000000.00000000.00000000.00010000
+                        compatible: 'pciex1000,97' + 'pci1000,97'
+                        model:  'LSI,3008'
+                        reg:  00540000.00000000.00000000.00000000.00000000.01540010.00000000.00000000.00000000.00000100.03540014.00000000.00000000.00000000.00010000.02540030.00000000.00000000.00000000.00100000
+                        version: '1.00.65'
+                        wide:  00000010
+                        device_type:  'scsi-sas'
+                        name:  'LSI,sas'
+                        #address-cells:  00000004
+                        fcode-rom-offset:  00049000
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
+                        Node 0xf0351a18
+                            compatible: 'st'
+                            device_type:  'byte'
+                            name:  'tape'
+
+                        Node 0xf035277c
+                            lba64:  
+                            compatible: 'sd'
+                            device_type:  'block'
+                            name:  'disk'
+
+    Node 0xf03680a0
+        alloc-size:  00000000
+        address:  51000000
+        size:  05c26000
+        compatible: 'SUNW,ramdisk'
+        device_type:  'block'
+        name:  'ramdisk-root'
+
+
+
